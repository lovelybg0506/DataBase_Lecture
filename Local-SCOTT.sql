-- view : ���� ���̺�
create view vw_emp20
as (select empno,ename,job,deptno from emp
    where deptno=20);
    
select * from user_views;
select view_name,text_length,text from user_views;
select * from vw_emp20;

drop view vw_emp20;

select rownum,E.* -- rownum�� ���������
from emp E;

select rownum,E.* -- rownum�� �����ص� ��ȣ�� �����ȴ�
from emp E
order by sal desc;

select rownum,E.* -- ���� ������ ����. �Ʒ� with as ���
from(select * from emp E order by sal desc);

--with as : ()�ȿ��ִ� ������� E ��� �ϰڴ�
with E as (select * from emp E order by sal desc)
select rownum,E.*
from E;

----------------
select rownum,E.* -- 1,2,3�� ã��
from(select * from emp E order by sal desc)E
where rownum <=3;

with E as (select * from emp E order by sal desc) -- with as ����ؼ� 1,2,3�� ã��
select rownum,E.*
from E
where rownum <=3;

-- sequence ��ü ( ��ü�� �����Ϸ��� drop ��� )
create table dept_sequence
as select * from dept;

select * from dept_sequence;

create sequence seq_dept_sequence
increment by 10 -- ������
start with 10 -- �ʱⰪ
maxvalue 90 -- �ִ밪
minvalue 0
nocycle -- ��ȯ����
cache 2; -- �̸� ���ڸ� �������µ�, 2���� �������ڴ� [�����, ����(�ӽ��������)����]

select * from user_sequences;

insert into dept_sequence(deptno,dname,loc)
values(seq_dept_sequence.nextval,'database2','seoul');

select * from dept_sequence order by deptno;

select seq_dept_sequence.currval from dual; -- �������� ���簪;

alter sequence seq_dept_sequence -- ������ ����
increment by 3
maxvalue 99
cycle; -- ��ȯ��Ű�� 99 ���� depno = 0, �� �������� 3�� ����.

select * from user_sequences;

drop sequence seq_dept_sequence;

commit;

--sysnonym(�óʴ�) : �ٸ� �̸� �ο� (��ü�� ó���Ǹ�, ������ �ȴ�)
create synonym E
for emp;

select * from E;

drop synonym E;

select * from emp;

-- 1) emp ���̺�� ���� ������ �����͸� �����ϴ� empidx���̺��� ���弼��.
create table empidx
as select * from emp;

select * from empidx;

-- 2) ������ empidx ���̺��� empno���� idx_empidx_empno�ε����� ���弼��.
create index idx_empid_empno
on empidx(empno);

-- 3) ���������� �ε����� �� ���� �Ǿ����� ������ ������ ���� �並 ���� Ȯ���� ������.
select * from user_indexes;
where index_name='idx_empidx_empno';

drop index idx_empidx_empno;

create or replace view empidx_over15k
--NVL2 :
as(select empno,ename,job,deptno,sal,NVL2(comm,'O','X') as comm from empidx where sal>1500);

select * from empidx_over15k;


create table deptseq
as select * from dept;

select * from deptseq;

create sequence deq_deptseq
increment by 1
start with 5
maxvalue 99
minvalue 1
nocycle
nocache;

insert into deptseq(deptno,dname,loc)
values(deq_deptseq.nextval,'database','seoul');
insert into deptseq(deptno,dname,loc)
values(deq_deptseq.nextval,'web','busan');
insert into deptseq(deptno,dname,loc)
values(deq_deptseq.nextval,'mobile','ilsan');

select * from deptseq;

delete from deptseq
where dname='database';
delete from deptseq
where dname='web';
delete from deptseq
where dname='mobile';

drop sequence deq_deptseq;

create sequence deq_deptseq
increment by 10
start with 50
maxvalue 99
minvalue 1
nocycle
nocache;

--���� ����
--not null : ������ ���� null�� ������� �ʴ´�. �ߺ��� ����Ѵ�.
--unique : ������ ���� ������ ���� ������ �Ѵ�. �� �ߺ� �Ұ� ,�� null�� �ߺ����� ����
--primary key : ������ ���� ������ ���̸鼭 null���� ������� �ʴ´�.
--foreign key : �ٸ� ���̺��� ���� ����
--check : ������ ���ǽ��� �����ϴ� �����͸� �Է� ����

--��ü ���Ἲ : ���̺� �����͸� �����ϰ� �ĺ� �� �� �ִ� �⺻Ű�� �ݵ�� ���� ������ �־�� �ϸ�
--              null �� �� �� ���� �ߺ� �� ���� ����

--���� ���Ἲ : ���� ���̺��� �ܷ�Ű ���� ���� ���̺��� �⺻Ű�ν� �����ؾ� �ϸ� null�� �����ϴ�.

create table table_notnull(
    login_id varchar2(20) not null,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);

desc table_notnull;

--insert into table_notnull(login_id,login_pwd,tel)
--values('test_id_01',null,'010-1234-5678'); -- not null�ε� null�� �����Ƿ� ����.

insert into table_notnull(login_id,login_pwd,tel)
values('test_id_01','1234','010-1234-5678');

select * from table_notnull;

--update table_notnull
--set login_pwd=null -- �̺κе� null�̶� update �Ұ���(����)
--where login_id='test_id_01';

update table_notnull
set login_pwd='5678'
where login_id='test_id_01';

create table table_unique(
    login_id varchar2(20) unique,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);

desc table_unique;

select owner,constraint_name,constraint_type,table_name
from user_constraints
where table_name='table_unique';

insert into table_unique(login_id,login_pwd,tel)
values('test_id_01','pwd01','010-1234-5678');

select * from table_unique;

--insert into table_unique(login_id,login_pwd,tel)
--values('test_id_01','pwd01','010-1234-5678'); -- id�κ��� unique �̱⶧���� ���� �����ϹǷ� ������ ����. (pwd�� unique�� �ƴϱ⶧���� �ߺ��̾ �������)

insert into table_unique(login_id,login_pwd,tel)
values('test_id_02','pwd01','010-1234-5678');

insert into table_unique(login_id,login_pwd,tel)
values('null','pwd01','010-1234-5678'); -- (id=null)�� ���� ����

alter table table_unique
modify(tel unique); -- modify ����

update table_unique
set tel=null;

select * from table_unique;

insert into table_unique(login_id,login_pwd,tel)
values(null,'pwd01','010-2345-9999');

insert into table_unique(login_id,login_pwd,tel)
values(null,'pwd01','010-2345-9999');

insert into table_unique(login_id,login_pwd,tel)
values(null,'pwd001',null);

commit;



























