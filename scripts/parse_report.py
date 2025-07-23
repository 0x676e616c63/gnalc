import json
import os
import sys
import re
import subprocess
import datetime

# The script will create subdirectories like 'local-arm' within this.
DATA_ROOT = "data"
COMMIT_MSG_MAX_LENGTH = 40

def get_commit_details_from_git(repo_path, commit_hash):
    """Fetches the commit message and ISO 8601 timestamp for a given hash."""
    try:
        # The '-C' flag tells Git to run the command in the specified directory.
        # The format string gets the commit message (%B) and the strict ISO 8601 committer date (%cI), separated by a unique delimiter.
        command = [
            "git", "-C", repo_path, "log", "-1", f"--pretty=format:%B---COMMIT_DATA_SEPARATOR---%cI", commit_hash
        ]
        result = subprocess.run(command, capture_output=True, text=True, check=True, encoding='utf-8')
        
        parts = result.stdout.strip().split("---COMMIT_DATA_SEPARATOR---")
        if len(parts) != 2:
            print(f"Warning: Could not parse details for commit {commit_hash}. Git output was unexpected.")
            return "Message not found", "Timestamp not found"

        message = parts[0].strip().split('\n')[0].strip()
        timestamp = parts[1].strip()

        if len(message) > COMMIT_MSG_MAX_LENGTH:
            message = message[:COMMIT_MSG_MAX_LENGTH] + "..."

        # Convert ISO 8601 with timezone to the 'Z' format for consistency
        # Example: 2025-07-23T22:21:48+08:00 -> 2025-07-23T14:21:48Z
        dt_object = datetime.datetime.fromisoformat(timestamp)
        utc_timestamp_str = dt_object.astimezone(datetime.timezone.utc).strftime('%Y-%m-%dT%H:%M:%SZ')
        
        return message, utc_timestamp_str

    except subprocess.CalledProcessError as e:
        print(f"Error: Git command failed for hash {commit_hash}. Make sure the 'main' branch is checked out and the commit exists.")
        print(f"Stderr: {e.stderr}")
        return None, None
    except Exception as e:
        print(f"An unexpected error occurred while fetching git details for {commit_hash}: {e}")
        return None, None

def parse_single_report(report_text, main_branch_path):
    """Parses the text of a single report block from the markdown file."""
    # Find commit hash
    commit_match = re.search(r'- \*\*Artifacts Commit:\*\* \[([a-f0-9]{40})\]', report_text)
    if not commit_match:
        return None 

    commit_hash = commit_match.group(1)

    # Find target platform
    target_match = re.search(r'- \*\*Target:\*\* (.*)', report_text)
    backend = "unknown"
    if target_match:
        target_str = target_match.group(1).lower()
        if "arm" in target_str:
            backend = "local-arm"
        elif "riscv" in target_str:
            backend = "local-riscv"
    
    if backend == "unknown":
        print(f"Warning: Could not determine backend for commit {commit_hash[:7]}. Skipping this report.")
        return None

    # Get commit details using the hash
    message, timestamp = get_commit_details_from_git(main_branch_path, commit_hash)
    if not message:
        print(f"Warning: Could not retrieve details for commit {commit_hash}. Skipping this report.")
        return None

    results = {}
    # Find all test blocks
    test_blocks = re.findall(r'#### Test: (.*?)\n(.*?)(?=#### Test:|\Z)', report_text, re.DOTALL)
    for test_name, block_content in test_blocks:
        test_name = test_name.strip()
        
        # 1. Skip functional tests by name
        if test_name.startswith("functional") or test_name.startswith("h_functional"):
            continue
            
        # 2. Skip failed tests
        if "Status:** ✅ PASSED" not in block_content:
            continue
        
        # 3. Extract file name and time
        file_match = re.search(r'- \*\*File:\*\* .*?/(.*?)\.(?:bin|s)', block_content)
        time_match = re.search(r'- \*\*Time Elapsed:\*\* (\d+)(us|ms)', block_content)

        if file_match and time_match:
            case_name = file_match.group(1)
            time_val = int(time_match.group(1))
            time_unit = time_match.group(2)
            
            # Convert time to seconds
            time_in_seconds = 0.0
            if time_unit == "us":
                time_in_seconds = time_val / 1_000_000.0
            elif time_unit == "ms":
                time_in_seconds = time_val / 1_000.0
            
            results[case_name] = time_in_seconds

    if not results:
        print(f"Info: No valid performance test data found in the report for commit {commit_hash[:7]}.")
        return None

    print(f"Successfully parsed {len(results)} valid test results for commit {commit_hash[:7]}.")
    
    return {
        "commit_hash": commit_hash,
        "timestamp": timestamp,
        "message": message,
        "backend": backend,
        "results": results
    }

