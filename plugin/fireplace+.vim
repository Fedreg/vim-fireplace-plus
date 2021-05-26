" fireplace+.vim - Just for me; a few niceties a top of Tim Pope's hard work
" Version: 0.1
" Author: Fed Reggiardo <fedreg@me.com> (Vimscript noob)

""""""""""""""""""""""""""""""""""""""""""""""""""
" Debux: Utils for using 
" https://github.com/philoskim/debux
" debux must be in project.clj, profiles.clj, etc.
" This is pretty terrible code but works.. 
" will improve when time permits
""""""""""""""""""""""""""""""""""""""""""""""""""

function! RequireString()
  if expand('%:e') == 'cljs'
    return "[debux.cs.core :refer-macros [dbgn]]"
  else
    return "[debux.core]"
  endif
endfunction

function! CheckDbxRequireExists()
  "Check if the Dbx require is in the namespace
  try
    let save_cursor = getcurpos()
    execute 'silent normal! ' . "gg/debux\r"
    return 1
  catch
    return 0
  endtry
  call setpos('.', save_cursor)
endfunction

function! DbxRequire()
  "require debux core right below ns require - or delete it
  let dbx_required = CheckDbxRequireExists()
  let req = RequireString()
  if !dbx_required
    execute 'silent normal! ' . "gg/(:require\r"
    execute 'silent normal! ' . "o" . req
    execute 'silent normal! ' . "gg0"
    execute ':Eval'
  else
    execute 'silent normal! ' . "gg/(:require\rjdd"
    execute ':Eval'
  endif
endfunction

function! DbxUnrequire()
  "require debux core right below ns require - or delete it
  let dbx_required = CheckDbxRequireExists()
  let req = RequireString()
  if !dbx_required
    execute 'silent normal! ' . "gg/(:require\r"
    execute 'silent normal! ' . "o" . req
    execute 'silent normal! ' . "gg0"
    execute ':Eval'
  else
    execute 'silent normal! ' . "gg/(:require\rjdd"
    execute ':Eval'
  endif
endfunction

function! DbxInstrument()
  try
    let save_cursor = getcurpos()
    let dbx_required = CheckDbxRequireExists()
    call setpos('.', save_cursor)
    if !dbx_required
      call DbxRequire()
      call setpos('.', save_cursor)
    endif
    execute 'silent normal! ' . "?defn\r/]\r"
    execute 'silent normal! ' . "o#d/dbgn"
    execute ':Eval'
  catch
    return 0
  endtry
endfunction

function! DbxUnstrument()
  try
    let save_cursor = getcurpos()
    let dbx_required = CheckDbxRequireExists()
    call setpos('.', save_cursor)
    if dbx_required
      call DbxRequire()
      call setpos('.', save_cursor)
    endif
    execute 'silent normal! ' . "?defn\r/#d/\dbgn\r"
    execute 'silent normal! ' . "dd"
    execute ':Eval'
  catch
    return 0
  endtry
endfunction

command! -nargs=0 DbxInstrument call DbxInstrument()
command! -nargs=0 DbxUnstrument call DbxUnstrument()

