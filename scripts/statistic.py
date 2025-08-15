#!/usr/bin/env python3
from __future__ import annotations
import sys
import gzip
import io
import re
from collections import namedtuple
from typing import List, Tuple, Dict

# name, pattern
PATTERNS: List[Tuple[str, str]] = [
    ("Vectorized", "Vectorized"),
    ("SLP scheduling failed", "Scheduling failed"),
    ("Parallelized loops", "Parallelized"),
    ("Carried dependencies", "memory dependency"),
    ("LoopElimination", "LoopElimination]"),
    ("Fused loops", "Fused"),
    ("Annotated loops", "Annotated"),
    ("AffineLICM", "AffineLICM]"),
    ("LICM", "LICM]"),
    ("Relayout transposed", "Transposed"),
    ("RangeSimplify", "RngSimplify"),
    ("LSR", "LSR]"),
    ("GVN-PRE", "GVN-PRE]"),
    ("InstSimplify", "InstSimplify]"),
    ("Inline", "Inline]: Inlining"),
    ("EarlyInline", "EarlyInline]: Inlined"),
    ("Unrolled loops", "unrolling"),
    ("Bad trip count", "get trip count"),
]
USE_REGEX: bool = False
IGNORE_CASE: bool = False
TOP_N: int = 10

# ----------------------------------------------------------

PassStat = namedtuple("PassStat", ["count", "total", "min_s", "max_s"])

_FINISHED_RE = re.compile(
    r"Finished\s+'(?P<pass>[^']+)'\s+on\s+'(?P<fn>[^']+)'\.(?:.*?elapsed(?: time)?:\s*(?P<time>[0-9.+-eE]+)s)",
    re.IGNORECASE,
)


def open_maybe_gz(path: str):
    if path == '-':
        return io.TextIOWrapper(sys.stdin.buffer, encoding='utf-8', errors='ignore')
    if path.endswith('.gz'):
        return gzip.open(path, mode='rt', encoding='utf-8', errors='ignore')
    return open(path, mode='rt', encoding='utf-8', errors='ignore')


def prepare_matcher(patterns: List[Tuple[str, str]], use_regex: bool, ignore_case: bool):
    """Prepare matcher structure.

    Returns a dict with keys:
      - mode: 'literal' or 'regex'
      - items: list of (name, pattern-or-compiled)
      - ignore_case: bool
    """
    if use_regex:
        flags = re.IGNORECASE if ignore_case else 0
        items = [(name, re.compile(pattern, flags)) for (name, pattern) in patterns]
        return {
            'mode': 'regex',
            'items': items,
            'ignore_case': ignore_case,
        }
    else:
        # literal mode: case-fold patterns if ignore_case for faster comparisons
        if ignore_case:
            items = [(name, pattern.casefold()) for (name, pattern) in patterns]
        else:
            items = [(name, pattern) for (name, pattern) in patterns]
        return {
            'mode': 'literal',
            'items': items,
            'ignore_case': ignore_case,
        }


def process_files(paths: List[str], matcher, skip_timing: bool = False):
    """Process one or more files and return counts and pass timing stats.

    Returns dict: {"files_processed": int, "pattern_counts": {...}, "pass_stats": {...}}
    """
    # initialize pattern counts using the pattern names (keep insertion order)
    pattern_counts: Dict[str, int] = {name: 0 for (name, _) in matcher['items']}

    pass_stats: Dict[str, PassStat] = {}
    files_processed = 0

    mode = matcher['mode']
    items = matcher['items']
    ignore_case = matcher['ignore_case']

    # localize frequently used objects for speed
    finished_re = _FINISHED_RE

    for path in paths:
        try:
            fh = open_maybe_gz(path)
        except FileNotFoundError:
            print(f"Warning: file not found: {path}", file=sys.stderr)
            continue
        except Exception as e:
            print(f"Warning: cannot open {path}: {e}", file=sys.stderr)
            continue

        files_processed += 1
        with fh:
            # Iterate line by line to keep memory low
            if mode == 'literal':
                if ignore_case:
                    for raw_line in fh:
                        line = raw_line.casefold()
                        for name, lit in items:
                            if lit in line:  # fast C-level substring search
                                pattern_counts[name] += 1
                        # only search timings if requested
                        if not skip_timing:
                            m = finished_re.search(raw_line)
                            if m:
                                _record_pass_time(m, pass_stats)
                else:
                    for raw_line in fh:
                        for name, lit in items:
                            if lit in raw_line:
                                pattern_counts[name] += 1
                        if not skip_timing:
                            m = finished_re.search(raw_line)
                            if m:
                                _record_pass_time(m, pass_stats)
            else:  # regex mode
                for raw_line in fh:
                    # regex search per pattern (patterns already compiled)
                    for name, preg in items:
                        if preg.search(raw_line):
                            pattern_counts[name] += 1
                    if not skip_timing:
                        m = finished_re.search(raw_line)
                        if m:
                            _record_pass_time(m, pass_stats)

    return {"files_processed": files_processed, "pattern_counts": pattern_counts, "pass_stats": pass_stats}


def _record_pass_time(m: re.Match, pass_stats: Dict[str, PassStat]):
    # helper to record timing for a pass; factored out to keep hot loop small
    pass_name = m.group("pass")
    try:
        t = float(m.group("time"))
    except Exception:
        return
    if pass_name in pass_stats:
        c, total, mn, mx = pass_stats[pass_name]
        c += 1
        total += t
        if t < mn:
            mn = t
        if t > mx:
            mx = t
        pass_stats[pass_name] = PassStat(c, total, mn, mx)
    else:
        pass_stats[pass_name] = PassStat(1, t, t, t)


