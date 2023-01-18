if exists('b:current_syntax')
    finish
endif

syntax case match

syntax keyword FishKeyword     begin function end
syntax keyword FishConditional if else switch
syntax keyword FishRepeat      while for in
syntax keyword FishLabel       case

syntax match   FishComment    /#.*/
syntax match   FishSpecial    /\\$/
syntax match   FishIdentifier /\$[[:alnum:]_]\+/
syntax region  FishString     start=/'/ skip=/\\'/ end=/'/
syntax region  FishString     start=/"/ skip=/\\"/ end=/"/ contains=fishIdentifier
syntax match   FishCharacter  /\v\\[abefnrtv *?~%#(){}\[\]<>&;"']|\\[xX][0-9a-f]{1,2}|\\o[0-7]{1,2}|\\u[0-9a-f]{1,4}|\\U[0-9a-f]{1,8}|\\c[a-z]/
syntax match   FishStatement  /\v;\s*\zs\k+>/
syntax match   FishCommandSub /\v\(\s*\zs\k+>/

syntax region  FishLineContinuation matchgroup=FishStatement
              \ start='\v^\s*\zs\k+>' skip='\\$' end='$'
              \ contains=fishSpecial,fishIdentifier,fishString,fishCharacter,fishStatement,fishCommandSub,fishComment

highlight default link FishKeyword     Keyword
highlight default link FishConditional Conditional
highlight default link FishRepeat      Repeat
highlight default link FishLabel       Label
highlight default link FishComment     Comment
highlight default link FishSpecial     Special
highlight default link FishIdentifier  Identifier
highlight default link FishString      String
highlight default link FishCharacter   Character
highlight default link FishStatement   Statement
highlight default link FishCommandSub  FishStatement

let b:current_syntax = 'fish'
