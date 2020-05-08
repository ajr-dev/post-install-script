zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'   # matches case insensitive for lowercase
zstyle ':completion:*' insert-tab pending             # pasting with tabs doesn't perform completion
zstyle ':completion:*' completer _expand _complete _files _correct _approximate  # default to file completion
