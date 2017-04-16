" Resaltar Palabra
"
" Esto crea una coincidencia para la palabra bajo el cursor, esto resaltará todos
" los usos de la palabra en el archivo. Si la coincidencia ya existe, entonces se borra,
" permitiendo que el resaltado pueda cambiarse

hi def InterestingWord1 guifg=#000000 ctermfg=16 guibg=#ffa724 ctermbg=214
hi def InterestingWord2 guifg=#000000 ctermfg=16 guibg=#aeee00 ctermbg=154
hi def InterestingWord3 guifg=#000000 ctermfg=16 guibg=#8cffba ctermbg=121
hi def InterestingWord4 guifg=#000000 ctermfg=16 guibg=#b88853 ctermbg=137
hi def InterestingWord5 guifg=#000000 ctermfg=16 guibg=#ff9eb8 ctermbg=211
hi def InterestingWord6 guifg=#000000 ctermfg=16 guibg=#ff2c4b ctermbg=195

let s:base_mid = 68750

function! hiinterestingword#HiInterestingWord(n)
    " Guardar nuestra ubicación
    normal! mz

    " Copiar la palabra actual al registro z
    normal! "zyiw

    " Calcular un ID arbitrario para la coincidencia. Ojalá no haya nada usándolo
    let mid = s:base_mid + a:n

    " Construir un patrón literal que tiene que coincidir en los límites
    let pat = '\V\<' . escape(@z, '\') . '\>'

    try
        call matchadd("InterestingWord" . a:n, pat, 1, mid)
    catch
        silent! call matchdelete(mid)
    endtry

    " Volver a nuestra ubicación original
    normal! `z
endfunction
