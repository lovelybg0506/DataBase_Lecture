create table classinfo(
    class_no number(2) primary key,
    cname varchar2(30) not null,
    reg_date date);
    
insert into classinfo(class_no,cname,reg_date)
    values('10','���Թ�','21/03/24');
    
insert into classinfo(class_no,cname,reg_date)
    values('20','�޴Թ�','21/03/24');
    
insert into classinfo(class_no,cname,reg_date)
    values('30','�ɴԹ�','21/03/24');
    
    
---------------------------------------------------

create table studentinfo(
    id varchar2(10) primary key,
    name varchar2(30) not null,
    class_no number(2) not null,
    constraint fk_studentinfo foreign key(class_no)
    references classinfo(class_no),
    reg_date date);
    
insert into studentinfo(id,name,class_no,reg_date)
    values('dragon','�ڹ���','10','21/03/24');
    
insert into studentinfo(id,name,class_no,reg_date)
    values('sky','�念��','10','21/03/24');

insert into studentinfo(id,name,class_no,reg_date)
    values('blue','ȫ�浿','20','21/03/24');

commit;

---------------------------------------------------------

create or replace function FINDCLASS (s_id varchar2)
    return varchar2 is
    class_name varchar2(30);
begin
    select c.cname
    into class_name
    from studentinfo s inner join classinfo c
on s.class_no=c.class_no
    where s.id=s_id;
    return class_name;
end;

select FINDCLASS('dragon') from dual;

drop function FINDCLASS;

commit;










