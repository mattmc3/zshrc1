# prompts.zsh

fpath+="${0:h}/external/pure"

zstyle -s :zebrafish:module:prompt theme themename || themename=pure
(( $+functions[promptinit] )) || autoload -Uz promptinit
promptinit
prompt "$themename"
unset themename
