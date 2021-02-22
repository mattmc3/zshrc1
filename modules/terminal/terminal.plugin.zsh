# https://github.com/zimfw/termtitle/blob/master/init.zsh
[[ ${TERM} != dumb ]] && () {
  if [[ ${TERM_PROGRAM} == Apple_Terminal ]]; then
    termtitle_update() {
      print -n "\E]7;${PWD}\a"
    }
  else
    local termtitle_format='%n@%m: %~'
    case ${TERM} in
      screen)
        builtin eval "termtitle_update() { print -Pn '\Ek${termtitle_format}\E\\' }"
        ;;
      *)
        builtin eval "termtitle_update() { print -Pn '\E]0;${termtitle_format}\a' }"
        ;;
    esac
  fi

  local zhooks zhook
  zhooks=(precmd)
  autoload -Uz add-zsh-hook
  for zhook (${zhooks}) add-zsh-hook ${zhook} termtitle_update
  termtitle_update  # we execute it once to initialize the window title
}
