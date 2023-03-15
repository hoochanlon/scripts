# 添加一劳永逸的静态路由
# rc.local：重启服务器生效；重启网络服务，则静态路由失效。
# static-routes：重启服务器生效；重启网络服务生效。
# route-eth0、static-routes 名称新旧的区别（redhat）

# route add -net 192.168.0.0/24 gw 192.168.2.11
# 设置成永久，失效，太新 centos 6不适用
# sudo echo "192.168.0.0/24 gw 192.168.2.11" >> /etc/sysconfig/network-scripts/route-eth0

sudo echo "any net 192.168.0.0 netmask 255.255.255.0 gw 192.168.2.11" >> /etc/sysconfig/static-routes


# 关键点汇总：
# 路由的核心的功能是转发数据加跨网段=跨网段转发数据的功能
# 路由是从源主机到目标主机的转发过程，路由器是根据路由表转发数据
# 路由器中维护的路由条目的集合，路由器根据路由表做路径选择
# 交换工作在数据链路层，根据mac地址表转发数据，硬件转发

# 参考
# [csdn-在linux下永久添加静态路由有两种方法](https://blog.csdn.net/harry_going/article/details/120891869)
# [cnblogs-route命令详情](https://www.cnblogs.com/machangwei-8/p/10352872.html)
# [csdn-路由转发的原理](https://blog.csdn.net/weixin_61522777/article/details/124403642)
# [内网文摘-Linux 系统添加永久静态路由](http://localnetwork.cn/project-3/doc-200/)