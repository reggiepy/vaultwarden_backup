#!/usr/bin/env bash

# 获取当前脚本所在的目录
SCRIPT_DIR=$(dirname "$0")
# 输出获取的路径
echo "当前脚本所在路径是: $SCRIPT_DIR"

cd $SCRIPT_DIR
git add .
git commit -m "update"
git push origin master
