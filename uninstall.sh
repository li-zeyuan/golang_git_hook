#!/bin/sh

if [ -f .git/hooks/pri-commit ]; then
    rm .git/hooks/pri-commit;
fi

if [ -f .git/hooks/commit-msg ]; then
    rm .git/hooks/commit-msg;
fi