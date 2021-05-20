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

--지역이 '경남','전남','경북'인 사람의 정보 조회
select username,addr from usertbl where addr='경남' or addr='전남' or addr='경북';
select username,addr from usertbl where addr in('경남','전남','경북');

--문자열 내용 조회
select username,height from usertbl where username like '김%';
select username,height from usertbl where username like '_종신';

--'조용필','사용한 사람','이용해 줘서 감사합니다' (용이라는 문자가 모두 들어감)
select username,height from usertbl where username like '_용%';

--서브쿼리
select username,height from usertbl where height > 177;

select username,height 
from usertbl
where height > (select height from usertbl where username='김경호');

--지역이 '경남'인 사람의 키보다 키가 크거나 같은 사람 조회,서브쿼리
--ANY : 서브쿼리의 여러 개의 결과 중 한 개 미만 만족
--ALL : 서브쿼리의 여러 개의 결과를 모두 만족
--//(any: 조건의 결과 값이 두 개 이상일 경우,두 개 값을 모두 조건으로 해주겠다, or연산자 느낌)
--select username,height 
--from usertbl
--where height >= (select height from usertbl where addr='경남'); -- error

select username,height 
from usertbl
where height >= any(select height from usertbl where addr='경남'); -- or

select username,height 
from usertbl
where height >= all(select height from usertbl where addr='경남'); -- 키가 170보다 크거나 같아야 할 뿐만 아니라, 173보다 크거나 같아야 함

select username,height 
from usertbl
where height = any(select height from usertbl where addr='경남');

select username,height 
from usertbl
where height in(select height from usertbl where addr='경남');

--order by
select username,mdate from usertbl order by mdate; --ascending,오름차순
select username,mdate from usertbl order by mdate desc; --descending,내림차순

--키가 큰 순서로 정렬하되 만약 키가 같은 경우에 이름 순으로 정렬
select username,height from usertbl order by height desc,username asc;

--중복된 것은 하나만 남기는 distinct
select addr from usertbl; 
select addr from usertbl order by addr;
select distinct addr from usertbl;

--테이블 복사 create table...as select... primary key는 복사되지 않는다.
create table buytbl2 as (select * from buytbl);
select * from buytbl2;

create table buytbl3 as (select userid,prodname from buytbl);
select * from buytbl3;

--group by, 집계 함수 avg(),min(),max(),count(),sum()
select userid,amount from buytbl order by userid;

select userid,sum(amount) 
from buytbl
group by userid;

select userid as "사용자 아이디",sum(amount) as "총 구매 개수"
from buytbl
group by userid;

select userid as "사용자 아이디",sum(price) as "총 구매액"
from buytbl
group by userid;

select avg(amount) as "평균 구매 개수" from buytbl;

select cast(avg(amount) as number(5,3))as "평균 구매 개수" from buytbl;

select userid,cast(avg(amount) as number(5,3))as "평균 구매 개수" 
from buytbl
group by userid;

--usertbl에서 가장 큰 키와 가장 작은 키의 회원이름과 키를 조회
--select username,max(height),min(height) from usertbl
--group by username;

select username,height 
from usertbl 
where height =(select max(height)from usertbl) or
      height =(select min(height)from usertbl);

--휴대폰이 있는 사용자 수
select count(*) from usertbl;

select count(mobile1) as "휴대폰이 있는 사용자" from usertbl;

--총 구매액이 1000 이상인 사용자 조회
--select userid as "사용자 아이디",sum(price*amount) as "총 구매액"
--from buytbl 
--where sum(price*amount) >= 1000 -- 그룹 함수는 where절에서 사용 할 수 없다
--group by userid;

select userid as "사용자 아이디",sum(price*amount) as "총 구매액"
from buytbl 
group by userid
having sum(price*amount)>=1000; --having 절은 반드시 group by 다음에 와야 한다

--insert
create table testtbl1(
id number(4),
username nchar(3),
age number(2)
);

