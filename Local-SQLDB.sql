create table userTBL(
userid char(8) not null primary key, -- ����� ���̵�(Primary Key)
username nvarchar2(10) not null, -- �̸�
birthyear number(4) not null, -- ����⵵
addr nchar(2) not null, -- ����(���,����,�泲 ��� 2���ڸ� �Է�)
mobile1 char(3), -- �޴����� ����(010,011,016,017,018,019)
mobile2 char(8), -- �޴����� ������ ��ȣ(������ ����)
height number(3), -- Ű
mdate date -- ȸ�� ������
);

create table buyTBL(
idnum number(8) not null primary key, -- ����(PK)
userid char(8) not null, -- ���̵� (FK)
prodname nchar(6) not null, -- ��ǰ��
groupName nchar(4), -- �з�
price number(8) not null, -- �ܰ�
amount number(3) not null, -- ����
foreign key (userid) references usertbl(userid)

);