function rebase
    git fetch
    git stash
    set branch (test -n "$argv[1]"; and echo $argv[1]; or echo "main")
    git rebase -i origin/$branch
end
