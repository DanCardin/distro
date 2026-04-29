function repeat
    while test $status -eq 0
        eval $argv
    end
end
