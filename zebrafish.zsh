# Zebrafish
# > A small, lightning fast, single Zsh include file for an awesome Zsh base config
# Project Home: https://github.com/zshzoo/zebrafish
# Licenses:
#   - Zebrafish: MIT (https://github.com/zshzoo/zebrafish/blob/main/LICENSE)
#   - Oh-My-Zsh: MIT (https://github.com/ohmyzsh/ohmyzsh/blob/master/LICENSE.txt)
#   - Prezto: MIT (https://github.com/sorin-ionescu/prezto/blob/master/LICENSE)
#   - Grml: GPL v2 (https://github.com/grml/grml-etc-core/blob/master/etc/zsh/zshrc)
#   - Zim: MIT (https://github.com/zimfw/zimfw/blob/master/LICENSE)
ZF_VERSION="0.6.1"

# Profiling
# load zprof first thing in case we want to profile performance
[[ ${ZF_PROFILE:-0} -eq 0 ]] || zmodload zsh/zprof
alias zf-profile="ZF_PROFILE=1 zsh"

#
#region Setup
#
() {
  # drive zebrafish with zstyle settings
  typeset -ga zf_features=(
    environment
    zshopts
    history
    completion-styles
    keybindings
    termtitle
    help
    colorized-man-pages
    zfunctions
    zshrcd
    completions
    plugins
    prompt
    compinit
  )
  local disabled_features
  zstyle -a ':zebrafish:disable' features 'disabled_features' || disabled_features=()
  zf_features=${zf_features:|disabled_features}

  typeset -ga zf_plugins
  zstyle -a ':zebrafish:external' plugins 'zf_plugins' || \
    zf_plugins=(
      zsh-users/zsh-autosuggestions
      zsh-users/zsh-history-substring-search
      zsh-users/zsh-syntax-highlighting
    )
}
#endregion


#
#region Environment
#
# https://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
# https://wiki.archlinux.org/index.php/XDG_user_directories
#
if (($zf_features[(Ie)environment])); then
  # XDG
  export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
  export XDG_CACHE_HOME=${XDG_CACHE_HOME:-~/.cache}
  export XDG_DATA_HOME=${XDG_DATA_HOME:-~/.local/share}
  export XDG_RUNTIME_DIR=${XDG_RUNTIME_DIR:-~/.xdg}

  # os specific vars
  if [[ "$OSTYPE" == darwin* ]]; then
    export XDG_DESKTOP_DIR=${XDG_DESKTOP_DIR:-~/Desktop}
    export XDG_DOCUMENTS_DIR=${XDG_DOCUMENTS_DIR:-~/Documents}
    export XDG_DOWNLOAD_DIR=${XDG_DOWNLOAD_DIR:-~/Downloads}
    export XDG_MUSIC_DIR=${XDG_MUSIC_DIR:-~/Music}
    export XDG_PICTURES_DIR=${XDG_PICTURES_DIR:-~/Pictures}
    export XDG_VIDEOS_DIR=${XDG_VIDEOS_DIR:-~/Videos}
    export XDG_PUBLICSHARE_DIR=${XDG_PUBLICSHARE_DIR:-~/Public}
    export XDG_PROJECTS_DIR=${XDG_PROJECTS_DIR:-~/Projects}
  fi

  # editors
  export EDITOR=${EDITOR:-vim}
  export VISUAL=${VISUAL:-vim}
  export PAGER=${PAGER:-less}
  export LESS=${LESS:-'-g -i -M -R -S -w -z-4'}
  if [[ "$OSTYPE" == darwin* ]]; then
    export BROWSER=${BROWSER:-open}
  fi

  # regional settings
  export LANGUAGE=${LANGUAGE:-en}
  export LANG=${LANG:-en_US.UTF-8}
  export LC_ALL=${LC_ALL:-en_US.UTF-8}

  # colors
  export LS_COLORS=${LS_COLORS:-'di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'}
  export LSCOLORS=${LSCOLORS:-exfxcxdxbxGxDxabagacad}
  export CLICOLOR=${CLICOLOR:-1}

  # use `< file` to quickly view the contents of any file.
  export READNULLCMD=${READNULLCMD:-$PAGER}

  # remove lag
  export KEYTIMEOUT=${KEYTIMEOUT:-1}

  # treat these characters as part of a word
  export WORDCHARS=${WORDCHARS:-'*?_-.[]~&;!#$%^(){}<>'}
