#!/bin/bash

# 设置目标部署目录
DEPLOY_DIR="/Users/swt/Dev/Softwares/docker/nginx/html/groot-tools"

# 确保目标目录存在
if [ ! -d "$DEPLOY_DIR" ]; then
    echo "目标部署目录不存在，正在创建..."
    mkdir -p "$DEPLOY_DIR"
fi

# 打印当前目录
echo "当前目录：$(pwd)"

# 安装依赖
echo "安装依赖..."
yarn

# 打包 Vue 项目
echo "开始打包 Vue 项目..."
yarn build

# 检查打包是否成功
if [ $? -eq 0 ]; then
    echo "打包成功！"
else
    echo "打包失败！"
    exit 1
fi

# 删除目标目录下的所有内容
echo "删除目标目录下的所有内容..."
rm -rf "$DEPLOY_DIR/*"

# 拷贝构建的文件到指定目录
echo "将构建文件复制到目标目录..."
cp -r dist/* "$DEPLOY_DIR"

# 完成部署
echo "部署完成，已将文件复制到 $DEPLOY_DIR"