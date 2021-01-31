FROM alpine:edge

RUN apk add zsh bash bash-completion sudo git bat pv curl wget screen rsync ncdu \
    strace valgrind gcc radare2 go \
    whois bind netcat-openbsd nginx iperf3 \
    chezmoi

RUN adduser roobre -s /bin/zsh -D

RUN su -l roobre -c 'sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"' &&\
    su -l roobre -c "chezmoi init https://git.tenshi.es/roobre/chezmoi.git --apply" &&\
    echo "roobre ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY --chown=roobre roobre.zsh-theme /home/roobre/.oh-my-zsh/themes/

USER roobre
WORKDIR /home/roobre

ENTRYPOINT [ "/bin/zsh" ]
