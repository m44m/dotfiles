" vim:set foldmethod=marker:
set encoding=utf-8
filetype off
filetype plugin indent on
scriptencoding utf8


" vimフォルダの場所
let s:vimfiles = has('win32') ? '~/vimfiles' : '~/.vim'

" python dll のパス定義
let s:pythonpath = expand($PYTHONPATH . '/python36.dll')
set pythonthreedll=s:pythonpath

" 起動時のパスをホームディレクトリに設定 {{{
if expand("%") == ''
  cd ~
endif
" }}}

" cdpath {{{
" 環境変数CDPATHを設定しておく
let &cdpath = ',' . substitute(substitute($CDPATH, '\\', '/', 'g'), ';', ',', 'g')
" }}}

" shell {{{
" shellをpowerpointにしておく
if has('win32') 
  set shell=C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe
endif
" }}}

" バックアップファイルを作成しない {{{
set nowritebackup
set nobackup
" }}}

" スワップファイルの作成先 => 作成しない {{{
" set directory=~/.vim/undo,~/vimfiles/undo
" 作成しない
set noswapfile
" }}}

" Undoファイルの作成先
set undodir=~/.vim/undo,~/vimfiles/undo

" encoding設定 {{{
if has('win32') && has('kaoriya') && has('gui')
  set   ambiwidth=auto
else
  set   ambiwidth=double
endif

if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'

  if iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213,euc-jp'
    let s:enc_jis = 'iso-2022-jp-3'
  endif

  set   fileencodings&
  let &fileencodings = &fileencodings.','.s:enc_jis.',cp932,'.s:enc_euc

  unlet s:enc_euc
  unlet s:enc_jis
endif

" utf-8優先簡易版
let &fileencodings=substitute(substitute(&fileencodings, ',\?utf-8', '', 'g'), 'cp932', 'utf-8,cp932', '')

if has('win32unix') || has('win32') || has('win64')
  set   termencoding=cp932
elseif !has('macunix')
  set   termencoding=
endif
" }}}

" 行番号表示
set number

" 括弧の対応表示時間
set showmatch matchtime=1

"タブ設定
set ts=2 sw=2 sts=2
set expandtab

"自働インデント
set autoindent

" バックスペース設定
set backspace=indent,eol,start

" クリップボード連携
" set clipboard=unnamed,autoselect

" 選択するとクリップボードにコピー
"GUI
set guioptions+=a
"CUI
"set clipboard+=autoselect

" 右クリックで貼り付け
nnoremap <RightMouse> "*p
inoremap <RightMouse> <C-r><C-o>*

" Tab,行末の半角スペースを明示的に表示
set list
set listchars=tab:^\ ,trail:~,extends:\

if has('gui')
  gui
endif
" }}}

"カラー設定: {{{
"autocmd ColorScheme * highlight Comment guifg=#9C9884
"autocmd ColorScheme * highlight Search guifg=#000000 guibg=#FD971F
"colorscheme molokai

set background=dark
colorscheme solarized
" }}}


" カーソル行のハイライト {{{
autocmd WinEnter *  setlocal cursorline
autocmd WinLeave *  setlocal nocursorline
" }}}

" 挿入モードに移行/抜ける際にIMEモードを解除 {{{
autocmd InsertEnter * let &l:iminsert=0
autocmd InsertLeave * let &l:iminsert=0
" }}}

" vimgrep時にQuickFixウィンドウを自働的に表示 {{{
autocmd QuickFixCmdPost vimgrep cw
" }}}

"<<キーマッピング>> {{{

" LeaderをSpaceに変更
"let mapleader = "\<Space>"


" 行頭行末の左右移動で行をまたぐ
"set nocompatible
"set whichwrap=b,s,h,l,<,>,[,]  

"左右キーで行をまたいで移動する
"set whichwrap=b,s,[,],<,>
"nnoremap h <Left>zv
"nnoremap l <Right>zv


"カーソルを表示行で移動
nnoremap j gj
nnoremap k gk

" .vimrc を別タブで開く
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>

" 行末までヤンク
nnoremap Y y$

" 連続貼り付け対策
vnoremap <silent> <C-p> "0p<CR>
vnoremap <silent> <C-P> "0P<CR>

" 選択中のテキストを検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>
vnoremap <silent> # "vy?\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

" 直前のコマンドの繰り返し
nnoremap c. q:k<CR>

" Homeキーの挙動を変更
noremap  <Home> ^
" noremap  <Home><Home> 0
inoremap <Home> <Esc>^i

" Esc 2回でハイライト消去
nmap <ESC><ESC> :noh<CR><ESC>


""日時の入力補助
"inoremap <expr> ,df strftime('%Y-%m-%d %H:%M:%S')
"inoremap <expr> <C-;> strftime('%Y-%m-%d')
"inoremap <expr> ,dd strftime('%Y-%m-%d')
"inoremap <expr> ,dt strftime('%H:%M:%S')

" 日付、時刻の挿入
noremap! <Leader>date <C-R>=strftime('%Y/%m/%d')<CR>
noremap! <Leader>time <C-R>=strftime('%H:%M')<CR>
noremap! <Leader>tstamp <C-R>=strftime('%Y%m%d%H%M')<CR>
noremap! <Leader>dstamp <C-R>=strftime('%Y%m%d')<CR>

