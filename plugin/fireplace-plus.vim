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

function! DbxInstrument()
  try
    execute 'silent normal! ' . "?defn\r/]\r"
    execute 'silent normal! ' . "o(use 'debux.core)"
    execute ':Eval'
    execute 'silent normal! ' . "o(debux.core/dbgn"
    execute 'silent normal! ' . "j0%$a)"
    execute ':Eval'
  catch
    return 0
  endtry
endfunction

function! DbxUnstrument()
  try
    execute 'silent normal! ' . "?defn\r/(use 'debux.core\r"
    execute 'silent normal! ' . "dd"
    execute 'silent normal! ' . "dd%$x"
    execute ':Eval'
  catch
    return 0
  endtry
endfunction

command! -nargs=0 DbxInstrument call DbxInstrument()
command! -nargs=0 DbxUnstrument call DbxUnstrument()
