function gbd --description 'alias gbd=git branch --delete $(git branch --merged main --no-contains main --format="%(refname:short)")'
    git branch --delete (git branch --merged main --no-contains main --format="%(refname:short)")
end
