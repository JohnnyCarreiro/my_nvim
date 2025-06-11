#!/usr/bin/env fish

set action $argv[1]
set tmux_pane_id $argv[2]
set server_address $argv[3] # Endereço do servidor Neovim

# Captura o diretório atual do tmux
set current_dir (tmux display-message -p -t "$tmux_pane_id" '#{pane_current_path}')
cd "$current_dir"; or exit 1

# Obtém o(s) arquivo(s) escolhidos com Yazi
set paths
yazi --chooser-file=/dev/stdout | while read -l line
    set paths "$paths" (string escape -- "$line")
end

# Se nenhum arquivo for selecionado, sai sem erro
if test -z "$paths"
    exit 0
end

# Envia o comando correto para o Neovim via servidor
set nvim_command "nvim --server $server_address --remote-send '<C-\\><C-n>:enew<CR>:edit $paths<CR>'"
eval "$nvim_command"

