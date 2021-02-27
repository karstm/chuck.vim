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
    return Chuck("add", bufname("%"))
endfunction

function! ChuckRemoveLast()
    if g:shreds > 0
	      let g:shreds-=1
    endif
    return Chuck("remove", g:shreds)
endfunction

function! ChuckReplaceLast()
    write
    return Chuck("replace", g:shreds . " " . bufname("%"))
endfunction

function! ChuckRemoveSelected()
    let g:shredSel = input('Which shred do you want to remove? ')
    if g:shreds > 0 && g:shreds == g:shredSel
	      let g:shreds-=1
    endif
    return Chuck("remove", g:shredSel) 
endfunction

function! ChuckReplaceSelected()
    write
    let g:shredSel = input('Which shred do you want to replace? ')
    return Chuck("replace", g:shredSel . " " . bufname("%")) 
endfunction

function! ChuckRemoveAll()
    let g:shreds=0
    return Chuck("remove.all", "") 
endfunction

function! ChuckStatus()
    return Chuck("status", "") 
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
    return Chuck("add", join(GetActiveBuffers()))
endfunction

nnoremap <buffer> + :echo ChuckAdd()<cr>
nnoremap <buffer> - :echo ChuckRemoveLast()<cr>
nnoremap <buffer> = :echo ChuckReplaceLast()<cr>

nnoremap <buffer> @ :echo ChuckRemoveSelected()<cr>
nnoremap <buffer> # :echo ChuckReplaceSelected()<cr>

nnoremap <buffer> _ :echo ChuckRemoveAll()<cr>
nnoremap <buffer> ^ :echo ChuckStatus()<cr>

nnoremap <buffer> * :echo ChuckAddAll()<cr>
