[user]
    name = Vidar Magnusson
	email = git@vidarmagnusson.com

[core]
    pager = delta
	editor = nvim

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    dark = true
    line-numbers = true

[diff]
    colorMoved = default

[filter "lfs"]
    required = true
    clean = git-lfs clean -- %f
    smudge = git-lfs smudge -- %f
    process = git-lfs filter-process

[pull]
    ff = only

[merge]
    conflictstyle = zdiff3

{% if hostname == "CND207067Z" %}
[includeIf "gitdir:~/Documents/projects/vcrs/"]
    path = ~/Documents/projects/vcrs/.gitconfig
{% end %}
