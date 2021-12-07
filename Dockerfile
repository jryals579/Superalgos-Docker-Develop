FROM node:16-alpine as small-os-build

WORKDIR /app

COPY docker-entrypoint.sh /

ARG BRANCH=develop \
    GIT_UPSTREAM=https://github.com/Superalgos/Superalgos.git 
	
ENV BRANCH=$BRANCH \
    PUID=1000 \
    PGID=1000 \
    LANG=C.UTF-8 \
    GIT_USERNAME=${GIT_USERNAME:-"PASTE_YOUR_GITHUB_USERNAME_HERE"} \ 
    GIT_EMAIL_ADRESS=${GIT_EMAIL_ADRESS:-"PASTE_YOUR_GITHUB_E-MAIL_ADRESS_HERE"} \	
    GIT_PERSONAL_ACCESS_TOKEN=${GIT_PERSONAL_ACCESS_TOKEN:-PASTE_YOUR_GITHUB_PERSONAL_ACCESS_TOKEN_HERE} \
    GIT_REPOSITORY_URL=${GIT_REPOSITORY_URL:-https://github.com/YOUR-GITHUB-USERNAME/Superalgos.git} \
    GIT_UPSTREAM=https://github.com/Superalgos/Superalgos.git

RUN apk add --no-cache --virtual .build-deps make g++ \
    && if [ "$BRANCH" = "develop" ] || [ "$BRANCH" = "plugins-docs" ]; then apk add git && git init && apk add --no-cache python3 && echo DEVELOP or PLUGIN DOCS VERSION - GIT AND PYTHON3  INSTALLED && git --version && python3 --version ; else echo NO GIT INSTALLED; fi \
    && apk del .build-deps \
    && chmod a+x /docker-entrypoint.sh

EXPOSE 34248 \
       18041
	   
VOLUME ["/app"]

CMD [ "/docker-entrypoint.sh" ]
