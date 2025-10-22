```markdown

# AI Daily Stats Rule
**Rule name:** `ai-daily-stats [<date>]`

**Description:** Run git statistics to analyze AI assistant (Claude Code) contributions to the codebase for a specific date. If no date is provided, uses today's date.

**Parameters:**
- `<date>` (optional): Date in YYYY-MM-DD format. If not provided, uses today's date.

**Date validation:**
The date parameter must match the pattern YYYY-MM-DD. If invalid format is provided, the command will output an error message.

**Commands to run:**
<pre><code id="example" class="language-bash">
# AI Daily Stats script with date validation
#!/bin/bash

# Function to validate date format YYYY-MM-DD
validate_date() {
    if [[ ! $1 =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        echo -e "\033[0;31mError: wrong date format, use format YYYY-MM-DD\033[0m" >&2
        exit 1
    fi
}

# Get date from parameter or use today
if [ $# -eq 0 ]; then
    TARGET_DATE=$(date +%Y-%m-%d)
else
    validate_date "$1"
    TARGET_DATE="$1"
fi

# Count commits with Claude Code signature from target date
git log --since="$TARGET_DATE 00:00:00" --until="$TARGET_DATE 23:59:59" --grep="Co-Authored-By: Claude <noreply@anthropic.com>" --oneline | wc -l

# Show commits with Claude Code signature from target date
git log --since="$TARGET_DATE 00:00:00" --until="$TARGET_DATE 23:59:59" --grep="Co-Authored-By: Claude <noreply@anthropic.com>" --oneline

# Calculate total lines added/deleted for Claude Code commits from target date
git log --since="$TARGET_DATE 00:00:00" --until="$TARGET_DATE 23:59:59" --grep="Co-Authored-By: Claude <noreply@anthropic.com>" --numstat | awk 'NF==3 {plus += $1; minus += $2} END {print "Target date added: " plus, "Target date deleted: " minus, "Target date net: " plus-minus}'

# Show detailed stat summary for each Claude Code commit from target date
git log --since="$TARGET_DATE 00:00:00" --until="$TARGET_DATE 23:59:59" --grep="Co-Authored-By: Claude <noreply@anthropic.com>" --stat --oneline
</code></pre>

**Summary format:**
- Number of commits today
- Total lines added/deleted today
- Net change today
- Brief description of today's commits (features, refactoring, etc.)
```