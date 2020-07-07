from xontrib.add_variable.decorators import alias

@alias
def art(arg):
    @(['php', 'artisan'] + arg)


@alias
def homestead(args):
    _back = ['cd', $PWD]
    commands = ['vagrant'] + args

    cd ~/Homestead
    @(commands)
    @(_back)


@alias
def t(args):
    $[./vendor/bin/phpunit @(args)]


@alias
def tw(args):
    $[./vendor/bin/phpunit-watcher @(args)]

