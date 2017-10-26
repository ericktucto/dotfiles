
	# General {
		alias list='function __alias() { history | grep $*;}; __alias'
		alias ev='eval $(ssh-agent -s)'
		alias npmlist='npm list -g --depth=0'
	# }
    # C {
    # }
	# PHPUnit {
		alias t='vendor/bin/phpunit'
		alias ts='vendor/bin/phpunit --stop-on-failure'
		alias tf='vendor/bin/phpunit --filter'
		alias tsf='vendor/bin/phpunit --stop-on-failure --filter'
		alias unit='phpunit'
		alias units='phpunit --stop-on-failure'
		alias unitf='phpunit --filter'
		alias unitsf='phpunit --stop-on-failure --filter'
	# }
	# Virtual Machine {
		alias homestead='function __homestead() { (cd ~/Homestead && vagrant $*); unset -f __homestead; }; __homestead'
		# alias ubuntu='function __ubuntu() { (cd ~/ubuntu && vagrant $*); unset -f __ubuntu; }; __ubuntu'
	# }
	# Laravel commands {
		alias art='php artisan'
		alias tinker='php artisan tinker'
		alias Tinker='clear && php artisan tinker'
	# }
	# Browsers {
		alias chrome='google-chrome-stable'
	# }
	# Editors Text {
	# }
	# Tools {
		alias open='xdg-open'
	# }

	#Others {
	# }
