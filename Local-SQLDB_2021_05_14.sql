create table userTBL(
userid char(8) not null PRIMARY KEY, --����� ���̵�(pk)
username NVARCHAR2(10) not null, --�̸�
birthyear number(4) not null, --����⵵
addr NCHAR(2) not null, --����(���,����,�泲 ��� 2���ڸ� �Է�)
mobile1 char(3),--�޴����� ����(010,016,017,018,019)
mobile2 char(8),--�޴����� ������ ��ȣ(������ ����)
height number(3),--Ű
mdate date --ȸ�� ������
);

create table buyTBL(
idnum number(8) not null primary key,--����(PK)
userid char(8) not null,--���̵�(FK)
prodname nchar(6) not null,--��ǰ��
groupName nchar(4),--�з�
price number(8) not null,--�ܰ�
amount number(3) not null,--����
FOREIGN key (userid) REFERENCES usertbl(userid)
);

commit;

insert into usertbl values('lsg','�̽±�',1987,'����','011','11111111',182,'2000-8-8');
insert into usertbl values('kbs','�����',1979,'�泲','011','22222222',173,'2012-4-4');
insert into usertbl values('kkh','���ȣ',1971,'����','019','33333333',177,'2007-7-7');
insert into usertbl values('jyp','������',1950,'���','011','44444444',166,'2009-4-4');
insert into usertbl values('ssk','���ð�',1979,'����',null,null,186,'2013-12-12');
insert into usertbl values('ljb','�����',1963,'����','016','66666666',182,'2009-9-9');
insert into usertbl values('yjs','������',1969,'�泲',null,null,170,'2005-5-5');
insert into usertbl values('ejw','������',1972,'���','011','88888888',174,'2014-3-3');
insert into usertbl values('jkw','������',1965,'���','018','99999999',172,'2010-10-10');
insert into usertbl values('bbk','�ٺ�Ŵ',1973,'����','010','00000000',176,'2013-5-5');

create SEQUENCE idseq;
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

select*from usertable;
select*from buytbl;

-- ���ȣ
select * from usertbl where username='���ȣ';

--1970�� ���Ŀ� ����ϰ� ������ 182 �̻��� ����� ���̵�� �̸� ��ȸ
select userid,username from usertbl where birthyear >=1970 and height >=182;

--1970�� ���Ŀ� ����߰ų� ������ 182 �̻��� ����� ���̵�� �̸� ��ȸ
select userid,username from usertbl where birthyear >=1970 or height >=182;

--Ű�� 180~183�� ��� ��ȸ
select username,height from usertbl where height >= 180 and height <=183;
select username,height from usertbl where height between 180 and 183;

--������ '�泲','����','���'�� ����� ���� ��ȸ
select userName,addr from usertbl where addr='�泲' or addr='����' or addr='���';
select userName,addr from usertbl where addr in('�泲','����','���');

--���ڿ� ���� ��ȸ
select userName,height from usertbl where username like '��%';
select userName,height from usertbl where username like '_����';

--'������','����� ���','�̿��� �༭ �����մϴ�'
select userName,height from usertbl where username like '_��%';

--��������
select username,height from usertbl where height > 177;

select username,height
from usertbl
where height > (select height from usertbl where username='���ȣ');

--������ '�泲'����� Ű���� Ű�� ũ�ų� ���� ��� ��ȸ,��������
--ANY:���������� ���� ���� ��� �� �Ѱ����� ����
--ALL:���������� ���� ���� ����� ��� ����

--select username,height
--from usertbl
--where height >=(select height from usertbl where addr='�泲');--error

select username,height
from usertbl
where height >= any(select height from usertbl where addr='�泲');--or

select username,height
from usertbl
where height >= all(select height from usertbl where addr='�泲');
--Ű�� 170���� ũ�ų� ���ƾ� �� �Ӹ� �ƴ϶�, 173���� ũ�ų� ���ƾ� �Ѵ�. �ᱹ Ű�� 173���� ũ�ų� ���� ����� �ش�

