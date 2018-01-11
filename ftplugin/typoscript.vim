function! IsPattern(search)
    let value = getline('.')
    let valres = split(value, '\.')
    if index(valres, a:search) == len(valres)-1
        return 0 
    else
        return 1
    endif
endfunction

function! IsBeforeOperator(search) 
    let l:value = getline('.')
    let l:valres = split(l:value)
    if index(l:valres, a:search) == len(l:valres)-2
        return 0
    else
        return 1
    endif
endfunction 

function! SaveKeywordSet()
    if getline(".") !~ "" 
        let l:value = getline(".")
        let l:valres = split(l:value) 
        if get(len(l:valres)-1) =~ "="
            for m in g:keywords 
                if m =~ get(len(l:valres)-1)  
                    return m
                endif
            endfor
        endif
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
                    if IsPattern("config") == 0
                        for m in g:config
                            if m =~ '^' . a:base 
                                call add(res, m)
                            endif
                        endfor
                    elseif IsPattern("stdWrap") == 0
                        for m in g:stdWrap 
                            if m =~ '^' . a:base 
                                call add(res, m)
                            endif
                        endfor
                    elseif IsPattern("if") == 0
                        for m in g:if 
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
        elseif IsBeforeOperator("=") 
            let l:val = getline(".") 
            let l:values = split(l:val) 
            if get(l:values, len(l:values)-2) =~ "case"
                for m in g:case 
                    if m =~ '^' . a:base
                        call add(res, m) 
                    endif
                endfor
                return res
            elseif get(l:values, len(l:values)-2) =~ "enable" 
                for m in g:enable 
                    if m =~ '^' . a:base
                        call add(res, m) 
                    endif
                endfor
                return res
            elseif get(l:values, len(l:values)-2) =~ "field" 
                for m in g:field 
                    if m =~ '^' . a:base
                        call add(res, m) 
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

let g:usedKeywords = []


let g:keywords =    [ 
                    \'CASE',
                    \'COA',
                    \'COA_INT',
                    \'CONTENT',
                    \'EDITPANEL',
                    \'FILE',
                    \'FILES',
                    \'FLUIDTEMPLATE',
                    \'FORM',
                    \'HMENU',
                    \'HTML',
                    \'IMAGE',
                    \'IMG_RESOURCE'
                    \'PAGE', 
                    \'RECORDS',
                    \'RESTORE_REGISTER',
                    \'SVG',
                    \'TEMPLATE',
                    \'TEXT',
                    \'USER',
                    \'USER_INT',
                    \]

let g:paras =   [
                \'value',
                \'case',
                \'enable',
                \'typeNum',
                \'file',
                \'stylesheet',
                \'config',
                \'stdWrap',
                \] 

