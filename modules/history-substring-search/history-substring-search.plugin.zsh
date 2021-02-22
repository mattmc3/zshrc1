# autosuggestions.zsh

0=${(%):-%N}
[[ -d "${0:h}/external" ]] ||
  command git clone --depth 1 https://github.com/zsh-users/zsh-history-substring-search.git "${0:h}/external"

source "${0:A:h}/external/zsh-history-substring-search.zsh"

# bind terminal-specific up and down keys
if [[ -n "$terminfo[kcuu1]" ]]; then
  bindkey -M emacs "$terminfo[kcuu1]" history-substring-search-up
  bindkey -M viins "$terminfo[kcuu1]" history-substring-search-up
fi
if [[ -n "$terminfo[kcud1]" ]]; then
  bindkey -M emacs "$terminfo[kcud1]" history-substring-search-down
  bindkey -M viins "$terminfo[kcud1]" history-substring-search-down
fi
