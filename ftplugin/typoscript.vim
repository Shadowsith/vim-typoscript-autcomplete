function! IsPattern(search)
    let value = getline('.')
    let valres = split(value, '\.')
    echo valres
    if index(valres, a:search) == len(valres)-1
        return 0 
    else
        return 1
    endif
endfunction

fun! TypoComplete(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        return start
    else
        " find months matching with "a:base"
        let res = []
        echo a:base
        if getline(".")[col(".")-2] == "."
            for m in g:paras
                if m =~ '^' . a:base 
                    if IsPattern("value") == 0
                        for m in g:value
                            if m =~ '^' . a:base 
                                call add(res, m)
                            endif
                        endfor
                    else
                        call add(res, m)
                    endif
                endif
            endfor
            return res
        else
            for m in g:keywords 
                if m =~ '^' . a:base
                    call add(res, m)
                endif
            endfor
            return res
        endif
    endif
endfun

let g:keywords =    [ 
                    \'PAGE', 
                    \'TEXT',
                    \]

let g:paras =   [
                \'value',
                \'case',
                \'enable',
                \'typeNum',
                \'file',
                \] 

let g:value = [ 'bla' ] 

let g:all = [] 
for m in g:keywords 
    call add(g:all, m)
endfor
for m in g:paras
    call add(g:all, m)
endfor

set completefunc=TypoComplete 
set omnifunc=TypoComplete 
