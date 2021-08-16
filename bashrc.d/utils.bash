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
          --delete \
          --verbose \
          --ignore-existing \
          --include-from=~/.config/ipod-sync.conf \
          --exclude=\* \
          --prune-empty-dirs \
          "$1" \
          "$2"
}

function clean-kernels() {
    dpkg -l linux-{image,headers}-"[0-9]*" |
        awk '/ii/{print $2}' |
        grep -ve "$(uname -r | sed -r 's/-[a-z]+//')" |
        xargs echo "sudo apt-get purge"
}

function insta-resize() {
    for in_filename in "$@"
    do
        local bname=$(basename -- "${in_filename}")
        local extension="${bname##*.}"
        local filename="${bname%.*}"
        local out_filename="${filename}-i.${extension}"

        gimp --no-interface \
             --batch="(let* ((in-filename \"$in_filename\")
                            (out-filename \"$out_filename\")
                            (image (car (gimp-file-load RUN-NONINTERACTIVE in-filename in-filename)))
                            (drawable (car (gimp-image-get-active-layer image)))
                            (old-width (car (gimp-image-width image)))
                            (old-height (car (gimp-image-height image)))
                            (is-landscape (> old-width old-height))
                            (is-portrait (> old-height old-width))
                            (new-width (max old-width old-height))
                            (new-height (max old-width old-height))
                            (offx (if is-landscape 0 (floor (/ (- new-width old-width) 2))))
                            (offy (if is-portrait 0 (floor (/ (- new-height old-height) 2)))))
                       (gimp-image-resize image new-width new-height offx offy)
                       (gimp-layer-resize-to-image-size drawable)
                       (gimp-file-save RUN-NONINTERACTIVE image drawable out-filename out-filename)
                       (gimp-image-delete image))" \
             --batch='(gimp-quit 0)'
    done

}

function web-resize() {
    for in_filename in "$@"
    do
        local bname=$(basename -- "${in_filename}")
        local extension="${bname##*.}"
        local filename="${bname%.*}"
        local out_filename="${filename}-web.${extension}"

        gimp --no-interface \
             --batch="(let* ((in-filename \"$in_filename\")
                            (out-filename \"$out_filename\")
                            (image (car (gimp-file-load RUN-NONINTERACTIVE in-filename in-filename)))
                            (drawable (car (gimp-image-get-active-layer image)))
                            (old-width (car (gimp-image-width image)))
                            (old-height (car (gimp-image-height image)))
                            (scale-factor (/ 1500 (max old-width old-height)))
                            (new-width (* scale-factor old-width))
                            (new-height (* scale-factor old-height)))
                       (gimp-image-scale image new-width new-height)
                       (file-jpeg-save RUN-NONINTERACTIVE image drawable out-filename out-filename 0.85 0 1 1 \"\" 2 1 0 0)
                       (gimp-image-delete image))" \
             --batch='(gimp-quit 0)'
    done
}

function binary-to-plain() {
    cat "$1" | tr -d "\0"
}

function disable-lock() {
    gsettings set org.gnome.desktop.screensaver ubuntu-lock-on-suspend 'false'
    gsettings set org.gnome.desktop.screensaver lock-enabled 'false'
}
