#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
import paramiko
hostname ='10.10.0.102'
port ='22'
username ='root'
password ='jinlian@88'
if __name__ == "__main__":
    paramiko.util.log_to_file('paramiko.log')
    S = paramiko.SSHClient()
    S.load_system_host_keys()
    S.connect(hostname,port,username,password)
    stdin,stdout,stderr = S.exec_command('ifconfig')
    print stdout.read()
    S.close()

