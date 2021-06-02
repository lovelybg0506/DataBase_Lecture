create table member(
    id varchar2(10) primary key,
    name varchar2(30) not null,
    age number(3) not null,
    address varchar2(60)
    );

insert into member(id,name,age,address)
    values('dragon','박문수','40','서울시');
    
insert into member(id,name,age,address)
    values('sky','김윤신','30','부산시');
    
insert into member(id,name,age,address)
    values('blue','이순신','40','인천시');
    
select id,name,age,address FROM member WHERE name like '%신%';