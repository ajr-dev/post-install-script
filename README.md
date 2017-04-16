# Configuración del entorno de programación Unix

Bienvenido a mi mundo. Esta es una colección de configuraciones para vim, tmux y zsh.

Obviamente esta configuración es adecuada para mi, pero puede que no se adecue a ti.
Si no te gusta esta configuración, eres libre de coger las ideas que te gusten y
si quieres puedes contribuir ideas para que esta configuración se pueda adaptar a más personas.

[Ver la wiki para más información](https://github.com/arturojosejr/dotfiles/wiki)

## Contenidos

* [Configuración del entorno de programación Unix](#configuración-del-entorno-de-programación-unix)
* [Contenidos](#contenidos)
* [Configuración Inicial e Instalación](#configuración-inicial-e-instalación)
  * [Copia de seguridad](#copia-de-seguridad)
  * [Instalación](#instalación)
* [Configuración de ZSH](#configuración-de-zsh)
  * [Indicador de entrada (Prompt)](#indicador-de-entrada-prompt)
  * [Información de Git en el indicador](#información-de-git-en-el-indicador)
  * [Procesos Suspendidos](#procesos-suspendidos)
* [Configuración de Vim y Neovim](#configuración-de-vim-y-neovim)
  * [Instalación](#instalación-1)
* [Fuentes](#fuentes)
* [Tmux](#tmux)
  * [Chuleta para Tmux](#chuleta-para-tmux)
    * [Sesiones](#sesiones)
    * [Varios](#varios)
    * [Ventanas (pestañas)](#ventanas-pestañas)
    * [Paneles (divisiones)](#paneles-divisiones)
  * [Atajos propios para Tmux](#atajos-propios-para-tmux)
* [Conky](#conky)

## Configuración Inicial e Instalación

### Copia de seguridad

En primer lugar, es posible que quieras hacer una copia de seguridad de los archivos
existentes para que esto no sobrescriba tu configuración.

Ejecuta `install/backup.sh` para hacer una copia de seguridad (de todos los archivos
a los que se realizarán enlaces simbólicos) en un directorio `~/dotfiles-backup`.

Esto no eliminará ninguno de estos archivos, y los scripts de instalación no
sobrescribirán los existentes. Una vez finalizada la copia de seguridad, puedes
eliminar los archivos del directorio principal para continuar con la instalación.

### Instalación

Abre un terminal y pega

```bash
git clone https://github.com/arturojosejr/dotfiles ~/.dotfiles
cd ~/.dotfiles
./instalar
```

Si estas en OSX, primero tendrás que instalar las herramientas de CLI (línea de comandos)
de XCode antes de continuar. Para ello, abre un terminal y escribe

```bash
xcode-select --install
```

**Lee el archivo `instalar` y comenta cualquier cosa que no quieras instalar.**
Se instalarán todos los enlaces simbólicos en el directorio de inicio. Cada archivo
con una extensión `.symlink` estará vinculado simbólicamente al directorio de inicio
con un `.` delante suya. Como ejemplo, `vimrc.symlink` estará vinculado simbólicamente
en el directorio de inicio como `~/.vimrc`. Entonces, este script creará un directorio
`~/.vim-tmp` en tu directorio de inicio, ya que aquí es donde vim está configurado para
colocar sus archivos temporales. Además, todos los archivos en el directorio
`$DOTFILES/config` se vincularán simbólicamente al directorio `~/.config/` para
las aplicaciones que siguen la
[especificación de directorio base XDG](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html),
como neovim.

A continuación, el script de instalación realizará una comprobación para ver si
se está ejecutando en una máquina OSX. Si es así, instalará Homebrew si no está
instalado actualmente e instalará los paquetes homebrew listados en [`brew.sh`](install/brew.sh).
A continuación, ejecutará [`osx.sh`](install/osx.sh) y cambiará algunas configuraciones
de OSX. Este archivo está bastante bien documentado y por lo tanto se aconseja que
__leas y comentes los cambios que no deseas__. A continuación, nginx (instalado
desde Homebrew) se configurará con el archivo de configuración proporcionado. Si
ya existe un archivo `nginx.conf` en `/usr/local/etc`, se hará una copia de
seguridad en `/usr/local/etc/nginx/nginx.conf.original`.

## Configuración de ZSH

[Comandos integrados en zsh](http://zsh.sourceforge.net/Doc/Release/Shell-Builtin-Commands.html)

ZSH está configurado en el archivo `zshrc.symlink`, que se enlazará simbólicamente
con el directorio de inicio. En este archivo se produce lo siguiente:

* Establecer el `EDITOR` a nvim
* Cargar cualquier configuración `~/.terminfo`
* Establecer la variable `CODE_DIR`, apuntando a la ubicación donde existen los
proyectos de código para el autocompletado exclusivo con el comando `c`
* Buscar recursivamente en el directorio `$DOTFILES/zsh` los archivos que terminen
en .zsh y añadirlos
* Instalar zplug plugin manager para complementos zsh e instalarlos.
* Añadir `/.localrc` si existe para que se puedan hacer configuraciones adicionales
que no se cambiarán al actualizar este repositorio. Esto es bueno para cosas como
las claves API, etc.
* Agregar los directorios `~/bin` y `$DOTFILES/bin` a la ruta
* Y más...

### Indicador de entrada (Prompt)

El indicador se pretende que sea simple, y aun así siga proporcionando una gran
cantidad de información al usuario, en particular sobre el estado del proyecto git,
si el directorio actual es un proyecto git. Este indicador establece `precmd`,` PROMPT` y `RPROMPT`.

![](http://nicknisi.com/share/prompt.png)

The `precmd` shows the current working directory in it and the `RPROMPT` shows the git and suspended jobs info.
El `precmd` muestra el directorio de trabajo actual en él y el `RPROMPT` muestra
la información de git y de los precesos suspendidos.

#### Información de Git en el indicador

La información de git que se muestra en el `RPROMPT` muestra el nombre de la rama
actual y si está limpia o sucia.

![](http://nicknisi.com/share/git-branch-state.png)

Además, hay flechas ⇣ y ⇡ que indican si un commit ha ocurrido y hay que hacer
un pull (empuje) (⇡), y si ha habido commits (contribuciones) en la rama remota y
hay que hacer un push (tirar) (⇣).

![](http://nicknisi.com/share/git-arrows.png)

#### Procesos Suspendidos

El indicador también mostrará un carácter ✱ en el `RPROMPT` indicando que hay un
trabajo suspendido que existe en segundo plano. Esto es útil para seguir la pista
de vim al ponerlo en segundo plano pulsando CTRL-Z.

![](http://nicknisi.com/share/suspended-jobs.png)

## Configuración de Vim y Neovim

[Neovim](https://neovim.io/) es una bifurcación y reemplazo para vim. En la mayoría
de los casos, no notarías ningunadiferencia entre los dos, aparte de que Neovim
permite que los complementos se ejecuten asincrónicamente para que no congelen el
editor, que es la razón principal por la que he cambiado a este. Vim y Neovim
utilizan Vimscript y la mayoría de los complementos funcionarán en ambos (todos
los complementos que yo utilizo funcionan tanto en Vim como en Neovim). Por esta
razón, comparten los mismos archivos de configuración en esta configuración. Neovim
utiliza la
[especificación del directorio base XDG](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html),
lo que significa que no buscará `.vimrc` en el directorio de inicio. En su lugar, su
configuración se parece a lo siguiente:

|                                    | Vim        | Neovim                    |
|------------------------------------|------------|---------------------------|
| Archivo de Configuración Principal | `~/.vimrc` | `~/.config/nvim/init.vim` |
| Directorio de Configuración        | `~/.vim`   | `~/.config/nvim`          |

### Instalación

Es probable que Vim ya esté instalado en tu sistema. Si utilizas una Mac, MacVim
se instalará desde Homebrew. Para otros sistemas, puede que tengas que instalar
Neovim manualmente. Consulta su [sitio web](https://neovim.io) para obtener más
información.

[`link.sh`](install/link.sh) conectará el directorio de configuración de XDG a
tu directorio de inicio y creará enlaces simbólicos para `.vimrc` y `.vim` a la
configuración de Neovim para que Vim y Neovim se configuren ambos de la misma
manera desde los mismos archivos. El beneficio de esta configuración es que sólo
tienes que mantener una configuración vim única para ambos, de modo que si Neovim
(que aún es software alfa) tiene problemas, puedes cambiar de forma cambiar sin
problemas a vim sin ningún impacto importante en su productividad.

Dentro de [`.zshrc`](zsh/zshrc.symlink), la variable del intérprete `EDITOR` se
establece en `nvim`, haciendo que Neovim sea el programa por defecto para realizar
tareas de edición, como escribir mensajes de commit para git. Además, he hecho un
alias de `vim` a` nvim` en [`aliases.zsh`](zsh/aliases.zsh) Puedes quitar esto
si prefieres no realizar un alias del comando `vim` a `nvim`.

Vim y Neovim deberían funcionar una vez que los complementos correctos estén
instalados. Para instalar los complementos, deberás abrir Neovim de la siguiente manera:

```bash
nvim +PlugInstall
```

### Plugins
NERDTree escribir :h NERDTreeMappings en vim para ver los comandos.

## Fuentes

Actualmente uso, [Hack](https://github.com/chrissimpkins/Hack). Además de esto,
tengo [nerd-fonts](https://github.com/ryanoasis/nerd-fonts) instalado y
configurado para ser utilizado para los caracteres que no sean ascii. Si prefiere
no hacerlo, simplemente quita el complemento `Plug 'ryanoasis/vim-devicons'` de
vim/nvim.

## Tmux

Tmux es un multiplexor de terminales que te permite crear ventanas y divisiones
en el terminal a las que puedes conectarte y desconectarte. Lo uso para mantener
múltiples proyectos abiertos en ventanas separadas y para crear un ambiente
similar a un IDE para trabajar donde puedo tener mi código abierto en vim/neovim
y un intérprete abierto para compilar o ejecutar el código. Tmux está configurado
en [~/.tmux.conf](tmux/tmux.conf.symlink), y en [tmux/theme.sh](tmux/theme.sh),
que define los colores utilizados, el diseño de la barra de tmux, y lo que se
mostrará, incluyendo la hora y la fecha, las ventanas abiertas, el nombre de la
sesión del tmux, el nombre del ordenador, y la canción actual que suena en iTunes.
Si no se ejecuta en macOS, esta configuración debe eliminarse.

Cuando tmux se inicia, se ejecutará [login-shell](bin/login-shell) y si determina
que lo estás ejecutando en macOS, llamará reattach-to-user-namespace, para arreglar
el portapapeles del sistema para su uso dentro de tmux.

## Chuleta para Tmux

```bash
tmux                            # Comenzar nueva sesión
tmux new -s myname              # Comenzar nueva sesión con nombre
tmux a                          # Conectarse a una sesión. También se puede esbribir tmux at o tmux attach
tmux a -t myname                # Conectarse a la sesión nombrada
tmux kill-session -t myname     # Borrar sesión
# Borrar todas las sesiones de tmux
tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill
```
Para los siguientes comandos hay que presionar el prefijo primero. El prefijo por
defecto es `ctrl+b`.

### Sesiones

```bash
:new<CR>                        # Nueva sesión
s                               # Listar sesiones
$                               # Nombrar sesión actual
```
### Varios
```bash
d                               # Desconectarse de la sesión actual
?                               # Muestra una lista de atajos
t                               # Muestra un gran reloj
```
### Ventanas (pestañas)

```bash
c                               # Crear ventana
w                               # Listar ventanas
n                               # Ventana siguiente
p                               # Ventana anterior
f                               # Encontrar ventana
,                               # Nombrar ventana
&                               # Borrar ventana
```
### Paneles (divisiones)

```bash
%                               # Crear ventana
"                               # Listar ventanas
o                               # Rota a través de los paneles
q                               # Mostrar los números de los paneles, presionar el número para ir al panel
x                               # Cerrar panel
+                               # Romper panel a ventana
-                               # Restaurar panel de ventana
(space)                         # Alternar entre diseños
{                               # Mover el panel actual a la izquierda
}                               # Mover el panel actual a la derecha
z                               # Alternar zoom del panel
```
## Atajos propios para Tmux

```bash
<Prefix> y    # Sincronizar todos los paneles de una ventana
<Prefix> r    # Recargar el archivo de configuración
<Prefix> N    # Abrir una nueva ventana rápidamente
<Prefix> |    # Partir ventana verticalmente
<Prefix> -    # Partir ventana horizontalmente
<Prefix> h    # Moverse al panel izquierdo
<Prefix> j    # Moverse al panel inferior
<Prefix> k    # Moverse al panel superior
<Prefix> l    # Moverse al panel derecho

bind -r C-h select-window -t :-
bind -r C-l select-window -t :+

<Prefix> H    # Redimensionar panel actual hacia la izquierda
<Prefix> J    # Redimensionar panel actual hacia abajo
<Prefix> K    # Redimensionar panel actual hacia arriba
<Prefix> L    # Redimensionar panel actual hacia la derecha
```

## Conky
![Alt text](conky/screenshot.png)
