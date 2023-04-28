FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates gnupg

# [UbuntuKylin](https://www.ubuntukylin.com/) is a Chinese Ubuntu derivative.
RUN echo "deb http://archive.ubuntukylin.com/ubuntukylin focal-partner main" > /etc/apt/sources.list.d/wechat.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 56583E647FFA7DE7

RUN apt-get update && apt-get install -y --no-install-recommends \
        weixin \
        dbus-x11 \
        locales \
        tzdata \
        language-pack-zh-hans \
        fonts-wqy-microhei \
        fonts-wqy-zenhei \
        xfonts-wqy \
        fonts-noto-color-emoji \
        libasound2 \
        libdrm2 \
        libxshmfence1 \
        libgbm1 \
        libegl-mesa0
RUN apt-get clean

ENV TZ="Asia/Shanghai" \
    RUN_AS_UID=1000 \
    LC_ALL=zh_CN.UTF-8 \
    LANG=zh_CN.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    GTK_IM_MODULE=fcitx \
    QT_IM_MODULE=fcitx \
    XMODIFIERS=@im=fcitx \
    DefaultIMModule=fcitx

RUN echo >> /start.sh 'LOCALTIME=/usr/share/zoneinfo/${TZ:-'"$TZ"'}' && \
    echo >> /start.sh 'if [ -f $LOCALTIME ]; then ln -fs $LOCALTIME /etc/localtime; dpkg-reconfigure -f noninteractive tzdata; fi' && \
    echo >> /start.sh 'useradd -m -u ${RUN_AS_UID:-'"$RUN_AS_UID"'} weixin' && \
    echo >> /start.sh 'su weixin -c "weixin --no-sandbox"'

CMD ["bash", "/start.sh"]
