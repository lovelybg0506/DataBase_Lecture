create table userTBL(
userid char(8) not null primary key, -- 사용자 아이디
username nvarchar2(10) not null, -- 사용자 이름
birthyear number(4) not null, -- 출생년도
addr nchar(2) not null, -- 지역(경기,서울,경남 등등 2글자만 입력)
mobile1 char(3), -- 휴대폰 국번(010,011,016,017,018,019)
mobile2 char(8), -- 휴대폰의 나머지 번호(하이픈 제외)
height number(3), -- 키
mdate date -- 회원 가입일
);

create table buyTBL(
idnum number(8) not null primary key, -- 순번(PK)
userid char(8) not null, -- 아이디(FK) /buytbl의 userid는 다른테이블에서 참조함
prodname nchar(6) not null, -- 물품명
groupName nchar(4), -- 분류
price number(8) not null, -- 단가
amount number(3) not null, -- 수량
foreign key (userid) references usertbl(userid)
);

commit;

insert into usertbl values('lsg','이승기',1987,'서울','011','11111111',182,'2008-8-8');
insert into usertbl values('kbs','김범수',1979,'경남','011','22222222',173,'2012-4-4');
insert into usertbl values('kkh','김경호',1971,'전남','019','33333333',177,'2007-7-7');
insert into usertbl values('jyp','조용필',1950,'경기','011','44444444',166,'2009-4-4');
insert into usertbl values('ssk','성시경',1979,'서울',null,null,186,'2013-12-12');
insert into usertbl values('ljb','임재범',1963,'서울','016','66666666',182,'2009-9-9');
insert into usertbl values('yjs','윤종신',1969,'경남',null,null,170,'2005-5-5');
insert into usertbl values('ejw','은지원',1972,'경북','011','88888888',174,'2014-3-3');
insert into usertbl values('jkw','조관우',1965,'경기','018','99999999',172,'2010-10-10');
insert into usertbl values('bbk','바비킴',1973,'서울','010','00000000',176,'2013-5-5');

create sequence idseq;
insert into buytbl values(idseq.nextval,'kbs','운동화',null,30,2);
insert into buytbl values(idseq.nextval,'kbs','노트북','전자',1000,1);
insert into buytbl values(idseq.nextval,'jyp','모니터','전자',200,1);
insert into buytbl values(idseq.nextval,'bbk','모니터','전자',200,5);
insert into buytbl values(idseq.nextval,'kbs','청바지','의류',50,3);
insert into buytbl values(idseq.nextval,'bbk','메모리','전자',80,10);
insert into buytbl values(idseq.nextval,'ssk','책','서적',15,5);
insert into buytbl values(idseq.nextval,'ejw','책','서적',15,2);
insert into buytbl values(idseq.nextval,'ejw','청바지','의류',50,1);
insert into buytbl values(idseq.nextval,'bbk','운동화',null,30,2);
insert into buytbl values(idseq.nextval,'ejw','책','서적',15,1);
insert into buytbl values(idseq.nextval,'bbk','운동화',null,30,2);

commit;

select * from usertbl;
select * from buytbl;

-- 김경호
select * from usertbl where username='김경호';

-- 1970년 이후에 출생하고 신장이 182 이상인 사람의 아이디와 이름 조회
select userid,username from usertbl where birthyear>=1970 and height>=182;

-- 1970년 이후에 출생했거나 신장이 182 이상인 사람의 아이디와 이름 조회
select userid,username from usertbl where birthyear>=1970 or height>=182;

-- 키가 180~183인 사람 조회(이름, 키 조회)
select username,height from usertbl where height >= 180 and height <= 183;
select username,height from usertbl where height between 180 and 183;

-- 지역이 '경남','전남','경북',인 사람의 정보 조회
select userName,addr from usertbl where addr='경남' or addr='전남' or addr='경북';
select userName,addr from usertbl where addr in('경남','전남','경북');

-- 문자열 내용 조회
select userName,height from usertbl where userName like '김%';
select userName,height from usertbl where userName like '_종신';

-- '조용필','사용한 사람','이용해 줘서 감사합니다'
select userName,height from usertbl where userName like '_용%';

-- 서브쿼리
select username,height from usertbl where height > 177;

select username,height
from usertbl
where height > (select height from usertbl where userName='김경호');

-- 지역이 '경남'사람의 키보다 키가 크거나 같은 사람 조회, 서브쿼리
--ANY : 서브쿼리의 여러 결과 중 한가지만 만족
--ALL : 서브쿼리의 여러 결과를 모두 만족

