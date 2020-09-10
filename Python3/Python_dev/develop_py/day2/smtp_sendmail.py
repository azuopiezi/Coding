#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
import smtplib
mail_server ='localhost'
mail_server_port = 25
from_addr = 'sended@example.com'
to_addr = 'receiver@example.com'

from_header = 'From:%s\r\n' % from_addr
to_header = 'To:%s\r\n' % to_addr
subject_header = 'Subject:nothing interesting'
body = 'This is a not-very-interesting email.'
email_messages = '%s\n%s\n%s\n\n%s' % (from_header, to_header, subject_header, body)
s = smtplib.SMTP(mail_server, mail_server_port)
s.sendmail(from_addr, to_addr, email_messages)
s.quit()

