#Courtesy Greg Fast
#git://git.drwholdings.com/gfast/dot-bash.git

if [ -f ~/.git_aliases ]; then
	. ~/.git_aliases
fi

#Courtesy Greg Fast
#git://git.drwholdings.com/gfast/dot-bash.git
if [ -f ~/dot-bash/git.bash ]; then
	. ~/dot-bash/git.bash
fi


alias src='cd ~/src/corsair/Mutiny'
alias out='cd ~/src/corsair/Mutiny/out/artifacts/Arsenal'
alias km='pkill -f "Mutiny|RiskWeb|Sextant|Swapper|Cutlass"'
alias d='cd /site/data/arsenal'
