# autosuggestions.zsh

[[ -d "${0:h}/external" ]] ||
  command git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git "${0:h}/external"

source "${0:h}/external/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'

if [[ -n "$key_info" ]]; then
  # vi
  bindkey -M viins "$key_info[Control]F" vi-forward-word
  bindkey -M viins "$key_info[Control]E" vi-add-eol
fi
