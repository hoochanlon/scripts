# hostname_user_ip.py
import sys
import getpass
import os
import socket
import psutil
from datetime import datetime

def get_current_date():
    """
    返回当前日期，格式为 年-月-日
    :return: str 当前日期
    """
    return datetime.now().strftime("%Y年%m月%d日")


def get_hostname_username():
    # 获取计算机名
    hostname = socket.gethostname()
    # 获取登录用户名
    username = getpass.getuser()
    return hostname, username

def get_wifi_ip():
    # 获取所有网络接口
    interfaces = psutil.net_if_addrs()

    # 遍历所有接口
    for interface, addrs in interfaces.items():
        if "WLAN" in interface:  # 查找Wi-Fi接口
            for addr in addrs:
                if addr.family == socket.AF_INET:  # 只获取IPv4地址
                    return addr.address
    
    return "127.0.0.1"  # 如果没有找到Wi-Fi接口，返回回环地址

def get_ethernet_ip():
    # 获取所有网络接口
    interfaces = psutil.net_if_addrs()

    # 遍历所有接口
    for interface, addrs in interfaces.items():
        if "以太网" in interface:  # 查找以太网接口
            for addr in addrs:
                if addr.family == socket.AF_INET:  # 只获取IPv4地址
                    return addr.address
    
    return "127.0.0.1"  # 如果没有找到以太网接口，返回回环地址

def get_preferred_ip():
    """优先返回Wi-Fi地址，如果没有Wi-Fi连接则返回以太网地址"""
    wifi_ip = get_wifi_ip()
    if wifi_ip:
        return wifi_ip  # 如果找到 Wi-Fi 地址，优先返回
    else:
        return get_ethernet_ip()  # 如果没有 Wi-Fi，返回以太网地址

