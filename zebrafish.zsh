#!/usr/bin/env zsh

# zebrafish.zsh
# > A powerful starter .zshrc
# Project Home: https://github.com/mattmc3/zebrafish
ZEBRAFISH_VERSION="2.0.0"

##? zsh_environment - set common zsh environment variables
function zsh_environment {
  # References
  # - https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zprofile

  # XDG base dir support.
  export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
  export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
  export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
  export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
  export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-$HOME/.xdg}

  # Ensure XDG dirs exist.
  local xdgdir
  for xdgdir in XDG_{CONFIG,CACHE,DATA,STATE}_HOME XDG_RUNTIME_DIR; do
    [[ -e ${(P)xdgdir} ]] || mkdir -p ${(P)xdgdir}
  done

  # Editors
  export EDITOR=${EDITOR:-vim}
  export VISUAL=${VISUAL:-nano}
  export PAGER=${PAGER:-less}

  # Less
  export LESS=${LESS:-'-g -i -M -R -S -w -z-4'}

  # Set the Less input preprocessor.
  # Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
  if [[ -z "$LESSOPEN" ]] && (( $#commands[(i)lesspipe(|.sh)] )); then
    export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
  fi

  # Browser
  if [[ "$OSTYPE" == darwin* ]]; then
    export BROWSER=${BROWSER:-open}
  fi

  # Regional settings
  export LANG=${LANG:-en_US.UTF-8}

  # use `< file` to quickly view the contents of any file.
  export READNULLCMD=${READNULLCMD:-$PAGER}
}

##? zsh_history - set zsh history options and variables
function zsh_history {
  # References:
  # - https://github.com/sorin-ionescu/prezto/tree/master/modules/history
  local histopts=(
    # 16.2.4 History        - https://zsh.sourceforge.io/Doc/Release/Options.html#History
    bang_hist               # Treat the '!' character specially during expansion.
    extended_history        # Write the history file in the ':start:elapsed;command' format.
    hist_expire_dups_first  # Expire a duplicate event first when trimming history.
    hist_find_no_dups       # Do not display a previously found event.
    hist_ignore_all_dups    # Delete an old recorded event if a new event is a duplicate.
    hist_ignore_dups        # Do not record an event that was just recorded again.
    hist_ignore_space       # Do not record an event starting with a space.
    hist_reduce_blanks      # Remove extra blanks from commands added to the history list.
    hist_save_no_dups       # Do not write a duplicate event to the history file.
    hist_verify             # Do not execute immediately upon history expansion.
    inc_append_history      # Write to the history file immediately, not when the shell exits.
    NO_hist_beep            # Don't beep when accessing non-existent history.
    NO_share_history        # Don't share history between all sessions.
  )
  setopt $histopts

  # $HISTFILE belongs in the data home, not with zsh configs
  HISTFILE=${XDG_DATA_HOME:=$HOME/.local/share}/zsh/history
  [[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h

  # You can set $SAVEHIST and $HISTSIZE to anything greater than the ZSH defaults
  # (1000 and 2000 respectively), but if not we make them way bigger.
  [[ $SAVEHIST -gt 1000 ]] || SAVEHIST=10000
  [[ $HISTSIZE -gt 2000 ]] || HISTSIZE=10000
}

##? zsh_options - set better zsh options than the defaults
function zsh_options {
  local zopts=(
    # 16.2.1 Changing Directories
    auto_cd                 # if a command isn't valid, but is a directory, cd to that dir.
    auto_pushd              # make cd push the old directory onto the dirstack.
    cdable_vars             # change directory to a path stored in a variable.
    pushd_ignore_dups       # don’t push multiple copies of the same directory onto the dirstack.
    pushd_minus             # exchanges meanings of +/- when navigating the dirstack.
    pushd_silent            # do not print the directory stack after pushd or popd.
    pushd_to_home           # push to home directory when no argument is given.

    # 16.2.3 Expansion and Globbing
    extended_glob           # Use extended globbing syntax.
    glob_dots               # Don't hide dotfiles from glob patterns.

    # 16.2.6 Input/Output
    interactive_comments    # Enable comments in interactive shell.
    rc_quotes               # Allow 'Hitchhiker''s Guide' instead of 'Hitchhiker'\''s Guide'.
    NO_clobber              # Don't overwrite files with >. Use >| to bypass.
    NO_mail_warning         # Don't print a warning if a mail file was accessed.
    NO_rm_star_silent       # Ask for confirmation for `rm *' or `rm path/*'

    # 16.2.7 Job Control
    auto_resume             # Attempt to resume existing job before creating a new process.
    long_list_jobs          # List jobs in the long format by default.
    notify                  # Report status of background jobs immediately.
    NO_bg_nice              # Don't run all background jobs at a lower priority.
    NO_check_jobs           # Don't report on jobs when shell exit.
    NO_hup                  # Don't kill jobs on shell exit.

    # 16.2.9 Scripts and Functions
    multios                 # Write to multiple descriptors.

    # 16.2.12 Zle
    combining_chars         # Combine 0-len chars with base chars (eg: accents).
    NO_beep                 # Be quiet.
  )
  setopt $zopts
}

##? zsh_color - setup color for built-in utilities
function zsh_color {
  local prefix cache

  # Cache results of running dircolors for 20 hours, so it should almost
  # always regenerate the first time a shell is opened each day.
  for prefix in '' g; do
    if (( $+commands[${prefix}dircolors] )); then
      local dircolors_cache=${XDG_CACHE_HOME:=$HOME/.cache}/zebrafish/${prefix}dircolors.zsh
      mkdir -p ${dircolors_cache:h}
      local cache=($dircolors_cache(Nmh-20))

      (( $#cache )) || ${prefix}dircolors --sh >| $dircolors_cache
      source "${dircolors_cache}"
      alias ${prefix}ls="${aliases[${prefix}ls]:-${prefix}ls} --group-directories-first --color=auto"
    fi
  done

  if [[ "$OSTYPE" == darwin* ]]; then
    export CLICOLOR=1
    alias ls="${aliases[ls]:-ls} -G"
  fi

  export LS_COLORS=${LS_COLORS:-'di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'}
  export LSCOLORS=${LSCOLORS:-exfxcxdxbxGxDxabagacad}
  alias grep="${aliases[grep]:-grep} --color=auto"

  # Show man pages in color.
  export LESS_TERMCAP_mb=$'\e[01;34m'      # mb:=start blink-mode (bold,blue)
  export LESS_TERMCAP_md=$'\e[01;34m'      # md:=start bold-mode (bold,blue)
  export LESS_TERMCAP_so=$'\e[00;47;30m'   # so:=start standout-mode (white bg, black fg)
  export LESS_TERMCAP_us=$'\e[04;35m'      # us:=start underline-mode (underline magenta)
  export LESS_TERMCAP_se=$'\e[0m'          # se:=end standout-mode
  export LESS_TERMCAP_ue=$'\e[0m'          # ue:=end underline-mode
  export LESS_TERMCAP_me=$'\e[0m'          # me:=end modes
}

##? zsh_utility - setup zsh built-in utilities
function zsh_utility {
  # Use built-in paste magic.
  autoload -Uz bracketed-paste-url-magic
  zle -N bracketed-paste bracketed-paste-url-magic
  autoload -Uz url-quote-magic
  zle -N self-insert url-quote-magic

  # Load more specific 'run-help' function from $fpath.
  (( $+aliases[run-help] )) && unalias run-help && autoload -Uz run-help
  alias help=run-help
}

##? zsh_completion - set zsh built-in completion system
function zsh_completion {
  local zopts=(
    # 16.2.2 Completion
    always_to_end           # Move cursor to the end of a completed word.
    auto_list               # Automatically list choices on ambiguous completion.
    auto_menu               # Show completion menu on a successive tab press.
    auto_param_slash        # If completed parameter is a directory, add a trailing slash.
    complete_in_word        # Complete from both ends of a word.
    NO_menu_complete        # Do not autoselect the first completion entry.

    # 16.2.3 Expansion and Globbing
    extended_glob           # Use extended globbing syntax.
    glob_dots               # Don't hide dotfiles from glob patterns.

    # 16.2.6 Input/Output
    path_dirs               # Perform path search even on command names with slashes.
    NO_flow_control         # Disable start/stop characters in shell editor.
  )
  setopt $zopts

  # Allow custom completions directory.
  fpath=(${ZDOTDIR:-${XDG_CONFIG_HOME:-$HOME/.config}/zsh}/completions(/N) $fpath)

  # Zsh compdump file.
  : ${ZSH_COMPDUMP:=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump}
  [[ -d $ZSH_COMPDUMP:h ]] || mkdir -p $ZSH_COMPDUMP:h

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
      zcompile "$ZSH_COMPDUMP"
    fi
  } &!
}

##? zsh_compstyle - set zstyle completion styles
function zsh_compstyle {
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

##? zsh_prompt - set zsh prompt
function zsh_prompt {
  setopt PROMPT_SUBST  # expand parameters in prompt variables
  autoload -Uz promptinit && promptinit
  (( ! $# )) || prompt $@
}

##? zsh_confd - use a Fish-like conf.d directory for sourcing configs.
function zsh_confd {
  local zfile
  for zfile in $ZDOTDIR/conf.d/*.zsh(N); do
    [[ $zfile:t != '~'* ]] || continue
    . $zfile
  done
}

##? zsh_funcdir - use a Fish-like functions directory for lazy-loaded functions.
function zsh_funcdir {
  local fn fndir funcdir=$ZDOTDIR/functions
  [[ -d $funcdir ]] || return 1
  for fndir in $funcdir(/FN) $funcdir/*(/FN); do
    fpath=($fndir $fpath)
  done
  for fn in $funcdir/*(.N) $funcdir/*/*(.N); do
    [[ $fn:t != '_'* ]] || continue
    autoload -Uz $fn:t
  done
}
