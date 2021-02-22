# environment.zsh

export CLICOLOR="${CLICOLOR:-1}"
export LSCOLORS="${LSCOLORS:-ExfxcxdxbxGxDxabagacad}"

export PAGER="${PAGER:-less}"
export EDITOR="${EDITOR:-vim}"
export VISUAL="${VISUAL:-vim}"

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER="${BROWSER:-open}"
fi

# path
path=(
  /usr/local/{bin,sbin}
  /usr/{bin,sbin}
  /{bin,sbin}
)

if [[ "$OSTYPE" == darwin* ]]; then
  path=(/opt/homebrew/{bin,sbin} $path)
fi

if [[ -n "$ZDOTDIR" ]] && [[ -d "$ZDOTDIR/bin" ]]; then
  path=("$ZDOTDIR/bin" $path)
fi
[[ -d "$HOME/bin" ]] &&  path=("$HOME/bin" $path)

# ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

### Less (https://github.com/sorin-ionescu/prezto/blob/b7a80d99a84e718f30a076b27b090d3e998ad135/runcoms/zprofile#L50-L63)
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi
