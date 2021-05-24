-- view : 가상 테이블
create view vw_emp20
as (select empno,ename,job,deptno from emp
    where deptno=20);
    
select * from user_views;
select view_name,text_length,text from user_views;
select * from vw_emp20;

drop view vw_emp20;

select rownum,E.* -- rownum이 만들어진다
from emp E;

select rownum,E.* -- rownum은 정렬해도 번호가 유지된다
from emp E
order by sal desc;

select rownum,E.* -- 실행 오류가 난다. 아래 with as 사용
from(select * from emp E order by sal desc);

--with as : ()안에있는 결과물을 E 라고 하겠다
with E as (select * from emp E order by sal desc)
select rownum,E.*
from E;

----------------
select rownum,E.* -- 1,2,3등 찾기
from(select * from emp E order by sal desc)E
where rownum <=3;

with E as (select * from emp E order by sal desc) -- with as 사용해서 1,2,3등 찾기
select rownum,E.*
from E
where rownum <=3;

-- sequence 객체 ( 객체를 삭제하려면 drop 사용 )
create table dept_sequence
as select * from dept;

select * from dept_sequence;

create sequence seq_dept_sequence
increment by 10 -- 증가값
start with 10 -- 초기값
maxvalue 90 -- 최대값
minvalue 0
nocycle -- 순환여부
cache 2; -- 미리 숫자를 만들어놓는데, 2개만 만들어놓겠다 [저장소, 버퍼(임시저장공간)개념]

select * from user_sequences;

insert into dept_sequence(deptno,dname,loc)
values(seq_dept_sequence.nextval,'database2','seoul');

select * from dept_sequence order by deptno;

select seq_dept_sequence.currval from dual; -- 시퀀스의 현재값;

alter sequence seq_dept_sequence -- 시퀀스 수정
increment by 3
maxvalue 99
cycle; -- 순환시키면 99 다음 depno = 0, 그 다음부터 3씩 증가.

select * from user_sequences;

drop sequence seq_dept_sequence;

commit;

--sysnonym(시너님) : 다른 이름 부여 (객체로 처리되며, 저장이 된다)
create synonym E
for emp;

select * from E;

drop synonym E;

select * from emp;

-- 1) emp 테이블과 같은 구조의 데이터를 저장하는 empidx테이블을 만드세요.
create table empidx
as select * from emp;

select * from empidx;

-- 2) 생성한 empidx 테이블의 empno열에 idx_empidx_empno인덱스를 만드세요.
create index idx_empid_empno
on empidx(empno);

-- 3) 마지막으로 인덱스가 잘 생성 되었는지 적절한 데이터 사전 뷰를 통해 확인해 보세요.
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

--제약 조건
--not null : 지정한 열에 null을 허용하지 않는다. 중복은 허용한다.
--unique : 지정한 열이 유일한 값을 가져야 한다. 즉 중복 불가 ,단 null은 중복에서 제외
--primary key : 지정한 열이 유일한 값이면서 null값을 허용하지 않는다.
--foreign key : 다른 테이블의 열을 참조
--check : 설정한 조건식을 만족하는 데이터만 입력 가능

--개체 무결성 : 테이블 데이터를 유일하게 식별 할 수 있는 기본키는 반드시 값을 가지고 있어야 하며
--              null 이 될 수 없고 중복 될 수도 없다

--참조 무결성 : 참조 테이블의 외래키 값은 참조 테이블의 기본키로써 존재해야 하며 null이 가능하다.

create table table_notnull(
    login_id varchar2(20) not null,
    login_pwd varchar2(20) not null,
    tel varchar2(20)
);

desc table_notnull;

--insert into table_notnull(login_id,login_pwd,tel)
--values('test_id_01',null,'010-1234-5678'); -- not null인데 null을 줬으므로 오류.

insert into table_notnull(login_id,login_pwd,tel)
values('test_id_01','1234','010-1234-5678');

select * from table_notnull;

--update table_notnull
--set login_pwd=null -- 이부분도 null이라서 update 불가능(오류)
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
--values('test_id_01','pwd01','010-1234-5678'); -- id부분은 unique 이기때문에 위와 동일하므로 오류가 난다. (pwd는 unique가 아니기때문에 중복이어도 상관없음)

insert into table_unique(login_id,login_pwd,tel)
values('test_id_02','pwd01','010-1234-5678');

insert into table_unique(login_id,login_pwd,tel)
values('null','pwd01','010-1234-5678'); -- (id=null)행 삽입 가능

alter table table_unique
modify(tel unique); -- modify 수정

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



























