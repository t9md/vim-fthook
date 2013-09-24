"=============================================================================
" File: fthook.vim
" Author: t9md <taqumd@gmail.com>
" Version: 0.3
" WebPage: https://github.com/t9md/vim-fthook
" License: BSD

" GUARD: {{{1
"============================================================
if exists('g:loaded_fthook')
  finish
endif
let g:loaded_fthook = 1
let s:old_cpo = &cpo
set cpo&vim

" MAIN: {{{1
"============================================================
if !exists('g:fthook') || type(g:fthook) != 4
    let g:fthook = {}
endif

function! s:call_hook() "{{{
    if type(get(g:fthook, "_", -1)) == 2
      call call(g:fthook["_"], [], {})
    endif

    let ft_underscore = tr(&filetype, '-' , '_')
    if type(get(g:fthook, ft_underscore, -1)) == 2
      call call(g:fthook[ft_underscore], [], {})
    endif
endfunction "}}}

augroup fthook "{{{
    autocmd!
    autocmd! FileType * call s:call_hook()
augroup END "}}}

" FINISH: {{{1
"============================================================
let &cpo = s:old_cpo
" vim: set sw=4 sts=4 et fdm=marker fdc=3 fdl=3:
