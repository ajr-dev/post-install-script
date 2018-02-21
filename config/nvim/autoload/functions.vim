" Atajos para movimiento de ventanas
" mover la ventana en la dirección indicada o crear una nueva ventana
function! functions#WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

" Completado inteligente con tabulador
function! functions#Smart_TabComplete()
    let line = getline('.')                         " la línea actual

    let substr = strpart(line, -1, col('.')+1)      " del comienzo de la línea actual
                                                    " a un carácter a la derecha del cursor
    let substr = matchstr(substr, '[^ \t]*$')       " palabra hasta el cursor
    if (strlen(substr)==0)                          " nada que coincida o cadena vacía
        return '\<tab>'
    endif
    let has_period = match(substr, '\.') != -1      " posición del punto, si lo hay
    let has_slash = match(substr, '\/') != -1       " posición de la barra inclinada, si la hay
    if (!has_period && !has_slash)
        return '\<C-X>\<C-P>'                       " coincidencia de texto existente
    elseif ( has_slash )
        return '\<C-X>\<C-F>'                       " coincidencia de archivo
    else
        return '\<C-X>\<C-O>'                       " coincidencia de plugin
    endif
endfunction

" Ejecutar un comando personalizado
function! functions#RunCustomCommand()
    up
    if g:silent_custom_command
        execute 'silent !' . s:customcommand
    else
        execute '!' . s:customcommand
    endif
endfunction

" Crear comando personalizado
function! functions#SetCustomCommand()
    let s:customcommand = input('Enter Custom Command$ ')
endfunction

" Borrar espacios al final de línea
" function! functions#TrimWhiteSpace()
"     %s/\s\+$//e
" endfunction

function! functions#HtmlUnEscape()
  silent s/&lt;/</eg
  silent s/&gt;/>/eg
  silent s/&amp;/\&/eg
endfunction
