# env

My environment files

### Setup
The setup script will update git submodules and create symbolic link files to this env repo
```bash
./setup.sh
```

### Add vim bundle plugins
Use git submodules to add new bundle plugin
```bash
cd env/.vim/bundle
git submodule add git@github.com:fatih/vim-go.git
```
