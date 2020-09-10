#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
import paramiko
import os
hostname = '10.10.0.102'
port = 22
username = 'root'
password = 'jinlian@88'
dir_path = '/var/log/'
if __name__ == "__main__":
    t =  paramiko.Transport((hostname,port))
    t.connect(username=username,password=password)
    sftp = paramiko.SSHClient.from_transport(t)
    file = sftp.listdir(dir_path)
    for i in files:
        print 'Retrieving',f
        sftp.get(os.path.join(dir_path,f),f)
        t.close()