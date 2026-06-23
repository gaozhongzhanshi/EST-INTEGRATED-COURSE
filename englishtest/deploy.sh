#!/bin/bash
set -e

APP_DIR="/var/www/englishtest"
NGINX_CONF="/etc/nginx/sites-available/englishtest"
PORT=${1:-8080}

echo "=== 科技英语翻译练习 部署脚本 ==="

# 1. 创建目录
echo "[1/4] 创建部署目录..."
sudo mkdir -p "$APP_DIR"
sudo cp index.html "$APP_DIR/"
sudo chown -R www-data:www-data "$APP_DIR"

# 2. 检查 nginx
echo "[2/4] 配置 Nginx..."
if ! command -v nginx &> /dev/null; then
    echo "  Nginx 未安装，正在安装..."
    sudo apt update && sudo apt install -y nginx
fi

# 3. 写入 nginx 配置
sudo tee "$NGINX_CONF" > /dev/null <<EOF
server {
    listen $PORT;
    server_name _;
    root $APP_DIR;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }

    gzip on;
    gzip_types text/html text/css application/javascript;
}
EOF

# 4. 启用站点
echo "[3/4] 启用站点..."
sudo ln -sf "$NGINX_CONF" /etc/nginx/sites-enabled/englishtest
sudo rm -f /etc/nginx/sites-enabled/default 2>/dev/null || true

echo "[4/4] 测试并重启 Nginx..."
sudo nginx -t
sudo systemctl restart nginx

echo ""
echo "=== 部署完成 ==="
echo "访问地址: http://$(hostname -I | awk '{print $1}'):$PORT"
echo ""
