set fish_greeting ""
powerline-daemon

#if status --is-interactive
#	#keychain --eval --clear
#	keychain --eval --quiet -Q id_rsa C325A4D4
#end

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

function notmuchfs_mount
	# mount notmuchfs if not mounted already
	if not mount | grep notmuchfs 1> /dev/null
		echo "Mounting notmuchfs"
		notmuchfs /home/mturquette/mail/.notmuch/notmuchfs \
			-o backing_dir=/home/mturquette/mail/.notmuch/notmuchfs-backing-store \
			-o mail_dir=/home/mturquette/mail \
			-o mutt_2476_workaround
	end
end

function notmuchfs_mount_debug
	# mount notmuchfs if not mounted already
	if not mount | grep notmuchfs 1> /dev/null
		echo "Mounting notmuchfs"
		notmuchfs -d /home/mturquette/mail/.notmuch/notmuchfs \
			-o backing_dir=/home/mturquette/mail/.notmuch/notmuchfs-backing-store \
			-o mail_dir=/home/mturquette/mail \
			-o mutt_2476_workaround
	end
end

function notmuchfs_unmount
	fusermount -u ~/mail/.notmuch/notmuchfs
end

## always try to mount
#notmuchfs_mount

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

# mutt: Save attachments to Dropbox
function mutt
	cd ~/Dropbox/Downloads ; /usr/bin/mutt
end

function vnm
	vim -c ':NotMuch'
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
	make -j$nr_jobs
end

# use m alias above, and save STDERR to errors.err log
function m2
	m 2> errors.err
end

## exports

# ccache
export CCACHE_DIR=$HOME/.cache/ccache