select username,height
from usertbl
where height = any(select height from usertbl where addr='�泲');

select username,height
from usertbl
where height in(select height from usertbl where addr='�泲');

--order by ����
select username,mdate from usertbl order by mdate;--ascending,��������
select username,mdate from usertbl order by mdate desc;--descendrin,��������

--Ű�� ū ������ �����ϵ� ���� Ű�� ���� ��쿡 �̸� ������ ����
select username,height from usertbl order by height desc, username asc;

--�ߺ��� ���� �ϳ��� ����� distinct
select addr from usertbl;
select addr from usertbl order by addr;
select distinct addr from usertbl; --�ּ��ߺ��� �������̺��� ����

--���̺� ���� create table...as select...primary key�� ���� ���� �ʴ´�.
create table buytbl2 as (select*from buytbl);
select*from buytbl2;

create table buytbl3 as (select userid,prodname from buytbl);
select*from buytbl3;

--group by,���� �Լ� avg(),min(),max(),count()
select userid,amount from buytbl order by userid;

select userid,sum(amount)
from buytbl
group by userid;

select userid as "����� ���̵�",sum(amount) as "�� ���� ����"--�÷�����ٲ�
from buytbl
group by userid;

select userid as "����� ���̵�",sum(price*amount) as "�� ���ž�"
from buytbl
group by userid;

select avg(amount) as "��� ���� ����" from buytbl;

select cast(avg(amount) as number(5,3))as "��� ���� ����"from buytbl;

select userid, cast(avg(amount) as number(5,3))as "��� ���� ����"
from buytbl
group by userid;

commit;

--���� ū Ű�� ���� ���� Ű�� ȸ���̸��� Ű�� ��ȸ
--select username,max(height),min(height) from usertbl
--group by username;

select username,height
from usertbl
where height = (select max(height)from usertbl) or
      height = (select min(height)from usertbl);
      
--�޴����� �ִ� ����� ��
select count(*) from usertbl;

select count(mobile1) from usertbl;

--�� ���ž��� 1000 �̻��� ����� ��ȸ
--select userid as "����� ���̵�",sum(price*amount) as "�� ���ž�"
--from buytbl
--where sum(price*amount) >= 1000 --�׷��Լ��� where������ ����� �� ����
--group by userid;

select userid as "����� ���̵�",sum(price*amount) as "�� ���ž�"
from buytbl
where usdrid
group by sum(price*amount) >= 1000 --having ���� �ݵ�� group by ������ �;��Ѵ�

--insert
create table testtbl1(
id number(4),
username nchar(3),
age number(2)
);

insert into testtbl1 values(1,'ȫ�浿',25);
select*from testtbl1;
--insert into testtbl1 values(2,'����'); --error
insert into testtbl1(id,username) values(2,'����');
insert into testtbl1(username,age,id) values('����',26,3);

create table testtbl2(
id number(4),
username nchar(3),--nation
age number(2),
nation nchar(4) default'���ѹα�'
);

create sequence idseq
   start with 1
   increment by 1;
      
drop sequence idseq;

select*from testtbl2;

insert into testtbl2 values(idseq.nextval,'����',25,default);
insert into testtbl2 values(idseq.nextval,'����',24,'����');

select*from testtbl2;

insert into testtbl2 values(11,'����',18,'�븸');--����
insert into testtbl2 values(idseq.nextval,'�̳�',21,'�Ϻ�');
alter sequence idseq
   increment by 10;
insert into testtbl2 values(idseq.nextval,'�̳�2',21,'�Ϻ�');
alter sequence idseq
   increment by 1;
insert into testtbl2 values(idseq.nextval,'�̳�3',21,'�Ϻ�');

select idseq.currval from dual; --dual ���� ���̺� 

--
create table testtbl4(
empid number(6),
firstname varchar2(20),
lastname varchar2(25),
phone varchar2(20)
);

--�뷮����
insert into testtbl4
select employee_id,first_name,last_name,phone_number
from hr.employees;

select * from testtbl4;
-------------------------------------------------------------------
create table testtbl5 as
(select employee_id,first_name,last_name,phone_number
from hr.employees);

