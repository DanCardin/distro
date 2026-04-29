function remote-git
    set -gx GIT_WORK_TREE (corpus --nearest --source-path -n git -e git)
    set -gx GIT_DIR (corpus --nearest -n git -e git)
end
