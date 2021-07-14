# fireplace-plus

A few personal niceties on top of Tim's hard work (Tim Pope is the creator of fireplace.vim)

...Currently this is only some helpers for using [Debux](https://github.com/philoskim/debux).  Removed a couple other things that weren't quite there.
## Requirements
1. [Vim Fireplace](https://github.com/tpope/vim-fireplace)
2. Leiningen based project
3. Debux
4. `profiles.clj` that includes debux in the `:dependencies`.  ...Something like
```clj
{:user {:dependencies [[philoskim/debux "0.7.9"]]}}
```

## Using the Debux helpers:

This script exposes two Debux commands, 
- `DbxInstrument`
- `DbxUnstrument`

To use, place cursor inside function body and call `DbxInstrument`.

That will transform a fn such as this:
```clj
(defn howdy [name]
  (str "Hello " name "!!!!"))
```
into
```clj
(defn howdy [name]
  (use 'debux.core)
  (debux.core/dbgn
  (str "Hello " name "!!!!")))
```
The next time `howdy` is evaled, you'll get all of the beautiful `dbgn` info in your repl.

Use `DbxUnstrument` to put the fn back to normal.

## Keybindings
No keybindings are added in this script.
I use these in my `init.vim`:
```viml
nnoremap <Leader>xi :DbxInstrument<CR>
nnoremap <Leader>xu :DbxUnstrument<CR>
```

## Limitations
1. Currently only works for lein projects..  
2. Currently only works for clj.   Can work for cljs projects with a couple very simple tweaks.