select * from testtbl5;
select*from hr.employees;
select*from testtbl4 order by firstname;

update testtbl4
set phone='����'
--where firstname='david';
WHERE Firstname='David';--�빮��

update testtbl5
set phone_number='����';

rollback;
commit;

delete from testtbl4;
select*from tab;
rollback;

delete from testtbl4 where firstname='pater';
rollback;

delete from testtbl4 where firstname='peter' and rownum <= 2;
select*from testtbl4 order by firstname;
rollback;--������ �����Ѱ����� �ѹ�

select*from testtbl4;
select*from testtbl4 where firstname='peter';

truncate table testtbl4;--�����͸� �����. �ڵ�commit;

select sysdate from dual;
select to_char(sysdate,'yyyy/mm/dd hh:mi:ss') "���� ��¥" from dual;

select length('�ѱ�'),length('AB'),lengthb('�ѱ�'),lengthb('AB')from dual;

--select
--from
--where
--group by
--having
--order by

--���� �Լ�
select row_number()over(order by height desc) "Űū ����",username,addr,height 
from usertbl;

--select username,addr,height
--from usertbl
--order by height desc;

select row_number()over(order by height desc,username asc) "Űū ����",username,addr,height 
from usertbl;

commit;

select addr,row_number() over(partition by addr order by height desc,username asc) "������ Űū����",
username,addr,height
from usertbl;

--�׷� ����,���� �ο��� �ٽ� ó������ ä���
select ntile(2) over(order by height desc)"�ݹ�ȣ",username,addr,height from usertbl;
select ntile(3) over(order by height desc)"�ݹ�ȣ",username,addr,height from usertbl;
select ntile(4) over(order by height desc)"�ݹ�ȣ",username,addr,height from usertbl;

--inner join
--select <�� ���>
--from <ù ��° ���̺�>
--   inner join<�� ��° ���̺�>
--   on <���ε� ����>
--where �˻� ����

--���� ���̺� �߿��� jyp��� ���̵� ���� ����� ������ ������ �߼��ϱ� ���ؼ�
--�̸�,�ּ�,����ó ���� �����ؼ� �˻�
--select username,addr,mobilel,mobile2
--from buytbl
--   inner join usertbl
--   on buytbl.userid=usertbl.userid --buytbl���ִ� userid��usertbl���ִ�userid������
----where buytbl.userid='jyp';

select * 
from buytbl
   inner join usertbl
   on buytbl.userid=usertbl.userid;

select buytbl.userid,username,prodname,addr,mobile1|| mobile2 as "����ó"
from buytbl
   inner join usertbl
   on buytbl.userid=usertbl.userid;
   
select buytbl.userid,usertbl.username,buytbl.prodname,usertbl.addr,usertbl.mobile1|| usertbl.mobile2 as "����ó"
from buytbl
   inner join usertbl
   on buytbl.userid=usertbl.userid;
   
select B.userid,U.username,B.prodname,U.addr,U.mobile1|| U.mobile2 as "����ó"
from buytbl B
   inner join usertbl U
   on B.userid=U.userid;
   
select B.userid,U.username,B.prodname,U.addr,U.mobile1|| U.mobile2 as "����ó"
from buytbl B
   inner join usertbl U
   on B.userid=U.userid
where B.userid='jyp';

--ȸ�� ���̺��� �������� jyp��� ���̵� ������ ���� ���
select U.userid,U.username,B.prodname,U.addr,U.mobile1|| U.mobile2 as "����ó"
from usertbl U
   inner join buytbl B
   on U.userid=B.userid
where B.userid='jyp';

--��ü ȸ������ ������ ����� ��� ����ϴµ� ȸ�� ���̵� ������ ����
select U.userid,U.username,B.prodname,U.addr,U.mobile1|| U.mobile2 as "����ó"
from usertbl U
   inner join buytbl B --���ʴ��ش�Ǵ»��,���Ǹ��� �������� ��ü:outer join
   on U.userid=B.userid
   order by U.userid;
