# AWS
#T_AWS_IAM_INC_SH_DIR=~/git/firecloud/support-firecloud/bin/
#T_AWS_IAM_INC_SH_DIR=~/git/firecloud/support-firecloud/bin/
#source ${T_AWS_IAM_INC_SH_DIR}/aws-iam-login.inc.sh
#alias awspd='aws-iam-login awsproclouddev_ops'
#alias awspp='aws-iam-login awsprocloudprod_ops'
set +o noclobber # Needed. Otherwise doesn't overwrite files

function aws_switch () {
	[ $# -gt 0 ] || {
		echo "Usage: aws_switch profilename" >&2
		return 1
	}
	aws configure list --profile $1 > /dev/null || {
		return 1
	}
	export AWS_DEFAULT_PROFILE=$1
	export AWS_PROFILE=$1
	export AWS_REGION=$(aws configure get region --profile $1)
	export AWS_DEFAULT_REGION=${AWS_REGION}
	echo "Switched to AWS profile: $1"
	aws configure list
}
#alias awspd='aws_switch awsproclouddev_ops'

# Environment variables
export LC_ALL=$LANG
export EDITOR='mvim -v'
export VISUAL='mvim -v'
alias vim='mvim -v'
alias vimdiff='vim -d'
alias view='vim -R -u ~/.vimrc.view'

# Vi mode for shell
#set -o vi # not possible in zsh?
bindkey -v # for zsh
bindkey "^r" history-incremental-search-backward
export KEYTIMEOUT=1 #0.1 s to take esc key
#zstyle ':prezto:module:editor' keymap 'vi' #presto something?

# General aliases
alias v='view -'
alias vjs="view -c 'set filetype=javascript'  -"
alias vz='view -c AnsiEsc -'
alias p='pwd'
alias vd='git diff . | v'
alias s='git status'

alias stash='git stash save'
alias sop='git stash pop'
alias sist='git stash list'
alias slear='git stash clear'

alias checkout='git checkout'
alias push='git push'
alias pushnewremote='git push --set-upstream origin $(branch)'
alias pull='git pull'
alias fetch='git fetch'
alias merge='git merge'
function show() {
  if [ -z $1 ]; then
    git show | view -
  else
    git show HEAD~$1 | view -
  fi
}
function shownodiff() {
  git log --oneline HEAD~$1~1..HEAD~$1
}
#alias show='git show | view -'

function daysago() {
  date -v-$1d "+%Y-%m-%d"
}

alias _glg='git log --color=always --topo-order --graph --pretty=format:"%C(green)%h%C(reset) %s%C(red)%d%C(reset)"'
alias glg='_glg --all | vz'
alias gle='git log --color=always --all --graph --date=short --since=$(daysago 5).midnight --pretty=format:"%Cgreen%h%Creset %s %Cred%d%Creset (%Cblue%an%Creset) %ad" | head -n 30'
alias glev='gle|vz'
alias glga='git log --color=always --topo-order --all --graph --pretty=format:"%Cgreen%h%Creset %s %Cred%d%Creset (%Cblue%an%Creset)" | vz'
alias glgad='git log --color=always --topo-order --all --graph --date=short --pretty=format:"%Cgreen%h%Creset %s %Cred%d%Creset (%Cblue%an%Creset) %ad" | vz'
alias glgadbw='git log --color=never --topo-order --all --graph --date=short --pretty=format:"%Cgreen%h%Creset %s %Cred%d%Creset (%Cblue%an%Creset) %ad" | vz'

alias glgb='git log --color=always --topo-order --graph --pretty=format:"%C(green)%h%C(reset) %s%C(red)%d%C(reset)" $(branch)'
alias glgba='git log --color=always --topo-order --graph --pretty=format:"%Cgreen%h%Creset %s %Cred%d%Creset (%Cblue%an%Creset)" $(branch)'
alias glgbad='git log --color=always --topo-order --graph --date=short --pretty=format:"%Cgreen%h%Creset %s %Cred%d%Creset (%Cblue%an%Creset) %ad" $(branch)'
alias showhead='glgbad | head -n 1'

alias glgh='_glg | head'
alias glgbh='glgb | head'

alias prettylog='git log --pretty=format:"%h  %<(20,trunc)%an  %ad  %s%Cred%d%Creset" --date=short'

alias sv='git status | view -'
alias commitdate='g show -s --format=%ad --date=short'
alias ...='cd ../..'
alias play='cd ~/playground'
alias cdfirecloud='cd ~/git/firecloud'
alias firecloud='cd ~/git/firecloud/client/site/share/files/app ; vimt'
alias makeshareclient='cd ~/git/firecloud/client/site/share/files ; make build ; cd -'
alias build='cd ~/git/firecloud/client/site/share/files ; make build'
alias branch='git rev-parse --abbrev-ref HEAD'

function diffSinceSplit() {
  base=$(git merge-base --fork-point master)
  if [ -z $base ]; then
    echo "No merge-base found"
  else
    git diff $base..
  fi
}

function logSinceSplit() {
  otherBranch='master'
  base=$(git merge-base --fork-point $otherBranch)
  if [ -z $base ]; then
    echo "No merge-base found"
  else
    glgbad $otherBranch $base~..
  fi
}

# Diary
alias diary='vim ~/diary.txt -u ~/.vimrc.diary'

# Jobs
alias j='jobs'
alias f='fg'
alias 1='fg %1' #zsh specific
alias 2='fg %2' #zsh specific
alias 3='fg %3' #zsh specific
alias 4='fg %4' #zsh specific
alias 5='fg %5' #zsh specific
alias 6='fg %6' #zsh specific
alias 7='fg %7' #zsh specific
alias 8='fg %8' #zsh specific

alias vimt='vim -u ~/.vimrc.search-ts'
function coffeesession() {
  vim -c "vs $1.coffee" -u ~/.vimrc.coffeescript-session $1.js
}

function _nfind() { find . -type f -ipath "*$1*";}
function nfind() { file=$(_nfind $1);echo $file;}
function goto() { cd $(dirname $(_nfind $1));}
#function nfind() { find . -type f -ipath $1;}
function nfindv() { nfind $1 | view - -u ~/.vimrcs.fkj/vimrc.grins;}
function vnim() { vim $(_nfind $1);}
alias vf='vim $file'

# grep
function grinsop() { 
    echo $* :
    egrep -Irinsa --exclude-dir={.svn,.git,node_modules,public} "$1" $2;
}
function grinso() {
    if [ $2 ]; then
        #for f in $(find . -ipath $2 -not -path '*/test/*' -type f); do
        for f in $(find . -ipath $2 -type f); do
            egrep -Hni $1 $f
        done
    else
        grinsop $1 .
    fi
}
function grinsoword() { grinso "\<$1\>" $2;}
function grins() { grinso $* | view - +/$1 -u ~/.vimrcs.fkj/vimrc.grins;}
function grinsword() { grinsoword $1 $2 | view - +/\\\<$1\\\> -u ~/.vimrcs.fkj/vimrc.grins;}

# make stuff
alias stal='API_BASE_URL=http://localhost:8081 make test/api'

alias chromenosecurity='/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --disable-web-security --user-data-dir'

source ~/.profile.video
source ~/playground2/profile

