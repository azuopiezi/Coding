#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
import os
import datetime
import tarfile
import json
from baidupan.baidupan import BaiduPan

def mysql_backup():
    db_host = 'localhost'
    db_user = 'root'
    db_password = 'password'
    mysqldump = '/usr/local/mysql/bin/mysqldump'

    #print db_bak_name

    cmd = "%s -u%s --database wordpress > %s" %(mysqldump,db_user,db_password,db_bak_name)

    if os.popen(cmd):
        tar = tarfile.open(db_bak,'w:bz2')
        tar.add(db_bak_name)
        return "Success"

#mysql_backup()
def blog_backup():
    blog_dir = '/data/wordpress'

    blog_tar = tarfile.open(blog_bak,'w:bz2')
    blog_tar.add(blog_dir)
    return "Success"

def upload_bpcs(upload_dir,upload_file.del_file):
    access_token = "access"##get it from panbaidu
    bpcs_dir = '/apps/bpcs_uploader/'
    if not disk.meta()



