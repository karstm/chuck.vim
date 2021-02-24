if !exists("g:shreds")
    let g:shreds=0
endif

function! Chuck(command, args)
    silent execute "!chuck --". a:command . " " . a:args 
    redraw! 
endfunction

function! ChuckAdd()
    call Chuck("add", bufname("%"))
    let g:shreds+=1
endfunction

function! ChuckRemoveLast()
    call Chuck("remove", g:shreds)
    if g:shreds > 0
	      let g:shreds-=1
    endif
endfunction

function! ChuckReplaceLast()
    call Chuck("replace", g:shreds . " " . bufname("%"))
endfunction

function! ChuckRemoveSelected()
    let g:shredSel = input('Which shred do you want to remove? ')
    call Chuck("remove", g:shredSel) 
    if g:shreds > 0 && g:shreds == g:shredSel
	      let g:shreds-=1
    endif
endfunction

function! ChuckReplaceSelected()
    let g:shredSel = input('Which shred do you want to replace? ')
    call Chuck("replace", g:shredSel . " " . bufname("%")) 
endfunction

function! ChuckRemoveAll()
    call Chuck("remove.all", "") 
    let g:shreds=0
endfunction

function! ChuckStatus()
    call Chuck("status", "") 
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
    call Chuck("add", join(GetActiveBuffers()))
    let g:shreds+=len(GetActiveBuffers())
endfunction

nnoremap <buffer> + :call ChuckAdd()<cr>
nnoremap <buffer> - :call ChuckRemoveLast()<cr>
nnoremap <buffer> = :call ChuckReplaceLast()<cr>

nnoremap <buffer> @ :call ChuckRemoveSelected()<cr>
nnoremap <buffer> # :call ChuckReplaceSelected()<cr>

nnoremap <buffer> _ :call ChuckRemoveAll()<cr>
nnoremap <buffer> ^ :call ChuckStatus()<cr>

nnoremap <buffer> * :call ChuckAddAll()<cr>
