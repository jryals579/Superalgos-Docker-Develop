#!/bin/sh
# Stops the Script if ANY Error occures
set -eo pipefail

# env vars
BRANCH=${BRANCH:-"develop"} 
GIT_REPOSITORY_URL=${GIT_REPOSITORY_URL:-https://github.com/Superalgos/Superalgos.git}
GIT_USERNAME=${GIT_USERNAME:-"jryals579"}
GIT_PERSONAL_ACCESS_TOKEN=${GIT_PERSONAL_ACCESS_TOKEN:="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"}
GIT_EMAIL_ADDRESS=${GIT_EMAIL_ADDRESS:="jason.ryals@outlook.com"}

echo "XXXXXXXXXX SET GITHUB USERNAME AND PERSONAL ACCESS TOKEN XXXXXXXXXX"
echo "XXXXXXXXXX GIT USERNAME = ${GIT_USERNAME} XXXXXXXXXX"
if [ "${GIT_USERNAME}" != "" ]; then
    GIT_REPOSITORY_URL="https://github.com/${GIT_USERNAME}/Superalgos.git"
	echo XXXXXXXXXX GIT_REPOSITORY_URL = "https://github.com/${GIT_USERNAME}/Superalgos.git" XXXXXXXXXX
fi
if [ "${GIT_PERSONAL_ACCESS_TOKEN}" != "" ]; then
    GIT_REPOSITORY_URL="https://strafe:${GIT_PERSONAL_ACCESS_TOKEN}@github.com/${GIT_USERNAME}/Superalgos.git"
	echo XXXXXXXXXX GIT_REPOSITORY_URL = "https://strafe:${GIT_PERSONAL_ACCESS_TOKEN}@github.com/${GIT_USERNAME}/Superalgos.git" XXXXXXXXXX
fi

# check if code already exists
echo XXXXXXXXXX CHECK IF SUPERALGOS IS ALREADY INSTALLED XXXXXXXXXX
if [ -d "/app/Superalgos/.git" ]; then
    # update code
	echo XXXXXXXXXX SUPERALGOS IS INSTALLED XXXXXXXXXX
    cd /app/Superalgos
    git checkout ${BRANCH}
	echo XXXXXXXXXX CURRENT BRANCH IS ${BRANCH} XXXXXXXXXX
    if git remote | grep upstream ; then
        if git pull upstream develop ; then
           echo "XXXXXXXXXX UPDATED OR ALREADY UP TO DATE BRANCH ${BRANCH} XXXXXXXXXX"
		   # git log --graph --decorate --oneline
        else
		   echo "XXXXXXXXXX UPDATED DEVELOP BRANCH XXXXXXXXXX"
		   # git log --graph --decorate --oneline
		   git config pull.rebase false 
		   git fetch upstream
		   # git rebase upstream/${BRANCH}
		   # git branch -avv
        fi
    else
		echo "XXXXXXXXXX NOT ON DEVELOPER BRANCH ??? XXXXXXXXXX"
		# git log --graph --decorate --onelineec
		git config pull.rebase false 
        git pull
    fi
else
    # clone Superalgos repo
	echo XXXXXXXXXX NOT INSTALLED YET - INSTALLING SUPERALGOS XXXXXXXXXX
	echo XXXXXXXXXX WORKDIR IS $PWD XXXXXXXXXX
	git init
    git clone "${GIT_REPOSITORY_URL}" /app/Superalgos
    if [ "${GIT_REPOSITORY_URL}" != "https://github.com/Superalgos/Superalgos.git" ]; 
	  then
	    cd Superalgos
             git remote add upstream https://github.com/Superalgos/Superalgos.git
	     git fetch upstream
             git checkout ${BRANCH}
    #        git checkout --track origin/${BRANCH}
    #	     git checkout --track origin
	  else
       echo ERROR	  
    fi

    #
	echo XXXXXXXXXX SET GIT EMAIL AND USERNAME AND REMOTE URL XXXXXXXXXX
        git config --global user.email "${GIT_EMAIL_ADDRESS}"                                                       
        git config --global user.name "${GIT_USERNAME}"  
        git config --get remote.origin.url
	git config --add checkout.defaultRemote upstream

    echo XXXXXXXXXX GIT USERNAME = ${GIT_USERNAME} XXXXXXXXXX
	echo XXXXXXXXXX GIT EMAIL = ${GIT_EMAIL_ADDRESS} XXXXXXXXXX
	

    # ensure node dependencies are up to date # caused an error when restarting Superalgos
	echo XXXXXXXXXX RUNNING NPM SETUP XXXXXXXXXX
	echo XXXXXXXXXX PLEASE BE PATIENT - IT CAN TAKE 5 TO 30 MINUTES XXXXXXXXXX
    npm run setup
	
	echo XXXXXXXXXX SETTING USER AND GROUP XXXXXXXXXX
	cd ..
    cd ..
    addgroup superalgos
    adduser --disabled-password --no-create-home --ingroup superalgos superalgos 
  # chown -R superalgos:superalgos /app   # Did not work with rasbery pi
    chown -R 1000:1000 /app 
	echo XXXXXXXXXX SUPERALGOS INSTALLATION FINISHED XXXXXXXXXX 
fi

echo XXXXXXXXXX UPDATE NODE BY RUNNING NPM SETUP AGAIN XXXXXXXXXX
echo XXXXXXXXXX PLEASE BE PATIENT - IT CAN TAKE 5 TO 30 MINUTES XXXXXXXXXX    
npm run setup

# run the application
cd /app/Superalgos
echo XXXXXXXXXX STARTING SUPERALGOS XXXXXXXXXX
node platform minMemo noBrowser
