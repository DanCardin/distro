function grb --wraps='git rebase -i origin/master' --description 'alias grb=git rebase -i origin/master'
    git rebase -i origin/master $argv
end
