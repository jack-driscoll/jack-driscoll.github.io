#!/usr/bin/env python
import sys
import yaml
from datetime import date

def update_date(filepath):
    with open(filepath, 'r') as f:
        lines = f.readlines()

    if lines and lines[0].strip() == "---":
        # Locate front matter block
        end_idx = None
        for i, line in enumerate(lines[1:], 1):
            if line.strip() == "---":
                end_idx = i
                break

        if end_idx is None:
            print("No closing '---' for YAML front matter found.")
            return

        yaml_text = ''.join(lines[1:end_idx])
        content_rest = ''.join(lines[end_idx+1:])
        metadata = yaml.safe_load(yaml_text) or {}
        metadata["date"] = str(date.today())

        # Write back
        with open(filepath, 'w') as f:
            f.write("---\n")
            yaml.dump(metadata, f, default_flow_style=False)
            f.write("---\n")
            f.write(content_rest)

        print(f"Updated 'date' in {filepath}")
    else:
        # No front matter, add one
        metadata = {"date": str(date.today())}
        with open(filepath, 'w') as f:
            f.write("---\n")
            yaml.dump(metadata, f, default_flow_style=False)
            f.write("---\n\n")
            f.writelines(lines)

        print(f"Added front matter and updated 'date' in {filepath}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: update_date.py file.md")
        sys.exit(1)

    update_date(sys.argv[1])
