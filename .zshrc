
# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=1000\
	
setopt autocd extendedglob nomatch notify
unsetopt beep
bindkey -v

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/madara/.zshrc'

autoload -Uz compinit && compinit
autoload bashcompinit
bashcompinit
compinit

#EXPORTS
export GDK_SCALE=2
export PATH="$PATH:/opt/nvim-linux64/bin"
path+=('/home/madara/.cargo/bin')
path+=('/usr/local/go/bin')
path+=('/home/madara/oh-my-posh')
path+=('/home/madara/.local/bin')
export PATH="/home/madara/.local/bin:$PATH"
export FPATH="<path_to_eza>/completions/zsh:$FPATH"
export PATH="/usr/local/bin:$PATH"
export PATH=/usr/bin:$PATH
export CUDNN_PATH=$(dirname $(python3 -c "import nvidia.cudnn;print(nvidia.cudnn.__file__)"))
#export LD_LIBRARY_PATH=${CUDNN_PATH}/lib
export XLA_FLAGS=--xla_gpu_cuda_data_dir=/usr/lib/cuda
#export LD_LIBRARY_PATH="/usr/lib/wsl/lib/"  
export NUMBA_CUDA_DRIVER="/usr/lib/wsl/lib/libcuda.so.1"
export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export EDITOR="nvim"

# End of lines added by compinstall

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

#source files
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
source /usr/share/zsh/plugins/zsh-you-should-use/you-should-use.plugin.zsh

autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Shell integrations
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(oh-my-posh --init --shell zsh --config ~/themes/half-life.omp.json)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"

_comp_options+=(globdots)


# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZP::docker

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Alias
alias bat='batcat'
alias z='eza --icons=always'
alias gawk="awk"
alias Ipython="python3 -m IPython"
alias code="codium"
alias help="compgen -c | fzf | xargs man" 
alias wezterm="/mnt/c/Program\ Files/WezTerm/wezterm.exe"
alias md="mkdir -p"
alias rd="rmdir"

# # >>> conda initialize >>>
# # !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/madara/miniforge3/bin/miniforge' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/madara/miniforge3/etc/profile.d/miniforge.sh" ]; then
#         . "/home/madara/miniforge3/etc/profile.d/miniforge.sh"
#     else
#         export PATH="/home/madara/miniforge3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# # <<< conda initialize <<<
#

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