--select userName,height
--from usertbl
--where height >= (select height from usertbl where addr='경남'); -- error

--select userName,height
--from usertbl
--where height >= any(select height from usertbl where addr='경남'); -- or
-- any 키워드 사용

select userName,height
from usertbl
where height >= all(select height from usertbl where addr='경남'); -- 키가 170보다 크거나 같아야 할 뿐만 아니라 173보다 크거나 같아야 하기때문에 후자가 기준이 된다
-- all 키워드 사용

select userName,height
from usertbl
where height= any(select height from usertbl where addr='경남');

select userName,height
from usertbl
where height in (select height from usertbl where addr='경남'); -- error
-- 위와 동일

--order by
select username,mdate from usertbl order by mdate; -- order by 후 asc,desc 지정하지않으면 default값은 오름차순(작은수 -> 큰수) 이다.
select username,mdate from usertbl order by mdate desc; -- 내림차순

--키가 큰 순서로 정렬하되 만약 키가 같을경우에 이름 순으로 정렬
select userName,height from usertbl order by height desc,username asc;

--중복된 것은 하나만 남기는 distinct
select addr from usertbl;
select addr from usertbl order by addr;
select distinct addr from usertbl;

--테이블 복사 create table...as select....primary key는 복사 되지 않는다.
create table buytbl2 as (select * from buytbl);
select * from buytbl2;

create table buytbl3 as (select userid,prodname from buytbl);
select * from buytbl3;

--group by,집계 함수 avg(),min(),max(),count()
select userid,amount from buytbl order by userid;

select userid,sum(amount)
from buytbl 
group by userid;

select userid as "사용자 아이디",sum(amount) as "총 구매 개수"
from buytbl
group by userid;

select userid as "사용자 아이디",sum(price*amount) as "총 구매액"
from buytbl
group by userid;

select avg(amount) as "평균 구매 개수" from buytbl;

select cast(avg(amount) as number(5,3))as "평균 구매 개수" from buytbl;

select userid,cast(avg(amount) as number(5,3))as "평균 구매 개수" 
from buytbl
group by userid;

--가장 큰 키와 가장 작은 키의 회원이름과 키를 조회
--select username,max(height),min(height) from usertbl
--group by username;

select username,height 
from usertbl
where height =(select max(height)from usertbl);
height =(select min(height)from usertbl);

--휴대폰이 있는 사용자 수
select count(*) from usertbl;

select count(mobile1) from usertbl;

-- select userid as "사용자 아이디",sum(price*amount) as "총 구매액"
from buytbl
group by userid;
having sum(price*amount)>1000; -- having절은 반드시 group by 다음에 와야 한다

--insert
create table testtbl1(
id number(4),
username nchar(3),
age number(2)
);
insert into testtbl1(1,'홍길동',25);
select * from testtbl1;
insert into testtbl1(id,username) values(2,'설현');
insert into testtbl1(username,age,id) values('지민',26,3);

create table testtbl2(
id number(4),
username nchar(3), --nation
age number(2)
nation nchar(4) default '대한민국'
);

create sequence idseq
start with 1
increment by 1;
    
select * from testtbl2;
    
drop sequence idseq;
    
insert into testtbl2 values(idseq.nextval,'유나',25,default);
insert into testtbl2 values(idseq.nextval,'혜정',24,'영국');
    
select*from testtbl2;
  
insert into testtbl2 values(11,'쯔위',18,'대만'); -- 강제
insert into testtbl2 values(idseq.nextval,'미나',21,'일본');
alter sequence idseq
    increment by 10;
    insert into testtbl2 values(idseq.nextval,'미나2',21,'일본');
    alter sequence idseq
        increment by 1;
    insert into testtbl2 values(idseq.nextval,'미나3',21,'일본');
    
select idseq.currval from dual; -- dual 가상 테이블
    
--대량 샘플
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
set phone='없음'
--where firstname='david';
where Firstname='David';

update testtbl5
set phone_number='없음';

ROLLBACK;
commit;

delete from testtbl4;
select * from tab;
rollback;

delete from testtbl4 where firstname='Peter';
rollback;

delete from testtbl4 where firstname='Peter' and rownum <=2;
select * from testtbl4 order by firstname;
rollback;

select * from testtbl4;
select * from testtbl4 where firstname='Peter';

truncate table testtbl4; -- truncate(자르다) : 롤백 해도 데이터가 복구되지 않는다.(이유 : 자동commit 되기때문)

