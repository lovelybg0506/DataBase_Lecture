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

--������ '�泲','����','���'�� ����� ���� ��ȸ
select username,addr from usertbl where addr='�泲' or addr='����' or addr='���';
select username,addr from usertbl where addr in('�泲','����','���');

--���ڿ� ���� ��ȸ
select username,height from usertbl where username like '��%';
select username,height from usertbl where username like '_����';

--'������','����� ���','�̿��� �༭ �����մϴ�' (���̶�� ���ڰ� ��� ��)
select username,height from usertbl where username like '_��%';

--��������
select username,height from usertbl where height > 177;

select username,height 
from usertbl
where height > (select height from usertbl where username='���ȣ');

--������ '�泲'�� ����� Ű���� Ű�� ũ�ų� ���� ��� ��ȸ,��������
--ANY : ���������� ���� ���� ��� �� �� �� �̸� ����
--ALL : ���������� ���� ���� ����� ��� ����
--//(any: ������ ��� ���� �� �� �̻��� ���,�� �� ���� ��� �������� ���ְڴ�, or������ ����)
--select username,height 
--from usertbl
--where height >= (select height from usertbl where addr='�泲'); -- error

select username,height 
from usertbl
where height >= any(select height from usertbl where addr='�泲'); -- or

select username,height 
from usertbl
where height >= all(select height from usertbl where addr='�泲'); -- Ű�� 170���� ũ�ų� ���ƾ� �� �Ӹ� �ƴ϶�, 173���� ũ�ų� ���ƾ� ��

select username,height 
from usertbl
where height = any(select height from usertbl where addr='�泲');

select username,height 
from usertbl
where height in(select height from usertbl where addr='�泲');

--order by
select username,mdate from usertbl order by mdate; --ascending,��������
select username,mdate from usertbl order by mdate desc; --descending,��������

--Ű�� ū ������ �����ϵ� ���� Ű�� ���� ��쿡 �̸� ������ ����
select username,height from usertbl order by height desc,username asc;

--�ߺ��� ���� �ϳ��� ����� distinct
select addr from usertbl; 
select addr from usertbl order by addr;
select distinct addr from usertbl;

--���̺� ���� create table...as select... primary key�� ������� �ʴ´�.
create table buytbl2 as (select * from buytbl);
select * from buytbl2;

create table buytbl3 as (select userid,prodname from buytbl);
select * from buytbl3;

--group by, ���� �Լ� avg(),min(),max(),count(),sum()
select userid,amount from buytbl order by userid;

select userid,sum(amount) 
from buytbl
group by userid;

select userid as "����� ���̵�",sum(amount) as "�� ���� ����"
from buytbl
group by userid;

select userid as "����� ���̵�",sum(price) as "�� ���ž�"
from buytbl
group by userid;

select avg(amount) as "��� ���� ����" from buytbl;

select cast(avg(amount) as number(5,3))as "��� ���� ����" from buytbl;

select userid,cast(avg(amount) as number(5,3))as "��� ���� ����" 
from buytbl
group by userid;

--usertbl���� ���� ū Ű�� ���� ���� Ű�� ȸ���̸��� Ű�� ��ȸ
--select username,max(height),min(height) from usertbl
--group by username;

select username,height 
from usertbl 
where height =(select max(height)from usertbl) or
      height =(select min(height)from usertbl);

--�޴����� �ִ� ����� ��
select count(*) from usertbl;

select count(mobile1) as "�޴����� �ִ� �����" from usertbl;

--�� ���ž��� 1000 �̻��� ����� ��ȸ
--select userid as "����� ���̵�",sum(price*amount) as "�� ���ž�"
--from buytbl 
--where sum(price*amount) >= 1000 -- �׷� �Լ��� where������ ��� �� �� ����
--group by userid;

select userid as "����� ���̵�",sum(price*amount) as "�� ���ž�"
from buytbl 
group by userid
having sum(price*amount)>=1000; --having ���� �ݵ�� group by ������ �;� �Ѵ�

--insert
create table testtbl1(
id number(4),
username nchar(3),
age number(2)
);

insert into testtbl1 values(1,'ȫ�浿',25);
select * from testtbl1;
--insert into testtbl1 values(2,'����'); --error
insert into testtbl1(id,username) values(2,'����');
insert into testtbl1(username,age,id) values('����',26,3);

create table testtbl2(
id number(4),
username nchar(3), --nation
age number(2),
nation nchar(4) default '���ѹα�'
);

create sequence idseq
    start with 1
    increment by 1;

drop sequence idseq;

insert into testtbl2 values(idseq.nextval,'����',25,default);
insert into testtbl2 values(idseq.nextval,'����',24,'����');

select * from testtbl2;

insert into testtbl2 values(11,'����',18,'�븸'); --����
insert into testtbl2 values(idseq.nextval,'�̳�',21,'�Ϻ�');
alter sequence idseq
    increment by 10;
insert into testtbl2 values(idseq.nextval,'�̳�2',21,'�Ϻ�');
alter sequence idseq
    increment by 1;
