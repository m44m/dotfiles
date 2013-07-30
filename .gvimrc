scriptencoding cp932
"コメント以外で日本語を使用している箇所があるのでこのファイルとscriptencodingが一致するように注意
"----------------------------------------
" システム設定
"----------------------------------------
"エラー時の音とビジュアルベルの抑制
set noerrorbells
set novisualbell
set visualbell t_vb=

if has('multi_byte_ime') || has('xim')
  "起動直後の挿入モードでは日本語入力を有効にしない
  set iminsert=0 imsearch=0
  if has('xim') && has('GUI_GTK')
    "XIMの入力開始キー
    "set imactivatekey=C-space
  endif
endif

"IMEの状態をカラー表示
if has('multi_byte_ime')
  highlight Cursor guifg=NONE guibg=Green
  highlight CursorIM guifg=NONE guibg=Purple
endif

"----------------------------------------
" 表示設定
"----------------------------------------
" ツールバーを非表示
set guioptions-=T
" コマンドラインの高さ
 set cmdheight=2

set showtabline=2

"カラー設定:
"colorscheme phd
colorscheme molokai


"フォント設定
"フォントは英語名で指定すると問題が起きにくくなります
if has('xfontset')
" set guifontset=a14,r14,k14
elseif has('unix')

elseif has('mac')
  set guifont=Ricty:h14
elseif has('win32') || has('win64')
   set guifont=Consolas:h9:cSHIFTJIS
   set guifontwide=MigMix_1M:h9:cSHIFTJIS
endif

"印刷用フォント
if has('printer')
  if has('win32') || has('win64')
"    set printfont=MS_Mincho:h12:cSHIFTJIS
"    set printfont=MS_Gothic:h12:cSHIFTJIS
  endif
endif

" """"""""""""""""""""""""""""""
" "Window位置の保存と復帰
" """"""""""""""""""""""""""""""
" if has('unix')
"   let s:infofile = '~/.vim/.vimpos'
" else
"   let s:infofile = '~/_vimpos'
" endif
" 
" function! s:SaveWindowParam(filename)
"   redir => pos
"   exec 'winpos'
"   redir END
"   let pos = matchstr(pos, 'X[-0-9 ]\+,\s*Y[-0-9 ]\+$')
"   let file = expand(a:filename)
"   let str = []
"   let cmd = 'winpos '.substitute(pos, '[^-0-9 ]', '', 'g')
"   cal add(str, cmd)
"   let l = &lines
"   let c = &columns
"   cal add(str, 'set lines='. l.' columns='. c)
"   silent! let ostr = readfile(file)
"   if str != ostr
"     call writefile(str, file)
"   endif
" endfunction
" 
" augroup SaveWindowParam
"   autocmd!
"   execute 'autocmd SaveWindowParam VimLeave * call s:SaveWindowParam("'.s:infofile.'")'
" augroup END
" 
" if filereadable(expand(s:infofile))
"   execute 'source '.s:infofile
" endif
" unlet s:infofile

" Windowwの初期サイズ
set lines=40
set columns=120


set wrap!

