() {
  local d
  local confdir
  local confdirs=(
    "${ZDOTDIR}/zshrc.d"
    "${ZDOTDIR}/conf.d"
    "${ZDOTDIR:-$HOME}/.zshrc.d"
  )
  for d in $confdirs; do
    if [[ -d "$d" ]]; then
      source-confdir "$d"
      return
    fi
    return 1
  done
}
