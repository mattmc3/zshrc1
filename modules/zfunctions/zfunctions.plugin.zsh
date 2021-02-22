() {
  local d
  local funcdir
  local funcdirs=(
    "${ZDOTDIR}/functions"
    "${ZDOTDIR}/zfunctions"
    "${ZDOTDIR:-$HOME}/.zfunctions"
  )
  for d in $funcdirs; do
    if [[ -d "$d" ]]; then
      autoload-funcdir "$d"
      return
    fi
    return 1
  done
}
