[alias]
	co = checkout
	br = branch
	ci = commit
	st = status
[pull]
	rebase = false
[init]
	defaultBranch = master
[user]
	name = Andy Davis
	email = {{ op://tmoi2qf2jmo7franvmgzdjcl24/co2ywk4mwttkqzqti7l2dwpeoy/email }}
	signingkey = {{ op://tmoi2qf2jmo7franvmgzdjcl24/co2ywk4mwttkqzqti7l2dwpeoy/signing key }}
[gpg]
	format = ssh
[gpg "ssh"]
	program = /opt/1Password/op-ssh-sign
[commit]
	gpgsign = true
[push]
	default = simple
[core]
	pager = cat
[credential "https://github.com"]
	helper = 
	helper = !/usr/bin/gh auth git-credential
[credential "https://gist.github.com"]
	helper = 
	helper = !/usr/bin/gh auth git-credential
