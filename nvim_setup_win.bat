set CONFIG_HOME=%LOCALAPPDATA%\nvim
set DOTFILES=%USERPROFILE%\git\dotfiles
if NOT EXIST "%CONFIG_HOME%" (
    mkdir %CONFIG_HOME%
)
cd %CONFIG_HOME%

mklink dein.toml %DOTFILES%\.vim\rc\dein.toml
mklink deinlazy.toml %DOTFILES%\.vim\rc\dein_lazy.toml

mklink init.vim %DOTFILES%\_vimrc
mklink keymap.rc.vim %DOTFILES%\keymap.rc.vim
mklink options.rc.vim %DOTFILES%\options.rc.vim
