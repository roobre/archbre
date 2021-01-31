FROM archlinux:base-devel

RUN echo archbre >> /etc/hostname &&\
    echo 127.0.0.1 archbre.local archbre >> /etc/hosts

RUN useradd -m roobre

RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm zsh chezmoi bat pv ffmpeg go hub hugo inotify-tools iperf3 wget screen openscad radare2 \
    rsync strace kubectl valgrind whois bind openbsd-netcat nginx

RUN su -l roobre -c 'sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"' &&\
    su -l roobre -c "chezmoi init https://git.tenshi.es/roobre/chezmoi.git --apply" &&\
    echo "roobre ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

COPY --chown=roobre roobre.zsh-theme /home/roobre/.oh-my-zsh/themes/

USER roobre
WORKDIR /home/roobre

ENTRYPOINT [ "/usr/bin/zsh" ]
