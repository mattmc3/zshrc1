# unplugged - A simple plugin manager
typeset -gHa __plugin_zopts=(extended_glob glob_dots no_monitor)

function -plugin-help {
  emulate -L zsh
  setopt local_options $__plugin_zopts

  print "usage: plugin <command>"
  print "       plugin load [--kind <path_fpath>] <plugins...>"
  print ""
  print "commands:"
  print "  help     print help"
  print "  clone    clone plugins"
  print "  load     load plugins"
  print "  list     list plugins"
  print "  home     print plugin home"
  print "  update   update plugins"
  print "  compile  compile plugins"
  print ""
}

function -plugin-clone {
  emulate -L zsh
  setopt local_options $__plugin_zopts

  local repo plugdir; local -Ua repos
  local plugin_home="$(-plugin-home)"

  # Remove bare words ${(M)@:#*/*} and paths with leading slash ${@:#/*}.
  # Then split/join to keep the 2-part user/repo form to bulk-clone repos.
  for repo in ${${(M)@:#*/*}:#/*}; do
    repo=${(@j:/:)${(@s:/:)repo}[1,2]}
    [[ -e $plugin_home/$repo ]] || repos+=$repo
  done

  for repo in $repos; do
    plugdir="$plugin_home/$repo"
    if [[ ! -d "$plugdir" ]]; then
      print "Cloning $repo..."
      (
        command git clone -q --depth 1 --recursive --shallow-submodules \
          "https://github.com/${repo}" "$plugdir"
        -plugin-compile "$plugdir"
      ) &
    fi
  done
  wait
}

function -plugin-home {
  emulate -L zsh
  setopt local_options $__plugin_zopts

  : ${__zsh_cache_dir:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh}
  [[ -n "$ZPLUGINDIR" ]] && print "$ZPLUGINDIR" || print "$__zsh_cache_dir/repos"
}

function -plugin-load {
  source <(-plugin-script $@)
}

function -plugin-script {
  emulate -L zsh
  setopt local_options $__plugin_zopts

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
    print >&2 "Invalid argument '$badopt'."
    return 1
  fi

  local plugin_home="$(-plugin-home)" src="source"
  local plugin plugindir init inits=()
  (( ! $+functions[zsh-defer] )) || src="zsh-defer ."

  for plugin in $@; do
    if [[ -n "$kind" ]]; then
      print "$kind=(\$$kind $plugin_home/$plugin)"
    else
      inits=(
        $__zsh_config_dir/plugins/$plugin/${plugin:t}.{plugin.zsh,zsh-theme,zsh,sh}(N)
        $plugin_home/${plugin}/${plugin:t}.plugin.zsh(N)
        $plugin_home/${plugin}/*.{zsh-theme,plugin.zsh}(N)
        $plugin_home/$plugin(.N)
        $plugin_home/$plugin.{plugin.zsh,zsh,zsh-theme}(.N)
        ${plugin}(.N)
      )
      if [[ "${#inits}" -gt 0 ]]; then
        inits=($inits[1])
      else
        inits=($plugin_home/${plugin}/*.{z,}sh(N))
      fi

      if [[ "${#inits}" -eq 0 ]]; then
        print >&2 "plugin: No plugin init found '$plugin'. Did you forget to clone?"
        continue
      fi
      for init in $inits; do
        print "$src $init"
      done
      plugindir=${inits[1]:h}
      print "fpath+=( $plugindir )"
      [[ "${plugindir:t}" == zsh-defer ]] && src="zsh-defer ."
    fi
  done
}

function -plugin-list {
  emulate -L zsh
  setopt local_options $__plugin_zopts

  local plugin_home="$(-plugin-home)"
  for plugdir in "$plugin_home"/*/*/.git(N/); do
    print "${${plugdir:A:h}##$plugin_home/}"
  done
}

function -plugin-update {
  emulate -L zsh
  setopt local_options $__plugin_zopts

  local plugdir oldsha newsha
  for plugdir in "$(-plugin-home)"/*/*/.git(N/); do
    plugdir=${plugdir:A:h}
    print "Updating ${plugdir:h:t}/${plugdir:t}..."
    (
      oldsha="$(command git -C "$plugdir" rev-parse --short HEAD)"
      command git -C "$plugdir" pull --quiet --ff --depth 1 --rebase --autostash
      newsha="$(command git -C "$plugdir" rev-parse --short HEAD)"
      [[ "$oldsha" == "$newsha" ]] || print "Plugin updated: $plugdir:t ($oldsha -> $newsha)"
    ) &
  done
  wait
  -plugin-compile
  print "Update complete."
}

function -plugin-remove {
  emulate -L zsh
  setopt local_options $__plugin_zopts

  local plugin ret=0
  for plugin in $@; do
    if [[ -d $(-plugin-home)/$plugin/.git ]]; then
      rm -rf -- $(-plugin-home)/$plugin
    else
      print >&2 "Plugin not found: $(-plugin-home)/$plugin..."
      ret=1
    fi
  done
  return $ret
}

function -plugin-compile {
  emulate -L zsh
  setopt local_options $__plugin_zopts

  autoload -Uz zrecompile
  local zfile
  for zfile in "${1:-$(-plugin-home)}"/**/*.zsh{,-theme}(N); do
    [[ "$zfile" != */test-data/* ]] || continue
    zrecompile -pq "$zfile"
  done
}

##? The humble un-plugin manager
function plugin {
  local cmd=$1
  (( $# )) && shift || cmd=help
  [[ $cmd == (-h|--help) ]] && cmd=help
  if (( $+functions[-plugin-$cmd] )); then
    "-plugin-$cmd" "$@"
  else
    print "plugin: command not found '$cmd'."
  fi
}
