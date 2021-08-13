#!/bin/sh

if [ -f .git/hooks/pri-commit ]; then
    rm .git/hooks/pri-commit;
fi

if [ -f .git/hooks/commit-msg ]; then
    rm .git/hooks/commit-msg;
fi

# 卸载全局git_template
if [ -d ~/.git_template ]; then
  rm -r ~/.git_template
  git config --global --unset init.templatedir
fi
