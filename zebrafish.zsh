() {
  local basedir="${${(%):-%x}:a:h}"
  fpath+="$basedir/functions"
  autoload -Uz $basedir/functions/*(.N)

  local loadmodules
  zstyle -a :zebrafish:modules: load loadmodules ||
    loadmodules=(
      xdg
      environment
      zshopts
      history
      autosuggestions
      pretty-man-pages
      history-substring-search
      editor
      terminal
      confd
      zfunctions
      zfishcmds
      prompts
      completions
    )

  # autoload common Zsh goodies
  (( $+functions[compinit] )) || autoload -Uz compinit
  (( $+functions[promptinit] )) || autoload -Uz promptinit

  local m
  for m in $loadmodules; do
    source "${basedir}/modules/${m}/${m}.plugin.zsh"
  done
}
