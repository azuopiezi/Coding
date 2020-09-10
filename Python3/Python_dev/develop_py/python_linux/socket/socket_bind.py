#!/usr/bin/env python
import socket
import sys

HOST = '' #Symbolic name meaning all available interface 
PORT = 88  #Arbitrary non-privileged PORT
s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
print 'Socket created'
try:
    s.bind((HOST,PORT))
except socket.error, msg:
    print 'Bind failed .Error code:' + str(msg[0]) + 'Message' +msg[1]
    sys.exit()
    
print 'socket bind complete'
s.listen(15)
print 'Socket now listening'


#wait to accept a connection -blocking call
conn,addr = s.accept()
##display client information
print 'Connection with ' + addr[0] + ':' +str(addr(1))

data = conn.recv(1024)
conn.sendall(data)
conn.close()
s.close()

