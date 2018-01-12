"MIT License Copyright (c) 2018 Philip Mayer

let g:dict = {}
let l:val = getline(".") 
let l:values = split(l:val) 
let l:subval = split(get(l:values, 0),'\.')    
let l:d1 = get(l:values, len(l:values)-1) 
let l:d2 = get(l:subval, len(l:subval)-1) 
if l:d2 == \[0-9] || == \[0-9][0-9] || == \[0-9][0-9][0-9]
    let g:dict = { l:d1 : l:d2 }
endif
