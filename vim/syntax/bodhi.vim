" Vim syntax file
" Language:		Bodhi

" Remove any old syntax stuff hanging around
if version < 600
  syn clear
elseif exists("b:current_syntax")
  finish
endif

" (Qualified) identifiers (no default highlighting)
syn match ConId "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=\<[A-Z][a-zA-Z0-9_']*\>"
syn match VarId "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=\<[a-z][a-zA-Z0-9_']*\>"

" Infix operators--most punctuation characters and any (qualified) identifier
" enclosed in `backquotes`. An operator starting with : is a constructor,
" others are variables (e.g. functions).
syn match bdVarSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[-!#$%&\*\+/<=>\?@\\^|~.][-!#$%&\*\+/<=>\?@\\^|~:.]*"
syn match bdConSym "\(\<[A-Z][a-zA-Z0-9_']*\.\)\=:[-!#$%&\*\+./<=>\?@\\^|~:]*"
syn match bdVarSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[a-z][a-zA-Z0-9_']*`"
syn match bdConSym "`\(\<[A-Z][a-zA-Z0-9_']*\.\)\=[A-Z][a-zA-Z0-9_']*`"

" Reserved symbols--cannot be overloaded.
syn match bdDelimiter  "(\|)\|\[\|\]\|,\|;\|_\|{\|}"

" Strings and constants
syn match   bdSpecialChar	contained "\\\([0-9]\+\|o[0-7]\+\|x[0-9a-fA-F]\+\|[\"\\'&\\abfnrtv]\|^[A-Z^_\[\\\]]\)"
syn match   bdSpecialChar	contained "\\\(NUL\|SOH\|STX\|ETX\|EOT\|ENQ\|ACK\|BEL\|BS\|HT\|LF\|VT\|FF\|CR\|SO\|SI\|DLE\|DC1\|DC2\|DC3\|DC4\|NAK\|SYN\|ETB\|CAN\|EM\|SUB\|ESC\|FS\|GS\|RS\|US\|SP\|DEL\)"
syn match   bdSpecialCharError	contained "\\&\|'''\+"
syn region  bdString		start=+"+  skip=+\\\\\|\\"+  end=+"+  contains=bdSpecialChar
syn match   bdCharacter		"[^a-zA-Z0-9_']'\([^\\]\|\\[^']\+\|\\'\)'"lc=1 contains=bdSpecialChar,bdSpecialCharError
syn match   bdCharacter		"^'\([^\\]\|\\[^']\+\|\\'\)'" contains=bdSpecialChar,bdSpecialCharError
syn match   bdNumber		"\<[0-9]\+\>\|\<0[xX][0-9a-fA-F]\+\>\|\<0[oO][0-7]\+\>"
syn match   bdFloat		"\<[0-9]\+\.[0-9]\+\([eE][-+]\=[0-9]\+\)\=\>"

" Keyword definitions. These must be patters instead of keywords
" because otherwise they would match as keywords at the start of a
" "literate" comment (see lbd.vim).
syn match bdModule		"\<module\>"
syn match bdImport		"\<import\>.*"he=s+6 contains=bdImportMod,bdLineComment,bdBlockComment
syn match bdImportMod		contained "\<\(as\|qualified\|hiding\)\>"
syn match bdInfix		"\<\(infix\|infixl\|infixr\)\>"
syn match bdStructure		"\<\(class\|data\|deriving\|instance\|default\|where\)\>"
syn match bdTypedef		"\<\(type\|newtype\)\>"
syn match bdStatement		"\<\(def\|do\|case\|of\|let\|in\)\>"
syn match bdConditional		"\<\(if\|then\|else\)\>"

" Not real keywords, but close.
if exists("bd_highlight_boolean")
  " Boolean constants from the standard prelude.
  syn match bdBoolean "\<\(True\|False\)\>"
endif
if exists("bd_highlight_types")
  " Primitive types from the standard prelude and libraries.
  syn match bdType "\<\(Int\|Integer\|Char\|Bool\|Float\|Double\|IO\|Void\|Addr\|Array\|String\)\>"
endif
if exists("bd_highlight_more_types")
  " Types from the standard prelude libraries.
  syn match bdType "\<\(Maybe\|Either\|Ratio\|Complex\|Ordering\|IOError\|IOResult\|ExitCode\)\>"
  syn match bdMaybe    "\<Nothing\>"
  syn match bdExitCode "\<\(ExitSuccess\)\>"
  syn match bdOrdering "\<\(GT\|LT\|EQ\)\>"
endif
if exists("bd_highlight_debug")
  " Debugging functions from the standard prelude.
  syn match bdDebug "\<\(undefined\|error\|trace\)\>"
endif


" Comments
syn match   bdLineComment      "---*\([^-!#$%&\*\+./<=>\?@\\^|~].*\)\?$"
syn region  bdBlockComment     start="{-"  end="-}" contains=bdBlockComment

" C Preprocessor directives. Shamelessly ripped from c.vim and trimmed
" First, see whether to flag directive-like lines or not
if (!exists("bd_allow_hash_operator"))
    syn match	cError		display "^\s*\(%:\|#\).*$"
endif
" Accept %: for # (C99)
syn region	cPreCondit	start="^\s*\(%:\|#\)\s*\(if\|ifdef\|ifndef\|elif\)\>" skip="\\$" end="$" end="//"me=s-1 contains=cComment,cCppString,cCommentError
syn match	cPreCondit	display "^\s*\(%:\|#\)\s*\(else\|endif\)\>"
syn region	cCppOut		start="^\s*\(%:\|#\)\s*if\s\+0\+\>" end=".\@=\|$" contains=cCppOut2
syn region	cCppOut2	contained start="0" end="^\s*\(%:\|#\)\s*\(endif\>\|else\>\|elif\>\)" contains=cCppSkip
syn region	cCppSkip	contained start="^\s*\(%:\|#\)\s*\(if\>\|ifdef\>\|ifndef\>\)" skip="\\$" end="^\s*\(%:\|#\)\s*endif\>" contains=cCppSkip
syn region	cIncluded	display contained start=+"+ skip=+\\\\\|\\"+ end=+"+
syn match	cIncluded	display contained "<[^>]*>"
syn match	cInclude	display "^\s*\(%:\|#\)\s*include\>\s*["<]" contains=cIncluded
syn cluster	cPreProcGroup	contains=cPreCondit,cIncluded,cInclude,cDefine,cCppOut,cCppOut2,cCppSkip,cCommentStartError
syn region	cDefine		matchgroup=cPreCondit start="^\s*\(%:\|#\)\s*\(define\|undef\)\>" skip="\\$" end="$"
syn region	cPreProc	matchgroup=cPreCondit start="^\s*\(%:\|#\)\s*\(pragma\>\|line\>\|warning\>\|warn\>\|error\>\)" skip="\\$" end="$" keepend

syn region	cComment	matchgroup=cCommentStart start="/\*" end="\*/" contains=cCommentStartError,cSpaceError contained
syntax match	cCommentError	display "\*/" contained
syntax match	cCommentStartError display "/\*"me=e-1 contained
syn region	cCppString	start=+L\="+ skip=+\\\\\|\\"\|\\$+ excludenl end=+"+ end='$' contains=cSpecial contained

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_bd_syntax_inits")
  if version < 508
    let did_bd_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink bdModule			  bdStructure
  HiLink bdImport			  Include
  HiLink bdImportMod			  bdImport
  HiLink bdInfix			  PreProc
  HiLink bdStructure			  Structure
  HiLink bdStatement			  Statement
  HiLink bdConditional			  Conditional
  HiLink bdSpecialChar			  SpecialChar
  HiLink bdTypedef			  Typedef
  HiLink bdVarSym			  bdOperator
  HiLink bdConSym			  bdOperator
  HiLink bdOperator			  Operator
  if exists("bd_highlight_delimiters")
    " Some people find this highlighting distracting.
    HiLink bdDelimiter			  Delimiter
  endif
  HiLink bdSpecialCharError		  Error
  HiLink bdString			  String
  HiLink bdCharacter			  Character
  HiLink bdNumber			  Number
  HiLink bdFloat			  Float
  HiLink bdConditional			  Conditional
  HiLink bdLiterateComment		  bdComment
  HiLink bdBlockComment		  bdComment
  HiLink bdLineComment			  bdComment
  HiLink bdComment			  Comment
  HiLink bdPragma			  SpecialComment
  HiLink bdBoolean			  Boolean
  HiLink bdType			  Type
  HiLink bdMaybe			  bdEnumConst
  HiLink bdOrdering			  bdEnumConst
  HiLink bdEnumConst			  Constant
  HiLink bdDebug			  Debug

  HiLink cCppString		bdString
  HiLink cCommentStart		bdComment
  HiLink cCommentError		bdError
  HiLink cCommentStartError	bdError
  HiLink cInclude		Include
  HiLink cPreProc		PreProc
  HiLink cDefine		Macro
  HiLink cIncluded		bdString
  HiLink cError			Error
  HiLink cPreCondit		PreCondit
  HiLink cComment		Comment
  HiLink cCppSkip		cCppOut
  HiLink cCppOut2		cCppOut
  HiLink cCppOut		Comment

  delcommand HiLink
endif

let b:current_syntax = "bodhi"

" Options for vi: ts=8 sw=2 sts=2 nowrap noexpandtab ft=vim
