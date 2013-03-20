if [ -f ~/.git_aliases ]; then
	. ~/.git_aliases
fi

if [ -f ~/dot-bash/aliases.bash-wud-gfast01 ]; then
	. ~/dot-bash/aliases.bash-wud-gfast01
fi

if [ -f ~/dot-bash/git.bash ]; then
	. ~/dot-bash/git.bash
fi


alias src='cd ~/src/corsair/Mutiny'
alias out='cd ~/src/corsair/Mutiny/out/artifacts/Arsenal'
alias km='pkill -f "Mutiny|RiskWeb|Sextant|Swapper|Cutlass"'
alias d='cd /site/data/arsenal'
