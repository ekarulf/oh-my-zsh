#!/bin/sh
echo "[Oh My Zsh] Checking for updates..."

current_path=`pwd`

( cd $ZSH && git pull origin master ) > /dev/null 2>&1
status=$?

if [ $status -eq 0 ]
then
    echo "[Oh My Zsh] Updated successfully!"
else
    echo "[Oh My Zsh] Error updating sources."
fi

cd "$current_path"
exit $status
