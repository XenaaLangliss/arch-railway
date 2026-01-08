FROM archlinux:base-2024.06.01

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
        wget \
        curl \
        git \
        python \
        python-pip \
        bash \
        ca-certificates \
        ttyd \
    && pacman -Scc --noconfirm

RUN wget -q https://raw.githubusercontent.com/dylanaraps/neofetch/master/neofetch && \
    install -Dm755 neofetch /usr/bin/neofetch

RUN echo "neofetch" >> /root/.bashrc && \
    echo "cd /root" >> /root/.bashrc

EXPOSE $PORT

CMD ["/bin/bash", "-c", "\
    echo \"export PS1='\\[\\033[01;36m\\]$USERNAME@\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ '\" >> /root/.bashrc && \
    ttyd -p $PORT -c $USERNAME:$PASSWORD bash"]
