# WSL 网络配置

## 修改WSL网络连接为桥接模式

```shell
#powershell执行下面命令
#获取网络适配器
Get-NetAdapter
```

```shell
#桥接网络
Set-VMSwitch WSL -NetAdapterName 以太网
#取消桥接网络（如果想恢复）
Set-VMSwitch WSL -SwitchType Internal
```

## 修改WSL ip配置

首先转换为root用户

```
su root
```

然后再修改网络配置

假设主机ip地址为192.168.10.110

网关ip地址为192.168.10.1

子网掩码为255.255.255.0

那么广播地址为192.168.10.255

```shell
#删除ip配置
ip addr del $(ip addr show eth0 | grep 'inet\b' | awk '{print $2}' | head -n 1) dev eth0

#添加ip配置
ip addr add 192.168.10.110/24 broadcast 192.168.10.255 dev eth0

#设置转发规则，将流量转发到网关
ip route add 0.0.0.0/0 via 192.168.10.1 dev eth0
```

每次重启电脑，WSL网络配置都会重置，因此需要重新执行WSL网络配置