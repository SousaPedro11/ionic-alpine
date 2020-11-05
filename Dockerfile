FROM alpine

LABEL maintainer="Pedro Sousa <ppls2106@gmail.com>"

RUN rm -rf /var/cache/apk/* && \
    apk update && \
    apk upgrade &&\
    apk add zsh &&\
    apk add git &&\
    apk add nodejs &&\
    apk add npm &&\
    rm -rf /var/cache/apk/*

RUN sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN sed -i -e "s/bin\/ash/bin\/zsh/" /etc/passwd

RUN npm i -g @ionic/cli cordova

EXPOSE 8100

EXPOSE 8200
