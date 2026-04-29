function mypy
    set mypy_cache (corpus --kind xdg-data --name mypy_cache)
    if not test -d $mypy_cache
        mkdir -p $mypy_cache
    end
    command mypy --cache-dir $mypy_cache $argv
end
