set fish_greeting ""
powerline-daemon

### HEY PLZ ADD AN ALIAS FOR ME KTHX ###
# exec msmtpq --q-mgmt "$1"
#ls /usr/local/share/msmtp/scripts/msmtpq/*
#/usr/local/share/msmtp/scripts/msmtpq/README.msmtpq
#/usr/local/share/msmtp/scripts/msmtpq/msmtp-queue
#/usr/local/share/msmtp/scripts/msmtpq/msmtpq

### HEY ALSO ADD ME ###
# /usr/local/share/git-core/contrib/git-jump/git-jump

## path
set -gx PATH $HOME/.local/bin $PATH $HOME/src/ghar/bin $HOME/src/gmailieer/

## GPG and SSH agent configuration

#gpg-connect-agent /bye
export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

## git functions

# apply patches that have been saved in Dropbox
function gam --description 'Apply patches from Dropbox'
	switch (count $argv)
	case 2
		set branchname $argv[2]
		if not git checkout -b $branchname $argv[1]
			exit 1
		end
	case 1
		set branchname $argv
	case '*'
		echo Invalid number of args
		exit 1
	end

	git am -s3 ~/Dropbox/patches/$branchname
end

## git aliases

function gs --description 'git status'
	git status
end

function gsk --description 'git am --skip'
	git am --skip
end

function gco --description 'git checkout <branch>'
	git checkout $argv
end

function gcob --description 'git checkout -b <new_branch> [<start_point>]'
	git checkout -b $argv
end

function gcb --description 'git checkout -b <new_branch> [<start_point>]'
	git checkout -b $argv
end

function gfp --description 'generate patches in $branchname dir'
	mkdir (git rev-parse --abbrev-ref HEAD)
	git format-patch --cover-letter -o (git rev-parse --abbrev-ref HEAD)/ $argv
end

function gcn --description 'git checkout clk-next'
	git checkout clk-next
end

function gmsg --description 'append Link: msgid to git commit'
	set msgid (cat ./msgid.patch)
	git filter-branch -f --msg-filter "cat && echo Link: lkml.kernel.org/r/$msgid" HEAD^..HEAD
end

## aliases

# alot: apply patches to Linux
function alot
	cd ~/src/linux ; /usr/local/bin/alot
end

# alias vim to nvim
function vim
	nvim $argv
end

# alias v to vim/nvim
function v
	nvim $argv
end

# vim for writing
function vw
	nvim -c "set textwidth=72" -c "set wrap" -c "set spell" -c "set nocp" $argv
end

# vim for debug
function vd
	nvim -c ":cf" -c ":copen"
end

# emacs console, not gui
function em
	emacs -nw
end

## make functions

# make, with 2 threads per cpu
function m
	# nr_jobs = nr_cpus * 2
	set nr_jobs (math "2 *" (grep -c "^processor" /proc/cpuinfo))
	make -j$nr_jobs $argv
end

# use m alias above, and save STDERR to errors.err log
function m2
	m $argv 2> errors.err
end

function c
	scp arch/$ARCH/boot/*Image arch/$ARCH/boot/dts/"$vendor"/*.dtb sh.deferred.io:/srv/tftp/$ARCH
	sync
end

function m3
	set -l nr_jobs (math "2 *" (grep -c "^processor" /proc/cpuinfo))
	if make -j$nr_jobs $argv 2> errors.err
		mkimage -A $ARCH -O linux -C none -T kernel -a $LOADADDR -e $LOADADDR -d arch/$ARCH/boot/Image arch/$ARCH/boot/uImage
		c
	end
	# display warnings & errors sent to STDERR, if any
	if test -s errors.err
		less errors.err
	end
end

function mosh.quantum
	mosh sh.deferred.io -p 60001:60005
end

function mosh.conch
	mosh sh.deferred.io -p 60006:60010
end

## exports

# ccache
export CCACHE_DIR=$HOME/.cache/ccache

# linux armv7, amlogic S805 kernel hacking
#export ARCH=arm
#export CROSS_COMPILE="ccache /home/mturquette/tc/gcc-linaro-5.2-2015.11-x86_64_arm-linux-gnueabi/bin/arm-linux-gnueabi-"
#export LOADADDR=0x00208000

# linux armv8, amlogic S905 kernel hacking
#export ARCH=arm64
#export CROSS_COMPILE="ccache /home/mturquette/tc/gcc-linaro-5.3-2016.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-"
#export LOADADDR=0x01080000

# android sdk dir used by gradle
export ANDROID_HOME=$HOME/Library/Android/sdk

# per-board environments

function env.meson8b
	set -gx ARCH arm
	set -gx CROSS_COMPILE "ccache /home/mturquette/tc/gcc-linaro-5.2-2015.11-x86_64_arm-linux-gnueabi/bin/arm-linux-gnueabi-"
	set -gx LOADADDR 0x00208000
	set -e vendor
end

function env.gxbb
	set -gx ARCH arm64
	set -gx CROSS_COMPILE "ccache /home/mturquette/tc/gcc-linaro-5.3-2016.02-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-"
	set -gx LOADADDR 0x01080000
	set -gx vendor amlogic
end

function env.clear
	set -e ARCH
	set -e CROSS_COMPILE
	set -e LOADADDR
	set -e vendor
end