--where B.userid='jyp';

select U.userid,U.username,U.addr
from usertbl U
   inner join buytbl B
   on U.userid=B.userid --������ ����
   order by U.userid;

select U.userid,U.username,U.addr
from usertbl U
where exists(select * from buytbl B where U.userid=B.userid); --�����̺���̵𰡰����� B���̺��մ°���ȸ
--exists:���ǿ��°� ��ȸ�� �ߺ��Ǵ� �ڵ�������ϰ� ������

commit;
----------------------------------------------------------------
create table stdtbl(
stdname nchar(5) not null primary key,
addr nchar(2)not null
);

create table clubtbl(
clubname nchar(5) not null primary key,
roomno nchar(4) not null
);

create sequence stdclubseq;

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

select*from clubtbl;
select*from stdclubtbl;
select*from stdtbl;

--�л� ���Ǻ�,���Ƹ� ���̺�,�л� ���Ƹ� ���̺��� �̿��ؼ� �л��� �������� �л��̸�,����,
--������ ���Ƹ�,�� ȣ�� ��ȸ ���
select S.stdname,S.addr,C.clubname,C.roomno
from stdtbl S
   inner join stdclubtbl SC
   on S.stdname=Sc.stdname
   inner join clubtbl C
   on SC.clubname=C.clubname
order by S.stdname;

--�л� ���Ǻ�,���Ƹ� ���̺�,�л� ���Ƹ� ���̺��� �̿��ؼ� ���Ƹ��� �������� �л��̸�,����,
--������ ���Ƹ�,�� ȣ�� ��ȸ ���
select C.clubname,C.roomno,S.stdname,S.addr
from stdtbl S
   inner join stdclubtbl SC
   on S.stdname=Sc.stdname
   inner join clubtbl C
   on SC.clubname=C.clubname
order by C.clubname;

--outer join
select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "����ó"
from usertbl U
   left outer join buytbl B --�������̺�(usertbl)�� ���� ��� ��µǾ�� �Ѵ�
   on U.userid=B.userid
order by U.userid;

select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "����ó"
from  buytbl B 
   right outer join usertbl U--���������̺�(buytbl)�� ���� ��� ��µǾ�� �Ѵ�
   on U.userid=B.userid
order by U.userid;

select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "����ó"
from usertbl U
   right outer join buytbl B 
   on U.userid=B.userid
order by U.userid;

--���� �Ȼ��� ����
select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "����ó"
from usertbl U
   left outer join buytbl B --�������̺�(usertbl)�� ���� ��� ��µǾ�� �Ѵ�
   on U.userid=B.userid
   where B.prodname is not null
order by U.userid;

select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "����ó"
from usertbl U
   full outer join buytbl B --���������ش�Ǵ°� ��� ���
   on U.userid=B.userid
order by U.userid;

--�л����̺����ַ� ó��
select S.stdname,S.addr,C.clubname,C.roomno
from stdtbl S
   left outer join stdclubtbl SC
   on S.stdname=SC.stdname
   left outer join clubtbl C
   on SC.clubname=C.clubname
order by S.stdname;

--���Ƹ��� �������� ����ϵ� ���� �л��� �ϳ��� ���� ���Ƹ��� ���
select C.clubname,C.roomno,S.stdname,S.addr
from stdtbl S
   left outer join stdclubtbl SC --�����̺�����
   on SC.stdname=S.stdname --��������:
   right outer join clubtbl C
   on SC.clubname=C.clubname
order by S.stdname;

--���Ƹ��� �������� ���� �л��� ��µǰ� �л��� �Ѹ� ���� ���Ƹ��� ���
select S.stdname,S.addr,C.clubname,C.roomno
from stdtbl S
   left outer join stdclubtbl SC
   on S.stdname=SC.stdname
   left outer join clubtbl C
   on SC.clubname=C.clubname
union
select S.stdname,S.addr,C.clubname,C.roomno
from stdtbl S
   left outer join stdclubtbl SC
   on SC.stdname=S.stdname
   right outer join clubtbl C
   on SC.clubname=C.clubname

