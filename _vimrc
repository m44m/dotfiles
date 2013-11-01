scriptencoding cp932

" 起動時のパス
if expand("%") == ''
  cd ~
endif

" バックアップファイルを作成しない
set nowritebackup
set nobackup

" スワップファイルの作成先
set directory=~/.vim/swap

" 行番号表示
set number

" 括弧の対応表示時間
:set showmatch matchtime=1

"タブ設定
set ts=2 sw=2 sts=2
set expandtab

"自働インデント
set autoindent

" クリップボード連携
" set clipboard=unnamed,autoselect

" Tab,行末の半角スペースを明示的に表示
set list
set listchars=tab:^\ ,trail:~,extends:\

" 全角スペースを表示
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif

" 透過表示設定
gui
set transparency=225

" ステータスライン設定
" 文字コードを表示
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 

" カーソル行のハイライト
autocmd WinEnter *  setlocal cursorline
autocmd WinLeave *  setlocal nocursorline

"挿入モード時、ステータスラインの色を変更
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
    redraw
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

"左右キーで行をまたいで移動する
set whichwrap=b,s,[,],<,>
nnoremap h <Left>zv
nnoremap l <Right>zv

" 挿入モードに移行/抜ける際にIMEモードを解除
autocmd InsertEnter * let &l:iminsert=0
autocmd InsertLeave * let &l:iminsert=0

" vimgrep時にQuickFixウィンドウを自働的に表示
autocmd QuickFixCmdPost vimgrep cw

" 折り畳み
" :let g:xml_syntax_folding = 1
" :set foldmethod=syntax

"-----------------------------
" キーマッピング
"-----------------------------
" 行頭行末の左右移動で行をまたぐ
"set compatible
set whichwrap=b,s,h,l,<,>,[,]  

"カーソルを表示行で移動
nnoremap j gj
nnoremap k gk

" .vimrc を別タブで開く
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>

" 連続貼り付け対策
vnoremap <silent> <C-p> "0p<CR>

"日時の入力補助
inoremap <expr> ,df strftime('%Y-%m-%d %H:%M:%S')
inoremap <expr> <C-;> strftime('%Y-%m-%d')
inoremap <expr> ,dd strftime('%Y-%m-%d')
inoremap <expr> ,dt strftime('%H:%M:%S')

" 選択中のテキストを検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>
vnoremap <silent> # "vy?\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

" 直前のコマンドの繰り返し
nnoremap c. q:k<CR>

" Homeキーの挙動を変更
noremap  <Home> ^
" noremap  <Home><Home> 0
inoremap <Home> <Esc>^i

" ESCキーをウィンドウズ
"nmap <Esc> <C-w>

" 日付、時刻の挿入
noremap! <Leader>date <C-R>=strftime('%Y/%m/%d')<CR>
noremap! <Leader>time <C-R>=strftime('%H:%M')<CR>
noremap! <Leader>tstamp <C-R>=strftime('%Y%m%d%H%M')<CR>
noremap! <Leader>dstamp <C-R>=strftime('%Y%m%d')<CR>

"圧縮
command! Zip :! 7z.exe a -p %:r.zip %

"-----------------------------
" プラグイン設定
"-----------------------------
" netrw.vim
" netrwは常にtree view
let g:netrw_liststyle = 3
" CVSと.で始まるファイルは表示しない
let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
" 'v'でファイルを開くときは右側に開く。(デフォルトが左側なので入れ替え)
let g:netrw_altv = 1
" 'o'でファイルを開くときは下側に開く。(デフォルトが上側なので入れ替え)
let g:netrw_alto = 1

"SSHクライアント設定
if (has('win32') || has('win64'))
  "use scp
  let g:netrw_scp_cmd     = "C:\\PuTTY\\pscp.exe -q -batch"
  let g:netrw_sftp_cmd    = "C:\\PuTTY\\psftp.exe"
  let g:netrw_ssh_cmd     = "C:\\PuTTY\\plink.exe"
endif

" Alignを日本語環境で使用するための設定
:let g:Align_xstrlen = 3

"TeraTermマクロのキーワード定義
autocmd BufWinEnter,BufNewFile *.ttl setlocal filetype=ttl
" for NERD_commenter
autocmd Filetype ttl setlocal commentstring=;\ %s
" for quickrun
"let g:quickrun_config['ttl'] = {'command': 'ttpmacro' }


"NeoBundle
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

" すでにインスタンスがある場合はそっちで開く
if has('clientserver')
    NeoBundle 'https://github.com/thinca/vim-singleton'
    call singleton#enable()
