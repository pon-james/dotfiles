
#!/bin/bash

# VS Code
echo "symlink VS code settings"
ln -sf $(pwd)/vs-code-settings.json ~/Library/Application\ Support/Code/User/settings.json

# Zsh
echo "symlink zshrc config"
ln -sf $(pwd)/.zshrc ~/.zshrc

# Commitizen
echo "symlink czrc config"
ln -sf $(pwd)/.czrc ~/.czrc
