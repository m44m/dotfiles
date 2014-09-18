" vim:set foldmethod=marker:

scriptencoding utf8

" 起動時のパスをホームディレクトリに設定 {{{
if expand("%") == ''
  cd ~
endif
" }}}

" バックアップファイルを作成しない {{{
set nowritebackup
set nobackup
" }}}

" スワップファイルの作成先 => 作成しない {{{
" set directory=~/.vim/swap
" 作成しない
set noswapfile
" }}}

" Undoファイルの作成先
set undodir=~/.vim/undo

" encoding設定 {{{
set   encoding=utf-8

if has('win32') && has('kaoriya')
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

if has('win32unix')
  set   termencoding=cp932
elseif !has('macunix')
  set   termencoding=euc-jp
endif
" }}}

" Color Scheme (Vim用)
colorscheme molokai

" 行番号表示
set number

" 括弧の対応表示時間
:set showmatch matchtime=1

"タブ設定
set ts=2 sw=2 sts=2
set expandtab

"自働インデント
set autoindent

" バックスペース設定
set backspace=indent,eol,start

" クリップボード連携
" set clipboard=unnamed,autoselect

" Tab,行末の半角スペースを明示的に表示
set list
set listchars=tab:^\ ,trail:~,extends:\

"" 全角スペースを表示 {{{
"function! ZenkakuSpace()
"  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
"endfunction
"if has('syntax')
"  augroup ZenkakuSpace
"    autocmd!
"    autocmd ColorScheme       * call ZenkakuSpace()
"    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
"  augroup END
"  call ZenkakuSpace()
"endif
"}}}

gui
" 透過表示設定 {{{
"set transparency=225
"set transparency=200
" }}}

"カラー設定: {{{
"colorscheme phd

"colorscheme hybrid

autocmd ColorScheme * highlight Comment guifg=#9C9884
autocmd ColorScheme * highlight Search guifg=#000000 guibg=#FD971F
colorscheme molokai

"syntax enable
"set background=dark
"colorscheme solarized
" }}}

" ステータスライン設定 {{{
" 文字コードを表示
"set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 

"挿入モード時、ステータスラインの色を変更
" let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
" 
" if has('syntax')
"   augroup InsertHook
"     autocmd!
"     autocmd InsertEnter * call s:StatusLine('Enter')
"     autocmd InsertLeave * call s:StatusLine('Leave')
"   augroup END
" endif
" 
" let s:slhlcmd = ''
" function! s:StatusLine(mode)
"   if a:mode == 'Enter'
"     silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
"     silent exec g:hi_insert
"   else
"     highlight clear StatusLine
"     silent exec s:slhlcmd
"     redraw
"   endif
" endfunction
" 
" function! s:GetHighlight(hi)
"   redir => hl
"   exec 'highlight '.a:hi
"   redir END
"   let hl = substitute(hl, '[\r\n]', '', 'g')
"   let hl = substitute(hl, 'xxx', '', '')
"   return hl
" endfunction
"}}}

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

" 折り畳み {{{
:let g:xml_syntax_folding = 1
autocmd FileType xml setlocal foldlevel=1
:set foldmethod=syntax
" }}}

"<<キーマッピング>> {{{
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

" ESCキーをウィンドウズ
"nmap <Esc> <C-w>

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
command! Zip :! 7z.exe a -p %:r.zip %

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

"SSHクライアント設定 {{{
if (has('win32') || has('win64'))
  "use scp
  let g:netrw_scp_cmd     = "C:\\PuTTY\\pscp.exe -q -batch"
  let g:netrw_sftp_cmd    = "C:\\PuTTY\\psftp.exe"
  let g:netrw_ssh_cmd     = "C:\\PuTTY\\plink.exe"
endif
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

"simple-javascript-indenter {{{
let g:SimpleJsIndenter_BriefMode = 1
let g:SimpleJsIndenter_CaseIndentLevel = -1
" }}}

"NeoBundle {{{
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

let g:neobundle_default_git_protocol='https'

NeoBundle 'Shougo/neosnippet.git'
NeoBundle 'Shougo/neocomplete.vim.git'
NeoBundle 'Shougo/unite.vim.git'
NeoBundle 'Shougo/vimfiler.git'
NeoBundle 'Shougo/vimshell.git'
NeoBundle 'https://github.com/Shougo/vimproc.git', { 
  \ 'build' : { 
    \ 'windows' : 'make -f make_mingw32.mak', 
    \ 'cygwin'  : 'make -f make_cygwin.mak',
    \ 'mac'     : 'make -f make_mac.mak',
    \ 'unix'    : 'make -f make_unix.mak',
  \ },
\}
NeoBundle 'vim-scripts/Align.git'
NeoBundle 'glidenote/memolist.vim.git'
NeoBundle 'kien/ctrlp.vim.git'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'thinca/vim-singleton'
NeoBundle 'tpope/vim-surround'
NeoBundle 'ujihisa/vimshell-ssh'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'scrooloose/nerdtree.git'
NeoBundle 'nathanaelkane/vim-indent-guides.git'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'LeafCage/yankround.vim'

NeoBundle 'Markdown'
NeoBundle 'suan/vim-instant-markdown'


" JavaScript
" NeoBundle 'teramako/jscomplete-vim.git'
NeoBundle 'scrooloose/syntastic.git'
NeoBundle 'felixge/vim-nodejs-errorformat'
"NeoBundle 'JavaScript-syntax'
"NeoBundle 'pangloss/vim-javascript'
"NeoBundle 'vim-scripts/JavaScript-Indent'

"Omnisharp
NeoBundleLazy 'nosami/Omnisharp', {
\   'autoload': {'filetypes': ['cs']},
\   'build': {
\     'windows': 'C:/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe server/OmniSharp.sln /p:Platform="Any CPU"',
\     'mac': 'xbuild server/OmniSharp.sln',
\     'unix': 'xbuild server/OmniSharp.sln',
\   }
\ }

" vim-javascript-syntax
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}

" tern for vim
"if has('python') && executable('npm')
"  NeoBundleLazy 'marijnh/tern_for_vim', {
"        \ 'build' : 'npm install',
"        \ 'autoload' : {
"        \   'functions': ['tern#Complete', 'tern#Enable'],
"        \   'filetypes' : 'javascript'
"        \ }}
"endif
"NeoBundle 'marijnh/tern_for_vim'

"colorscheme
NeoBundle 'w0ng/vim-hybrid'



filetype plugin on
filetype indent on

NeoBundleCheck
" }}}

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

"neocomplete.vim }}} ----------

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

let g:neosnippet#snippets_directory = '~/.vim/snippets'
let g:neosnippet#disable_runtime_snippets = {"_": 1,}
"neosnippet }}} ----------

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

" vinarise {{{
let g:vinarise_enable_auto_detect = 1
" }}}

" ctrlp {{{
let g:ctrlp_use_migemo = 1
let g:ctrlp_clear_cache_on_exit = 0   " 終了時キャッシュをクリアしない
let g:ctrlp_mruf_max            = 500 " MRUの最大記録数
let g:ctrlp_open_new_file       = 1   " 新規ファイル作成時にタブで開く
" }}}

"emmet-vim {{{
let g:user_emmet_expandabbr_key = '<c-e>'
let g:use_emmet_complete_tag = 1
" }}}

"vim-singleton {{{
" すでにインスタンスがある場合はそっちで開く
if has('clientserver')
    NeoBundle 'thinca/vim-singleton'
    call singleton#enable()
endif
" }}}

" Closure Linter {{{
" refer to:
" http://www.curiosity-drives.me/2012/01/vimjavascript.html
" #文法チェック
"autocmd FileType javascript :compiler gjslint
"autocmd QuickfixCmdPost make copen
" -> Windwos(7 x64)でgjslintが動かなかった...
" }}}

" jscomplete-vim {{{
"autocmd FileType javascript
"  \ :setl omnifunc=jscomplete#CompleteJS
""let g:neobundle_souce_rank = {
""  \ 'jscomplete' : 500,
""  \}
"" DOMとMozilla関連とES6のメソッドを補完
"let g:jscomplete_use = ['dom', 'moz', 'es6th']
" }}}

" syntastic {{{
let g:syntastic_javascript_checkers = ["jshint"]
"let g:syntastic_javascript_jshint_conf = "~/_jshintrc"
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'active_filetypes': ['ruby', 'javascript'],
      \ 'passive_filetypes': []
      \ }
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

" outlook.vim {{{
   NeoBundle 'vim-scripts/OutlookVim.git'
   let g:outlook_always_use_unicode = 1
" }}}
"
