FROM archlinux:latest

ENV LANG=C.UTF-8

RUN pacman-key --init && \
    pacman-key --populate archlinux

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
        wget \
        curl \
        git \
        python \
        python-pip \
        neofetch \
        ttyd \
        bash \
    && pacman -Scc --noconfirm

RUN echo "neofetch" >> /root/.bashrc && \
    echo "cd /root" >> /root/.bashrc

EXPOSE $PORT

CMD ["/bin/bash", "-c", "\
    echo \"export PS1='\\[\\033[01;36m\\]$USERNAME@\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ '\" >> /root/.bashrc && \
    ttyd -p $PORT -c $USERNAME:$PASSWORD bash"]
