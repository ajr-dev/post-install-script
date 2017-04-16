" importar cualquier fichero .vimrc.local files en el actual directorio de trabajo y hacia arriba recursivamente
call applylocalsettings#ApplyLocalSettings(expand('.'))
