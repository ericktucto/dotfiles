from xontrib.add_variable.decorators import variable, alias
from time import strftime
from os.path import isfile


def e(cmd):
    return cmd.strip('\n') if type(cmd) is str else cmd


@variable
def timeNow():
    return strftime('%H:%M')


@alias
def base16(arg):
    # Declaracion de varibles
    if not arg:
        return 'No eligiste ningun tema o tipe list para listar los temas'
    theme = arg[0]
    if (theme == 'list'):
        themes = [ t[7:-3] for t in e($(ls -1 $BASE16_SHELL/scripts)).split('\n') ]
        # themes = [ t[7:-3] for t in $(ls -1 $BASE16_SHELL/scripts).split('\n')[:-1]]
        return '\n'.join(themes)
    script = $BASE16_SHELL + "scripts/base16-" + theme + ".sh"

    # Verificar que el script del tema exista, no olvidar mensaje de error
    if (isfile(script)):
        @(['bash', script])
        ln -fs @(script) ~/.base16_theme
        $BASE16_THEME = theme
        echo -e @(f"if !exists('g:colors_name') || g:colors_name != 'base16-{theme}'\n  colorscheme base16-{theme}\nendif") > ~/.vimrc_background
        return True
    else:
        print("No existe el tema.")
        return False
    # Terminar con los Hooks


def lorem(arg):
    texto = arg[0] * int(arg[1])
    $[echo @(texto) | xclip -selection clipboard]

