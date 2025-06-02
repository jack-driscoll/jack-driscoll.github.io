#!/bin/bash

FILE="$1"
DATE_STR=$(date +"%Y-%m-%d")

if [[ -z "$FILE" ]]; then
  echo "Usage: $0 file.md"
  exit 1
fi

if [[ ! -f "$FILE" ]]; then
  echo "Error: File not found."
  exit 2
fi

# Read file into array
mapfile -t lines < "$FILE"

# Check for YAML front matter (--- at top)
if [[ "${lines[0]}" == "---" ]]; then
  # Check if date already exists
  found_date=0
  for i in "${!lines[@]}"; do
    if [[ "${lines[$i]}" =~ ^date:\  ]]; then
      lines[$i]="date: $DATE_STR"
      found_date=1
      break
    fi
    if [[ "${lines[$i]}" == "---" && $i -ne 0 ]]; then
      break  # End of frontmatter reached without finding date
    fi
  done

  if [[ $found_date -eq 0 ]]; then
    # Insert date line before closing ---
    for i in "${!lines[@]}"; do
      if [[ "${lines[$i]}" == "---" && $i -ne 0 ]]; then
        lines=("${lines[@]:0:$i}" "date: $DATE_STR" "${lines[@]:$i}")
        break
      fi
    done
  fi
else
  # No front matter — add it
  lines=("---" "date: $DATE_STR" "---" "" "${lines[@]}")
fi

# Write back to file
printf "%s\n" "${lines[@]}" > "$FILE"

echo "Updated date in $FILE to $DATE_STR"

