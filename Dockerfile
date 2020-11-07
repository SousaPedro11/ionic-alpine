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

RUN npm i -g @ionic/cli cordova yarn

RUN sed -i -e "s/git/git ionic ng/" ~/.zshrc

RUN echo $'\nexport PATH="$PATH:$(yarn global bin)"\n' >> ~/.zshrc

RUN echo $'\nif type compdef &>/dev/null; then\n\t__ionic(){\n\t\tcompadd -- $(ionic completion -- "${words[@]}" 2>/dev/null)\n\t}\n\n\tcompdef __ionic ionic\nfi\n' >> ~/.zshrc

RUN ionic config set -g npmClient yarn

EXPOSE 8100

EXPOSE 8200
