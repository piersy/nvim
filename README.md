# nvim configuration repository

This repositiory contains my configuration for nvim.

# Installation

Clone repository to `$HOME/.config/nvim` the run the following to get vim plug and install plugins:
```
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c "PlugInstall | qa"
```

Then open nvim and run `:PlugInstall` then close an reopen nvim.
