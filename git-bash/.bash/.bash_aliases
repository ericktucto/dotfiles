
	# General {
		alias ls='ls -F --color=auto --show-control-chars'
		alias ll='ls -l'
		alias list='function __alias() { alias | grep $*;}; __alias'
		alias c='clear'
		alias ev='eval $(ssh-agent -s)'
		alias npmlist='npm list -g --depth=0'
	# }
    # C {
        alias make='mingw32-make'
    # }
	# PHPUnit {
		alias t='phpunit --color --bootstrap'
		alias ts='phpunit --color --bootstrap --stop-on-failure'
		alias unit='phpunit'
		alias units='phpunit --stop-on-failure'
	# }
	# Virtual Machine {
		alias homestead='function __homestead() { (cd ~/Homestead && vagrant $*); unset -f __homestead; }; __homestead'
		alias ubuntu='function __ubuntu() { (cd ~/ubuntu && vagrant $*); unset -f __ubuntu; }; __ubuntu'
	# }
	# Laravel commands {
		alias art='php artisan'
		alias tinker='php artisan tinker'
		alias Tinker='clear && php artisan tinker'
		alias Test='vendor/bin/phpunit'
		alias Testf='vendor/bin/phpunit --filter'
	# }
	# Browsers {
		alias firefox='/c/"Program Files (x86)"/Mozilla\ Firefox/firefox.exe'
		alias chrome='/c/"Program Files (x86)"/Google/Chrome/Application/chrome.exe'
	# }
	# Editors Text {
		alias txt='/c/Windows/system32/notepad.exe'
		alias sub='/c/Program\ Files/Sublime\ Text\ 3/sublime_text.exe'
		alias vs='/c/"Program Files (x86)"/Microsoft\ VS\ Code/Code.exe'
	# }
	# Tools {
		alias sql='cd /c/wamp64/bin/mysql/mysql5.7.14/bin'
		alias open='/c/Windows/explorer.exe'
		alias winrar='/c/Program\ Files/WinRAR/WinRAR.exe'
	# }

	#Others {
		alias wortix='cd /c/wamp64/www/wortix-web/'
	# }
