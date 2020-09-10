#!/usr/bin/env python
import paramiko
hostname = '10.10.21.154'
port = 22
username = 'root'
password = 'sursen@2017'
if __name__=='__main__':
    paramiko.util.log_to_file('paramiko.log')
    s = paramiko.SSHClient()
    s.load_system_host_keys()
    s.connect(hostname,port,username,password)
    stdin,stdout,stderr = s.exec_command('ifconfig')
    stdin,stdout,stderr = s.exec_command('ip a')
    print stdout.read()
    s.close()