insert into testtbl2 values(idseq.nextval,'�̳�2',21,'�Ϻ�');

select idseq.currval from dual; --dual ���� ���̺� // �ش� �������� ���� ��

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
-----------------------------------------------------
create table testtbl5 as 
(select employee_id,first_name,last_name,phone_number
from hr.employees);

select * from testtbl5;
select * from hr.employees;
select * from testtbl4 order by firstname;

select * from testtbl4 where firstname='David';

update testtbl4
set phone='����'
--where firstname='david'; //error
WHERE Firstname='David';

update testtbl5
set phone_number='����';

rollback;
commit;

delete from testtbl4;
select * from tab;
rollback;

delete from testtbl4 where firstname='Peter';

delete from testtbl4 where firstname='Peter' and  rownum <=2;
select * from testtbl4 order by firstname;
rollback;

select * from testtbl4;
select * from testtbl4 where firstname='Peter';

truncate table testtbl4; -- �����͸� �����. �ڵ� commit;

select sysdate from dual;
select to_char(sysdate,'yyyy/mm/dd hh:mi:ss') "���� ��¥" from dual;

select length('�ѱ�'),length('AB'),lengthb('�ѱ�'),lengthb('AB') from dual;

--����
--select 
--from
--where
--group by
--having
--order by


--���� �Լ�
select row_number() over(order by height desc) "Ű ū ����" ,username,addr,height 
from usertbl;

--select username,addr,height 
--from usertbl
--order by height desc;

select row_number() over(order by height desc,username asc) "Ű ū ����" ,username,addr,height 
from usertbl;

commit;

--�� ������ ����
select addr,row_number()over(partition by addr order by height desc, username asc) "������ Ű ū ����",
username,height
from usertbl;

--������ ���
select dense_rank()over(order by height desc) "Ű ū ����",username,addr,height
from usertbl;

select rank()over(order by height desc) "Ű ū ����",username,addr,height
from usertbl;

--�׷� ����, ���� �ο��� �ٽ� ó������ ä���
select ntile(2) over(order by height desc) "�� ��ȣ",username,addr,height from usertbl;
select ntile(3) over(order by height desc) "�� ��ȣ",username,addr,height from usertbl;
select ntile(4) over(order by height desc) "�� ��ȣ",username,addr,height from usertbl;

--inner join
--select <�� ���>
--from <ù ��° ���̺�>
--    inner join <�� ��° ���̺�>
--    on <���ε� ����>
--where �˻� ����

--���� ���̺� �߿��� JYP��� ���̵� ���� ����� ������ ������ �߼��ϱ�
--�̸�,�ּ�,����ó ���� �����ؼ� �˻�

--select username,addr,mobile1,mobile2
--from buytbl
--    inner join usertbl
--    on buytbl.userid=usertbl.userid;
--where buytbl.userid='jyp';

select *
from buytbl
    inner join usertbl
    on buytbl.userid=usertbl.userid;

select buytbl.userid,username,prodname,addr,mobile1||mobile2 as "����ó"
from buytbl
    inner join usertbl
    on buytbl.userid=usertbl.userid;

select buytbl.userid,usertbl.username,buytbl.prodname,usertbl.addr,usertbl.mobile1||usertbl.mobile2 as "����ó"
from buytbl
    inner join usertbl
    on buytbl.userid=usertbl.userid;

--���̺� �� ��Ī
select B.userid,U.username,B.prodname,U.addr,U.mobile1||U.mobile2 as "����ó"
from buytbl B
    inner join usertbl U
    on B.userid=U.userid;

select B.userid,U.username,B.prodName,U.addr,U.mobile1,U.mobile2 as "����ó"
from buytbl B
    inner join usertbl U
    on B.userid=U.userid
where B.userid='jyp';

--ȸ�� ���̺��� �������� JYP��� ���̵� ������ ���� ���
select U.userid,U.username,B.prodName,U.addr,U.mobile1,U.mobile2 as "����ó"
from usertbl U
    inner join buytbl B
    on U.userid=B.userid
where B.userid='jyp';

--��ü ȸ������ ������ ����� ��� ����ϴµ�, ȸ�� ���̵� ������ ����
select U.userid,U.username,B.prodName,U.addr,U.mobile1,U.mobile2 as "����ó"
from usertbl U
    inner join buytbl B -- outer join ( ���ǿ� ������ �ʾƵ� ���)
    on U.userid=B.userid
    order by U.userid;
--where B.userid='jyp';

select distinct U.userid,U.username,U.addr
from usertbl U
    inner join buytbl B
    on U.userid=B.userid
    order by U.userid;

select U.userid,U.username,U.addr
from usertbl U
where exists(select * from buytbl B where U.userid=B.userid);

commit;
-------------------------------------------------------------
create table stdtbl(
stdname nchar(5) not null primary key,
addr nchar(2) not null
);

create table clubtbl(
clubname nchar(5) not null primary key,
roomno nchar(4) not null
);

create sequence stdclubseq;

