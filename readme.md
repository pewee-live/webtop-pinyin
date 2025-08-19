# 🖥️ Webtop + WeChat (支持中文输入)

本项目基于 [LinuxServer.io Webtop](https://github.com/linuxserver/webtop) 镜像构建，集成了：

- ✅ Webtop (通过浏览器访问完整 Linux 桌面环境)
- ✅ 中文输入法 (Fcitx5 + 拼音)
- ✅ 字体支持（文泉驿 + Noto CJK）
- ✅ 官方 Linux 微信客户端 (支持 amd64 / arm64)
- ✅ GitHub Actions 自动构建 & 推送镜像


适合在NAS中挂微信,换手机也可以不丢失消息,配合绿联等nas自带的docker穿透可以实现在哪里,无论有没有手机都可以网页聊微信.

---

## 🚀 功能

- 支持多架构 (`amd64` 和 `arm64`)
- 通过网页即可使用 Linux 桌面环境，无需 VNC
- 自带中文输入法，可以直接输入中文
- 内置官方微信客户端 (WeChat for Linux)
- 镜像自动构建并推送到 Docker Hub / GitHub Container Registry

---

## 📦 使用方法

### 1. 拉取镜像 & 启动镜像

```bash
docker pull peweelive/webtop-chinese:latest

docker run -d \
  --name=webtop \
  --security-opt seccomp=unconfined `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e SUBFOLDER=/ `#optional` \
  -e TITLE=Webtop `#optional` \
  -p 3000:3000 \
  -p 3001:3001 \
  -v /app/webtop/config:/config \
  -v /var/run/docker.sock:/var/run/docker.sock `#optional` \
  --shm-size="1gb" `#optional` \
  --restart unless-stopped \
  peweelive/webtop-chinese:latest

```

启动后，在浏览器访问：http://localhost:3000


##🔧 开发者说明

本项目已经通过actions在每次提交推送最新docker镜像到我的仓库;如需自己build(不太推荐,自己构建时间花的很长!!)执行以下流程:

```bash

git clone https://github.com/pewee-live/webtop-pinyin.git

cd webtop-pinyin 

docker build -t  {仓库名}/镜像名:{tag}


```

## 📜 License

本项目基于 LinuxServer.io Webtop，遵循其开源协议。
微信客户端由腾讯官方提供，本项目仅做打包集成。