select sysdate from dual; -- dual : 가상테이블(큰 의미는없다)
select to_char(sysdate,'yyyy/mm/dd hh:mi:ss') "현재 날짜" from dual;

select length('한글'),length('AB'),lengthb('한글'),lengthb('AB')from dual;

--select
--from
--where
--group by
--having
--order by


--순위 함수
select row_number()over(order by height desc) "키큰 순위",username,addr,height from usertbl;

--select username,addr,height
--from usertbl
--order by height desc;

select row_number()over(order by height desc,username asc) "키큰 순위",username,addr,height from usertbl;

commit;

select addr,row_number()over(partition by addr order by height desc,username asc) "지역별 키큰순위",username,addr,height from usertbl;-- partition 나누다

select rank()over(order by height desc) "키큰 순위",username,addr,height from usertbl;

--그룹분할,남는 인원은 다시 처음부터 채운다
select ntile(2) over(order by height desc)"반번호",username,addr,height from usertbl; -- 두갈래
select ntile(3) over(order by height desc)"반번호",username,addr,height from usertbl; -- 세갈래
select ntile(4) over(order by height desc)"반번호",username,addr,height from usertbl; -- 네갈래

--inner join --
--select <열 목록>
--from <첫 번째 테이블>
--    inner join<두 번째 테이블>
--    on <조인될 조건>
--where 검색 조건

-- 구매테이블 중에서 JYP라는 아이디를 가진 사람이 구매한 물건을 발송하기 위해서
-- 이름,주소,연락처 등을 조인해서 검색
select username,addr,mobile1,mobile2
from buytbl
    inner join usertbl
    on buytbl.userid=usertbl.userid;
--where buytbl.userid='jyp';

select *
from buytbl
    inner join usertbl
    on buytbl.userid=usertbl.userid;

select buytbl.userid,username,prodname,addr,mobile1||mobile2 as "연락처" -- 컬럼이 겹치면(userid) 오류가 난다.
from buytbl
    inner join usertbl
    on buytbl.userid=usertbl.userid;

-- 테이블 명 별칭 지정하기
select B.userid,U.username,B.prodname,U.addr,U.mobile1||U.mobile2 as "연락처"
from buytbl B
    inner join usertbl U
    on B.userid=U.userid;

select B.userid,U.username,B.prodname,U.addr,U.mobile1,U.mobile2 as "연락처"
from buytbl B
    inner join usertbl U
    on B.userid=U.userid
where B.userid='jyp';

--회원 테이블을 기준으로 JYP라는 아이디가 구매한 물건 목록
select U.userid,U.username,B.prodname,U.addr,U.mobile1,U.mobile2 as "연락처"
from usertbl U
    inner join buytbl B
    on U.userid=B.userid
where B.userid='jyp';

--전체 회원들이 구매한 목록을 모두 출력하되, 회원 아이디 순으로 정렬
select U.userid,U.username,B.prodname,U.addr,U.mobile1,U.mobile2 as "연락처"
from usertbl U
    inner join buytbl B -- inner join : 양쪽의 조건 모두 충족시켜야 조인,  outer join : 물건을 사지 않은사람까지 모두 포함시켜서 조인
    on U.userid=B.userid;
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
---------------------
create table stdtbl(
stdname nchar(5) not null primary key,
addr nchar(2) not null
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

insert into stdtbl values('김범수','경남');
insert into stdtbl values('성시경','서울');
insert into stdtbl values('조용필','경기');
insert into stdtbl values('은지원','경북');
insert into stdtbl values('바비킴','서울');

insert into clubtbl values('수영','101호');
insert into clubtbl values('바둑','102호');
insert into clubtbl values('축구','103호');
insert into clubtbl values('봉사','104호');

insert into stdclubtbl values(stdclubseq.nextval,'김범수','바둑');
insert into stdclubtbl values(stdclubseq.nextval,'김범수','축구');
insert into stdclubtbl values(stdclubseq.nextval,'조용필','축구');
insert into stdclubtbl values(stdclubseq.nextval,'은지원','축구');
insert into stdclubtbl values(stdclubseq.nextval,'은지원','봉사');
insert into stdclubtbl values(stdclubseq.nextval,'바비킴','봉사');

select * from clubtbl;
select * from stdclubtbl;
select * from stdtbl;

--학생 테이블, 동아리 테이블, 학생동아리 테이블을 이용해서 학생을 기준으로 학생이름,지역,
--가입한 동아리,방호수 조회 출력