commit;

create table stdclubtbl(
idnum number(5) not null primary key,
stdname nchar(5) not null,
clubname nchar(5) not null,
foreign key(stdname) references stdtbl(stdname),
foreign key(clubname) references clubtbl(clubname)
);

insert into stdtbl values('�����','�泲');
insert into stdtbl values('���ð�','����');
insert into stdtbl values('������','���');
insert into stdtbl values('������','���');
insert into stdtbl values('�ٺ�Ŵ','����');

insert into clubtbl values('����','101ȣ');
insert into clubtbl values('�ٵ�','102ȣ');
insert into clubtbl values('�౸','103ȣ');
insert into clubtbl values('����','104ȣ');

insert into stdclubtbl values(stdclubseq.nextval,'�����','�ٵ�');
insert into stdclubtbl values(stdclubseq.nextval,'�����','�౸');
insert into stdclubtbl values(stdclubseq.nextval,'������','�౸');
insert into stdclubtbl values(stdclubseq.nextval,'������','�౸');
insert into stdclubtbl values(stdclubseq.nextval,'������','����');
insert into stdclubtbl values(stdclubseq.nextval,'�ٺ�Ŵ','����');

select * from clubtbl;
select * from stdclubtbl;
select * from clubtbl;

--�л� ���̺�, ���Ƹ� ���̺�, �л� ���Ƹ� ���̺��� �̿��ؼ� �л��� �������� �л��̸�,����,
--������ ���Ƹ�,�� ȣ�� ��ȸ ���
select S.stdname,S.addr,C.clubname,C.roomno
from stdtbl S
    inner join stdclubtbl SC
    on S.stdname=SC.stdname
    inner join clubtbl C
    on SC.clubname=C.clubname
order by S.stdname;

--�л� ���̺�, ���Ƹ� ���̺�, �л� ���Ƹ� ���̺��� �̿��ؼ� ���Ƹ��� �������� �л��̸�,����,
--������ ���Ƹ�,�� ȣ�� ��ȸ ���
select C.clubname,C.roomno,S.stdname,S.addr
from stdtbl S
    inner join stdclubtbl SC
    on S.stdname=SC.stdname
    inner join clubtbl C
    on SC.clubname=C.clubname
order by C.clubname;

--outer join
select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "����ó"
from usertbl U
    left outer join buytbl B --���� ���̺�(usertbl)�� ���� ��� ��µǾ�� �Ѵ�
    on U.userid=B.userid
order by U.userid;

select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "����ó"
from buytbl B
    right outer join usertbl U --������ ���̺�(buytbl)�� ���� ��� ��µǾ�� �Ѵ�
    on U.userid=B.userid
order by U.userid;

select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "����ó"
from usertbl U
    right outer join buytbl B
    on U.userid=B.userid
order by U.userid;

select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "����ó"
from usertbl U
    left outer join buytbl B
    on U.userid=B.userid
    where B.prodname is not null
order by U.userid;

select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "����ó"
from usertbl U
    full outer join buytbl B
    on U.userid=B.userid
order by U.userid;

select S.stdname,S.addr,C.clubname,C.roomno
from stdtbl S
    left outer join stdclubtbl SC --outer ��������
    on S.stdname=SC.stdname
    left outer join clubtbl C
    on SC.clubname=C.clubname
order by S.stdname;

--���Ƹ��� �������� ����ϵ� ���� �л��� �ϳ��� ���� ���Ƹ��� ���
select C.clubname,C.roomno,S.stdname,S.addr
from stdtbl S
    left outer join stdclubtbl SC
    on SC.stdname=S.stdname
    right outer join clubtbl C
    on SC.clubname=C.clubname
order by S.stdname;

--���Ƹ��� �������� ���� �л��� ��µǰ� �л��� �Ѹ� ���� ���Ƹ��� ��� 
select S.stdname,S.addr,C.clubname,C.roomno
from stdtbl S
    left outer join stdclubtbl SC
    on SC.stdname=S.stdname
    left outer join clubtbl C
    on SC.clubname=C.clubname
union
select S.stdname,S.addr,C.clubname,C.roomno
from stdtbl S
    left outer join stdclubtbl SC
    on SC.stdname=S.stdname
    right outer join clubtbl C
    on SC.clubname=C.clubname;
    
select stdname,addr from stdtbl
union --�ߺ����� //��ü������ �������� ����
select clubname,roomno from clubtbl;

select stdname,addr from stdtbl
union all--�ߺ�����
select clubname,roomno from clubtbl;

create table sal(
num number(5),
name varchar2(12),
part varchar2(20)
);

create table depart(
num varchar2(3),
dname varchar2(10)
);

insert into sal values(001,'ȫ�浿','���ߺ�');
insert into sal values(002,'�̼���','��ȹ��');
insert into sal values(003,'�������','�ѹ���');

insert into depart values('A01','���ߺ�');
insert into depart values('B01','��ȹ��');
insert into depart values('C01','�ѹ���');

select name,part from sal
union all
select num,dname from depart;

