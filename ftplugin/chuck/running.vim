if !exists("g:shreds")
    let g:shreds=0
endif

if !exists("g:chuck_command")
    let g:chuck_command = "chuck"
endif

function! ChuckAdd()
    call vimproc#system_bg(g:chuck_command . " --add " . bufname("%"))
    let g:shreds+=1
endfunction

function! ChuckRemoveLast()
    call vimproc#system_bg(g:chuck_command . " --remove " . g:shreds)
    if g:shreds > 0
	 let g:shreds-=1
    endif
endfunction

function! ChuckReplaceLast()
    call vimproc#system_bg(g:chuck_command . " --replace " . g:shreds . " " . bufname("%"))
endfunction


function! ChuckRemoveSelected()
    let g:shredSel = input('Which shred do you want to remove?')
    call vimproc#system_bg(g:chuck_command . " --remove " . g:shredSel)
    if g:shreds > 0 && g:shreds == g:shredSel
	 let g:shreds-=1
    endif
endfunction

function! ChuckReplaceSelected()
    let g:shredSel = input('Which shred do you want to replace?')
    call vimproc#system_bg(g:chuck_command . " --replace " . g:shredSel . " " . bufname("%"))
endfunction

function! ChuckRemoveAll()
    call vimproc#system_bg(g:chuck_command . " --remove.all")
    let g:shreds=0
endfunction

function! ChuckStatus()
    call vimproc#system_bg(g:chuck_command . " --status")
endfunction

function! GetActiveBuffers()
    let l:blist = getbufinfo({'bufloaded': 1, 'buflisted': 1})
    let l:result = []
    for l:item in l:blist
        "skip unnamed buffers; also skip hidden buffers?
        if empty(l:item.name) || l:item.hidden
            continue
        endif
        call add(l:result, shellescape(l:item.name))
    endfor
    return l:result
endfunction

function! ChuckAddAll()
    call vimproc#system_bg(g:chuck_command . " --add " . join(GetActiveBuffers()))
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
