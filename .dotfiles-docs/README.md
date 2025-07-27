# Made a bare git repo for managing dotfiles
```
git init --bare $HOME/.dotfiles
```

# Setup an alias for easily adding new/committing dotfile updates
```
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
```

# Ignore untracked files
```
dotfiles config --local status.showUntrackedFiles no
```

# Start tracking files!
```
dotfiles add .config/path/to/file.conf
dotfiles add /some/other/file
dotfiles commit -m "Cool message"
dotfiles remote add origin ...
dotfiles push -u origin master
```

# When setting up a new machine
```
git clone --bare git@github.com:ardavis/omarchy-dotfiles.git $HOME/.dotfiles
# Add the alias from above to ~/.bashrc
dotfiles checkout
```

Do manual diff/compares during Omarchy updates and then add/commit them to the dotfiles

