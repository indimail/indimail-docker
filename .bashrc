# Bourne Again SHell init file.
#

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
umask 022
if [ -z "$USER" ] ; then
	declare -x USER=`whoami`
fi
# If running interactively, then:
if [ "$PS1" ]; then
	set noclobber
	declare -x PROMPT_COMMAND='PS1="$HOSTNAME:($USER) $PWD >"'
	#
	# Set readonly variables
	#
	readonly SHELL
	#readonly EDITOR
	declare -x TTY=`tty`
	#
	# general terminal characteristics
	#
	set -o vi

	# ignoreeof=
	# Set auto_resume if you want to resume on "emacs", as well as on
	# "%emacs".
	auto_resume=1

	# Set notify if you want to be asynchronously notified about background
	# job completion.
	notify=1

	# Make it so that failed `exec' commands don't flush this shell.
	no_exit_on_failed_exec=1 
	if [ ! -d $HOME/history ] ; then
		mkdir -p $HOME/history
	fi
	HISTFILE=$HOME/history/.history
	HISTTIMEFORMAT="%F %T "
	HISTCONTROL="ignorespace:ignoredups"
	MAIL=$HOME/Maildir
	MAILCHECK=60

	# A couple of default aliases.
	alias j='jobs -l'
	alias po=popd
	alias pu=pushd
	if [ -f ~/.alias ]; then
		source ~/.alias
	fi
	if [ -f ~/.gfuncs ]; then
		source ~/.gfuncs
	fi
fi

export PATH=$PATH
