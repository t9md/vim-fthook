" Guard:
if exists('g:loaded_fthook')
  finish
endif

let g:loaded_fthook = 1
let s:old_cpo = &cpo
set cpo&vim

" Main:
let s:options = {
      \ 'g:fthook' : {},
      \ }

function! s:set_options(options) "{{{
  for [varname, value] in items(a:options)
    if !exists(varname)
      let {varname} = value
    endif
    unlet value
  endfor
endfunction "}}}
call s:set_options(s:options)

function! s:call_hook(afile, amatch) "{{{
  let context = { 'afile' : a:afile, 'amatch': a:amatch }

  if exists('*g:fthook._')
    call g:fthook._(context)
  endif

  let ft_underscore = tr(&filetype, '-' , '_')

  if exists('*g:fthook.' . ft_underscore)
    call g:fthook[ft_underscore](context)
  endif

  " if type(get(g:fthook, ft_underscore, -1)) == 2
    " call g:fthook[ft_underscore](context)
  " endif
endfunction "}}}

augroup plugin-fthook "{{{
  autocmd!
  autocmd! FileType * call s:call_hook(expand('<afile>'), expand('<amatch>'))
  " autocmd! BufReadPost * call s:call_hook(expand('<afile>'), expand('<amatch>'))
augroup END "}}}

let &cpo = s:old_cpo
" vim: foldmethod=marker
