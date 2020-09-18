#!/bin/bash
set -x
CommitName=
git commit -a -m "$CommitName"
git add -a -m "LinuxBaseConfig"
git add -a
git add -A
git add -a -m "LinuxBaseConfig"
git commit -a -m "LinuxBaseConfig"
git push 
git push .
git help config
git push --help 
git push all
git push origin HEAD:master
git config --global push.default simple
git push origin HEAD:master

