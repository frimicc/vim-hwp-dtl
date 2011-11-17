" Vim syntax file
" Language:	HighWire Press DTL
" Maintainer:	Mike Friedman, <friedman+spam@highwire.stanford.edu>
" URL:		
" A near-complete rip-off of the PHP syntax file, I think. I inherited this.
" Original rewrite by Aixian Lin, HighWire Press.
" If anyone has provenance for the thing this is based on, please let me know.
"
" Options	
"		dtl_parent_error_close = 1  for highlighting parent error ] or )
"		dtl_parent_error_open = 1  for skipping an dtl end tag, if there exists an open ( or [ without a closing one
"		dtl_folding = 1  for folding classes and functions
"		dtl_sync_method = x
"			x=-1 to sync by search ( default )
"			x>0 to sync at least x lines backwards
"			x=0 to sync from start

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
  set iskeyword+=!,.
elseif exists("b:current_syntax")
  finish
  setlocal iskeyword+=!,.
endif

if !exists("main_syntax")
  let main_syntax = 'dtl'
endif

if version < 600
  so <sfile>:p:h/html.vim
else
  runtime syntax/html.vim
  unlet b:current_syntax
endif

if exists("dtl_parentError")
  let dtl_parent_error_close=1
  unlet dtl_parent_error_open
endif

" accept old options
if !exists("dtl_sync_method")
  if exists("dtl_minlines")
    let dtl_sync_method=dtl_minlines
  else
    let dtl_sync_method=-1
  endif
endif

syn cluster htmlPreproc add=dtlRegion

syn case match


" Env Variables

syn keyword	dtlEnvVar	HTTP_ACCEPT HTTP_ACCEPT_CHARSET HTTP_ACCEPT_LANGUATE HTTP_ACCESS_CONFIG_PATH HTTP_BASICAUTH_USER HTTP_CONFIG_PATH HTTP_CONNECTION HTTP_HOST HTTP_REFERRER HTTP_USER_AGENT SERVER_NAME SEVER_PORT TZ REQUEST_URI contained

" Internal Variables
syn keyword	dtlIntVar 	MONTH_LONG MONTH_MEDIUM MONTH_SHORT MONTH_LZSHORT DAY DAY_LONG YEAR_SHORT YEAR_LONG TIME DAYOFWEEK	contained
syn keyword	dtlIntVar 	TODAY TOTALCOUNT CURRCOUNT ISFIRST ISLAST ALL ALLVARDEFS UPPER LOWER LB RB	contained
syn match	dtlSpecIntVar 	"\!LOOPINDEX\|\!TOTALCOUNT\|\!CURRENTCOUNT\|\!ISFIRST\|!ISLAST"	contained

" syn case ignore

" Function names
syn keyword	dtlFunctions	ADD SUBTRACT MULTIPLY DIVIDE REMAINDER	contained
syn keyword	dtlFunctions	FILTER FTMDATE HTMLTOASCII BEGINS ENDS	contained
syn keyword	dtlFunctions	EVAL EVALDEF DEFINED WITH	contained
" Grr, contains is a special word for syntax files.  How can I fake it out?
" syn match	dtlFunctions	"CONTAINS"	contained

" Conditional
syn keyword	dtlConditional	IF ELSE SWITCH	contained

" Repeat
syn keyword	dtlRepeat	DO FOR WHILE ENDWHILE FOREACH FORLOOP	contained

" Label
syn keyword	dtlLabel	CASE DEFAULT SWITCH	contained

" Statement
syn keyword	dtlStatement	BREAKLOOP NEXTLOOP	contained

" Keyword
syn keyword	dtlKeyword	var	contained

" Type
syn keyword	dtlType	VARDEF STATICVARDEF ARRDEF RECDEF

" Structure
syn keyword	dtlStructure	extends	contained

" StorageClass
syn keyword	dtlStorageClass	global static	contained

" Operator
syn match	dtlOperator	"ANDDEF"	contained display
syn match	dtlOperator	"ORDEF"	contained display
syn match	dtlOperator	"NOT"	contained display
syn match	dtlOperator	"EVERY"	contained display
syn match	dtlOperator	"MULTIPLE"	contained display
syn match	dtlOperator	"DATETYPE\|INTTYPE\|STRINGTYPE"	contained display
syn match	dtlRelation	"EQUAL\|GREATER\|GEQ\|LESS\|LEQ"	contained display
syn match	dtlMemberSelector	"."	contained display
syn match	dtlVarSelector	"\$"	contained display

" Identifier
syn match	dtlIdentifier	"$\h\w*"	contained contains=dtlEnvVar,dtlIntVar,dtlSpecIntVar,dtlVarSelector display
" syn match	dtlIdentifier	"$\(\h\.\)\(\w\.\!\)*"	contained contains=dtlEnvVar,dtlEnvVar,dtlIntVar,dtlVarSelector display

" Include
syn keyword	dtlInclude	INCLUDE INCLUDEDTL INCLUDESLP INCLUDEHTMLASC

" Define
" syn keyword	dtlDefine	new	contained

" Boolean
" syn keyword	dtlBoolean	true false	contained

" Number
syn match dtlNumber	"-\=\<\d\+\>"	contained display

" Float
syn match dtlFloat	"\(-\=\<\d+\|-\=\)\.\d\+\>"	contained display

" SpecialChar
syn match dtlSpecialChar	"\\[abcfnrtyv\\]"	contained display
syn match dtlSpecialChar	"\\\d\{3}"	contained contains=dtlOctalError display
syn match dtlSpecialChar	"\\x[0-9a-fA-F]\{2}"	contained display

