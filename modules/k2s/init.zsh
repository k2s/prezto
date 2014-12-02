

### search/find related ###
alias ,fi-text='grep -rni --exclude=\*.svn\*'
alias ,fi-text-configs='grep -rni --exclude=\*.svn\*'
alias ,fi-proc='ps auxww|/usr/bin/grep -v grep|/usr/bin/grep'
alias ,fi-nd='find . -iname'
alias ,fi-nd-configs='find . -iname'
alias ,fi-bindkey='bindkey | less'

### disk/folder related ###
alias ll="ls -l --group-directories-first"
alias lh="ls -l --group-directories-first -h"
alias ,cdback='cd -'
alias ,cddev='cd ~/Dev/xtdoc/DocBuilder'
alias df='df -kTh'
alias ,ds-file-systems='df'
alias ,ds-usage-subdirs='du -sk ./* | sort -n | awk '\''BEGIN{pref[1]="K";pref[2]="M"; pref[3]="G";} { total = total + $1; x = $1; y = 1; while( x > 1024 ) { x = (x + 1023)/1024; y++; } printf("%g%s\t%s\n",int(x*10)/10,pref[y],$2); } END { y = 1; while( total > 1024 ) { total = (total + 1023)/1024; y++; } printf("Total: %g%s\n",int(total*10)/10,pref[y]); }'\'''
alias ,ds-usage-summary='du -sch'
## find sorted list of biggest files under current directory
alias ,ds-biggest='find -type f -printf '\''%s %p\n'\'' | sort -nr | head -n 40 | gawk "{ print \$1/1000000 \" \" \$2 \" \" \$3 \" \" \$4 \" \" \$5 \" \" \$6 \" \" \$7 \" \" \$8 \" \" \$9 }"'

### process related ###
alias ,pc-by-mem='ps -e -orss=,args= | sort -b -k1,1n | pr -TW$COLUMNS'
alias ,pc-drop-caches='free -h && sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches && free -h"'

### pacman commands ###
alias ,pa-install='yaourt -Sy --needed'
alias ,pa-search='yaourt --pager -Ss'
alias ,pa-file-belongs='pacman -Qo'
alias ,pa-display='yaourt -Si'
alias ,pa-orphans='pacman -Qtdq'
# recursively removing orphans
alias ,pa-orphans-remove='sudo pacman -Rs $(pacman -Qtdq)'
# Remove the specified package(s), retaining its configuration(s) and required dependencies
alias ,pa-remove='sudo pacman -R'
# Remove the specified package(s), its configuration(s) and unneeded dependencies
alias ,pa-remove-completly='sudo pacman -Rns'
# Show history of pacman/yaourt actions
alias ,pa-history='less /var/log/pacman.log'

### ZSH global aliases for piping ###
alias -g H="| head"
alias -g T="| tail"
alias -g C="| wc -l"
alias -g L="| less"
alias -g G="| grep"
#alias -g S="| sed -e"
#alias -g A="| awk"

### PC power management ###
alias reboot='sudo reboot'
alias shutdown='sudo shutdown -h now'
alias hibernate='sudo pm-hibernate'
alias suspend='sudo pm-suspend'

### easy systemd commands
# simplified systemd command, for instance "sudo systemctl stop xxx" - > "0.stop xxx"
if ! systemd-notify --booted;
then  # for not systemd
    0.start() {
        sudo rc.d start $@
    }

    0.restart() {
        sudo rc.d restart $@
    }

    0.stop() {
        sudo rc.d stop $@
    }
else
# start systemd service
    0.start() {
        sudo systemctl start $@
    }
# restart systemd service
    0.restart() {
        sudo systemctl restart $@
    }
# stop systemd service
    0.stop() {
        sudo systemctl stop $@
    }
# enable systemd service
    0.enable() {
        sudo systemctl enable $@
    }
# disable a systemd service
    0.disable() {
        sudo systemctl disable $@
    }
# show the status of a service
    0.status() {
        systemctl status $@
    }
# reload a service configuration
    0.reload() {
        sudo systemctl reload $@
    }
# list all running service
    0.list() {
        systemctl
    }
# list all failed service
    0.failed () {
        systemctl --failed
    }
# list all systemd available unit files
    0.list-files() {
        systemctl list-unit-files
    }
# check the log
    0.log() {
        sudo journalctl
    }
# show wants
    0.wants() {
        systemctl show -p "Wants" $1.target
    }
# analyze the system
    0.analyze() {
        systemd-analyze $@
    }
fi
