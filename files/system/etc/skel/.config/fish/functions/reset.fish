function reset
    set branch (test -n "$argv[1]"; and echo $argv[1]; or echo "origin/main")
    git fetch
    git checkout $branch
    git branch -D $branch
    git checkout -b $branch
end
