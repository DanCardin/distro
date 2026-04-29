function sql-result
    set sql $argv[1]
    set args $argv[2..-1]
    set result (psql -F'\t' --no-align $args -c "$sql")
    echo $result | pbcopy
end
