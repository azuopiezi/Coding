'''
Created on Jun 28, 2016

@author: shixingwen
'''
#!/usr/bin/python
# _*_ coding: UTF-8 _*_
from IPy import IP
s = IP('10.0.0.0/8').version()
print s 
ip = IP('192.168.1.0/28')
print ip.len()
#for x in ip:
#    print x
ip = IP('192.168.1.20')
s= ip.reverseNames()
ip.iptype()
IP('8.8.8.8').int()
IP('8.8.8.8').strBin()
IP('8.8.8.8').strHex()
print(IP('192.168.1.0').make_net('255.255.255.0'))

print s 

print `IP('10.0.0.0/24') < IP('12.0.0.0/24')`
print `IP('192.168.0.0/23').overlaps('192.168.1.0/24')`

ip_s = raw_input('please input an ip or net-range:')
ips = IP(ip_s)
if len(ips) >1:
    print('net:%s' % ips.net())
    print('netmask:%s' % ips.netmask())
    print('broadcast:%s' % ips.broadcast())
    print('reverse address:%s' % ips.reverseNames()[0])
    print('subnet:%s' % len(ips))
else:
    print('reverse address:%s' % ips.reverseNames()[0])
print('hexadecimal:%s' % ips.strHex())
print('binary ip:%s' % ips.strBin())
print('iptype:%s' % ips.iptype())


