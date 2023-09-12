import os
from subprocess import run

def composer(args):
    group = "www-data"
    user = str(os.getuid()) + ":" + group
    run(["docker-compose", "exec", "-u", user, "php", "composer"] + args[1:])
    #chmod g+w app/storage -R
    return 1

def npm(args):
    node(args)


def node(args):
    run(["docker-compose", "exec", "-u", "node:node", "nodejs"] + args)

def artisan(args):
    group = "www-data"
    user = str(os.getuid()) + ":" + group
    run(["docker-compose", "exec", "-u", user, "php", "php"] + args)
    return 1

def ptest(args):
    binario = "vendor/bin/phpunit"
    if "--watch" in args or "-w" in args:
        args = [x for x in args if x not in ["--watch", "-w"]]
        binario += "-watcher"
    run(["docker-compose", "exec", "php", binario] + args[1:])