def format_time(t: float) -> str:
    if t >= 1.0:
        return f"{t:.3f}s"
    elif t >= 1e-3:
        return f"{t * 1e3:.3f}ms"
    elif t >= 1e-6:
        return f"{t * 1e6:.3f}µs"
    else:
        return f"{t * 1e9:.3f}ns"


def print_summary(result, top_n: int, timing_enabled: bool):
    files_processed = result["files_processed"]
    pattern_counts = result["pattern_counts"]
    pass_stats = result["pass_stats"]

    print(f"Files processed: {files_processed}")
    print()

    print("Optimization Statistics:")
    for p, c in pattern_counts.items():
        print(f"  {p}: {c}")
    print()

    if not timing_enabled:
        print("Pass timing collection was disabled (omit --skip-timing to enable).")
        return

    # build rows
    rows = []
    for pass_name, stat in pass_stats.items():
        c = stat.count
        total = stat.total
        avg = total / c if c else 0.0
        rows.append({
            "pass": pass_name,
            "count": c,
            "total_s": total,
            "avg_s": avg,
            "min_s": stat.min_s,
            "max_s": stat.max_s,
        })

    if not rows:
        print("No pass timing info found (no 'Finished ... elapsed time:' matches).")
        return

    by_total = sorted(rows, key=lambda r: r["total_s"], reverse=True)
    by_max = sorted(rows, key=lambda r: r["max_s"], reverse=True)

    n = min(top_n, len(by_total))
    print(f"Top {n} passes by TOTAL elapsed time:")

    header = f"{'total':>12}  {'count':>6}  {'avg':>12}  {'max':>12}  {'min':>12}  pass"
    print(header)
    for r in by_total[:n]:
        total_s = format_time(r['total_s'])
        avg_s = format_time(r['avg_s'])
        max_s = format_time(r['max_s'])
        min_s = format_time(r['min_s'])
        print(f"{total_s:>12}  {r['count']:6d}  {avg_s:>12}  {max_s:>12}  {min_s:>12}  {r['pass']}")

    print()
    n2 = min(top_n, len(by_max))
    print(f"Top {n2} passes by SINGLE max elapsed time:")
    header2 = f"{'max':>12}  {'count':>6}  {'total':>12}  {'avg':>12}  {'min':>12}  pass"
    print(header2)
    for r in by_max[:n2]:
        total_s = format_time(r['total_s'])
        avg_s = format_time(r['avg_s'])
        max_s = format_time(r['max_s'])
        min_s = format_time(r['min_s'])
        print(f"{max_s:>12}  {r['count']:6d}  {total_s:>12}  {avg_s:>12}  {min_s:>12}  {r['pass']}")


def diff_two_logs(path_old: str, path_new: str, matcher):
    """Compute difference in pattern_counts between two logs (new - old) and print a sorted report.

    Timing info is explicitly skipped for the diff.
    """
    res_old = process_files([path_old], matcher, skip_timing=True)
    res_new = process_files([path_new], matcher, skip_timing=True)

    counts_old = res_old['pattern_counts']
    counts_new = res_new['pattern_counts']

    # union of keys
    all_keys = sorted(set(counts_old.keys()) | set(counts_new.keys()),
                      key=lambda k: abs(counts_new.get(k, 0) - counts_old.get(k, 0)),
                      reverse=True)

    print(f"Diff: new='{path_new}'  vs  old='{path_old}'")
    print(f"Files processed: old={res_old['files_processed']}, new={res_new['files_processed']}")
    print()
    print(f"{'pattern':<30}  {'old':>8}  {'new':>8}  {'diff':>8}")
    print('-' * 60)
    for k in all_keys:
        o = counts_old.get(k, 0)
        n = counts_new.get(k, 0)
        d = n - o
        print(f"{k:<30}  {o:8d}  {n:8d}  {d:8d}")


def parse_args():
    import argparse
    ap = argparse.ArgumentParser(description="Parse compiler logs and compute optimization statistics (patterns are configured in the script).")
    ap.add_argument("paths", nargs='*', help="Log file paths to process (use - for stdin). Supports .gz.")
    ap.add_argument("--top", type=int, default=TOP_N, help="Top N passes to show (overrides TOP_N in script).")
    ap.add_argument("--regex", action="store_true", help="Treat PATTERNS as regex (overrides USE_REGEX in script).")
    ap.add_argument("--no-ignore-case", action="store_true", help="Do not ignore case (overrides IGNORE_CASE in script).")
    ap.add_argument("--skip-timing", action="store_true", help="Skip collecting pass timing info (faster).")
    ap.add_argument("--diff", nargs=2, metavar=("OLD", "NEW"), help="Compare two log files and print pattern count differences (timing excluded).")
    return ap.parse_args()


def main():
    args = parse_args()

    use_regex = args.regex or USE_REGEX
    ignore_case = (not args.no_ignore_case) and IGNORE_CASE
    skip_timing = args.skip_timing

    matcher = prepare_matcher(PATTERNS, use_regex, ignore_case)

    # If --diff supplied, run diff mode and exit
    if args.diff:
        old, new = args.diff
        diff_two_logs(old, new, matcher)
        return

    if not args.paths:
        print("No input paths provided. Provide one or more log files, or use --diff OLD NEW.", file=sys.stderr)
        sys.exit(2)

    result = process_files(args.paths, matcher, skip_timing=skip_timing)
    print_summary(result, top_n=args.top, timing_enabled=(not skip_timing))


if __name__ == "__main__":
    main()
