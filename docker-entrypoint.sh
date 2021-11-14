#!/bin/sh
set -eo pipefail

# env vars
BRANCH=${BRANCH:-"develop"} 
GIT_UPSTREAM=${GIT_UPSTREAM:-"https://github.com/Superalgos/Superalgos.git"}
GIT_REPOSITORY_URL=${GIT_REPOSITORY_URL:-$GIT_UPSTREAM}
GIT_USERNAME=${GIT_USERNAME:-""}
GIT_PERSONAL_ACCESS_TOKEN=${GIT_PERSONAL_ACCESS_TOKEN:=""}
GIT_EMAIL_ADRESS=${GIT_EMAIL_ADRESS:=""}

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
        git pull upstream ${BRANCH}
    else
        git pull
    fi
else
    # clone repo
	git init
    git clone "${GIT_REPOSITORY_URL}" /app/Superalgos
    if [ "${GIT_REPOSITORY_URL}" != "${GIT_UPSTREAM}" ]; then
        git remote add upstream "${GIT_UPSTREAM}"
    fi
fi

cd /app/Superalgos

git config --global user.email "${GIT_EMAIL_ADRESS}"                                                       
git config --global user.name "${GIT_USERNAME}"  
git config --get remote.origin.url

# ensure node dependencies are up to date
node setup noShortcuts

# run the application
node platform minMemo noBrowser