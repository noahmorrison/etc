#!/usr/bin/env sh
# Meanings of exit codes:
# code | meaning    | action of ranger
# -----+------------+-------------------------------------------
# 0    | success    | success. display stdout as preview
# 1    | no preview | failure. display no preview at all
# 2    | plain text | display the plain content of the file
# 3    | fix width  | success. Don't reload when width changes
# 4    | fix height | success. Don't reload when height changes
# 5    | fix both   | success. Don't ever reload

# Meaningful aliases for arguments:
path="$1"    # Full path of the selected file
width="$2"   # Width of the preview pane (number of fitting characters)
height="$3"  # Height of the preview pane (number of fitting characters)

mimetype=`file --mime-type -Lb "$path"`

try()
{
    output=`eval '"$@"'` \
    && echo "$output" | head -n "$height"\
    && exit 0
}

case "$mimetype" in
    text/*)
        try highlight -Oansi "$path" ||
        try cat "$path";;
    video/* | audio/*)
        try exiftool "$path";;
esac

exit 1
