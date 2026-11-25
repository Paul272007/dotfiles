if exists("b:current_syntax")
  finish
endif

" Comments
syntax match zccComment "#.*$"

" Keywords
syntax keyword zccKeyword continue break ret return assert auto module import use this goto await null
" syntax keyword zccStatement ...
syntax keyword zccConditional if elif else and or xor not switch
syntax keyword zccRepeat for each in while

" Identifiers
"syntax ??? zccFunction ???
"syntax ??? zccIdentifier ???

" Strings
syntax region zccString start=+"+ skip=+\\"+ end=+"+
"syntax region zccFString start=+`+ skip=+\`+ end=+`+
syntax region zccChar start=+'+ skip=+\\'+ end=+'+

" Numbers
syntax match zccNumber "\v<\d+>"
"syntax match zccFloat ???

" Bools
syntax keyword zccBoolean true false

" Types
syntax keyword zccModifier extern mut static const inline pub public private protected proc async attr
syntax keyword zccType i8 i16 i32 i64 int u8 u16 u32 u64 unsigned f32 f64 float double str strv bool void char
syntax keyword zccTypeDecl struct enum union type concept
"syntax ??? zccTypedef ???

" Macros and preprocessing
"syntax ??? zccConstant ???
"syntax ??? zccSpecial ???
"syntax ??? zccPreProc ???

" Operators
syntax match zccOperator /+\|-\|\*\|%\|\~\|&\|!\|\^\|?\||\|\.\|:\|\/\|==\|!=\|>=\|<=\|>\|<\|->\|::\|=\|\[\|\]\|:=\|sizeof\|typeof/

" Delimiters ??
"syntax ??? zccDelimiter ???

" Link syntax groups to theme colors
highlight default link zccComment Comment
highlight default link zccKeyword Keyword
highlight default link zccConditional Conditional
highlight default link zccRepeat Repeat
highlight default link zccString String
"highlight default link zccFString String
highlight default link zccChar Character
highlight default link zccNumber Number
"highlight default link zccFloat Float
highlight default link zccBoolean Boolean
highlight default link zccModifier Keyword " looks better when they count as keywords
highlight default link zccType Type
highlight default link zccTypeDecl Type
"highlight default link zccTypedef Typedef
"highlight default link zccConstant Constant
"highlight default link zccSpecial Special
"highlight default link zccPreProc PreProc
highlight default link zccOperator Operator
"highlight default link zccDelimiter Delimiter

let b:current_syntax = "zcc"