insert into testtbl1 values(1,'홍길동',25);
select * from testtbl1;
--insert into testtbl1 values(2,'설현'); --error
insert into testtbl1(id,username) values(2,'설현');
insert into testtbl1(username,age,id) values('지민',26,3);

create table testtbl2(
id number(4),
username nchar(3), --nation
age number(2),
nation nchar(4) default '대한민국'
);

create sequence idseq
    start with 1
    increment by 1;

drop sequence idseq;

insert into testtbl2 values(idseq.nextval,'유나',25,default);
insert into testtbl2 values(idseq.nextval,'혜정',24,'영국');

select * from testtbl2;

insert into testtbl2 values(11,'쯔위',18,'대만'); --강제
insert into testtbl2 values(idseq.nextval,'미나',21,'일본');
alter sequence idseq
    increment by 10;
insert into testtbl2 values(idseq.nextval,'미나2',21,'일본');
alter sequence idseq
    increment by 1;
insert into testtbl2 values(idseq.nextval,'미나2',21,'일본');

select idseq.currval from dual; --dual 가상 테이블 // 해당 시퀀스의 현재 값

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
-----------------------------------------------------
create table testtbl5 as 
(select employee_id,first_name,last_name,phone_number
from hr.employees);

select * from testtbl5;
select * from hr.employees;
select * from testtbl4 order by firstname;

select * from testtbl4 where firstname='David';

update testtbl4
set phone='없음'
--where firstname='david'; //error
WHERE Firstname='David';

update testtbl5
set phone_number='없음';

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

truncate table testtbl4; -- 데이터만 지운다. 자동 commit;

select sysdate from dual;
select to_char(sysdate,'yyyy/mm/dd hh:mi:ss') "현재 날짜" from dual;

select length('한글'),length('AB'),lengthb('한글'),lengthb('AB') from dual;

--순서
--select 
--from
--where
--group by
--having
--order by


--순위 함수
select row_number() over(order by height desc) "키 큰 순위" ,username,addr,height 
from usertbl;

--select username,addr,height 
--from usertbl
--order by height desc;

select row_number() over(order by height desc,username asc) "키 큰 순위" ,username,addr,height 
from usertbl;

commit;

--각 지역별 순위
select addr,row_number()over(partition by addr order by height desc, username asc) "지역별 키 큰 순위",
username,height
from usertbl;

--동일한 등수
select dense_rank()over(order by height desc) "키 큰 순위",username,addr,height
from usertbl;

select rank()over(order by height desc) "키 큰 순위",username,addr,height
from usertbl;

--그룹 분할, 남는 인원은 다시 처음부터 채운다
select ntile(2) over(order by height desc) "반 번호",username,addr,height from usertbl;
select ntile(3) over(order by height desc) "반 번호",username,addr,height from usertbl;
select ntile(4) over(order by height desc) "반 번호",username,addr,height from usertbl;

--inner join
--select <열 목록>
--from <첫 번째 테이블>
--    inner join <두 번째 테이블>
--    on <조인될 조건>
--where 검색 조건

--구매 테이블 중에서 JYP라는 아이디를 가진 사람이 구매한 물건을 발송하기
--이름,주소,연락처 등을 조인해서 검색

--select username,addr,mobile1,mobile2
--from buytbl
--    inner join usertbl
--    on buytbl.userid=usertbl.userid;
--where buytbl.userid='jyp';

select *
from buytbl
    inner join usertbl
    on buytbl.userid=usertbl.userid;

select buytbl.userid,username,prodname,addr,mobile1||mobile2 as "연락처"
from buytbl
    inner join usertbl
    on buytbl.userid=usertbl.userid;

select buytbl.userid,usertbl.username,buytbl.prodname,usertbl.addr,usertbl.mobile1||usertbl.mobile2 as "연락처"
from buytbl
    inner join usertbl
    on buytbl.userid=usertbl.userid;