endif

NeoBundle 'https://github.com/Shougo/neocomplcache.git'
NeoBundle 'https://github.com/Shougo/neosnippet.git'
NeoBundle 'https://github.com/Shougo/unite.vim.git'
NeoBundle 'https://github.com/Shougo/vimfiler.git'
NeoBundle 'https://github.com/Shougo/vimshell.git'
NeoBundle 'https://github.com/Shougo/vimproc.git'
NeoBundle 'https://github.com/vim-scripts/Align.git'
NeoBundle 'https://github.com/glidenote/memolist.vim.git'
NeoBundle 'https://github.com/kien/ctrlp.vim.git'
NeoBundle 'https://github.com/thinca/vim-quickrun'
NeoBundle 'https://github.com/mattn/emmet-vim'
NeoBundle 'https://github.com/thinca/vim-singleton'
NeoBundle 'https://github.com/tpope/vim-surround'
NeoBundle 'https://github.com/ujihisa/vimshell-ssh'
" JavaScript
NeoBundle 'https://github.com/teramako/jscomplete-vim.git'
NeoBundle 'https://github.com/scrooloose/syntastic.git'



"Omnisharp
NeoBundleLazy 'https://github.com/nosami/Omnisharp', {
\   'autoload': {'filetypes': ['cs']},
\   'build': {
\     'windows': 'C:/Windows/Microsoft.NET/Framework/v4.0.30319/MSBuild.exe server/OmniSharp.sln /p:Platform="Any CPU"',
\     'mac': 'xbuild server/OmniSharp.sln',
\     'unix': 'xbuild server/OmniSharp.sln',
\   }
\ }

" vim-javascript-syntax
NeoBundleLazy 'jelera/vim-javascript-syntax', {'autoload':{'filetypes':['javascript']}}

filetype plugin on
filetype indent on
" Installation check.

if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif


" <TAB>: completion.                                         
inoremap <expr><CR>     pumvisible() ? neocomplcache#close_popup(): "\<CR>"
inoremap <expr><TAB>    pumvisible() ? "\<C-n>" : "\<TAB>"   
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>" 

"neocomplcache/neosnippet
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_cursor_hold_i = 1
let g:neosnippet#snippets_directory = '~/.vim/snippets'

" neosnippet-examples から引用 ------------------
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
xmap <C-l>     <Plug>(neosnippet_start_unite_snippet_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)"
 \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
 \ "\<Plug>(neosnippet_expand_or_jump)"
 \: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Enable snipMate compatibility feature.
 let g:neosnippet#enable_snipmate_compatibility = 1
" -----------------------------------------------

" unite.vim
nnoremap [unite] <nop>
nmap     <Leader>f [unite]

nnoremap [unite]u :<C-u>Unite -no-splitM<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>file<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir<CR>
nnoremap <silent> ,vr :UniteResume<CR>

" vimfiler.vim
" IDE風に起動
command! Ide :VimFiler -split -simple -winwidth=50 -no-quit

" vinarise
let g:vinarise_enable_auto_detect = 1
 
" unite-build map
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

" ctrlp
" let g:ctrlp_use_migemo = 1
" let g:ctrlp_clear_cache_on_exit = 0   " 終了時キャッシュをクリアしない
" let g:ctrlp_mruf_max            = 500 " MRUの最大記録数
" let g:ctrlp_open_new_file       = 1   " 新規ファイル作成時にタブで開く

"emmet-vim
let g:user_emmet_expandabbr_key = '<c-e>'
let g:use_emmet_complete_tag = 1

"vim-singleton
call singleton#enable()

" Closure Linter
" refer to:
" http://www.curiosity-drives.me/2012/01/vimjavascript.html
" #文法チェック
"autocmd FileType javascript :compiler gjslint
"autocmd QuickfixCmdPost make copen
" -> Windwos(7 x64)でgjslintが動かなかった...

" jscomplete-vim {{{
autocmd FileType javascript
  \ :setl omnifunc=jscomplete#CompleteJS
" DOMとMozilla関連とES6のメソッドを補完
let g:jscomplete_use = ['dom', 'moz', 'es6th']
" }}}

" syntastic {{{
let g:syntastic_javascript_checker = "jshint"
let g:syntastic_mode_map = {
      \  'mode': 'active',
      \ 'active_filetypes': ['ruby', 'javascript'],
      \ 'passive_filetypes': []
      \ }
" }}}
