#!/usr/bin/env bash
# 检测区
# -------------------------------------------------------------
# 检查系统
export LANG=en_US.UTF-8
initVar() {
  echoType='echo -e'
  BaseDir=`pwd`
  BackupFile='.backup.cron'
  shName="cron.sh"
}

echoContent() {
	case $1 in
	# 红色
	"red")
		# shellcheck disable=SC2154
		${echoType} "\033[31m${printN}$2 \033[0m"
		;;
		# 天蓝色
	"skyBlue")
		${echoType} "\033[1;36m${printN}$2 \033[0m"
		;;
		# 绿色
	"green")
		${echoType} "\033[32m${printN}$2 \033[0m"
		;;
		# 白色
	"white")
		${echoType} "\033[37m${printN}$2 \033[0m"
		;;
	"magenta")
		${echoType} "\033[31m${printN}$2 \033[0m"
		;;
		# 黄色
	"yellow")
		${echoType} "\033[33m${printN}$2 \033[0m"
		;;
	esac
}

initVar "$1"

crontab_job="*/5 * * * * /bin/bash ${BaseDir}/${shName} ${BaseDir}"

install() {
  backupCrontab
   ( crontab -l | grep -v "${BaseDir}/${shName}"; echo "${crontab_job}" ) | crontab -   # 添加cron_job定时任务
}

uninstall() {
   ( crontab -l | grep -v "${shName}" ) | crontab -    # 删除cron_job定时任务
}

showCrontab() {
   crontab -l    # 删除cron_job定时任务
}

backupCrontab() {
  crontab -l > "$BackupFile"
  now=`date`
  crontab -l > "$BackupFile.${now}"
}

loadCrontab() {
  crontab $BackupFile
}

# 主菜单
menu() {
	cd "$HOME" || exit
	echoContent red "\n=============================================================="
	echoContent green "作者:reggiepy"
	echoContent green "当前版本:v1.0.0"
	echoContent green "Github:https://github.com/mack-a/v2ray-agent"
	echoContent skyBlue "-------------------------工具管理-----------------------------"
	echoContent yellow "1.安装"
	echoContent yellow "2.卸载"
	echoContent yellow "3.展示定时任务"
	echoContent red "=============================================================="
	read -r -p "请选择:" selectInstallType
	case ${selectInstallType} in
	1)
		install
		showCrontab
		;;
	2)
		uninstall
		showCrontab
		;;
	2)
		showCrontab
		;;
	esac
}
menu
