#!/bin/sh

function _current_epoch() {
  echo $(($(date +%s) / 60 / 60 / 24))
}

function _update_zsh_update() {
  echo "LAST_EPOCH=$(_current_epoch)" > ~/.zsh-update
}

if [ -f ~/.zsh-update ]
then
  . ~/.zsh-update

  if [[ -z "$LAST_EPOCH" ]]; then
    # fix corrupted zsh file
    _update_zsh_update && return 0;
  fi

  epoch_diff=$(($(_current_epoch) - $LAST_EPOCH))
  if [ $epoch_diff -gt 6 ]
  then
    /bin/sh $ZSH/tools/upgrade.sh
    if [ $? -eq 0 ]
    then
        # update the zsh file
        _update_zsh_update
    fi
  fi
else
  # create the zsh file
  _update_zsh_update
fi