--테이블 명 별칭
select B.userid,U.username,B.prodname,U.addr,U.mobile1||U.mobile2 as "연락처"
from buytbl B
    inner join usertbl U
    on B.userid=U.userid;

select B.userid,U.username,B.prodName,U.addr,U.mobile1,U.mobile2 as "연락처"
from buytbl B
    inner join usertbl U
    on B.userid=U.userid
where B.userid='jyp';

--회원 테이블을 기준으로 JYP라는 아이디가 구매한 물건 목록
select U.userid,U.username,B.prodName,U.addr,U.mobile1,U.mobile2 as "연락처"
from usertbl U
    inner join buytbl B
    on U.userid=B.userid
where B.userid='jyp';

--전체 회원들이 구매한 목록을 모두 출력하는데, 회원 아이디 순으로 정렬
select U.userid,U.username,B.prodName,U.addr,U.mobile1,U.mobile2 as "연락처"
from usertbl U
    inner join buytbl B -- outer join ( 조건에 속하지 않아도 출력)
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
select * from clubtbl;

--학생 테이블, 동아리 테이블, 학생 동아리 테이블을 이용해서 학생을 기준으로 학생이름,지역,
--가입한 동아리,방 호수 조회 출력
select S.stdname,S.addr,C.clubname,C.roomno
from stdtbl S
    inner join stdclubtbl SC
    on S.stdname=SC.stdname
    inner join clubtbl C
    on SC.clubname=C.clubname
order by S.stdname;

--학생 테이블, 동아리 테이블, 학생 동아리 테이블을 이용해서 동아리를 기준으로 학생이름,지역,
--가입한 동아리,방 호수 조회 출력
select C.clubname,C.roomno,S.stdname,S.addr
from stdtbl S
    inner join stdclubtbl SC
    on S.stdname=SC.stdname
    inner join clubtbl C
    on SC.clubname=C.clubname
order by C.clubname;

--outer join
select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "연락처"
from usertbl U
    left outer join buytbl B --왼쪽 테이블(usertbl)의 것은 모두 출력되어야 한다
    on U.userid=B.userid
order by U.userid;

select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "연락처"
from buytbl B
    right outer join usertbl U --오른쪽 테이블(buytbl)의 것은 모두 출력되어야 한다
    on U.userid=B.userid
order by U.userid;

select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "연락처"
from usertbl U
    right outer join buytbl B
    on U.userid=B.userid
order by U.userid;

select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "연락처"
from usertbl U
    left outer join buytbl B
    on U.userid=B.userid
    where B.prodname is not null
order by U.userid;

select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "연락처"
from usertbl U
    full outer join buytbl B
    on U.userid=B.userid
order by U.userid;

select S.stdname,S.addr,C.clubname,C.roomno
from stdtbl S
    left outer join stdclubtbl SC --outer 생략가능
    on S.stdname=SC.stdname
    left outer join clubtbl C
    on SC.clubname=C.clubname
order by S.stdname;

--동아리를 기준으로 출력하되 가입 학생이 하나도 없는 동아리도 출력
select C.clubname,C.roomno,S.stdname,S.addr
from stdtbl S
    left outer join stdclubtbl SC
    on SC.stdname=S.stdname
    right outer join clubtbl C
    on SC.clubname=C.clubname
order by S.stdname;

--동아리에 가입하지 않은 학생도 출력되고 학생이 한명도 없는 동아리도 출력 
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
union --중복제거 //전체적으로 오름차순 정렬
select clubname,roomno from clubtbl;

select stdname,addr from stdtbl
union all--중복포함
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

insert into sal values(001,'홍길동','개발부');
insert into sal values(002,'이순신','기획부');
insert into sal values(003,'세종대왕','총무부');

insert into depart values('A01','개발부');
insert into depart values('B01','기획부');
insert into depart values('C01','총무부');

select name,part from sal
union all
select num,dname from depart;

