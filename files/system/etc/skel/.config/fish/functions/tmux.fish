function tmux --wraps='TERM=screen-256color tmux -2 -f "$XDG_CONFIG_HOME"/tmux/config' --description 'alias tmux=TERM=screen-256color tmux -2 -f "$XDG_CONFIG_HOME"/tmux/config'
    env TERM=screen-256color command tmux -2 -f "$XDG_CONFIG_HOME/tmux/config" $argv
end
