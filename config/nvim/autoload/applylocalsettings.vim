" Buscar recursivamente desde dirname, añadiendo todos los archivos .vimrc.local por el camino
function! applylocalsettings#ApplyLocalSettings(dirname)
    " convertir las rutas de windows al estilo unix
    let l:curDir = substitute(a:dirname, '\\', '/', 'g')

    " ir a lo alto del árbol de directorios
    let l:parentDir = strpart(l:curDir, 0, strridx(l:curDir, '/'))
    if isdirectory(l:parentDir)
        call ApplyLocalSettings(l:parentDir)
    endif

    " ahora ir de vuelta por la ruta y añadir .vimsettings conforme se encuentren
    " los directorios hijo pueden heredar de sus padres
    let l:settingsFile = a:dirname . '/.vimrc.local'
    if filereadable(l:settingsFile)
        exec ':source' . l:settingsFile
    endif
endfunction
