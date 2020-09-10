#!/usr/bin/env python
#handing errors in python socket programs
import socket  #for socket


import sys   #for exit

try:
    # create an AF_INET,STREAM socket TCP
    s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
except socket.error,mgs:
    print 'Failed to create socket.Error code:' + str(mgs[0]) + ',Error message:' + mgs[1]
    sys.exit();
    
print 'Socket Created'



host = "www.sina.cn"
port = 80
try:
    remote_ip = socket.gethostbyname(host)
except socket.gaierror:
    
    #could not resolve
    
    print 'Hostname could not be resolved.Exiting'
    sys.exit()

print 'Ip address of ' + host + ' is ' + remote_ip


##Connect to remote server
s.connect((remote_ip,port))

print 'Socket Connect to ' + host + 'on ip ' + remote_ip


###Send some data to remote server
message = "GET /HTTP/1.1\r\n\r\n"

try:
####Set the whole string
    s.sendall(message)
except socket.error:
    #Send failed
    print 'Send failed'
    sys.exit()

print 'Message send succussfully'



##Now receive data
reply = s.recv(4096)
print reply

s.close()
