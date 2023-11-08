#!/bin/zsh
# .zshrc1
# > A powerful starter .zshrc
# Project Home: https://github.com/mattmc3/zshrc1

# Init zshrc1
() {
  typeset -g ZSHRC1_VERSION="1.0.1"

  # Add Fish-like variables for key Zsh directories.
  export __zsh_config_dir=${ZDOTDIR:-${XDG_CONFIG_HOME:-~/.config}/zsh}
  export __zsh_user_data_dir=${XDG_DATA_HOME:-~/.local/share}/zsh
  export __zsh_cache_dir=${XDG_CACHE_HOME:-~/.cache}/zsh

  # Ensure Zsh directories exist.
  local zdir
  for zdir in __zsh_{config,user_data,cache}_dir; do
    [[ -d "${(P)zdir}" ]] || mkdir -p ${(P)zdir}
  done

  # Customize with zstyles.
  [[ ! -r $__zsh_config_dir/.zstyles ]] || source $__zsh_config_dir/.zstyles
}

##? run_compinit - Initialize the built-in Zsh completion system.
function run_compinit {
  # Zsh compdump file.
  typeset -g ZSH_COMPDUMP
  zstyle -s ':zshrc1:completion' compdump 'ZSH_COMPDUMP' ||
    ZSH_COMPDUMP=$__zsh_cache_dir/zcompdump

  # Load and initialize the completion system ignoring insecure directories with a
  # cache time of 20 hours, so it should almost always regenerate the first time a
  # shell is opened each day.
  autoload -Uz compinit
  local comp_files=($ZSH_COMPDUMP(Nmh-20))
  if (( $#comp_files )); then
    compinit -i -C -d "$ZSH_COMPDUMP"
  else
    compinit -i -d "$ZSH_COMPDUMP"
    # Ensure $ZSH_COMPDUMP is younger than the cache time even if it isn't regenerated.
    touch "$ZSH_COMPDUMP"
  fi

  # Compile zcompdump, if modified, in background to increase startup speed.
  {
    if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
      if command mkdir "${ZSH_COMPDUMP}.zwc.lock" 2>/dev/null; then
        zcompile "$ZSH_COMPDUMP"
        command rmdir  "${ZSH_COMPDUMP}.zwc.lock" 2>/dev/null
      fi
    fi
  } &!
}

##? run_promptinit - Initialize the built-in Zsh prompt system.
function run_promptinit {
  # Initialize built-in prompt system.
  autoload -Uz promptinit && promptinit

  # Set prompt.
  local -a prompt_argv
  zstyle -a ':zshrc1:prompt' theme 'prompt_argv'
  if [[ $TERM == (dumb|linux|*bsd*) ]]; then
    prompt 'off'
  elif (( $#prompt_argv > 0 )); then
    prompt "$prompt_argv[@]"
  fi
}

# compstyle_zshrc1_setup - Set Zsh completion styles.
function compstyle_zshrc1_setup {
  # Defaults.
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*:default' list-prompt '%S%M matches%s'

  # Case-insensitive (all), partial-word, and then substring completion.
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

  # Group matches and describe.
  zstyle ':completion:*:*:*:*:*' menu select
  zstyle ':completion:*:matches' group 'yes'
  zstyle ':completion:*:options' description 'yes'
  zstyle ':completion:*:options' auto-description '%d'
  zstyle ':completion:*:corrections' format ' %F{red}-- %d (errors: %e) --%f'
  zstyle ':completion:*:descriptions' format ' %F{purple}-- %d --%f'
  zstyle ':completion:*:messages' format ' %F{green} -- %d --%f'
  zstyle ':completion:*:warnings' format ' %F{yellow}-- no matches found --%f'
  zstyle ':completion:*' format ' %F{blue}-- %d --%f'
  zstyle ':completion:*' group-name ''
  zstyle ':completion:*' verbose yes

  # Fuzzy match mistyped completions.
  zstyle ':completion:*' completer _complete _match _approximate
  zstyle ':completion:*:match:*' original only
  zstyle ':completion:*:approximate:*' max-errors 1 numeric

  # Increase the number of errors based on the length of the typed word. But make
  # sure to cap (at 7) the max-errors to avoid hanging.
  zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3>7?7:($#PREFIX+$#SUFFIX)/3))numeric)'

  # Don't complete unavailable commands.
  zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

  # Array completion element sorting.
  zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

  # Directories
  zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
  zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
  zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
  zstyle ':completion:*' squeeze-slashes true
  zstyle ':completion:*' special-dirs ..

  # History
  zstyle ':completion:*:history-words' stop yes
  zstyle ':completion:*:history-words' remove-all-dups yes
  zstyle ':completion:*:history-words' list false
  zstyle ':completion:*:history-words' menu yes

  # Environment Variables
  zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

  # Ignore multiple entries.
  zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
  zstyle ':completion:*:rm:*' file-patterns '*:all-files'

  # Kill
  zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
  zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
  zstyle ':completion:*:*:kill:*' menu yes select
  zstyle ':completion:*:*:kill:*' force-list always
  zstyle ':completion:*:*:kill:*' insert-ids single

  # complete manual by their section
  zstyle ':completion:*:manuals'    separate-sections true
  zstyle ':completion:*:manuals.*'  insert-sections   true
  zstyle ':completion:*:man:*'      menu yes select
}

# coreutils_alias_setup - Add colorization for ls command.
function __coreutils_alias_setup {
  local prefix=$1  # 'g' or '' for GNU coreutils alongside BSD coreutils

  # Cache results of running dircolors for 20 hours, so it should almost
  # always regenerate the first time a shell is opened each day.
  local dircolors_cache=$__zsh_cache_dir/${prefix}dircolors.zsh
  local cache_files=($dircolors_cache(Nmh-20))
  if ! (( $#cache_files )); then
    ${prefix}dircolors --sh >| $dircolors_cache
  fi
  source "${dircolors_cache}"
  alias ${prefix}ls="${aliases[${prefix}ls]:-${prefix}ls} --group-directories-first --color=auto"
}

# Run zshrc1.
() {
  #
  # General Options
  #

  setopt extended_glob           # Use extended globbing syntax.
  setopt combining_chars         # Combine 0-len chars with base chars (eg: accents).
  setopt interactive_comments    # Enable comments in interactive shell.
  setopt rc_quotes               # Allow 'Hitchhiker''s Guide' instead of 'Hitchhiker'\''s Guide'.
  setopt NO_beep                 # Be quiet.
  setopt NO_mail_warning         # Don't print a warning if a mail file was accessed.

  #
  # Autoload functions
  #

  # Add Fish-like lazy-load functions directory.
  typeset -g ZFUNCDIR
  zstyle -s ':zshrc1:function' dir 'ZFUNCDIR' \
    || ZFUNCDIR=$__zsh_config_dir/functions
  local fndir
  for fndir in $ZFUNCDIR(-/FN) $ZFUNCDIR/*(-/FN); do
    fpath=($fndir $fpath)
    autoload -Uz $fndir/*~*/_*(N.:t)
  done

  #
  # Colorize
  #

  # Built-in zsh colors
  autoload -Uz colors && colors

  # Show man pages in color.
  export LESS_TERMCAP_mb=$'\e[01;34m'      # mb:=start blink-mode (bold,blue)
  export LESS_TERMCAP_md=$'\e[01;34m'      # md:=start bold-mode (bold,blue)
  export LESS_TERMCAP_so=$'\e[00;47;30m'   # so:=start standout-mode (white bg, black fg)
  export LESS_TERMCAP_us=$'\e[04;35m'      # us:=start underline-mode (underline magenta)
  export LESS_TERMCAP_se=$'\e[0m'          # se:=end standout-mode
  export LESS_TERMCAP_ue=$'\e[0m'          # ue:=end underline-mode
  export LESS_TERMCAP_me=$'\e[0m'          # me:=end modes

  # Set colors for grep and ls command using dircolors if available.
  alias grep="${aliases[grep]:-grep} --color=auto"
  if (( $+commands[gdircolors] )); then
    __coreutils_alias_setup g
  fi
  if (( $+commands[dircolors] )); then
    __coreutils_alias_setup
  else
    alias ls="${aliases[ls]:-ls} -G"
    export LSCOLORS=${LSCOLORS:-exfxcxdxbxGxDxabagacad}
  fi
  unfunction -- __coreutils_alias_setup

  #
  # File system
  #

  setopt auto_pushd              # Make cd push the old directory onto the dirstack.
  setopt pushd_minus             # Exchanges meanings of +/- when navigating the dirstack.
  setopt pushd_silent            # Do not print the directory stack after pushd or popd.
  setopt pushd_to_home           # Push to home directory when no argument is given.
  setopt multios                 # Write to multiple descriptors.
  setopt glob_dots               # Don't hide dotfiles from glob patterns.
  setopt NO_clobber              # Don't overwrite files with >. Use >| to bypass.
  setopt NO_rm_star_silent       # Ask for confirmation for `rm *' or `rm path/*'

  # Show directory stack.
  alias dirh='dirs -v'

  #
  # History
  #

  setopt bang_hist               # Treat the '!' character specially during expansion.
  setopt extended_history        # Write the history file in the ':start:elapsed;command' format.
  setopt hist_expire_dups_first  # Expire a duplicate event first when trimming history.
  setopt hist_find_no_dups       # Do not display a previously found event.
  setopt hist_ignore_all_dups    # Delete an old recorded event if a new event is a duplicate.
  setopt hist_ignore_dups        # Do not record an event that was just recorded again.
  setopt hist_ignore_space       # Do not record an event starting with a space.
  setopt hist_reduce_blanks      # Remove extra blanks from commands added to the history list.
  setopt hist_save_no_dups       # Do not write a duplicate event to the history file.
  setopt hist_verify             # Do not execute immediately upon history expansion.
  setopt inc_append_history      # Write to the history file immediately, not when the shell exits.
  setopt NO_hist_beep            # Don't beep when accessing non-existent history.
  setopt NO_share_history        # Don't share history between all sessions.

  # Set the path to the history file.
  zstyle -s ':zshrc1:history' histfile 'HISTFILE' \
    || HISTFILE="$__zsh_user_data_dir/zsh_history"
  # Set the maximum number of events to save in the internal history.
  zstyle -s ':zshrc1:history' histsize 'HISTSIZE' \
    || HISTSIZE=20000
  # Set the maximum number of events to save in the history file.
  zstyle -s ':zshrc1:history' savehist 'SAVEHIST' \
    || SAVEHIST=100000

  # Use a better history command.
  alias history='fc -li'

  #
  # Job control
  #

  setopt auto_resume             # Attempt to resume existing job before creating a new process.
  setopt long_list_jobs          # List jobs in the long format by default.
  setopt notify                  # Report status of background jobs immediately.
  setopt NO_bg_nice              # Don't run all background jobs at a lower priority.
  setopt NO_check_jobs           # Don't report on jobs when shell exit.
  setopt NO_hup                  # Don't kill jobs on shell exit.

  #
  # Utilities
  #

  # Use built-in paste magic.
  autoload -Uz bracketed-paste-url-magic
  zle -N bracketed-paste bracketed-paste-url-magic
  autoload -Uz url-quote-magic
  zle -N self-insert url-quote-magic

  # Load more specific 'run-help' function from $fpath.
  (( $+aliases[run-help] )) && unalias run-help && autoload -Uz run-help
  alias help=run-help

  # Allow mapping Ctrl+S and Ctrl+Q shortcuts
  [[ -r ${TTY:-} && -w ${TTY:-} && $+commands[stty] == 1 ]] && stty -ixon <$TTY >$TTY

  #
  # conf.d
  #

  # Use Fish-like conf.d for loading config.
  local zfile confd
  zstyle -s ':zshrc1:confd' dir 'confd' \
    || confd=$__zsh_config_dir/conf.d
  for zfile in $confd/*.zsh(N); do
    [[ ${zfile:t} != '~'* ]] || continue
    source $zfile
  done

  #
  # Completions
  #

  setopt always_to_end           # Move cursor to the end of a completed word.
  setopt auto_list               # Automatically list choices on ambiguous completion.
  setopt auto_menu               # Show completion menu on a successive tab press.
  setopt auto_param_slash        # If completed parameter is a directory, add a trailing slash.
  setopt complete_in_word        # Complete from both ends of a word.
  setopt path_dirs               # Perform path search even on command names with slashes.
  setopt NO_flow_control         # Disable start/stop characters in shell editor.
  setopt NO_menu_complete        # Do not autoselect the first completion entry.

  # Add Fish-like custom completions directory.
  fpath=($__zsh_config_dir/completions(/N) $fpath)

  # Set completion zstyles.
  typeset -g ZSH_COMPSTYLE
  zstyle -s ':zshrc1:completion' compstyle 'ZSH_COMPSTYLE' \
    || ZSH_COMPSTYLE=zshrc1
  (( $+functions[compstyle_${ZSH_COMPSTYLE}_setup] )) && compstyle_${ZSH_COMPSTYLE}_setup

  # Initialize completions if the user didn't.
  (( $+functions[compinit] )) || run_compinit

  #
  # Prompt
  #

  # Expand parameters in prompt variables.
  setopt prompt_subst

  # Initialize prompt if the user didn't.
  (( $+functions[promptinit] )) || run_promptinit
}

# vim: ft=zsh sw=2 ts=2 et
