#!/usr/bin/env python
import socket



class Myserver(socket.:
    
    def handle(self):
        
        conn = self.request
        conn.sendall(bytes("nihao,woshijiqiren",encoding="utf-8"))
        while True:
            ret_bytes = conn.recv(1024)
            ret_str = str(ret_bytes,encoding="utf-8")
            if ret_str == "q":
                break
            conn.sendall(bytes(ret_str+"nihaowohaodajiaohao",encoding="utf-8"))

if __name__ == "__main__":
    server = socket.ThreadingTCPServer(("127.0.0.1",8080),Myserver)
    server.serve_forever()
