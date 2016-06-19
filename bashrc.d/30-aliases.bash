# -*- mode: sh -*-

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../../"
alias acs="apt-cache search"
alias aliases="e ~/.dotfiles/bashrc.d/30-aliases.bash"
alias amend="git commit --amend"
alias b="bundle"
alias bake="bundle exec rake"
alias be="bundle exec"
alias ber="bundle exec ruby"
alias bi="bundle install --path vendor/bundle"
alias blog="cd ~/src/blog"
alias bo="bundle outdated"
alias bot="cd ~/src/miq_bot"
alias br="bin/rspec"
alias bu="bundle update"
alias c="cd"
alias chomp="perl -i -pe 'eof && chomp'"
alias cop="rubocop"
alias coppa="rubocop --auto-correct"
alias cud="bundle exec cucumber --format pretty"
alias cuke="bundle exec cucumber"
alias cup="bundle exec cucumber --format process"
alias d="cd ~/.dotfiles"
alias dl="cd ~/Downloads"
alias dr="cd ~/Dropbox"
alias dt="cd ~/Desktop"
alias e=$EDITOR
alias fucking="sudo"
alias fs="bundle exec foreman start"
alias g="git"
alias ga="git add"
alias gaa="git add -u && git add . && git status"
alias gba="git branch -a"
alias gbr="git branch"
alias gca="git commit -a"
alias gcb="git checkout -b"
alias gci="git commit -v"
alias gcl="git clone"
alias gcm="git commit -m"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gcom="git checkout master"
alias gcp="git cherry-pick -x"
alias gdc="git diff --cached"
alias gdf="git diff"
alias gdm="git diff master"
alias gfo="git fetch origin"
alias gg="git lg"
alias gir="git rebase -i origin/master"
alias glg="git lg"
alias gp="git push"
alias gpf="git push --force"
alias gpl="git pull"
alias gpu="git fetch upstream && git merge upstream/master"
alias gps="git push"
alias gpsf="git push --force"
alias grao="git remote add origin"
alias grep="grep --color=always"
alias greph="history | grep"
alias grout="bundle exec rake routes | grep"
alias grpo="git remote prune origin"
alias grv="git remote -v"
alias gs="git status"
alias gst="git status"
alias guard="bundle exec guard"
alias hpush="git push heroku master"
alias irb="irb --readline -r irb/completion"
alias j="bundle exec guard-jasmine"
alias js="bundle exec jekyll serve --drafts"
alias jsonpp="python -m json.tool"
alias killemacs="emacsclient -e '(kill-emacs)'"
alias killruby='killall -9 ruby'
alias la="ls -la --group-directories-first"
alias less="less -R" # display colors correctly
alias lh="ls -lahv --group-directories-first"
alias ll="ls -l --group-directories-first"
alias ln="ln -v"

if [[ $(uname) == Darwin ]]; then
    alias ls="ls -G -h"
else
    alias ls="ls --color -h"
fi

alias loc="wc -l * | sort -n"
alias migrate="bundle exec rake db:migrate db:rollback && bundle exec rake db:migrate db:test:prepare"
alias miq="cd ~/src/manageiq"
alias mkdir="mkdir -p"

if [[ $(uname) == Darwin ]]; then
    alias myip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d\   -f2"
else
    alias myip="cat <(ifconfig wlan0) <(ifconfig eth0) | grep 'inet ' | cut --delimiter=' ' -f12 | sed s/addr://"
fi

alias n="e ~/Documents/notes"
alias now="date '+%Y-%m-%d %H:%M'"
alias op="gnome-open"
alias oports="echo 'User:      Command:   Port:'; echo '----------------------------' ; lsof -i 4 -P -n | grep -i 'listen' | awk '{print \$3, \$1, \$9}' | sed 's/ [a-z0-9\.\*]*:/ /' | sort -k 3 -n | xargs printf '%-10s %-10s %-10s\n' | uniq"
alias pad="padrino"
alias padrion="padrino"
alias puke="bundle exec cucumber --format progress"
alias path="echo $PATH | tr ':' '\n'"
alias r="bundle exec rails"
alias rc="bundle exec rails console"
alias reguard="bin/spring stop && guard"
alias respring="bin/spring stop"

if [[ $(uname) == Darwin ]]; then
    alias retag="rm -f TAGS; ctags -a -e -f TAGS --tag-relative -R --exclude=.git --exclude=log --exclude=tmp *"
else
    alias retag="rm -f TAGS; ctags-exuberant -a -e -f TAGS --tag-relative -R app lib vendor"
fi

alias rg="bundle exec rails generate"
alias rk="bundle exec rake"
alias rkr="bundle exec rake routes"
alias rkt="bundle exec rake -T"
alias rr="bundle exec rails runner"
alias rs="bundle exec rails server"
alias rube="ruby"
alias s="bundle exec rspec --format progress"
alias scratch="cd ~/src/scratch"
alias sff="bundle exec rspec --format progress --fail-fast"
alias src="cd ~/src"
alias sr="screen -r"
alias ss="bin/spring stop"
alias tlf="tail -f"
alias track="git checkout -t"
alias tree="tree -C" # add colors
alias u='cd ..'
alias unb="tar xjvf"
alias undeployed='git fetch --multiple production origin && git log production/master..origin/master'
alias ung="tar xzvf"
alias usage="du -sch"
alias vi="vim"
alias xcopy="xclip -selection clipboard"
alias xpaste="xclip -o"

### Package management
if [[ $(uname) == Darwin ]]; then
    alias agi="brew install"
    alias agr="brew rm"
    alias acs="brew search"
    alias agu="brew update"
else
    alias agi="sudo apt-get install"
    alias agr="sudo apt-get remove"
    alias acs="apt-cache search"
    alias agu="sudo apt-get update"
fi

### Meta
alias rce="$EDITOR ~/.bashrc"
alias rcs="source ~/.bashrc"
