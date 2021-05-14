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
