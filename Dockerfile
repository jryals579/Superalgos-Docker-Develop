FROM node:16-alpine as small-os-build

WORKDIR /app

COPY docker-entrypoint.sh /

ARG BRANCH=develop
	
ENV BRANCH=$BRANCH \
    GIT_USERNAME=${GIT_USERNAME:-"PASTE_YOUR_GITHUB_USERNAME_HERE"} \ 
    GIT_EMAIL_ADDRESS=${GIT_EMAIL_ADDRESS:-"PASTE_YOUR_GIT_EMAIL_ADDRESS_HERE"} \ 	
    GIT_PERSONAL_ACCESS_TOKEN=${GIT_PERSONAL_ACCESS_TOKEN:-PASTE_YOUR_GITHUB_PERSONAL_ACCESS_TOKEN_HERE} \
    PUID=1000 \
    PGID=1000 \
	TZ=/etc/timezone \
    LANG=C.UTF-8

RUN apk add --no-cache --virtual .build-deps make g++ \
    && if [ "$BRANCH" = "develop" ]; then apk add git && git init && apk add --no-cache python3 && echo DEVELOP VERSION - GIT AND PYTHON3  INSTALLED && git --version && python3 --version ; else echo NO GIT INSTALLED; fi \
    && apk del .build-deps \
	&& apk add vim \
    && chmod a+x /docker-entrypoint.sh

EXPOSE 34248 \
       18041
	   
VOLUME ["/app"]

CMD [ "/docker-entrypoint.sh" ]