select stdname,addr from stdtbl
union --�ߺ�����
select clubname,roomno from clubtbl;

select stdname,addr from stdtbl
union all 
select clubname,roomno from clubtbl;

create table sal(
num number(5),
name varchar2(20),
part varchar2(20)
);

create table depart(
num varchar2(3),
part varchar2(10)
pos varchar2(20)
);

insert into sal values('001','ȫ�浿','���ߺ�');
insert into sal values('002','�̼���','��ȹ��');
insert into sal values('003','�������','�ѹ���');

insert into depart values('0001','���ߺ�','����');
insert into depart values('0002','��ȹ��','�λ�');
insert into depart values('0003','�ѹ���','��õ');
--�ڵ尡������ �Ѱ�������, �ٸ��� �ٳ���
select name,part from sal
union 
select num,dname from depart;

commit;

--usertbl���� (��ȭ�Ⱑ ���� ���) �����ϰ� ��ȸ
select username,concat(mobile1,mobile2) as "��ȭ��ȣ" from usertbl
where username not in (select username from usertbl where mobile1 is null);

--usertbl���� ��ȭ�Ⱑ ���� ��� ��ȸ
--select username,concat(mobile1,mobile2) as "��ȭ��ȣ" from usertbl
--where mobile1 is null;
select username,concat(mobile1,mobile2) as "��ȭ��ȣ" from usertbl
where username in (select username from usertbl where mobile1 is null);

--procedu Language SQL
--set serveroutput on;
declare
    var1 number(5); --��������
begin
   var1:=100; --������(����)
   if var1=100 then --var1�� 100�̳�
       dbms_output.put_line('100�Դϴ�');
   else
       dbms_output.put_line('100�� �ƴմϴ�');
   end if;
end;

declare
  hiredate date;
  curdate date;
  wdays number(5);
  
begin
    select hire_date into hiredate --�Ի糯¥
    from HR.employees
    where employee_id=200;
    curdate:=current_date(); --���糯¥
    wdays:=curdate-hiredate; --����ð�
    if(wdays/365) >= 5 then
        dbms_output.put_line('�Ի�����'||wdays||'���̳� �������ϴ�. �����մϴ�!');
    else
        dbms_output.put_line('�Ի�����'||wdays||'�Ϲۿ� �ȵǾ��׿�. ������ ���ϼ���');
    end if;
end;


declare
   pnumber number(3);
   credit char(1);
begin
   pnumber:=77;
   if pnumber >= 90 then
       credit:='A';
    elsif pnumber >= 80 then
       credit:='B';
    elsif pnumber >=70 then
       credit:='C';
    elsif pnumber >=60 then
       credit:='D';
    elsif 
       credit:='F';
    end if;
    dbms_output.put_line('�������==>'||pnumber||',����==>'||credit);
end;

declare
   pnumber number(3);
   credit char(1);
begin
   pnumber:=99;
   case
   when pnumber >= 90 then
       credit:='A';
    when pnumber >= 80 then
       credit:='B';
    when pnumber >=70 then
       credit:='C';
    when pnumber >=60 then
       credit:='D';
    else 
       credit:='F';
    end case;
    dbms_output.put_line('�������==>'||pnumber||',����==>'||credit);
end;

--buytbl���� ���ž�(price*amount)�� 1500�� �̻��� ���� '�ֿ�� ��','1000�� �̻���
--���� '�����',1�� �̻��� ���� '�Ϲݰ�'���� ���, ���� �������� ������ ����
--���� '���ɰ�'�̶�� ���
--buytbl���� ���ž�(price*amount)�� ����� ���̵�(userid)���� �׷�ȭ�Ѵ�. ���� ���ž���
--���� ������ �����Ѵ�
select userid,sum(price*amount) as "�� ���ž�"
from buytbl 
group by userid
order by sum(price*amount) desc;

--usertbl�� �����ؼ� ����� �̸��� ���
select B.userid,U.username,sum(price*amount) as "�� ���ž�"
from buytbl B
    inner join usertbl U
    on B.userid=U.userid 