"圧縮
command! Zip :! 7za.exe a -p %:r.zip %

"ファイルフォーマットの変換
command! Conv2utf8 set fileencoding=utf-8
function! Conv2utf8()
  set fileencoding=utf-8
  set fileformat=unix
endfunction

"}}}

" <<Syntax>> {{{

" log4js
autocmd BufRead,BufNewFile *.log set syntax=log4j

" }}}

" <<プラグイン設定>>
" netrw.vim {{{
" netrwは常にtree view
let g:netrw_liststyle = 3
" CVSと.で始まるファイルは表示しない
let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1
" }}}

" Alignを日本語環境で使用するための設定 {{{
:let g:Align_xstrlen = 3
" }}}

"TeraTermマクロのキーワード定義 {{{
autocmd BufWinEnter,BufNewFile *.ttl setlocal filetype=ttl
" for NERD_commenter
autocmd Filetype ttl setlocal commentstring=;\ %s
" for quickrun
"let g:quickrun_config['ttl'] = {'command': 'ttpmacro' }
" }}}

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

  "let g:dein#install_log_filename = g:rc_dir . '/dein_install.log'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})


  " 設定終了
  call dein#end()
  call dein#save_state()
endif
call dein#call_hook('source')

if dein#check_install()
  call dein#install()
endif

"}}}


"neosnippet {{{ ----------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)
"
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
 \: pumvisible() ? "\<C-k>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)"
 \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"let g:neosnippet#snippets_directory = s:vimfiles . '/snippets'
"let g:neosnippet#disable_runtime_snippets = {"_": 1,}
"neosnippet }}} ----------

"neocomplete.vim {{{ ----------
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <TAB>: completion.
"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1


" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
"autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

let g:neocomplete#sources#omni#input_patterns.javascript = '[^. \t]\.\w*'
"neocomplete.vim }}} ----------

" unite.vim {{{
nnoremap [unite] <nop>
nmap     <Leader>f [unite]

nnoremap [unite]u :<C-u>Unite -no-splitM<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>file<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir<CR>
nnoremap <silent> ,vr :UniteResume<CR>
" }}}
" unite-build map {{{
nnoremap <silent> ,vb :Unite build<CR>
nnoremap <silent> ,vcb :Unite build:!<CR>
nnoremap <silent> ,vch :UniteBuildClearHighlight<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
" }}}

" vimfiler.vim {{{
" IDE風に起動
command! Ide :VimFiler -split -simple -winwidth=50 -no-quit
" }}}

" ctrlp {{{
let g:ctrlp_use_migemo = 1
let g:ctrlp_clear_cache_on_exit = 0   " 終了時キャッシュをクリアしない
let g:ctrlp_mruf_max            = 500 " MRUの最大記録数
let g:ctrlp_open_new_file       = 1   " 新規ファイル作成時にタブで開く
" }}}

"emmet-vim {{{
let g:user_emmet_expandabbr_key = '<c-k>'
let g:use_emmet_complete_tag = 1
" }}}

" vim-indent-guides {{{
 let g:indent_guides_start_level = 2
 let g:indent_guides_enable_on_vim_startup = 1
 let g:indent_guides_color_change_percent = 5
 let g:indent_guides_guide_size = 2
" }}}

" vim-over {{{
  nnoremap <silent> <Leader>m :OverCommandLine<CR>
  " カーソル下の単語をハイライト付きで置換
  nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>
  " コピーした文字列をハイライト付きで置換
  nnoremap subp :OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '//!', 'g')<CR>!!gI<Left><Left><Left>
" }}}

" yankround.vim {{{
  " キーマップ
  nmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap <C-n> <Plug>(yankround-prev)
  nmap <C-p> <Plug>(yankround-next)

  "履歴取得数
  let g:yankround_max_history = 50

  "履歴一覧(kien/ctrp.vim)
  nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
" }}}

" JavaScript {{{
let g:ale_fixers = {'javascript': ['prettier']}
let g:ale_fix_on_save = 1

function! EnableJavascript()
  " Setup used libraries
  let g:used_javascript_libs = 'jquery,react'
  let b:javascript_lib_use_jquery = 1
  let b:javascript_lib_use_react = 1
endfunction
autocmd FileType javascript,javascript.jsx call EnableJavascript()
"}}}

" Python {{{
" jedi-vim
"let s:hooks = neobundle#get_hooks('jedi-vim')
"function! s:hooks.on_source(bundle)
"  " 自動設定機能をOFFにし手動で設定を行う
"  let g:jedi#auto_vim_configuration = 0
"  " 補完の最初の項目が選択された状態だと使いにくいためオフにする
"  let g:jedi#popup_select_first = 0
"  " quickrunと被るため大文字に変更
"  let g:jedi#rename_command = '<Leader>R'
"  " gundooと被るため大文字に変更
"  let g:jedi#goto_command = '<Leader>G'
"endfunction
" }}}

filetype plugin indent on
syntax on

