#!/usr/bin/env bash
create table user(

userid int(4) primary key not null auto_increment,
username varchar(16) not null,
userpassword varchar(32) not null,
) engine = InnoDB,DEFAULT CAHASET = utf8;
