import sys
import os


def parse_file(file_path):
    """
    解析文件，返回一个字典，键为第二列的标识，值为一个包含所有列的列表。
    """
    data = {}
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            for line in f:
                # 使用 split() 处理多空格，并过滤空字符串
                parts = line.strip().split()
                if len(parts) >= 4:
                    key = parts[1]
                    data[key] = parts
    except FileNotFoundError:
        print(f"错误: 文件未找到 - {file_path}")
        sys.exit(1)
    return data


def main():
    """
    主函数，处理文件并打印结果。
    """
    if len(sys.argv) != 3:
        print("用法: python diff_files.py <文件1> <文件2>")
        sys.exit(1)

    file1_path = sys.argv[1]
    file2_path = sys.argv[2]

    # 解析两个文件
    data1 = parse_file(file1_path)
    data2 = parse_file(file2_path)

    # 统计第一个文件的状态
    status_counts = {"AC": 0, "TLE": 0, "WA": 0, "RE": 0}
    for key in data1:
        status = data1[key][2]
        if status in status_counts:
            status_counts[status] += 1

    # 打印统计结果
    print(f"AC：{status_counts['AC']} TLE：{status_counts['TLE']} WA：{status_counts['WA']} RE：{status_counts['RE']}")
    print("---")

    print("时间差异和状态变化:")
    changes = []

    # 获取所有唯一的键并排序，以便按顺序打印
    all_keys = sorted(list(set(data1.keys()) | set(data2.keys())))

    for key in all_keys:
        if key in data1 and key in data2:
            try:
                # 获取时间值和状态
                time1 = float(data1[key][3])
                time2 = float(data2[key][3])
                status1 = data1[key][2]
                status2 = data2[key][2]

                # 记录状态变化
                if status1 != status2:
                    changes.append(f"{key}: {status2} -> {status1}")

                # 记录时间差异
                time_diff = time1 - time2
                # 只在时间有明显差异时打印
                if abs(time_diff) > 1e-6:
                    changes.append(f"{key} diff: {time_diff:.6f}")

            except (ValueError, IndexError):
                continue
        elif key in data1 and key not in data2:
            changes.append(f"{key} (仅存在于文件1)")
        elif key in data2 and key not in data1:
            changes.append(f"{key} (仅存在于文件2)")

    if not changes:
        print("nothing has been changed")
    else:
        for change in changes:
            print(change)


if __name__ == "__main__":
    main()
