create table userTBL(
userid char(8) not null primary key, -- ����� ���̵�
username nvarchar2(10) not null, -- ����� �̸�
birthyear number(4) not null, -- ����⵵
addr nchar(2) not null, -- ����(���,����,�泲 ��� 2���ڸ� �Է�)
mobile1 char(3), -- �޴��� ����(010,011,016,017,018,019)
mobile2 char(8), -- �޴����� ������ ��ȣ(������ ����)
height number(3), -- Ű
mdate date -- ȸ�� ������
);

create table buyTBL(
idnum number(8) not null primary key, -- ����(PK)
userid char(8) not null, -- ���̵�(FK) /buytbl�� userid�� �ٸ����̺��� ������
prodname nchar(6) not null, -- ��ǰ��
groupName nchar(4), -- �з�
price number(8) not null, -- �ܰ�
amount number(3) not null, -- ����
foreign key (userid) references usertbl(userid)
);

commit;

insert into usertbl values('lsg','�̽±�',1987,'����','011','11111111',182,'2008-8-8');
insert into usertbl values('kbs','�����',1979,'�泲','011','22222222',173,'2012-4-4');
insert into usertbl values('kkh','���ȣ',1971,'����','019','33333333',177,'2007-7-7');
insert into usertbl values('jyp','������',1950,'���','011','44444444',166,'2009-4-4');
insert into usertbl values('ssk','���ð�',1979,'����',null,null,186,'2013-12-12');
insert into usertbl values('ljb','�����',1963,'����','016','66666666',182,'2009-9-9');
insert into usertbl values('yjs','������',1969,'�泲',null,null,170,'2005-5-5');
insert into usertbl values('ejw','������',1972,'���','011','88888888',174,'2014-3-3');
insert into usertbl values('jkw','������',1965,'���','018','99999999',172,'2010-10-10');
insert into usertbl values('bbk','�ٺ�Ŵ',1973,'����','010','00000000',176,'2013-5-5');

create sequence idseq;
insert into buytbl values(idseq.nextval,'kbs','�ȭ',null,30,2);
insert into buytbl values(idseq.nextval,'kbs','��Ʈ��','����',1000,1);
insert into buytbl values(idseq.nextval,'jyp','�����','����',200,1);
insert into buytbl values(idseq.nextval,'bbk','�����','����',200,5);
insert into buytbl values(idseq.nextval,'kbs','û����','�Ƿ�',50,3);
insert into buytbl values(idseq.nextval,'bbk','�޸�','����',80,10);
insert into buytbl values(idseq.nextval,'ssk','å','����',15,5);
insert into buytbl values(idseq.nextval,'ejw','å','����',15,2);
insert into buytbl values(idseq.nextval,'ejw','û����','�Ƿ�',50,1);
insert into buytbl values(idseq.nextval,'bbk','�ȭ',null,30,2);
insert into buytbl values(idseq.nextval,'ejw','å','����',15,1);
insert into buytbl values(idseq.nextval,'bbk','�ȭ',null,30,2);

commit;

select * from usertbl;
select * from buytbl;

-- ���ȣ
select * from usertbl where username='���ȣ';

-- 1970�� ���Ŀ� ����ϰ� ������ 182 �̻��� ����� ���̵�� �̸� ��ȸ
select userid,username from usertbl where birthyear>=1970 and height>=182;

-- 1970�� ���Ŀ� ����߰ų� ������ 182 �̻��� ����� ���̵�� �̸� ��ȸ
select userid,username from usertbl where birthyear>=1970 or height>=182;

-- Ű�� 180~183�� ��� ��ȸ(�̸�, Ű ��ȸ)
select username,height from usertbl where height >= 180 and height <= 183;
select username,height from usertbl where height between 180 and 183;

-- ������ '�泲','����','���',�� ����� ���� ��ȸ
select userName,addr from usertbl where addr='�泲' or addr='����' or addr='���';
select userName,addr from usertbl where addr in('�泲','����','���');

-- ���ڿ� ���� ��ȸ
select userName,height from usertbl where userName like '��%';
select userName,height from usertbl where userName like '_����';

-- '������','����� ���','�̿��� �༭ �����մϴ�'
select userName,height from usertbl where userName like '_��%';

-- ��������
select username,height from usertbl where height > 177;

select username,height
from usertbl
where height > (select height from usertbl where userName='���ȣ');

-- ������ '�泲'����� Ű���� Ű�� ũ�ų� ���� ��� ��ȸ, ��������
--ANY : ���������� ���� ��� �� �Ѱ����� ����
--ALL : ���������� ���� ����� ��� ����

--select userName,height
--from usertbl
--where height >= (select height from usertbl where addr='�泲'); -- error

--select userName,height
--from usertbl
--where height >= any(select height from usertbl where addr='�泲'); -- or
-- any Ű���� ���

select userName,height
from usertbl
where height >= all(select height from usertbl where addr='�泲'); -- Ű�� 170���� ũ�ų� ���ƾ� �� �Ӹ� �ƴ϶� 173���� ũ�ų� ���ƾ� �ϱ⶧���� ���ڰ� ������ �ȴ�
-- all Ű���� ���

select userName,height
from usertbl
where height= any(select height from usertbl where addr='�泲');

select userName,height
from usertbl
where height in (select height from usertbl where addr='�泲'); -- error
-- ���� ����

--order by
select username,mdate from usertbl order by mdate; -- order by �� asc,desc �������������� default���� ��������(������ -> ū��) �̴�.
select username,mdate from usertbl order by mdate desc; -- ��������

--Ű�� ū ������ �����ϵ� ���� Ű�� ������쿡 �̸� ������ ����
select userName,height from usertbl order by height desc,username asc;

--�ߺ��� ���� �ϳ��� ����� distinct
select addr from usertbl;
select addr from usertbl order by addr;
select distinct addr from usertbl;

--���̺� ���� create table...as select....primary key�� ���� ���� �ʴ´�.
create table buytbl2 as (select * from buytbl);
select * from buytbl2;

create table buytbl3 as (select userid,prodname from buytbl);
select * from buytbl3;

--group by,���� �Լ� avg(),min(),max(),count()
select userid,amount from buytbl order by userid;

select userid,sum(amount)
from buytbl 
group by userid;

select userid as "����� ���̵�",sum(amount) as "�� ���� ����"
from buytbl
group by userid;

select userid as "����� ���̵�",sum(price*amount) as "�� ���ž�"
from buytbl
group by userid;

select avg(amount) as "��� ���� ����" from buytbl;

select cast(avg(amount) as number(5,3))as "��� ���� ����" from buytbl;

select userid,cast(avg(amount) as number(5,3))as "��� ���� ����" 
from buytbl
group by userid;

--���� ū Ű�� ���� ���� Ű�� ȸ���̸��� Ű�� ��ȸ
--select username,max(height),min(height) from usertbl
--group by username;

select username,height 
from usertbl
where height =(select max(height)from usertbl);
height =(select min(height)from usertbl);

--�޴����� �ִ� ����� ��
select count(*) from usertbl;

select count(mobile1) from usertbl;

-- select userid as "����� ���̵�",sum(price*amount) as "�� ���ž�"
from buytbl
group by userid;
having sum(price*amount)>1000; -- having���� �ݵ�� group by ������ �;� �Ѵ�

--insert
create table testtbl1(
id number(4),
username nchar(3),
age number(2)
);
insert into testtbl1(1,'ȫ�浿',25);
select * from testtbl1;
insert into testtbl1(id,username) values(2,'����');
insert into testtbl1(username,age,id) values('����',26,3);

create table testtbl2(
id number(4),
username nchar(3), --nation
age number(2)
nation nchar(4) default '���ѹα�'
);

create sequence idseq
start with 1
increment by 1;
    
select * from testtbl2;
    
drop sequence idseq;
    
insert into testtbl2 values(idseq.nextval,'����',25,default);
insert into testtbl2 values(idseq.nextval,'����',24,'����');
    
select*from testtbl2;
  
insert into testtbl2 values(11,'����',18,'�븸'); -- ����
insert into testtbl2 values(idseq.nextval,'�̳�',21,'�Ϻ�');
alter sequence idseq
    increment by 10;
    insert into testtbl2 values(idseq.nextval,'�̳�2',21,'�Ϻ�');
    alter sequence idseq
        increment by 1;
    insert into testtbl2 values(idseq.nextval,'�̳�3',21,'�Ϻ�');
    
select idseq.currval from dual; -- dual ���� ���̺�
    
--�뷮 ����
create table testtbl4(
empid number(6),
firstname varchar2(20),
lastname varchar2(25),
phone varchar2(20)
);
insert into testtbl4
select employee_id,first_name,last_name,phone_number
from hr.employees;

select * from testtbl4;
-------------------------------------------------------------
create table testtbl5 as
(select employee_id,first_name,last_name,phone_number
from hr.employees);

select*from testtbl5;
select*from hr.employees;
select*from testtbl4 order by firstname;

update testtbl4
set phone='����'


    




