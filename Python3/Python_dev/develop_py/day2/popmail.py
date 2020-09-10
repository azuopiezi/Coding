#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
import poplib
username = 'shixingwe.n@163.com'
passwd = 'sX209@^Yj'
mail_server = 'mail.163.com'
p = poplib.POP3(mail_server)
p.user(username)
p.pass_(passwd)
for msg_id in p.list()[1]:
    print msg_id
    outf =open('%s.eml' % msg_id,'w')
    outf.write('\n'.join(p.retr(msg_id)[1]))
    outf.close()
p.quit()
