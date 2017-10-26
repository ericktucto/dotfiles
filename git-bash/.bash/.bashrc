#
# Settings by Erick Tucto <tucto90@gmail.com>
#

source ~/.git-prompt.sh

if test -f /etc/profile.d/git-sdk.sh
then
	TITLEPREFIX=SDK-${MSYSTEM#MINGW}
else
	TITLEPREFIX=$MSYSTEM
fi
PS1='\[\033]0;Route: ${PWD//[^[:ascii:]]/?}\007\]' # set window title

export LANG="es_ES.UTF8"
export LANGUAGE="es_ES.UTF8"

