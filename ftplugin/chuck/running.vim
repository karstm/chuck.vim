if !exists("g:shreds")
    let g:shreds=0
endif

function! Chuck(command, args)
    let msg = system("chuck --". a:command . " " . a:args)  
    redraw!
    return msg
endfunction

function! ChuckAdd()
    write
    let g:shreds+=1
    echo Chuck("add", '''' . expand("%") . '''')
endfunction

function! ChuckRemoveLast()
    echo Chuck("remove", g:shreds)
    if g:shreds > 0
	      let g:shreds-=1
    endif
endfunction

function! ChuckReplaceLast()
    write
    echo Chuck("replace", g:shreds . " " . '''' . expand("%") . '''')
endfunction

function! ChuckRemoveSelected()
    let g:shredSel = input('Which shred do you want to remove? ')
    if g:shreds > 0 && g:shreds == g:shredSel
	      let g:shreds-=1
    endif
    echo Chuck("remove", g:shredSel) 
endfunction

function! ChuckReplaceSelected()
    write
    let g:shredSel = input('Which shred do you want to replace? ')
    echo Chuck("replace", g:shredSel . " " . '''' . expand("%") . '''') 
endfunction

function! ChuckRemoveAll()
    let g:shreds=0
    echo Chuck("remove.all", "") 
endfunction

function! ChuckStatus()
    echo Chuck("status", "") 
endfunction

function! GetActiveBuffers()
    let l:bufferList = getbufinfo({'bufloaded': 1, 'buflisted': 1})
    let l:result = []
    for l:buffer in l:bufferList
        if empty(l:buffer.name) || l:buffer.hidden
            continue
        endif
        call add(l:result, shellescape(l:buffer.name))
    endfor
    return l:result
endfunction

function! ChuckAddAll()
    let g:shreds+=len(GetActiveBuffers())
    echo Chuck("add", join(GetActiveBuffers()))
endfunction

nnoremap <buffer> + :call ChuckAdd()<cr>
nnoremap <buffer> - :call ChuckRemoveLast()<cr>
nnoremap <buffer> = :call ChuckReplaceLast()<cr>

nnoremap <buffer> @ :call ChuckRemoveSelected()<cr>
nnoremap <buffer> # :call ChuckReplaceSelected()<cr>

nnoremap <buffer> _ :call ChuckRemoveAll()<cr>
nnoremap <buffer> ^ :call ChuckStatus()<cr>

nnoremap <buffer> * :call ChuckAddAll()<cr>
