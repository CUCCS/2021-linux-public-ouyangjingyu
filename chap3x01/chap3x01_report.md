# 学习systemctl入门教程并全程录像

## 实验目的

掌握systemctl操作，熟练使用asciinema录像

## 实验环境

Ubuntu 20.04 Server 64bit

asciinema

## 实验要求

- 上传本人亲自操作实验全程录像
- 完成第三章自查清单

## 实验步骤

### 一、学习Systemd入门教程：命令篇

#### &emsp;第一章 由来

&emsp;&emsp;[lesson1](https://asciinema.org/a/ehfqOWjv21SvL43xzDIebNPEC)

#### &emsp;第二章 systemctl概述

&emsp;&emsp;[lesson2](https://asciinema.org/a/gGkm4UFYRrCwj1XXmtGtPnSHj)

#### &emsp;第三章 系统管理

- 3.1 systemctl
- 3.2 systemd-analyze
- 3.3 hostnamectl
- 3.4 localectl
- 3.5 timedatectl
- 3.6 loginctl

&emsp;&emsp;[lesson3.3-3.4](https://asciinema.org/a/goYXOIsuq9CN8SxJphChUmRtT)

&emsp;&emsp;[lesson3.5](https://asciinema.org/a/Wt7fdrIdg7YwpSrmDgJAZL1uo)

&emsp;&emsp;[lesson3.6](https://asciinema.org/a/o2fObxg0VBaFTsthOvewxzlCa)

#### &emsp;第四章 Unit

- 4.1 含义
- 4.2 Unit 的状态
- 4.3 Unit 管理
- 4.4 依赖关系
  
&emsp;&emsp;[lesson4.1-4.2](https://asciinema.org/a/wTIHlQ6XqOOhs5PHbLbRoEg7H)

&emsp;&emsp;[lesson4.3-4.4](https://asciinema.org/a/azKKMvCkjAVkU1A8Mox5ymXCR)

#### &emsp;第五章 Unit 的配置文件

- 5.1 概述
- 5.2 配置文件的状态
- 5.3 配置文件的格式
- 5.4 配置文件的区块

&emsp;&emsp;[lesson5.1-5.2](https://asciinema.org/a/lm6GCDgOKAh3x6oa5tv9m62S7)

&emsp;&emsp;[lesson5.3-6](https://asciinema.org/a/Yd3G5HdXrKXJ5joJJNlTHNYtJ)

#### &emsp;第六章 Target

&emsp;&emsp;[lesson5.3-6](https://asciinema.org/a/Yd3G5HdXrKXJ5joJJNlTHNYtJ)


#### &emsp;第七章 日志管理

&emsp;&emsp;[lesson7(1)](https://asciinema.org/a/GWw4JnUvsLsDvO3blKOd6dvCG)

&emsp;&emsp;[lesson7(2)](https://asciinema.org/a/NrnrjoAom8UAKGhulRbazHZce)


### 一、学习Systemd入门教程：实战篇

#### &emsp;基本任务

- 开机启动
- 启动服务
- 停止服务
- 读懂配置文件
- [Unit] 区块：启动顺序与依赖关系。
- [Service] 区块：启动行为
- Target 的配置文件
- 修改配置文件后重启


&emsp;&emsp;[lesson1-9](https://asciinema.org/a/XiVDF3jQKXcyoGASN0a6KXEzL)

## 问题自查

- 如何添加一个用户并使其具备sudo执行程序的权限
`adduser <username> <username> ALL=(ALL) ALL`
- 如何将一个用户添加到一个用户组
`usermod -a -G <groupname> <username>`
- 如何查看当前系统的分区表和文件系统详细信息？
`sudo fdisk -l`
- 如何实现开机自动挂载Virtualbox的共享目录分区？ 
`mount -t vboxsf sharing /mnt/share`(切换到root用户执行)
- 基于LVM（逻辑分卷管理）的分区如何实现动态扩容和缩减容量？ 
`lvextend -L +<容量> <目录>` (扩容)
`lvreduce -L -<容量> <目录>` (减容)
- 如何通过systemd设置实现在网络连通时运行一个指定脚本，在网络断开时运行另一个脚本？ 
```
ExecStartPost=<路径1> post1
ExecStopPost=<路径2> post2
sudo systemctl daemon-reload
sudo systemctl restart httpd.service
```
- 如何通过systemd设置实现一个脚本在任何情况下被杀死之后会立即重新启动？实现杀不死？
`Restart=always` 
`sudo systemctl daemon-reload`

## 实验中的问题与解决方法

##### &emsp;问题1

&emsp;执行命令`sudo apt-get update` 时，出现错误“E: The repository ‘http://ppa.launchpad.net/XXX Release’ does not have a Release file.”

##### &emsp;解决方法

```
cd /etc/apt/sources.list.d  #切换目录
ls   #查看当前目录下的文件
sudo rm XXX.list  #删除对应的ppa源
```

##### &emsp;问题2

&emsp;3.1-3.2中的操作涉及系统的启动、关机和休眠等状态，无法录制asciinema录像，暂时没有解决办法。

##### &emsp;问题3

&emsp;误删了原本的lesson5.3-lesson6的录制视频，原视频没有保存在本地，重新录制时默认的Target已经修改为multi-user.target。