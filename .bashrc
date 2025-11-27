# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

# lsd
alias la='lsd -a --color=never'
alias ls='lsd --color=never'
alias ll='lsd -l --color=never'

# networking
alias wifi_list='nmcli dev wifi'
alias wifi_connect='nmcli dev wifi connect' #example wifi_connect <networkname> password <password>
alias lswifi='wifi_list'


# Brightness ctl
alias bl_dim='brightnessctl set 15%'
alias bl_bright='brightnessctl set 45%'
alias bl='brightnessctl set'

# make requirements file (python)
alias mkreq='pip freeze > requirements.txt'

unset rc
. "$HOME/.cargo/env"

. "$HOME/.local/bin/env"
