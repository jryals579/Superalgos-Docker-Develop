#!/bin/sh
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
    cd /app/Superalgos
    git checkout ${BRANCH}
    if git remote | grep upstream ; then
        if git pull upstream develop ; then
           echo "updated-1"
        else
           echo "already up to date, or other error occurred"
        fi
    else
        git pull
		echo "updated-2"
    fi
else
    # clone Superalgos repo
	git init
    git clone "${GIT_REPOSITORY_URL}" /app/Superalgos
    if [ "${GIT_REPOSITORY_URL}" != "${GIT_UPSTREAM}" ]; then
        git remote add upstream "${GIT_UPSTREAM}"
    fi
	cd /app/Superalgos

    #
    git config --global user.email "${GIT_EMAIL_ADDRESS}"                                                       
    git config --global user.name "${GIT_USERNAME}"  
    git config --get remote.origin.url

    # ensure node dependencies are up to date # caused an error when restarting Superalgos
    node setup noShortcuts

    cd ..
    cd ..
    addgroup superalgos
    adduser --disabled-password --no-create-home --ingroup superalgos superalgos 
  # chown -R superalgos:superalgos /app   # Did not work with rasbery pi
    chown -R 1000:1000 /app 
fi

# run the application
cd /app/Superalgos
node platform minMemo noBrowser
