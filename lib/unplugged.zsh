# unplugged - A simple plugin manager
typeset -gHa __plugin_zopts=(extended_glob glob_dots no_monitor)

function plugin-help {
  emulate -L zsh; setopt local_options $__plugin_zopts
  echo "usage: plugin <command>"
  echo "       plugin load [--kind <path_fpath>] <plugins...>"
  echo ""
  echo "commands:"
  echo "  help     print help"
  echo "  clone    clone plugins"
  echo "  load     load plugins"
  echo "  list     list plugins"
  echo "  home     print plugin home"
  echo "  update   update plugins"
  echo "  compile  compile plugins"
  echo ""
}

function plugin-clone {
  emulate -L zsh; setopt local_options $__plugin_zopts
  local repo plugdir; local -Ua repos
  local plugin_home="$(plugin-home)"

  # Remove bare words ${(M)@:#*/*} and paths with leading slash ${@:#/*}.
  # Then split/join to keep the 2-part user/repo form to bulk-clone repos.
  for repo in ${${(M)@:#*/*}:#/*}; do
    repo=${(@j:/:)${(@s:/:)repo}[1,2]}
    [[ -e $plugin_home/$repo ]] || repos+=$repo
  done

  for repo in $repos; do
    plugdir="$plugin_home/$repo"
    if [[ ! -d "$plugdir" ]]; then
      echo "Cloning $repo..."
      (
        command git clone -q --depth 1 --recursive --shallow-submodules \
          "https://github.com/${repo}" "$plugdir"
        plugin-compile "$plugdir"
      ) &
    fi
  done
  wait
}

function plugin-home {
  : ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
  [[ -n "$ZPLUGINDIR" ]] && echo "$ZPLUGINDIR" || echo "$__zsh_cache_dir/repos"
}

function plugin-load {
  source <(plugin-script $@)
}

function plugin-script {
  emulate -L zsh; setopt local_options $__plugin_zopts

  # parse args: kind=path,fpath
  local kind badopt
  while (( $# )); do
    case $1 in
      -k|--kind)  shift; kind="$1" ;;
      --)         shift; break;    ;;
      -*)         badopt="$1"      ;;
      *)          break            ;;
    esac
    shift
  done

  if [[ -n "$badopt" ]]; then
    echo >&2 "Invalid argument '$badopt'."
    return 1
  fi

  local plugin_home="$(plugin-home)"
  local plugin src="source" inits=()
  (( ! $+functions[zsh-defer] )) || src="zsh-defer ."

  for plugin in $@; do
    if [[ -n "$kind" ]]; then
      echo "$kind=(\$$kind $plugin_home/$plugin)"
    else
      inits=(
        $__zsh_config_dir/plugins/$plugin/${plugin:t}.{plugin.zsh,zsh-theme,zsh,sh}(N)
        $plugin_home/$plugin/${plugin:t}.{plugin.zsh,zsh-theme,zsh,sh}(N)
        $plugin_home/$plugin/*.{plugin.zsh,zsh-theme,zsh,sh}(N)
        $plugin_home/$plugin(N)
        ${plugin}/*.{plugin.zsh,zsh-theme,zsh,sh}(N)
        ${plugin}(N)
      )
      if [[ $#inits -eq 0 ]]; then
        echo >&2 "No plugin init found '$plugin'. Did you forget to clone?"
        continue
      fi
      plugin=$inits[1]
      echo "fpath=(\$fpath $plugin:h)"
      echo "$src $plugin"
      [[ "$plugin:h:t" == zsh-defer ]] && src="zsh-defer ."
    fi
  done
}

function plugin-list {
  emulate -L zsh; setopt local_options $__plugin_zopts
  local plugin_home="$(plugin-home)"
  for plugdir in "$plugin_home"/*/*/.git(N/); do
    echo "${${plugdir:A:h}##$plugin_home/}"
  done
}

function plugin-update {
  emulate -L zsh; setopt local_options $__plugin_zopts

  local plugdir oldsha newsha
  for plugdir in "$(plugin-home)"/*/*/.git(N/); do
    plugdir=${plugdir:A:h}
    echo "Updating ${plugdir:h:t}/${plugdir:t}..."
    (
      oldsha="$(command git -C "$plugdir" rev-parse --short HEAD)"
      command git -C "$plugdir" pull --quiet --ff --depth 1 --rebase --autostash
      newsha="$(command git -C "$plugdir" rev-parse --short HEAD)"
      [[ "$oldsha" == "$newsha" ]] || echo "Plugin updated: $plugdir:t ($oldsha -> $newsha)"
    ) &
  done
  wait
  plugin-compile
  echo "Update complete."
}

function plugin-remove {
  emulate -L zsh
  setopt local_options $__plugin_zopts

  local plugin ret=0
  for plugin in $@; do
    if [[ -d $(plugin-home)/$plugin/.git ]]; then
      rm -rf -- $(plugin-home)/$plugin
    else
      print >&2 "Plugin not found: $(plugin-home)/$plugin..."
      ret=1
    fi
  done
  return $ret
}

function plugin-compile {
  emulate -L zsh; setopt local_options $__plugin_zopts

  autoload -Uz zrecompile
  local zfile
  for zfile in "${1:-$(plugin-home)}"/**/*.zsh{,-theme}(N); do
    [[ "$zfile" != */test-data/* ]] || continue
    zrecompile -pq "$zfile"
  done
}

function plugin {
  local cmd=$1
  (( $# )) && shift || cmd=help
  [[ $cmd == (-h|--help) ]] && cmd=help
  if (( $+functions[plugin-$cmd] )); then
    "plugin-$cmd" "$@"
  else
    echo "plugin: command not found '$cmd'."
  fi
}
