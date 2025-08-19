FROM lscr.io/linuxserver/webtop:ubuntu-mate

# 保持默认用户机制 (PUID/PGID)，不要手动 USER 切换
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

# 在容器启动后由 s6 以 abc 用户执行，不需要再 USER abc
RUN mkdir -p /defaults/root/.config/fcitx5 && \
    echo "[Groups/0]" > /defaults/root/.config/fcitx5/profile && \
    echo "Name=Default" >> /defaults/root/.config/fcitx5/profile && \
    echo "Default Layout=us" >> /defaults/root/.config/fcitx5/profile && \
    echo "DefaultIM=fcitx-keyboard-us" >> /defaults/root/.config/fcitx5/profile && \
    echo "" >> /defaults/root/.config/fcitx5/profile && \
    echo "[Groups/0/Items/0]" >> /defaults/root/.config/fcitx5/profile && \
    echo "Name=fcitx-keyboard-us" >> /defaults/root/.config/fcitx5/profile && \
    echo "Layout=" >> /defaults/root/.config/fcitx5/profile && \
    echo "" >> /defaults/root/.config/fcitx5/profile && \
    echo "[Groups/0/Items/1]" >> /defaults/root/.config/fcitx5/profile && \
    echo "Name=pinyin" >> /defaults/root/.config/fcitx5/profile && \
    echo "Layout=" >> /defaults/root/.config/fcitx5/profile && \
    echo "" >> /defaults/root/.config/fcitx5/profile && \
    echo "[GroupOrder]" >> /defaults/root/.config/fcitx5/profile && \
    echo "0=Default" >> /defaults/root/.config/fcitx5/profile
