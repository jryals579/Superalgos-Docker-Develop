#!/bin/sh
# Stops the Script if ANY Error occures
set -eo pipefail

# env vars
BRANCH=${BRANCH:-"develop"} 
GIT_UPSTREAM=${GIT_UPSTREAM:-"https://github.com/Superalgos/Superalgos.git"}
GIT_REPOSITORY_URL=${GIT_REPOSITORY_URL:-$GIT_UPSTREAM}
GIT_USERNAME=${GIT_USERNAME:-"superalgos"}
GIT_PERSONAL_ACCESS_TOKEN=${GIT_PERSONAL_ACCESS_TOKEN:=""}
GIT_EMAIL_ADDRESS=${GIT_EMAIL_ADDRESS:=""}

if [ "${GIT_USERNAME}" != "" ]; then
    GIT_REPOSITORY_URL="https://github.com/${GIT_USERNAME}/Superalgos.git"
fi
if [ "${GIT_PERSONAL_ACCESS_TOKEN}" != "" ]; then
    GIT_REPOSITORY_URL="https://strafe:${GIT_PERSONAL_ACCESS_TOKEN}@github.com/${GIT_USERNAME}/Superalgos.git"
fi

# check if code already exists
if [ -d "/app/Superalgos/.git" ]; then
    # update code
	echo UPDATE CORE
    cd /app/Superalgos
    git checkout ${BRANCH}
    if git remote | grep upstream ; then
        if git pull upstream develop ; then
           echo "UPDATED DEVELOP BRANCH"
        else
           echo "ALREADY UP TO DATE, OR ERROR OCCURED"
        fi
    else
        git pull
		echo "UPDATED MASTER BRANCH ???"
    fi
else
    # clone Superalgos repo
	echo INSTALL SUPERALGOS
	git init
    git clone "${GIT_REPOSITORY_URL}" /app/Superalgos
    if [ "${GIT_REPOSITORY_URL}" != "${GIT_UPSTREAM}" ]; then
        git remote add upstream "${GIT_UPSTREAM}"
		git fetch upstream
		git checkout ${BRANCH}
    fi
	cd /app/Superalgos

    #
	echo "SET GIT EMAIL AND USERNAME AND REMOTE URL"
    git config --global user.email "${GIT_EMAIL_ADDRESS}"                                                       
    git config --global user.name "${GIT_USERNAME}"  
    git config --get remote.origin.url


    # ensure node dependencies are up to date # caused an error when restarting Superalgos
	echo RUNNING NODE SETUP
    node setup noShortcuts
	
	echo SETTING USER AND GROUP
	cd ..
    cd ..
    addgroup superalgos
    adduser --disabled-password --no-create-home --ingroup superalgos superalgos 
  # chown -R superalgos:superalgos /app   # Did not work with rasbery pi
    chown -R 1000:1000 /app 
	echo SUPERALGOS INSTALLATION FINISHED
fi


# run the application
cd /app/Superalgos
echo MAKEING SURE YOUR FORK IS IN SYNC WITH SUPERALGOS

if git remote add upstream ${GIT_UPSTREAM} ; then
   echo SETTING REMOTE UPSTREAM to ${GIT_UPSTREAM}
   git remote add upstream ${GIT_UPSTREAM}
else
   echo REMOTE UPSTREAM ALREADY EXISTS AND IS SET TO ${GIT_UPSTREAM}
   echo OR ERROR OCCURED
fi
git fetch upstream
git checkout ${BRANCH}
git rebase upstream/${BRANCH}

echo STARTING SUPERALGOS
node platform minMemo noBrowser
