set fish_greeting ""
powerline-daemon

# kick ssh & gpg agents
if status --is-interactive
	#keychain --clear
	set -l IFS # this temporarily clears IFS, which disables the newline-splitting
	#eval (keychain --eval --quiet)
	eval (keychain --eval 84174131 C325A4D4 id_rsa korg-mturquette)
	#keychain 84174131 C325A4D4 id_rsa korg-mturquette

	#eval (keychain --eval --quiet korg-mturquette 84174131)
	# FIXME: use --noask here potentially?
	#eval (keychain --eval --quiet id_rsa C325A4D4)
	#eval (keychain --eval --quiet id_rsa korg-mturquette C325A4D4 84174131)
	#ssh-add ~/.ssh/korg-mturquette
end

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

## application functions

# alot: apply patches to Linux
function alot
	cd ~/src/linux ; ~/.local/bin/alot
end

# mvim for writing
function mvw
	mvim -c "set textwidth=72" -c "set wrap" -c "set spell" -c "set nocp" $argv
end

# vim for writing
function vw
	vim -c "set textwidth=72" -c "set wrap" -c "set spell" -c "set nocp" $argv
end

# vim for developing
function vd
	vim -c ":cf" -c ":copen"
end

## aliases

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

## exports

# ccache
export CCACHE_DIR=$HOME/.cache/ccache

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