def write_files(data_root, report_data):
    """Writes the JSON file and updates the corresponding index.json."""
    commit_hash = report_data["commit_hash"]
    backend_dir = report_data["backend"]
    
    short_hash = commit_hash[:7]
    json_filename = f"{short_hash}.json"
    
    output_data = {
        "commit": commit_hash,
        "author": "GitHub Action",
        "timestamp": report_data["timestamp"],
        "message": report_data["message"],
        "results": report_data["results"]
    }

    target_dir_path = os.path.join(data_root, backend_dir)
    os.makedirs(target_dir_path, exist_ok=True)

    json_file_path = os.path.join(target_dir_path, json_filename)
    try:
        with open(json_file_path, 'w', encoding='utf-8') as f:
            json.dump(output_data, f, indent=4)
        print(f"Successfully generated data file: {json_file_path}")
    except Exception as e:
        print(f"Error: Failed to write JSON file: {e}")
        return

    index_file_path = os.path.join(target_dir_path, "index.json")
    try:
        index_data = []
        if os.path.exists(index_file_path):
            with open(index_file_path, 'r', encoding='utf-8') as f:
                content = f.read()
                if content:
                    index_data = json.loads(content)
        
        if json_filename not in index_data:
            index_data.append(json_filename)
            with open(index_file_path, 'w', encoding='utf-8') as f:
                json.dump(index_data, f, indent=4)
            print(f"Successfully added {json_filename} to {index_file_path}")
        else:
            print(f"Info: {json_filename} already exists in index.json. No update needed.")

    except json.JSONDecodeError:
        print(f"Error: {index_file_path} is not valid JSON. Please fix or delete it.")
    except Exception as e:
        print(f"Error: Failed to update index.json: {e}")

def main():
    if len(sys.argv) < 3:
        print("Usage: python parse_report.py <path_to_report.md> <path_to_main_branch_checkout> [--all]")
        sys.exit(1)
        
    report_file = sys.argv[1]
    main_branch_path = sys.argv[2]
    process_all = len(sys.argv) > 3 and sys.argv[3] == '--all'

    print(f"Reading report from: {report_file}")
    print(f"Using git repository at: {main_branch_path}")
    print(f"Processing all reports: {process_all}")
    print("-" * 30)

    try:
        with open(report_file, 'r', encoding='utf-8') as f:
            content = f.read()
    except FileNotFoundError:
        print(f"Error: Report file not found at {report_file}")
        sys.exit(1)

    # Split the entire file into report blocks based on the '---' separator
    report_blocks = content.split('\n---\n')

    reports_to_process = []
    if process_all:
        reports_to_process = report_blocks
        print(f"Found {len(reports_to_process)} reports to process in batch mode.")
    elif report_blocks:
        reports_to_process = [report_blocks[0]] # Only the latest one
        print("Processing the latest report from the top of the file.")
    
    if not reports_to_process:
        print("No reports found to process.")
        sys.exit(0)

    for i, block in enumerate(reports_to_process):
        if not block.strip():
            continue
        print(f"\nProcessing report block {i+1}...")
        parsed_data = parse_single_report(block, main_branch_path)
        if parsed_data:
            write_files(DATA_ROOT, parsed_data)
    
    print("\nScript finished.")

if __name__ == "__main__":
    main()