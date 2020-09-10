#!/usr/bin/python
# -*- coding: UTF-8 -*-
#!/usr/bin/env python
##文件输入流
def FileInputStream(filename):
    try:
        f = open(filename)
        for line in f:
            for byte in line:
                yield byte
    except StopIteration,e:
        f.close()
        return

#文件输出流
def FileOutputStream(inputStream,filename):
    try:
        f = open(filename, "w")
        while True:
            byte = inputStream.next()
            f.write(byte)
    except StopIteration,e:
        f.close()
        return
if __name__ == "__main__":
    FileOutputStream(FileInputStream("hello1.txt"),"hello2.txt")