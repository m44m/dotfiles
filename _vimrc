scriptencoding cp932

" �N�����̃p�X
if expand("%") == ''
  cd ~
endif

" �o�b�N�A�b�v�t�@�C�����쐬���Ȃ�
set nowritebackup
set nobackup

" �X���b�v�t�@�C���̍쐬��
set directory=~/.vim/swap

" �s�ԍ��\��
set number

" ���ʂ̑Ή��\������
:set showmatch matchtime=1

"�^�u�ݒ�
set ts=2 sw=2 sts=2
set expandtab

"�����C���f���g
set autoindent

" �N���b�v�{�[�h�A�g
" set clipboard=unnamed,autoselect

" Tab,�s���̔��p�X�y�[�X�𖾎��I�ɕ\��
set list
set listchars=tab:^\ ,trail:~,extends:\

" �S�p�X�y�[�X��\��
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
endfunction
if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /�@/
  augroup END
  call ZenkakuSpace()
endif

" ���ߕ\���ݒ�
gui
set transparency=225

" �X�e�[�^�X���C���ݒ�
" �����R�[�h��\��
set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 

" �J�[�\���s�̃n�C���C�g
autocmd WinEnter *  setlocal cursorline
autocmd WinLeave *  setlocal nocursorline

"�}�����[�h���A�X�e�[�^�X���C���̐F��ύX
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

"���E�L�[�ōs���܂����ňړ�����
set whichwrap=b,s,[,],<,>
nnoremap h <Left>zv
nnoremap l <Right>zv

" �}�����[�h�Ɉڍs/������ۂ�IME���[�h������
autocmd InsertEnter * let &l:iminsert=0
autocmd InsertLeave * let &l:iminsert=0

" vimgrep����QuickFix�E�B���h�E�������I�ɕ\��
autocmd QuickFixCmdPost vimgrep cw

" �܂���
" :let g:xml_syntax_folding = 1
" :set foldmethod=syntax

"-----------------------------
" �L�[�}�b�s���O
"-----------------------------
" �s���s���̍��E�ړ��ōs���܂���
"set compatible
set whichwrap=b,s,h,l,<,>,[,]  

"�J�[�\����\���s�ňړ�
nnoremap j gj
nnoremap k gk

" .vimrc ��ʃ^�u�ŊJ��
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>

" �A���\��t���΍�
vnoremap <silent> <C-p> "0p<CR>

"�����̓��͕⏕
inoremap <expr> ,df strftime('%Y-%m-%d %H:%M:%S')
inoremap <expr> <C-;> strftime('%Y-%m-%d')
inoremap <expr> ,dd strftime('%Y-%m-%d')
inoremap <expr> ,dt strftime('%H:%M:%S')

" �I�𒆂̃e�L�X�g������
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>
vnoremap <silent> # "vy?\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

" ���O�̃R�}���h�̌J��Ԃ�
nnoremap c. q:k<CR>

" Home�L�[�̋�����ύX
noremap  <Home> ^
" noremap  <Home><Home> 0
inoremap <Home> <Esc>^i

" ESC�L�[���E�B���h�E�Y
"nmap <Esc> <C-w>

" ���t�A�����̑}��
noremap! <Leader>date <C-R>=strftime('%Y/%m/%d')<CR>
noremap! <Leader>time <C-R>=strftime('%H:%M')<CR>
noremap! <Leader>tstamp <C-R>=strftime('%Y%m%d%H%M')<CR>
noremap! <Leader>dstamp <C-R>=strftime('%Y%m%d')<CR>

"���k
command! Zip :! 7z.exe a -p %:r.zip %

"-----------------------------
" �v���O�C���ݒ�
"-----------------------------
" netrw.vim
" netrw�͏��tree view
let g:netrw_liststyle = 3
" CVS��.�Ŏn�܂�t�@�C���͕\�����Ȃ�
let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
" 'v'�Ńt�@�C�����J���Ƃ��͉E���ɊJ���B(�f�t�H���g�������Ȃ̂œ���ւ�)
let g:netrw_altv = 1
" 'o'�Ńt�@�C�����J���Ƃ��͉����ɊJ���B(�f�t�H���g���㑤�Ȃ̂œ���ւ�)
let g:netrw_alto = 1

"SSH�N���C�A���g�ݒ�
if (has('win32') || has('win64'))
  "use scp
  let g:netrw_scp_cmd     = "C:\\PuTTY\\pscp.exe -q -batch"
  let g:netrw_sftp_cmd    = "C:\\PuTTY\\psftp.exe"
  let g:netrw_ssh_cmd     = "C:\\PuTTY\\plink.exe"
endif

" Align����{����Ŏg�p���邽�߂̐ݒ�
:let g:Align_xstrlen = 3

"TeraTerm�}�N���̃L�[���[�h��`
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

" ���łɃC���X�^���X������ꍇ�͂������ŊJ��
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

" neosnippet-examples ������p ------------------
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
" IDE���ɋN��
command! Ide :VimFiler -split -simple -winwidth=50 -no-quit

" vinarise
let g:vinarise_enable_auto_detect = 1
 
" unite-build map
nnoremap <silent> ,vb :Unite build<CR>
nnoremap <silent> ,vcb :Unite build:!<CR>
nnoremap <silent> ,vch :UniteBuildClearHighlight<CR>

" �E�B���h�E�𕪊����ĊJ��
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" �E�B���h�E���c�ɕ������ĊJ��
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESC�L�[��2�񉟂��ƏI������
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" ctrlp
" let g:ctrlp_use_migemo = 1
" let g:ctrlp_clear_cache_on_exit = 0   " �I�����L���b�V�����N���A���Ȃ�
" let g:ctrlp_mruf_max            = 500 " MRU�̍ő�L�^��
" let g:ctrlp_open_new_file       = 1   " �V�K�t�@�C���쐬���Ƀ^�u�ŊJ��

"emmet-vim
let g:user_emmet_expandabbr_key = '<c-e>'
let g:use_emmet_complete_tag = 1

"vim-singleton
call singleton#enable()

" Closure Linter
" refer to:
" http://www.curiosity-drives.me/2012/01/vimjavascript.html
" #���@�`�F�b�N
"autocmd FileType javascript :compiler gjslint
"autocmd QuickfixCmdPost make copen
" -> Windwos(7 x64)��gjslint�������Ȃ�����...

" jscomplete-vim {{{
autocmd FileType javascript
  \ :setl omnifunc=jscomplete#CompleteJS
" DOM��Mozilla�֘A��ES6�̃��\�b�h��⊮
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
