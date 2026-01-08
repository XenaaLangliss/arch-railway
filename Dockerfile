FROM archlinux:latest

RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm wget curl git python python-pip fastfetch && \
    pacman -Scc --noconfirm

RUN wget -qO /bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64 && \
    chmod +x /bin/ttyd

RUN echo "fastfetch" >> /root/.bashrc && \
    echo "cd /root" >> /root/.bashrc

EXPOSE $PORT

RUN echo $CREDENTIAL > /tmp/debug

CMD ["/bin/bash", "-c", "\
    echo \"export PS1='\\[\\033[01;36m\\]$USERNAME@\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ '\" >> /root/.bashrc && \
    /bin/ttyd -p $PORT -c $USERNAME:$PASSWORD /bin/bash"]
