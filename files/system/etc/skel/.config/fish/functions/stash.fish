function stash --wraps='git stash' --description 'alias stash=git stash'
    git stash $argv
end
