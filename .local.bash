### Git

# Default push
alias gitpush='git push origin master'

# Checkout or create a new letsdothis branch
alias letsdothis='git checkout letsdothis || git checkout -b letsdothis'

# List all current branches
alias branch='git branch | egrep -v "yCOMPLETED|zABANDONED"'

## Mark branches
# Mark a branch as completed
finish() {
	markBranchAsDone "yCOMPLETED" $1
}

# Mark a branch as abandoned
abandon() {
	markBranchAsDone "zABANDONED" $1
}

# Unmark a branch as finished or abandoned
makeCurrent() {
	local branchToRename=$(getBranch $1)
	local currentPrefix=${branchToRename:0:11}

	if [ $(isBranchDone $currentPrefix) = true ]
	then
		git branch -m $branchToRename "${branchToRename:11}"
	fi
}

# Helpers
getBranch() {
	local currentBranch=$(git symbolic-ref --short -q HEAD)
	if (( "$#" == 1 ))
	then
		currentBranch=$1
	fi		
	echo $currentBranch
}

isBranchDone() {
	local branchDone=false
	if [ \( $1 = "yCOMPLETED_" \) -o \( $1 = "zABANDONED_" \) ]
	then
		branchDone=true
	fi
	echo $branchDone
}

markBranchAsDone() {
	local prefix=$1
	local branchToRename=$(getBranch $2)
	local currentPrefix=${branchToRename:0:11}

	if [ $(isBranchDone $currentPrefix) = true ]
	then
		git branch -m $branchToRename "${prefix}_${branchToRename:11}"
	else
		git branch -m $branchToRename "${prefix}_${branchToRename}"
	fi
}


## Other
alias sublime='open -a "Sublime Text"'
