set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
" scriptencoding utf8

" 起動時のパスを$Homeに設定
if expand("%") == ''
  cd ~
endif

let s:vimfiles = has("win32") ? '~/vimfiles' : '~/.vim'

" Backup/Swap/Undo {{{
" Backup/Swap は作成しない
set nowritebackup
set nobackup
set noswapfile

" Undファイルの作成先
set undodir=~/.vim/undo,~/vimfiles/undo
" }}}

set number
set showmatch matchtime=1

" タブ設定
set ts=2 sw=2 sts=2
set expandtab

" 自動インデント
set autoindent

" vsplitは右で開く
set splitright

" キーマッピング {{{
" -----
" カーソルを表示行で移動
nnoremap j gj
nnoremap k gk

" vimrcを開く
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>

" 行末までヤンク
nnoremap Y y$

" Esc 2回でハイライト消去
nmap <ESC><ESC> :noh<CR><ESC>

" 日付、時刻の挿入
noremap! <Leader>dt <C-R>=strftime('%Y/%m/%d')<CR>
noremap! <Leader>tm <C-R>=strftime('%H:%M')<CR>
noremap! <Leader>ts <C-R>=strftime('%Y%m%d%H%M')<CR>
noremap! <Leader>ds <C-R>=strftime('%Y%m%d')<CR>

" -----
" }}}

" 挿入モードに移行/抜ける際にIMEモードを解除 {{{
autocmd InsertEnter * let &l:iminsert=0
autocmd InsertLeave * let &l:iminsert=0
" }}}



" plugins {{{

"dein.vim {{{

if &compatible
  set nocompatible
endif

"プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim が無ければ github から落としてくる
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
let &runtimepath = s:dein_repo_dir . ',' . &runtimepath

"設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  let g:rc_dir    = expand(s:vimfiles . '/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'


  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

call dein#call_hook('source')

if dein#check_install()
  call dein#install()
endif

"}}} dein.vim

let g:python3_host_prog = expand('C:\\Program Files\\Python37\\python.exe')

" }}} plugins

syntax enable
filetype plugin indent on
