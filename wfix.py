import math
import re
import pathlib
import sys

if len(sys.argv) != 2:
    sys.exit(1)

filepath = sys.argv[1]
file_content = pathlib.Path(filepath).read_text()

match = re.findall(r"AVERAGE_WIDTH\s(\d+)", file_content)

if not match:
    exit(1)

avg_w = int(match[0])

new_avg_w = math.ceil(avg_w / 10) * 10
patched = file_content.replace(
    f"AVERAGE_WIDTH {avg_w}",
    f"AVERAGE_WIDTH {new_avg_w}"
)

with open(filepath, "w") as f:
    f.write(patched)
