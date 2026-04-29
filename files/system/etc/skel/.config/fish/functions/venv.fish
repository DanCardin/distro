function venv
    set -gx VENV_NAME (pwd)/.venv
    set -gx VIRTUAL_ENV $VENV_NAME

    if not test -d $VENV_NAME
        python$argv[1] -m venv $VENV_NAME
    end
    source .venv/bin/activate.fish
end
