create table member(
    id varchar2(10) primary key,
    name varchar2(30) not null,
    age number(3) not null,
    address varchar2(60)
    );

insert into member(id,name,age,address)
    values('dragon','�ڹ���','40','�����');
    
insert into member(id,name,age,address)
    values('sky','������','30','�λ��');
    
insert into member(id,name,age,address)
    values('blue','�̼���','40','��õ��');
    
select id,name,age,address FROM member WHERE name like '%��%';