function fetch
    set origin (test -n "$argv[1]"; and echo $argv[1]; or echo "origin")
    git fetch $origin
end
