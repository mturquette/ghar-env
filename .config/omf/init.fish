set fish_greeting ""
powerline-daemon

function vnm
	vim -c ':NotMuch'
end

#if status --is-interactive
#	#keychain --eval --clear
#	keychain --eval --quiet -Q id_rsa C325A4D4
#end

# kick ssh & gpg agents
if status --is-interactive
	set -l IFS # this temporarily clears IFS, which disables the newline-splitting
	eval (keychain --eval --quiet id_rsa C325A4D4 84174131)
end

# mount notmuchfs if not mounted already
if not mount | grep notmuchfs 1> /dev/null
	notmuchfs /home/mturquette/mail/.notmuch/notmuchfs \
		-o backing_dir=/home/mturquette/mail/.notmuch/notmuchfs-backing-store \
		-o mail_dir=/home/mturquette/mail \
		-o mutt_2476_workaround
end