fi
#endregion


#
#region Zsh Options
#
# http://zsh.sourceforge.net/Doc/Release/Options.html
#
if (($zf_features[(Ie)zshopts])); then
  # changing directories
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Changing-Directories
  setopt auto_cd                 # if a command isn't valid, but is a directory, cd to that dir
  setopt auto_pushd              # make cd push the old directory onto the directory stack
  setopt pushd_ignore_dups       # don’t push multiple copies of the same directory onto the directory stack
  setopt pushd_minus             # exchanges the meanings of ‘+’ and ‘-’ when specifying a directory in the stack

  # completions
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Completion-2
  setopt always_to_end           # move cursor to the end of a completed word
  setopt auto_list               # automatically list choices on ambiguous completion
  setopt auto_menu               # show completion menu on a successive tab press
  setopt auto_param_slash        # if completed parameter is a directory, add a trailing slash
  #setopt complete_aliases        # for aliases, use separate completions rather than the aliased command
  setopt complete_in_word        # complete from both ends of a word
  setopt no_menu_complete        # don't autoselect the first completion entry

  # expansion and globbing
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Expansion-and-Globbing
  setopt extended_glob           # use more awesome globbing features
  setopt glob_dots               # include dotfiles when globbing

  # initialization
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Initialisation

  # input/output
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Input_002fOutput
  setopt no_clobber              # must use >| to truncate existing files
  setopt no_correct              # don't try to correct the spelling of commands
  setopt no_correct_all          # don't try to correct the spelling of all arguments in a line
  setopt no_flow_control         # disable start/stop characters in shell editor
  setopt interactive_comments    # enable comments in interactive shell
  setopt no_mail_warning         # don't print a warning message if a mail file has been accessed
  setopt path_dirs               # perform path search even on command names with slashes
  setopt rc_quotes               # allow 'Henry''s Garage' instead of 'Henry'\''s Garage'
  setopt no_rm_star_silent       # ask for confirmation for `rm *' or `rm path/*'

  # job control
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Job-Control
  setopt auto_resume            # attempt to resume existing job before creating a new process
  setopt no_bg_nice             # don't run all background jobs at a lower priority
  setopt no_check_jobs          # don't report on jobs when shell exit
  setopt no_hup                 # don't kill jobs on shell exit
  setopt long_list_jobs         # list jobs in the long format by default
  setopt notify                 # report status of background jobs immediately

  # prompting
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Prompting
  setopt prompt_subst           # expand parameters in prompt variables

  # scripts and functions
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Scripts-and-Functions

  # shell emulation
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Shell-Emulation

  # shell state
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Shell-State

  # zle
  # http://zsh.sourceforge.net/Doc/Release/Options.html#Zle
  setopt no_beep                # be quiet!
  setopt combining_chars        # combine zero-length punctuation characters (accents) with the base character
  setopt emacs                  # use emacs keybindings in the shell
fi
#endregion


#
#region History
#
# http://zsh.sourceforge.net/Doc/Release/Options.html#History
#
if (($zf_features[(Ie)history])); then
  setopt append_history          # append to history file
  setopt extended_history        # write the history file in the ':start:elapsed;command' format
  setopt no_hist_beep            # don't beep when attempting to access a missing history entry
  setopt hist_expire_dups_first  # expire a duplicate event first when trimming history
  setopt hist_find_no_dups       # don't display a previously found event
  setopt hist_ignore_all_dups    # delete an old recorded event if a new event is a duplicate
  setopt hist_ignore_dups        # don't record an event that was just recorded again
  setopt hist_ignore_space       # don't record an event starting with a space
  setopt hist_no_store           # don't store history commands
  setopt hist_reduce_blanks      # remove superfluous blanks from each command line being added to the history list
  setopt hist_save_no_dups       # don't write a duplicate event to the history file
  setopt hist_verify             # don't execute immediately upon history expansion
  setopt inc_append_history      # write to the history file immediately, not when the shell exits
  setopt no_share_history        # don't share history between all sessions

  # $HISTFILE belongs in the data home, not with zsh configs
  HISTFILE=${XDG_DATA_HOME:-~/.local/share}/zsh/history
  [[ -f "$HISTFILE" ]] || { mkdir -p "$HISTFILE:h" && touch "$HISTFILE" }

  # you can set $SAVEHIST and $HISTSIZE to anything greater than the ZSH defaults
  # (1000 and 2000 respectively), but if not we make them way bigger.
  [[ $SAVEHIST -gt 1000 ]] || SAVEHIST=20000
  [[ $HISTSIZE -gt 2000 ]] || HISTSIZE=100000
