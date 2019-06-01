function mcd() {
  mkdir -p "$1" && cd "$1";
}

function myip() {
    for interface in $(ifconfig -s | grep BMRU | cut --delimiter=' ' --fields=1)
    do
        ifconfig $interface |
            grep 'inet ' |
            tr -s ' ' |
            cut --delimiter=' ' --fields=3 |
            sed s/addr://
    done
}

function oports() {
    echo 'User:      Command:   Port:'
    echo '----------------------------'
    lsof -i 4 -P -n |
        grep -i 'listen' |
        awk '{print $3, $1, $9}' |
        sed 's/ [a-z0-9\.\*]*:/ /' |
        sort -k 3 -n |
        xargs printf '%-10s %-10s %-10s\n' |
        uniq
}

function set-scaling-factor() {
    if [ "$#" -ne 1 ]
    then
        echo "Usage: set-scaling-factor <n>"
    else
        gsettings set org.gnome.desktop.interface scaling-factor "$1"
        gsettings set org.gnome.settings-daemon.plugins.xsettings overrides "[{'Gdk/WindowScalingFactor', <$1>}]"
    fi
}

function ipod-sync() {
    rsync --archive \
          --verbose \
          --include-from=~/.config/ipod-sync.conf \
          --exclude=\* \
          --prune-empty-dirs \
          "$1" \
          "$2"
}
