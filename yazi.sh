tmp="$(mktemp -t "yazi-cwd.XXXXXX")"   # no 'local' here
yazi "$@" --cwd-file="$tmp"            # ensure $tmp is passed correctly

# Debug output to check contents of the tmp file
echo "tmp file contains: $(cat "$tmp")"

cwd="$(command cat -- "$tmp")"         # assign cwd
if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"              # change to cwd if valid
fi

rm -f -- "$tmp"                        # remove tmp file after use
zsh                                   # or whichever shell you want to open