fi
#endregion


#
#region Completion Styles
#
function zf-completion-styles() {
  # https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh
  # Defaults.
  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
  zstyle ':completion:*:default' list-prompt '%S%M matches%s'

  # Use caching to make completion for commands such as dpkg and apt usable.
  zstyle ':completion::complete:*' use-cache on
  zstyle ':completion::complete:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zebrafish/zcompcache"

  # Case-insensitive (all), partial-word, and then substring completion.
  if zstyle -t ':zebrafish:module:completion:*' case-sensitive; then
    zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    setopt CASE_GLOB
  else
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
    unsetopt CASE_GLOB
  fi

  # Group matches and describe.
  zstyle ':completion:*:*:*:*:*' menu select
  zstyle ':completion:*:matches' group 'yes'
  zstyle ':completion:*:options' description 'yes'
  zstyle ':completion:*:options' auto-description '%d'
  zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
  zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
  zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
  zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
  zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
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

  # History
  zstyle ':completion:*:history-words' stop yes
  zstyle ':completion:*:history-words' remove-all-dups yes
  zstyle ':completion:*:history-words' list false
  zstyle ':completion:*:history-words' menu yes

  # Environment Variables
  zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

  # Populate hostname completion. But allow ignoring custom entries from static
  # */etc/hosts* which might be uninteresting.
  zstyle -a ':zebrafish:module:completion:*:hosts' etc-host-ignores '_etc_host_ignores'

  zstyle -e ':completion:*:hosts' hosts 'reply=(
    ${=${=${=${${(f)"$(cat {/etc/ssh/ssh_,~/.ssh/}known_hosts(|2)(N) 2> /dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
    ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2> /dev/null))"}%%(\#${_etc_host_ignores:+|${(j:|:)~_etc_host_ignores}})*}
    ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2> /dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
  )'

  # Don't complete uninteresting users...
  zstyle ':completion:*:*:*:users' ignored-patterns \
    adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
    dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
    hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
    mailman mailnull mldonkey mysql nagios \
    named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
    operator pcap postfix postgres privoxy pulse pvm quagga radvd \
    rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

  # ... unless we really want to.
  zstyle '*' single-ignored show

  # Ignore multiple entries.
  zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
  zstyle ':completion:*:rm:*' file-patterns '*:all-files'

  # Kill
  zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
  zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
  zstyle ':completion:*:*:kill:*' menu yes select
  zstyle ':completion:*:*:kill:*' force-list always
  zstyle ':completion:*:*:kill:*' insert-ids single

  # Man
  zstyle ':completion:*:manuals' separate-sections true
  zstyle ':completion:*:manuals.(^1*)' insert-sections true

  # Media Players
  zstyle ':completion:*:*:mpg123:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
  zstyle ':completion:*:*:mpg321:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
  zstyle ':completion:*:*:ogg123:*' file-patterns '*.(ogg|OGG|flac):ogg\ files *(-/):directories'
  zstyle ':completion:*:*:mocp:*' file-patterns '*.(wav|WAV|mp3|MP3|ogg|OGG|flac):ogg\ files *(-/):directories'

  # Mutt
  if [[ -s "$HOME/.mutt/aliases" ]]; then
    zstyle ':completion:*:*:mutt:*' menu yes select
    zstyle ':completion:*:mutt:*' users ${${${(f)"$(<"$HOME/.mutt/aliases")"}#alias[[:space:]]}%%[[:space:]]*}
  fi

  # SSH/SCP/RSYNC
  zstyle ':completion:*:(ssh|scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
  zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
  zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
  zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
  zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
  zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
}
(($zf_features[(Ie)completion-styles])) && zf-completion-styles
#endregion


#
#region Autoload Functions
#
function zf-zfunctions() {
  local fndir fnfile
  zstyle -s ':zebrafish:functions' path 'fndir' \
    || fndir=${ZDOTDIR:-~/.config/zsh}/functions
  [[ -d $fndir ]] || return 1
  fpath+=$fndir
  for fnfile in $fndir/**/*(N); do
    if test -f $fnfile; then
      autoload -Uz "$fnfile"
    fi
  done
}
(($zf_features[(Ie)zfunctions])) && zf-zfunctions
#endregion


#
#region Custom completions
#
function zf-completions() {
  # load additional completions
  local f compdir
  zstyle -s ':zebrafish:completions' path 'compdir' \
    || compdir=${ZDOTDIR:-~/.config/zsh}/completions
  [[ -d $compdir ]] || return 1
  fpath+=$compdir
  for f in "$compdir"/*.zsh(.N); do
    source "$f"
  done
}
(($zf_features[(Ie)completions])) && zf-completions
#endregion


#
#region Key bindings
#
# https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/key-bindings.zsh
# https://raw.githubusercontent.com/sorin-ionescu/prezto/master/modules/editor/init.zsh
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Zle-Builtins
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
#
function zf-keybindings() {
  # bind a reasonable set of common keyboard shortcuts

  # Make sure that the terminal is in application mode when zle is active, since
  # only then values from $terminfo are valid
  if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init() {
      echoti smkx
    }
    function zle-line-finish() {
      echoti rmkx
    }
    zle -N zle-line-init
    zle -N zle-line-finish
  fi

  # Use emacs key bindings
  bindkey -e

  # [PageUp] - Up a line of history
  if [[ -n "${terminfo[kpp]}" ]]; then
    bindkey -M emacs "${terminfo[kpp]}" up-line-or-history
    bindkey -M viins "${terminfo[kpp]}" up-line-or-history
    bindkey -M vicmd "${terminfo[kpp]}" up-line-or-history
  fi
  # [PageDown] - Down a line of history
  if [[ -n "${terminfo[knp]}" ]]; then
    bindkey -M emacs "${terminfo[knp]}" down-line-or-history
    bindkey -M viins "${terminfo[knp]}" down-line-or-history
    bindkey -M vicmd "${terminfo[knp]}" down-line-or-history
  fi

  # Start typing + [Up-Arrow] - fuzzy find history forward
  if [[ -n "${terminfo[kcuu1]}" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search

    bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
    bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
    bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
  fi
  # Start typing + [Down-Arrow] - fuzzy find history backward
  if [[ -n "${terminfo[kcud1]}" ]]; then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search

    bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
    bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
    bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
  fi

  # [Home] - Go to beginning of line
  if [[ -n "${terminfo[khome]}" ]]; then
    bindkey -M emacs "${terminfo[khome]}" beginning-of-line
    bindkey -M viins "${terminfo[khome]}" beginning-of-line
    bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
  fi
  # [End] - Go to end of line
  if [[ -n "${terminfo[kend]}" ]]; then
    bindkey -M emacs "${terminfo[kend]}"  end-of-line
    bindkey -M viins "${terminfo[kend]}"  end-of-line
    bindkey -M vicmd "${terminfo[kend]}"  end-of-line
  fi

  # [Shift-Tab] - move through the completion menu backwards
  if [[ -n "${terminfo[kcbt]}" ]]; then
    bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
    bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
    bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
  fi

  # [Backspace] - delete backward
  bindkey -M emacs '^?' backward-delete-char
  bindkey -M viins '^?' backward-delete-char
  bindkey -M vicmd '^?' backward-delete-char
  # [Delete] - delete forward
  if [[ -n "${terminfo[kdch1]}" ]]; then
    bindkey -M emacs "${terminfo[kdch1]}" delete-char
    bindkey -M viins "${terminfo[kdch1]}" delete-char
    bindkey -M vicmd "${terminfo[kdch1]}" delete-char
  else
    bindkey -M emacs "^[[3~" delete-char
    bindkey -M viins "^[[3~" delete-char
    bindkey -M vicmd "^[[3~" delete-char

    bindkey -M emacs "^[3;5~" delete-char
    bindkey -M viins "^[3;5~" delete-char
    bindkey -M vicmd "^[3;5~" delete-char
  fi

  # [Ctrl-Delete] - delete whole forward-word
  bindkey -M emacs '^[[3;5~' kill-word
  bindkey -M viins '^[[3;5~' kill-word
  bindkey -M vicmd '^[[3;5~' kill-word

  # [Ctrl-RightArrow] - move forward one word
  bindkey -M emacs '^[[1;5C' forward-word
  bindkey -M viins '^[[1;5C' forward-word
  bindkey -M vicmd '^[[1;5C' forward-word
  # [Ctrl-LeftArrow] - move backward one word
  bindkey -M emacs '^[[1;5D' backward-word
  bindkey -M viins '^[[1;5D' backward-word
  bindkey -M vicmd '^[[1;5D' backward-word


  bindkey '\ew' kill-region                             # [Esc-w] - Kill from the cursor to the mark
  bindkey -s '\el' 'ls\n'                               # [Esc-l] - run command: ls
  bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
  bindkey ' ' magic-space                               # [Space] - don't do history expansion


  # Edit the current command line in $EDITOR
  autoload -U edit-command-line
  zle -N edit-command-line
  bindkey '\C-x\C-e' edit-command-line

  # file rename magick
  bindkey "^[m" copy-prev-shell-word
}
(($zf_features[(Ie)keybindings])) && zf-keybindings
#endregion


#
#region Terminal
#
# https://github.com/zimfw/termtitle/blob/master/init.zsh
#
function zf-termtitle() {
  # set the terminal title
  [[ ${TERM} != dumb ]] || return
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
(($zf_features[(Ie)termtitle])) && zf-termtitle
#endregion


#
#region Misc
#
# https://github.com/sorin-ionescu/prezto/blob/be61026920c9a0db6d775ec97a002984147b954c/init.zsh#L186-L187
#
function zf-help() {
  # run-help is great, but it's often masked by an alias to man.
  alias run-help >&/dev/null && unalias run-help
  local rh
  for rh in run-help{,-git,-ip,-openssl,-p4,-sudo,-svk,-svn}; do
    autoload $rh
  done
}
(($zf_features[(Ie)help])) && zf-help

function zf-colorized-man-pages() {
  # show man pages in color
  export LESS_TERMCAP_mb=$'\e[01;34m'      # mb:=start blink-mode (bold,blue)
  export LESS_TERMCAP_md=$'\e[01;34m'      # md:=start bold-mode (bold,blue)
  export LESS_TERMCAP_so=$'\e[00;47;30m'   # so:=start standout-mode (white bg, black fg)
  export LESS_TERMCAP_us=$'\e[04;35m'      # us:=start underline-mode (underline magenta)
  export LESS_TERMCAP_se=$'\e[0m'          # se:=end standout-mode
  export LESS_TERMCAP_ue=$'\e[0m'          # ue:=end underline-mode
  export LESS_TERMCAP_me=$'\e[0m'          # me:=end modes
}
(($zf_features[(Ie)colorized-man-pages])) && zf-colorized-man-pages
#endregion


#
#region zshrc.d
#
function zf-zshrcd() {
  local confdir f files
  zstyle -s ':zebrafish:zshrc.d' path 'confdir' \
    || confdir=${ZDOTDIR:-~/.config/zsh}/zshrc.d
  [[ -d $confdir ]] || return 1
  files=("$confdir"/*.{sh,zsh}(.N))
  for f in ${(o)files}; do
    case ${f:t} in '~'*) continue;; esac
    source "$f"
  done
}
(($zf_features[(Ie)zshrcd])) && zf-zshrcd
#endregion


#
#region Plugins
#
function zf-plugins() {
  local repo plugin_name plugin_root plugin_dir initfile initfiles
  zstyle -s ':zebrafish:plugins' path 'plugin_root' \
    || plugin_root=${ZDOTDIR:-~/.config/zsh}/plugins

  for repo in $zf_plugins; do
    plugin_name=${repo:t}
    plugin_dir=$plugin_root/$plugin_name
    initfile=$plugin_dir/$plugin_name.zsh
    if [[ ! -d $plugin_dir ]]; then
      if [[ $repo != "https://"* ]] && [[ $repo != "git@"* ]]; then
        repo=https://github.com/$repo
      fi
      command git clone --depth 1 --recursive --shallow-submodules $repo $plugin_dir
      if [[ $? -ne 0 ]]; then
        echo >&2 "git clone failed for: ${repo:t}" && return 1
      fi
      if [[ ! -e $initfile ]]; then
        initfiles=(
          # look for specific files first
          $plugin_dir/$plugin_name.zsh(N)
          $plugin_dir/$plugin_name.plugin.zsh(N)
          $plugin_dir/init.zsh(N)
          $plugin_dir/$plugin_name(N)
          $plugin_dir/$plugin_name.zsh-theme(N)
          # then do more aggressive globbing
          $plugin_dir/*.plugin.zsh(N)
          $plugin_dir/*.zsh(N)
          $plugin_dir/*.zsh-theme(N)
          $plugin_dir/*.sh(N)
        )
        if [[ ${#initfiles[@]} -eq 0 ]]; then
          echo >&2 "no plugin init file found for ${repo:t}" && return 1
        else
          ln -s ${initfiles[1]} $initfile
        fi
      fi
    fi
    # source the plugin
    fpath+=$plugin_dir
    [[ -d $plugin_dir/functions ]] && fpath+=$plugin_dir/functions
    source $initfile
  done
}
(($zf_features[(Ie)plugins])) && zf-plugins
#endregion


#
#region Prompt
function zf-prompt() {
  local STARSHIP_CONFIG=${STARSHIP_CONFIG:-~/.config/starship.toml}
  [[ -f $STARSHIP_CONFIG ]] || {
    mkdir -p ${STARSHIP_CONFIG:h} && touch $STARSHIP_CONFIG
  }
  command -v starship &>/dev/null || sh -c "$(curl -fsSL https://starship.rs/install.sh)"
  eval "$(starship init zsh)"
}
(($zf_features[(Ie)prompt])) && zf-prompt


#
#region Compinit
#
# https://github.com/sorin-ionescu/prezto/blob/master/modules/completion/init.zsh#L31-L44
# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zlogin#L9-L15
# http://zsh.sourceforge.net/Doc/Release/Completion-System.html#Use-of-compinit
# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-2894219
# https://htr3n.github.io/2018/07/faster-zsh/
#
function zf-compinit() {
  # run compinit in a smarter, faster way
  emulate -L zsh
  setopt localoptions extendedglob

  ZSH_COMPDUMP=${ZSH_COMPDUMP:-$XDG_CACHE_HOME/zsh/zcompdump}
  [[ -d "$ZSH_COMPDUMP:h" ]] || mkdir -p "$ZSH_COMPDUMP:h"
  autoload -Uz compinit

  # if compdump is less than 20 hours old,
  # consider it fresh and shortcut it with `compinit -C`
  #
  # Glob magic explained:
  #   #q expands globs in conditional expressions
  #   N - sets null_glob option (no error on 0 results)
  #   mh-20 - modified less than 20 hours ago
  if [[ "$1" != "-f" ]] && [[ $ZSH_COMPDUMP(#qNmh-20) ]]; then
    # -C (skip function check) implies -i (skip security check).
    compinit -C -d "$ZSH_COMPDUMP"
  else
    compinit -i -d "$ZSH_COMPDUMP"
    touch "$ZSH_COMPDUMP"
  fi

  # Compile zcompdump, if modified, in background to increase startup speed.
  {
    if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
      zcompile "$ZSH_COMPDUMP"
    fi
  } &!
}
(($zf_features[(Ie)compinit])) && zf-compinit
#endregion


# done profiling
[[ ${ZF_PROFILE:-0} -eq 0 ]] || { unset ZF_PROFILE && zprof }
true