" Error
syn match dtlOctalError	"[89]"	contained display
if exists("dtl_parent_error_close")
  syn match dtlParentError	"[)\]}]"	contained display
endif

" Todo
syn keyword	dtlTodo	todo fixme xxx	contained

" Comment
syn region	dtlComment	start="\[/\*" end="\*/\]"	contains=dtlTodo extend
"syn match	dtlComment	"#.\{-}\(?>\|$\)\@="	contained contains=dtlTodo
syn match	dtlComment	"\[//.\{-}\(?>\|$\)\@="	contains=dtlTodo

" String
syn region	dtlStringDouble	matchgroup=None start=+"+ skip=+\\\\\|\\"+ end=+"+	contains=@dtlAddStrings,dtlIdentifier,dtlSpecialChar contained keepend extend
syn region	dtlStringSingle	matchgroup=None start=+'+ skip=+\\\\\|\\'+ end=+'+	contains=@dtlAddStrings,dtlSpecialChar contained keepend extend

" Parent
" if exists("dtl_parent_error_close") || exists("dtl_parent_error_open")
"   syn match dtlParent	"[{}]"	contained
"   syn region	dtlParent	matchgroup=Delimiter start="(" end=")"	contained contains=@dtlClInside transparent
"   syn region	dtlParent	matchgroup=Delimiter start="\[" end="\]"	contained contains=@dtlClInside transparent
" else
"   syn match dtlParent	"[({[\]})]"	contained
" endif

syn cluster	dtlClInside	contains=dtlComment,dtlFunctions,dtlFunctions,dtlIdentifier,dtlConditional,dtlRepeat,dtlLabel,dtlStatement,dtlOperator,dtlRelation,dtlStringSingle,dtlStringDouble,dtlNumber,dtlFloat,dtlSpecialChar,dtlParent,dtlParentError,dtlInclude,dtlKeyword,dtlType,dtlIdentifierParent,dtlBoolean,dtlStructure,dtlMethodsVar,dtlHereDoc
syn cluster	dtlClFunction	contains=@dtlClInside,dtlDefine,dtlParentError,dtlStorageClass
syn cluster	dtlClTop	contains=@dtlClFunction,dtlFoldFunction,dtlFoldClass

if exists("dtl_parent_error_open")
  " Php Region
    syn region	 dtlRegion	matchgroup=Delimiter start="\[\[" end="\]\]"	contains=@dtlClTop
else
  " Php Region
    syn region	 dtlRegion	matchgroup=Delimiter start="\[\[" end="\]\]"	contains=@dtlClTop keepend
endif

" " Fold
" if exists("dtl_folding")
"   set foldmethod=syntax
"   syn region dtlFoldHtmlInside	matchgroup=Delimiter start="?>" end="<?\(dtl\)\=" contained transparent contains=@htmlTop
"   syn region dtlFoldFunction	matchgroup=Define start="^\z\(\s*\)Function" matchgroup=Delimiter end="^\z1}" contains=@dtlClFunction,dtlFoldHtmlInside contained transparent fold extend
"   syn region dtlFoldClass	matchgroup=Structure start="^\z\(\s*\)Class" matchgroup=Delimiter end="^\z1}" contains=@dtlClFunction,dtlFoldFunction contained transparent fold extend
" else
"   syn keyword	dtlDefine	function	contained
"   syn keyword	dtlStructure	class	contained
" endif

" Sync
if dtl_sync_method==-1
    syn sync match dtlRegionSync grouphere dtlRegion "\[\["
  syn sync match dtlRegionSync grouphere dtlRegion +\[\[+
  syn sync match dtlRegionSync groupthere NONE "\]\]"
  syn sync minlines=50
elseif dtl_sync_method>0
  exec "syn sync minlines=" . dtl_sync_method
else
  exec "syn sync fromstart"
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_dtl_syn_inits")
  if version < 508
    let did_dtl_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink	 dtlComment	Comment
  HiLink	 dtlBoolean	Boolean
  HiLink	 dtlStorageClass	StorageClass
  HiLink	 dtlStructure	Structure
  HiLink	 dtlStringSingle	String
  HiLink	 dtlStringDouble	String
  HiLink	 dtlHereDoc	String
  HiLink	 dtlNumber	Number
  HiLink	 dtlFloat	Float
  HiLink	 dtlFunctions	Function
  HiLink	 dtlFunctions	Function
  HiLink	 dtlRepeat	Repeat
  HiLink	 dtlConditional	Conditional
  HiLink	 dtlLabel	Label
  HiLink	 dtlStatement	Statement
  HiLink	 dtlKeyword	Statement
  HiLink	 dtlType	Type
  HiLink	 dtlType	Type
  HiLink	 dtlInclude	Include
  HiLink	 dtlInclude	Include
  HiLink	 dtlDefine	Define
  HiLink	 dtlSpecialChar	SpecialChar
  HiLink	 dtlParent	Delimiter
  HiLink	 dtlParentError	Error
  HiLink	 dtlOctalError	Error
  HiLink	 dtlTodo	Todo
  HiLink	 dtlMemberSelector	Structure
  HiLink	 dtlIntVar	Identifier
  HiLink	 dtlSpecIntVar	Identifier
  HiLink	 dtlEnvVar	Identifier
  HiLink	 dtlEnvVar	Identifier
  HiLink	 dtlOperator	Operator
  HiLink	 dtlOperator	Operator
  HiLink	 dtlVarSelector	Operator
  HiLink	 dtlRelation	Operator
  HiLink	 dtlRelation	Operator
  HiLink	 dtlIdentifier	Identifier

  delcommand HiLink
endif

let b:current_syntax = "dtl"

if main_syntax == 'dtl'
  unlet main_syntax
endif

" vim: ts=8
