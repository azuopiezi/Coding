#!/usr/bin/env python
# coding:utf-8
import sys
import urllib
import urllib.request
import time
import json
import requests

reload(sys)
sys.setdefaultencoding('utf-8')

#����Ĳ�����һ���ַ���ÿ����Ϣ��separator��������ֻҪ�����ַ�����split("separator")�����ֿ���Ϣ�Ϳ����ˡ�
#������nagiosֻ�ܴ���һ��������python�����԰����а����û�������������������Ϣ�Ž�һ���ַ�����
notify_str = str(sys.argv[1])
notifydata = notify_str.split("separator")
user = notifydata[0]
cationtype = notifydata[1]
desc = notifydata[2]
alias = notifydata[3]
address = notifydata[4]
state = notifydata[5]
datatime = notifydata[6]
output = notifydata[7]
content ='***** Nagios ***** \n\nNotification Type: ' + cationtype + '\n\nService: ' + desc + '\nHost: ' + alias + '\nAddress: ' + address + '\nState: ' + state + '\n\nDate/Time: ' + datatime + '\n\nAdditional Info:\n\n' + output + '\n'

class Token(object):
    # ��ȡtoken
    def __init__(self, corpid, corpsecret):
        self.baseurl = 'https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid={0}&corpsecret={1}'.format(
            corpid, corpsecret)
        self.expire_time = sys.maxint

    def get_token(self):
        if self.expire_time > time.time():
            request = urllib2.Request(self.baseurl)
            response = urllib2.urlopen(request)
            ret = response.read().strip()
            ret = json.loads(ret)
            if 'errcode' in ret.keys():
                print >> ret['errmsg'], sys.stderr
                sys.exit(1)
            self.expire_time = time.time() + ret['expires_in']
            self.access_token = ret['access_token']
        return self.access_token


def send_msg(content):
    # ������Ϣ
    corpid = "" # ��д�Լ�Ӧ�õ�
    corpsecret = ""  # ��д�Լ�Ӧ�õ�
    qs_token = Token(corpid=corpid, corpsecret=corpsecret).get_token()
    url = "https://qyapi.weixin.qq.com/cgi-bin/message/send?access_token={0}".format(
        qs_token)
    payload = {
        "touser": "user",  #���͵�user
        "msgtype": "text",
        "agentid": "1",
        "text": {
                "content": content
        },
        "safe": "0"
    }
    data=json.dumps(payload, ensure_ascii=False, indent=4)
    ret = requests.post(url, data)
    print (ret.json())

if __name__ == '__main__':
    # print title, content
    send_msg(content)
