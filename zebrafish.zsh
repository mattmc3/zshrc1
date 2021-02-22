() {
  local basedir="${${(%):-%x}:a:h}"
  fpath+="$basedir/functions"
  autoload -Uz $basedir/functions/*(.N)

  local loadmodules
  zstyle -a :zebrafish:modules load loadmodules ||
    loadmodules=(
      xdg
      environment
      zshopts
      history
      autosuggestions
      pretty-man-pages
      history-substring-search
      terminal
      confd
      zfunctions
      zfishcmds
      prompts
      completions
    )
  local m
  for m in $loadmodules; do
    source "${basedir}/modules/${m}/${m}.plugin.zsh"
  done

  local themename
  zstyle -s :zebrafish:module:prompt theme themename || themename=pure
  prompt "$themename"
}
