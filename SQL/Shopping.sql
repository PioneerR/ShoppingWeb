#���ݿ�����ȫ��Сд
create database shopping;

use shopping;

create table user 
(
id int primary key auto_increment,
username varchar(40),
password varchar(16),
phone varchar(40),
addr varchar(255),
rdate datetime,
email varchar(20),
qq varchar(20)
);

create table category
(
id int primary key auto_increment,
pid int, #pidΪ0�������ڵ�
name varchar(255), 
descr varchar(255),
cno int, #�������, ÿ��ռ��λ, ���99���ӽڵ�
grade int #������, ��1��ʼ
);

create table cart
(
id int primary key auto_increment,
productid int,
userid int,
count int,
cdate datetime
);

create table product
(
id int primary key auto_increment,
name varchar(255),
descr varchar(255),
normalprice int,
memberprice int,
pdate datetime,
categoryid int references catetory(id)
);

create table salesorder
(
id int primary key auto_increment,
userid int,
addr varchar(255),
odate datetime,
status int
);

create table salesitem 
(
id int primary key auto_increment,
productid int, 
unitprice double, 
pcount int,
orderid int
);

#select pid, sum(pcount) sumCount from salesitem group by pid order by sumCount desc limit 0, 10 


