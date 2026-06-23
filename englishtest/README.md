# 科技英语综合教程 - 翻译练习系统

翻译练习 & 刷题网页，支持按单元复习和随机刷题。

## 功能

- **复习模式**：按单元查看所有词条的英文和中文对照
- **刷题模式**：英译中 / 中译英 / 混合，支持按单元选择和随机打乱

## Linux 部署

### 方式一：Nginx（推荐）

```bash
# 上传文件到服务器
scp -r index.html deploy.sh user@server:~/englishtest/

# 登录服务器执行
cd ~/englishtest
chmod +x deploy.sh
sudo ./deploy.sh 8080   # 端口号可自定义，默认 8080
```

### 方式二：Python 快速启动（无需安装）

```bash
cd /path/to/englishtest
python3 -m http.server 8080
# 访问 http://your-server-ip:8080
```

### 方式三：Docker

```bash
# 构建镜像
docker build -t englishtest .

# 运行容器
docker run -d -p 8080:80 --name englishtest englishtest
```

## 使用

打开浏览器访问服务器 IP + 端口即可，纯前端，无需后端。