group by B.userid,U.username
order by sum(price*amount) desc;

--�������� ���� ���� ��ܵ� ���� ���
select B.userid,U.username,sum(price*amount) as "�� ���ž�"
from buytbl B
    right outer join usertbl U
    on B.userid=U.userid 
group by B.userid,U.username
order by sum(price*amount) desc nulls last;

--�������� ���� ���� userid ���
select U.userid,U.username,sum(price*amount) as "�� ���ž�"
from buytbl B
    right outer join usertbl U
    on B.userid=U.userid 
group by U.userid,U.username
order by sum(price*amount) desc nulls last;

select U.userid,U.username,sum(price*amount) as "�� ���ž�",
    case
        when(sum(price*amount)>= 1500) then '�ֿ����'
        when(sum(price*amount)>= 1000) then '�����'
        when(sum(price*amount)>= 1) then '�Ϲݰ�'
       else '���ɰ�'
       end as ""
from buytbl B
 right outer join usertbl U
    on B.userid=U.userid 
group by U.userid,U.username
order by sum(price*amount) desc nulls last;

set serveroutput on;
declare
     inum number(3);
     hap number(5);
 begin
     inum:=1;
     hap:=0;
     while inum<=100
     loop
          hap:=hap+inum;
          inum:=inum+1;
    end loop;
    dbms_output.put_line(hap);
end;

declare
     inum number(3);
     hap number(5);
 begin
     hap:=0;
    for inum in 1..100
     loop
          hap:=hap+inum;
    end loop;
    dbms_output.put_line(hap);
end;
---------------------------------------------------------------
declare
     inum number(3);
     hap number(5);
 begin
    inum:=1;
     hap:=0;
    while inum<100
     loop
        if mod(inum,7)=0 then --����� 7�γ������� 0������
        inum:=inum+1; --��������+1
        continue; --�ٽùݺ�������
        end if;
        hap:=hap+inum;
        if hap>1000 then
               exit;
           end if;
           inum:=inum+1;
        end loop;
        dbms_lock.sleep(5); --5��
        dbms_output.put_line(hap);
        dbms_output.put_line('5�ʰ� ���� �� ����Ǿ���');
end;

--Exception Handling
declare
      --���̺� ���� ������ Ÿ�԰� �����ϰ� ���� Ÿ���� ����
    v_username usertbl.username%TYPE; --v_username�̷� �����̸����� ���ٴ�
begin
    select username into v_username from usertbl
    where username like('��%');
     dbms_output.put_line('�达 �� �̸���'||v_username||'�Դϴ�');
     exception
        when no_data_found then --�����͸� ��ã�����
            dbms_output.put_line('�达 ���� �����ϴ�');
        when too_many_rows then --�ʹ����� ���
        dbms_output.put_line('�达 ���� �ʹ� ���׿�');
 end;
 
--����� ���� ����ó��
declare
      --���̺� ���� ������ Ÿ�԰� �����ϰ� ���� Ÿ���� ����
    v_username usertbl.username%TYPE; --v_username�̷� �����̸����� ���ٴ�
    userexception exception;
    pragma exception_init(userexception,-1422); --���� ���,-1422:2���̻� ���� ��ȯ�Ҷ�
begin
    select username into v_username from usertbl
    where username like('��%');
     dbms_output.put_line('�达 �� �̸���'||v_username||'�Դϴ�');
     exception
        when no_data_found then --�����͸� ��ã�����
            dbms_output.put_line('�达 ���� �����ϴ�');
        when too_many_rows then --�ʹ����� ���
        dbms_output.put_line('�达 ���� �ʹ� ���׿�');
 end;
 --------------------------------------------------------------------
 declare
     v_username usertbl.username%type;
     zerodelete exception;
begin
     v_username:='����';
     delete from usertbl where username=v_username;
     if sql%notfound then
          raise zerodelete;
        end if;
        exception
          when zerodelete then
            dbms_output.put_line(v_username||'������ ����. Ȯ�� �ٶ��ϴ�^^');
end;





































