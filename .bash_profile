#
# trap deadly signals
#
trap "" SIGHUP SIGQUIT
trap "sh $HOME/.glogout" SIGTERM EXIT
umask 022

if [ -z "$USER" ] ; then
	declare -x USER=`whoami`
fi
if [ "$PS1" ]; then
	declare -x PROMPT_COMMAND='PS1=`pwd`\>'
fi

# If the user has her own init file, then use that one, else use the
# canonical one.
declare -x PATH=$PATH:/bin:$HOME/bin:/usr/libexec/indimail
if [ -f ~/.bashrc ]; then
	source ~/.bashrc
else
if [ -f ${default_dir}Bashrc ]; then
	source ${default_dir}Bashrc;
fi
fi
declare -x LESS=-e
declare -x SIMPLE_BACKUP_SUFFIX='.BAK'
declare -x MANPATH="$MANPATH:/usr/local/man"
declare -x GIT_PAGER=""
ENV=$HOME/.bashrc
export PATH
if [ " $TERM" = " xterm" -o " $TERM" = " xterm-256color" ] ; then
	declare -x TERM=vt100
	if [ -x /usr/bin/screen -a ! -f ~/.noscreen ] ; then
		exec /usr/bin/screen
	fi
else
	declare -x TERM=xterm
fi
