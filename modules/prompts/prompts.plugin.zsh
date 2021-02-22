# prompts.zsh

[[ -d "${0:h}/external" ]] || mkdir -p "${0:h}/external"

[[ -d "${0:h}/external/pure" ]] ||
  command git clone --depth 1 https://github.com/sindresorhus/pure.git "${0:h}/external/pure"

fpath+="${0:h}/external/pure"
autoload -U promptinit; promptinit
