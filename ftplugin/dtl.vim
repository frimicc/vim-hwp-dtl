" Vim filetype plugin
" Language:		HighWire Press DTL
" Maintainer:	Mike Friedman, <friedman+spam@highwire.stanford.edu>	

if exists("b:did_ftplugin")
  finish
endif

runtime! ftplugin/html.vim ftplugin/html_*.vim ftplugin/html/*.vim

" setlocal comments=fb:*,fb:-,fb:+,n:> commentstring=>\ %s
" setlocal formatoptions+=tcqln
" setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\\|^[-*+]\\s\\+

let b:undo_ftplugin .= "|setl cms< com< fo<"

