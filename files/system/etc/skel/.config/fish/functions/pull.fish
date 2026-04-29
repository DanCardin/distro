function pull
    set branch (test -n "$argv[1]"; and echo $argv[1]; or echo "main")
    set origin (test -n "$argv[2]"; and echo $argv[2]; or echo "origin")
    git pull $origin $branch
end
