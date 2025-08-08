#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import json
import os
import datetime
import pytz
import sys

# --- 配置 ---
DATA_ROOT = "../data"
TEST_DATA_FILE = "rank.txt"

def get_backend_info():
    """获取用户输入的后端类型并返回对应文件夹名。"""
    while True:
        backend_input = input("👉 请输入后端类型 (A/a for ARM, R/r for RISC-V): ").strip().lower()
        if backend_input in ['a', 'arm']:
            return "educg-arm"
        if backend_input in ['r', 'riscv']:
            return "educg-riscv"
        print("❌ 输入无效，请输入 'A/a' 或 'R/r'.")

def get_commit_info():
    """获取 commit 相关信息。"""
    commit_hash = input("👉 请输入完整的 Commit Hash: ").strip()
    if not commit_hash:
        print("❌ Commit Hash 不能为空。")
        sys.exit(1)

    while True:
        time_str = input("👉 请输入 Commit 的北京时间 (格式: YYYY-MM-DD HH:MM:SS): ").strip()
        try:
            # 定义北京时区
            beijing_tz = pytz.timezone('Asia/Shanghai')
            # 将字符串解析为 naive datetime 对象
            naive_dt = datetime.datetime.strptime(time_str, '%Y-%m-%d %H:%M:%S')
            # 为 naive datetime 对象赋予北京时区信息，使其成为 aware datetime 对象
            aware_beijing_dt = beijing_tz.localize(naive_dt)
            # 转换为 UTC 时间
            utc_dt = aware_beijing_dt.astimezone(pytz.utc)
            # 格式化为带 'Z' 的 ISO 8601 格式
            iso_utc_str = utc_dt.strftime('%Y-%m-%dT%H:%M:%SZ')
            break
        except (ValueError, TypeError):
            print("❌ 时间格式不正确，请严格按照 'YYYY-MM-DD HH:MM:SS' 格式输入。")
    
    commit_message = input("👉 请输入 Commit Message: ").strip()
    if not commit_message:
        print("❌ Commit Message 不能为空。")
        sys.exit(1)

    return commit_hash, iso_utc_str, commit_message

def parse_test_data():
    """解析 rank.txt 文件并返回结果字典。"""
    print(f"📋 请将测试结果复制到当前目录下的 {TEST_DATA_FILE} 文件中。")
    print("   文件格式要求：每行代表一个测例，列之间用空格或制表符分隔。例: '1 01_mm1 AC 4.98 PASSED - 运行时间: 4.98秒'")
    input("👉 完成后请按 Enter 键继续...")

    results = {}
    try:
        with open(TEST_DATA_FILE, 'r', encoding='utf-8') as f:
            lines = f.readlines()
            if not lines:
                print(f"❌ 文件 {TEST_DATA_FILE} 为空。")
                sys.exit(1)

            print("\n🔍 开始解析测试数据...")
            for i, line in enumerate(lines, 1):
                parts = line.strip().split()
                if not parts:
                    continue

                if len(parts) < 4:
                    print(f"⚠️ 第 {i} 行格式不正确 (少于4列)，已跳过: '{line.strip()}'")
                    continue

                status = parts[2]
                if status != "AC":
                    print(f"ℹ️  第 {i} 行测试用例 '{parts[1]}' 状态非 AC，已跳过。")
                    continue

                test_name = parts[1]
                try:
                    score = float(parts[3])
                    if score < 0:
                        print(f"⚠️ 第 {i} 行测试用例 '{test_name}' 成绩为负数，已跳过。")
                        continue
                    results[test_name] = score
                except ValueError:
                    print(f"⚠️ 第 {i} 行成绩无法解析为数字，已跳过: '{line.strip()}'")
                    continue

            if not results:
                print("❌ 未能从文件中解析出任何有效的测试数据。")
                sys.exit(1)

            print(f"✅ 成功解析 {len(results)} 条有效的测试数据。")
            return results

    except FileNotFoundError:
        print(f"❌ 错误: 未找到文件 '{TEST_DATA_FILE}'。请创建该文件并填入数据。")
        sys.exit(1)
    except Exception as e:
        print(f"❌ 读取或解析文件时发生未知错误: {e}")
        sys.exit(1)

def write_files(backend_dir, commit_hash, timestamp, message, results):
    """构建 JSON 对象并写入文件，同时更新 index.json。"""
    short_hash = commit_hash[:7]
    json_filename = f"{short_hash}.json"
    
    # 最终的 JSON 数据结构
    output_data = {
        "commit": commit_hash,
        "author": "Auto-generated", # 可以根据需要修改或删除
        "timestamp": timestamp,
        "message": message,
        "results": results
    }

    # 确保目标目录存在
    target_dir_path = os.path.join(DATA_ROOT, backend_dir)
    os.makedirs(target_dir_path, exist_ok=True)

    # 写入 commit 的 JSON 文件
    json_file_path = os.path.join(target_dir_path, json_filename)
    try:
        with open(json_file_path, 'w', encoding='utf-8') as f:
            json.dump(output_data, f, indent=4, ensure_ascii=False)
        print(f"\n✅ 成功生成性能数据文件: {json_file_path}")
    except Exception as e:
        print(f"❌ 写入JSON文件失败: {e}")
        sys.exit(1)
    
    # 更新 index.json
    index_file_path = os.path.join(target_dir_path, "index.json")
    try:
        index_data = []
        if os.path.exists(index_file_path):
            with open(index_file_path, 'r', encoding='utf-8') as f:
                # 处理空文件的情况
                content = f.read()
                if content:
                    index_data = json.loads(content)
        
        if json_filename not in index_data:
            index_data.append(json_filename)
            with open(index_file_path, 'w', encoding='utf-8') as f:
                json.dump(index_data, f, indent=4, ensure_ascii=False)
            print(f"✅ 已将 {json_filename} 添加到 {index_file_path}")
        else:
            print(f"ℹ️ {json_filename} 已存在于 index.json 中，无需重复添加。")

    except json.JSONDecodeError:
        print(f"❌ {index_file_path} 文件内容不是有效的 JSON 格式。请修复或删除该文件后重试。")
        sys.exit(1)
    except Exception as e:
        print(f"❌ 更新 index.json 文件失败: {e}")
        sys.exit(1)


def main():
    backend_dir = get_backend_info()
    commit_hash, timestamp, message = get_commit_info()
    results = parse_test_data()
    write_files(backend_dir, commit_hash, timestamp, message, results)
    print("\n🎉 全部任务完成！")

if __name__ == "__main__":
    main()