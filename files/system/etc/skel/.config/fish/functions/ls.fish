function ls --wraps='eza --ignore-glob __pycache__' --description 'alias ls=eza --ignore-glob __pycache__'
    eza --ignore-glob __pycache__ $argv
end