let g:CASE = [
            \'if',
            \'setCurrent',
            \'key',
            \'default',
            \'stdWrap',
            \']

let g:File = [
            \'file',
            \'linkWrap',
            \'wrap',
            \'stdWrap',
            \'altText',
            \'titleText',
            \'emptyTitleHanlding',
            \'useAlt',
            \'longdescURL',
            \]

let g:Files = [
            \'files',
            \'references',
            \'collections',
            \'folders',
            \'sorting',
            \'begin',
            \'maxitems',
            \'renderObj',
            \'stdWrap',
            \]

let g:FilesReferences = [
            \'table',
            \'uid',
            \'fieldName',
            \]

let g:Text = [
            \'value',
            \'stdWrap',
            \]

let g:if = [
        \'directReturn',
        \'isNull',
        \'isTrue',
        \'isFalse',
        \'isPositive',
        \'isGreaterThan',
        \'isLessThan',
        \'equals',
        \'isInList',
        \'value',
        \'negate',
        \]


let g:stdWrap = [
            \'setContentToCurrent',
            \'addPageCacheTags',
            \'setCurrent',
            \'lang',
            \'data',
            \'field',
            \'current',
            \'cObject',
            \'numRows',
            \'preUserFunc',
            \'override',
            \'preIfEmptyListNum',
            \'ifNull',
            \'ifEmpty',
            \'ifBlank',
            \'listNum',
            \'trim',
            \'strPad',
            \'stdWrap',
            \'required',
            \'if',
            \'fieldRequierd',
            \'csConv',
            \'parseFunc',
            \'HTMLparser',
            \'split',
            \'replacement',
            \'prioriCalc',
            \'char',
            \'intval',
            \'hash',
            \'round',
            \'round',
            \'numberFormat',
            \'date',
            \'strftime',
            \'strttime',
            \'age',
            \'case',
            \'bytes',
            \'substring',
            \'cropHTML',
            \'stripHtml',
            \'crop',
            \'rawUrlEncode',
            \'htmlSpecialChars',
            \'encodeForJavaScriptValue',
            \'doubleBrTag',
            \'br',
            \'brTag',
            \'encapsLines',
            \'keywords',
            \'innerWrap',
            \'innerWrap2',
            \'addParams',
            \'filelink',
            \'preCObject',
            \'postCObject',
            \'wrapAlign',
            \'typolink',
            \'wrap',
            \'noTrimWrap',
            \'wrap2',
            \'dataWrap',
            \'prepend',
            \'append',
            \'wrap3',
            \'orderedStdWrap',
            \'outerWrap',
            \'insertData',
            \'postUserFunc',
            \'postUserFuncInt',
            \'prefixComment',
            \'editIcons',
            \'editPanel',
            \'cache',
            \'debug',
            \'debugFunc',
            \'debugData',
            \]

let g:enable = ['0', '1']

let g:field = [
            \'header',]

let g:case = [
            \'upper',
            \'lower',
            \'capitalize',
            \'ucfirst',
            \'lcfirst',
            \'uppercamelcase',
            \'lowercamelcase',
            \]

let g:config =  [
                \'absRefPrefix',
                \'additionalHeaders',
                \'admPanel'
                \'ATagParams',
                \'baseURL',
                \'cache',
                \'cache_clearAtMidnight',
                \'cache_period',
                \'compressCss',
                \'compressJs',
                \'concatenateCss',
                \'concatenateJs',
                \'concatenateJsAndCss',
                \'content_from_pid_allowOutsideDomain',
                \'contentObjectExceptionHandler',
                \'debug',
                \'defaultGetVars',
                \'disableAllHeaderCode',
                \'disableBodyTag',
                \'disableCharsetHeader',
                \'disablelmgBorderAttr',
                \'disablePageExternalUrl',
                \'disablePrefixComment',
                \'disablePreviewNotification',
                \'disableLanguageHeader',
                \'doctype',
                \'doctypeSwitch',
                \'enableContentLengthHeader',
                \'extTarget',
                \'fileTarget',
                \'forceTypeValue',
                \'formMailCharset',
                \'ftu',
                \'headerComment',
                \'htmlTag_dir',
                \'htmlTag_langKey',
                \'htmlTag_setParams',
                \'htmlTag_stdWrap',
                \'index_descrLgd',
                \'index_enable',
                \'index_externals',
                \'index_metatags',
                \'inlineStyle2TempFile',
                \'intTarget',
                \'language',
                \'language_alt',
                \'linkVars',
                \'locale_all',
                \'message_page_is_being_generated',
                \'message_preview',
                \'message_preview_workspace',
                \'metaCharset',
                \'moveJsFormHeaderToFooter',
                \'MP_defaults',
                \'MP_disableTypolinkClosestMPvalue',
                \'MP_mapRootPoints',
                \'namespaces',
                \'no_cache',
                \'noPageTitle',
                \'pageTitleFirst',
                \'pageTitleSeparator',
                \'removeDefaultCss',
                \'removeDefaultJs',
                \'removePageCss',
                \'sendCacheHeaders',
                \'sendCacheHeaders_onlyWhenLoginDeniedInBranch',
                \'spamProtectEmailAdresses',
                \'spamProtectEmailAdresses_atSubst',
                \'spamProtectEmailAdresses_lastDostSubst',
                \'sword_noMixedCase',
                \'sword_standAlone',
                \'sys_language_isocode',
                \'sys_language_isocode_default',
                \'sys_language_mode',
                \'sys_language_overlay',
                \'`sys\_language\_softMergeIfNotBlank`_',
                \'sys_language_uid',
                \'titleTagFunction',
                \'tx_[extension key with no underscores]_[*]',
                \'typolinkCheckRootline',
                \'typolinkEnableLinksAcrossDomains',
                \'typolinkLinkAccessRestrictedPages',
                \'typolinkLinkAccessRestrictedPages_addParams',
                \'USERNAME_substToken',
                \'xhtmlDoctype',
                \'xmlprologue',
                \]

let g:all = [] 
for m in g:keywords 
    call add(g:all, m)
endfor
for m in g:paras
    call add(g:all, m)
endfor

set completeopt+=longest 
set completefunc=TypoComplete 
set omnifunc=TypoComplete 
