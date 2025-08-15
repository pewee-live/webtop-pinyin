FROM lscr.io/linuxserver/webtop:ubuntu-mate

USER root

RUN apt update && \
    apt install -y \
        locales \
        im-config \
        fcitx5 \
        fcitx5-pinyin \
        fcitx5-chinese-addons \
        fcitx5-config-qt \
        fcitx5-configtool \
        fonts-wqy-microhei \
        fonts-wqy-zenhei \
        fonts-noto-cjk \
    && locale-gen zh_CN.UTF-8 en_US.UTF-8 \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=zh_CN.UTF-8
ENV LANGUAGE=zh_CN:zh
ENV LC_ALL=zh_CN.UTF-8
ENV GTK_IM_MODULE=fcitx
ENV QT_IM_MODULE=fcitx
ENV XMODIFIERS="@im=fcitx"

RUN mkdir -p /root/.config/fcitx5 && \
    echo "[Groups/0]" > /root/.config/fcitx5/profile && \
    echo "Name=Default" >> /root/.config/fcitx5/profile && \
    echo "Default Layout=us" >> /root/.config/fcitx5/profile && \
    echo "DefaultIM=fcitx-keyboard-us" >> /root/.config/fcitx5/profile && \
    echo "" >> /root/.config/fcitx5/profile && \
    echo "[Groups/0/Items/0]" >> /root/.config/fcitx5/profile && \
    echo "Name=fcitx-keyboard-us" >> /root/.config/fcitx5/profile && \
    echo "Layout=" >> /root/.config/fcitx5/profile && \
    echo "" >> /root/.config/fcitx5/profile && \
    echo "[Groups/0/Items/1]" >> /root/.config/fcitx5/profile && \
    echo "Name=pinyin" >> /root/.config/fcitx5/profile && \
    echo "Layout=" >> /root/.config/fcitx5/profile && \
    echo "" >> /root/.config/fcitx5/profile && \
    echo "[GroupOrder]" >> /root/.config/fcitx5/profile && \
    echo "0=Default" >> /root/.config/fcitx5/profile

USER abc
