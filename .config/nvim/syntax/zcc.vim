if exists("b:current_syntax")
  finish
endif

" Mots-clés
syntax keyword zccKeyword struct extern for while if elif else switch ret return enum auto mut static inline pub public private protected module import break continue
syntax keyword zccType int i32 float f32 string bool void
syntax keyword zccBoolean true false

" Commentaires
syntax match zccComment "#.*$"

" Chaînes de caractères
syntax region zccString start=+"+ skip=+\\"+ end=+"+

" Opérateurs et symboles
syntax match zccOperator /+\|-\|\*\|\/\|==\|!=\|>=\|<=\|>\|<\|->\|::\|=\|\[\|\]/

" Nombres
syntax match zccNumber "\v<\d+>"

" Lier les groupes de syntaxe aux couleurs du thème
highlight default link zccKeyword Keyword
highlight default link zccType Type
highlight default link zccBoolean Boolean
highlight default link zccComment Comment
highlight default link zccString String
highlight default link zccOperator Operator
highlight default link zccNumber Number

let b:current_syntax = "zcc"
