function push --description 'alias push=git push origin "$(git rev-parse --abbrev-ref HEAD)"'
    git push origin (git rev-parse --abbrev-ref HEAD) $argv
end
