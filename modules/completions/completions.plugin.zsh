() {
  local compdir="${ZDOTDIR:-$HOME/.config/zsh}/completions"
  if [[ -d "$compdir" ]]; then
    fpath+="$compdir"
    run-compinit
    source-confdir "$compdir"
  fi
}
