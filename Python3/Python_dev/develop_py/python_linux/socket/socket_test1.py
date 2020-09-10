#!/usr/bin/env python
import socket
s = socket.socket()
s.connect(('10.10.21.154',8081))
s.send("GET /HTTP/1.0\n\n")
w = s.recv(1024)
print w
s.close()
