create table userTBL(
userid char(8) not null PRIMARY KEY, --사용자 아이디(pk)
username NVARCHAR2(10) not null, --이름
birthyear number(4) not null, --출생년도
addr NCHAR(2) not null, --지역(경기,서울,경남 등등 2글자만 입력)
mobile1 char(3),--휴대폰의 국번(010,016,017,018,019)
mobile2 char(8),--휴대폰의 나머지 번호(하이픈 제외)
height number(3),--키
mdate date --회원 가입일
);

create table buyTBL(
idnum number(8) not null primary key,--순번(PK)
userid char(8) not null,--아이디(FK)
prodname nchar(6) not null,--물품명
groupName nchar(4),--분류
price number(8) not null,--단가
amount number(3) not null,--수량
FOREIGN key (userid) REFERENCES usertbl(userid)
);

commit;

insert into usertbl values('lsg','이승기',1987,'서울','011','11111111',182,'2000-8-8');
insert into usertbl values('kbs','김범수',1979,'경남','011','22222222',173,'2012-4-4');
insert into usertbl values('kkh','김경호',1971,'전남','019','33333333',177,'2007-7-7');
insert into usertbl values('jyp','조용필',1950,'경기','011','44444444',166,'2009-4-4');
insert into usertbl values('ssk','성시경',1979,'서울',null,null,186,'2013-12-12');
insert into usertbl values('ljb','임재범',1963,'서울','016','66666666',182,'2009-9-9');
insert into usertbl values('yjs','윤종신',1969,'경남',null,null,170,'2005-5-5');
insert into usertbl values('ejw','은지원',1972,'경북','011','88888888',174,'2014-3-3');
insert into usertbl values('jkw','조관우',1965,'경기','018','99999999',172,'2010-10-10');
insert into usertbl values('bbk','바비킴',1973,'서울','010','00000000',176,'2013-5-5');

create SEQUENCE idseq;
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

select*from usertable;
select*from buytbl;

-- 김경호
select * from usertbl where username='김경호';

--1970년 이후에 출생하고 신장이 182 이상인 사람의 아이디와 이름 조회
select userid,username from usertbl where birthyear >=1970 and height >=182;

--1970년 이후에 출생했거나 신장이 182 이상인 사람의 아이디와 이름 조회
select userid,username from usertbl where birthyear >=1970 or height >=182;

--키가 180~183인 사람 조회
select username,height from usertbl where height >= 180 and height <=183;
select username,height from usertbl where height between 180 and 183;

--지역이 '경남','전남','경북'인 사람의 정보 조회
select userName,addr from usertbl where addr='경남' or addr='전남' or addr='경북';
select userName,addr from usertbl where addr in('경남','전남','경북');

--문자열 내용 조회
select userName,height from usertbl where username like '김%';
select userName,height from usertbl where username like '_종신';

--'조용필','사용한 사람','이용해 줘서 감사합니다'
select userName,height from usertbl where username like '_용%';

--서브쿼리
select username,height from usertbl where height > 177;

select username,height
from usertbl
where height > (select height from usertbl where username='김경호');

--지역이 '경남'사람의 키보다 키가 크거나 같은 사람 조회,서브쿼리
--ANY:서브쿼리의 여러 개의 결과 중 한가지만 만족
--ALL:서브쿼리의 여러 개의 결과를 모두 만족

--select username,height
--from usertbl
--where height >=(select height from usertbl where addr='경남');--error

select username,height
from usertbl
where height >= any(select height from usertbl where addr='경남');--or

select username,height
from usertbl
where height >= all(select height from usertbl where addr='경남');
--키가 170보다 크거나 같아야 할 뿐만 아니라, 173보다 크거나 같아야 한다. 결국 키가 173보다 크거나 같은 사람만 해당

select username,height
from usertbl
where height = any(select height from usertbl where addr='경남');

select username,height
from usertbl
where height in(select height from usertbl where addr='경남');

--order by 순서
select username,mdate from usertbl order by mdate;--ascending,오름차순
select username,mdate from usertbl order by mdate desc;--descendrin,내림차순

--키가 큰 순서로 정렬하되 만약 키가 같을 경우에 이름 순으로 정렬
select username,height from usertbl order by height desc, username asc;

--중복된 것은 하나만 남기는 distinct
select addr from usertbl;
select addr from usertbl order by addr;
select distinct addr from usertbl; --주소중복을 유저테이블에서 제거

--테이블 복사 create table...as select...primary key는 복사 되지 않는다.
create table buytbl2 as (select*from buytbl);
select*from buytbl2;

create table buytbl3 as (select userid,prodname from buytbl);
select*from buytbl3;

--group by,집계 함수 avg(),min(),max(),count()
select userid,amount from buytbl order by userid;

select userid,sum(amount)
from buytbl
group by userid;

select userid as "사용자 아이디",sum(amount) as "총 구매 개수"--컬럼제목바꿈
from buytbl
group by userid;

select userid as "사용자 아이디",sum(price*amount) as "총 구매액"
from buytbl
group by userid;

select avg(amount) as "평균 구매 개수" from buytbl;

select cast(avg(amount) as number(5,3))as "평균 구매 개수"from buytbl;

select userid, cast(avg(amount) as number(5,3))as "평균 구매 개수"
from buytbl
group by userid;

commit;

--가장 큰 키와 가장 작은 키의 회원이름과 키를 조회
--select username,max(height),min(height) from usertbl
--group by username;

select username,height
from usertbl
where height = (select max(height)from usertbl) or
      height = (select min(height)from usertbl);
      
--휴대폰이 있는 사용자 수
select count(*) from usertbl;

select count(mobile1) from usertbl;

--총 구매액이 1000 이상인 사용자 조회
--select userid as "사용자 아이디",sum(price*amount) as "총 구매액"
--from buytbl
--where sum(price*amount) >= 1000 --그룹함수는 where절에서 사용할 수 없다
--group by userid;

select userid as "사용자 아이디",sum(price*amount) as "총 구매액"
from buytbl
where usdrid
group by sum(price*amount) >= 1000 --having 절은 반드시 group by 다음에 와야한다

--insert
create table testtbl1(
id number(4),
username nchar(3),
age number(2)
);

insert into testtbl1 values(1,'홍길동',25);
select*from testtbl1;
--insert into testtbl1 values(2,'설현'); --error
insert into testtbl1(id,username) values(2,'설현');
insert into testtbl1(username,age,id) values('지민',26,3);

create table testtbl2(
id number(4),
username nchar(3),--nation
age number(2),
nation nchar(4) default'대한민국'
);

create sequence idseq
   start with 1
   increment by 1;
      
drop sequence idseq;

select*from testtbl2;

insert into testtbl2 values(idseq.nextval,'유나',25,default);
insert into testtbl2 values(idseq.nextval,'혜정',24,'영국');

select*from testtbl2;

insert into testtbl2 values(11,'쯔위',18,'대만');--강제
insert into testtbl2 values(idseq.nextval,'미나',21,'일본');
alter sequence idseq
   increment by 10;
insert into testtbl2 values(idseq.nextval,'미나2',21,'일본');
alter sequence idseq
   increment by 1;
insert into testtbl2 values(idseq.nextval,'미나3',21,'일본');

select idseq.currval from dual; --dual 가상 테이블 

--
create table testtbl4(
empid number(6),
firstname varchar2(20),
lastname varchar2(25),
phone varchar2(20)
);

--대량샘플
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
set phone='없음'
--where firstname='david';
WHERE Firstname='David';--대문자

update testtbl5
set phone_number='없음';

rollback;
commit;

delete from testtbl4;
select*from tab;
rollback;

delete from testtbl4 where firstname='pater';
rollback;

delete from testtbl4 where firstname='peter' and rownum <= 2;
select*from testtbl4 order by firstname;
rollback;--마지막 저장한곳까지 롤백

select*from testtbl4;
select*from testtbl4 where firstname='peter';

truncate table testtbl4;--데이터만 지운다. 자동commit;

select sysdate from dual;
select to_char(sysdate,'yyyy/mm/dd hh:mi:ss') "현재 날짜" from dual;

select length('한글'),length('AB'),lengthb('한글'),lengthb('AB')from dual;

--select
--from
--where
--group by
--having
--order by

--순위 함수
select row_number()over(order by height desc) "키큰 순위",username,addr,height 
from usertbl;

--select username,addr,height
--from usertbl
--order by height desc;

select row_number()over(order by height desc,username asc) "키큰 순위",username,addr,height 
from usertbl;

commit;

select addr,row_number() over(partition by addr order by height desc,username asc) "지역별 키큰순위",
username,addr,height
from usertbl;

--그룹 분할,남는 인원은 다시 처음부터 채운다
select ntile(2) over(order by height desc)"반번호",username,addr,height from usertbl;
select ntile(3) over(order by height desc)"반번호",username,addr,height from usertbl;
select ntile(4) over(order by height desc)"반번호",username,addr,height from usertbl;

--inner join
--select <열 목록>
--from <첫 번째 테이블>
--   inner join<두 번째 테이블>
--   on <조인될 조건>
--where 검색 조건

--구매 테이블 중에서 jyp라는 아이디를 가진 사람이 구매한 물건을 발송하기 위해서
--이름,주소,연락처 등을 조인해서 검색
--select username,addr,mobilel,mobile2
--from buytbl
--   inner join usertbl
--   on buytbl.userid=usertbl.userid --buytbl에있는 userid와usertbl에있는userid가같냐
----where buytbl.userid='jyp';

select * 
from buytbl
   inner join usertbl
   on buytbl.userid=usertbl.userid;

select buytbl.userid,username,prodname,addr,mobile1|| mobile2 as "연락처"
from buytbl
   inner join usertbl
   on buytbl.userid=usertbl.userid;
   
select buytbl.userid,usertbl.username,buytbl.prodname,usertbl.addr,usertbl.mobile1|| usertbl.mobile2 as "연락처"
from buytbl
   inner join usertbl
   on buytbl.userid=usertbl.userid;
   
select B.userid,U.username,B.prodname,U.addr,U.mobile1|| U.mobile2 as "연락처"
from buytbl B
   inner join usertbl U
   on B.userid=U.userid;
   
select B.userid,U.username,B.prodname,U.addr,U.mobile1|| U.mobile2 as "연락처"
from buytbl B
   inner join usertbl U
   on B.userid=U.userid
where B.userid='jyp';

--회원 테이블을 기준으로 jyp라는 아이디가 구매한 물건 목록
select U.userid,U.username,B.prodname,U.addr,U.mobile1|| U.mobile2 as "연락처"
from usertbl U
   inner join buytbl B
   on U.userid=B.userid
where B.userid='jyp';

--전체 회원들이 구매한 목록을 모두 출력하는데 회원 아이디 순으로 정렬
select U.userid,U.username,B.prodname,U.addr,U.mobile1|| U.mobile2 as "연락처"
from usertbl U
   inner join buytbl B --양쪽다해당되는사람,조건만족 안하지만 전체:outer join
   on U.userid=B.userid
   order by U.userid;
--where B.userid='jyp';

select U.userid,U.username,U.addr
from usertbl U
   inner join buytbl B
   on U.userid=B.userid --물건을 산사람
   order by U.userid;

select U.userid,U.username,U.addr
from usertbl U
where exists(select * from buytbl B where U.userid=B.userid); --두테이블아이디가같으면 B테이블에잇는것조회
--exists:조건에맞게 조회후 중복되는 코드는제외하고 보여줌

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

select*from clubtbl;
select*from stdclubtbl;
select*from stdtbl;

--학생 테의블,동아리 테이블,학생 동아리 테이블을 이용해서 학생을 기준으로 학생이름,지역,
--가입한 동아리,방 호수 조회 출력
select S.stdname,S.addr,C.clubname,C.roomno
from stdtbl S
   inner join stdclubtbl SC
   on S.stdname=Sc.stdname
   inner join clubtbl C
   on SC.clubname=C.clubname
order by S.stdname;

--학생 테의블,동아리 테이블,학생 동아리 테이블을 이용해서 동아리를 기준으로 학생이름,지역,
--가입한 동아리,방 호수 조회 출력
select C.clubname,C.roomno,S.stdname,S.addr
from stdtbl S
   inner join stdclubtbl SC
   on S.stdname=Sc.stdname
   inner join clubtbl C
   on SC.clubname=C.clubname
order by C.clubname;

--outer join
select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "연락처"
from usertbl U
   left outer join buytbl B --왼쪽테이블(usertbl)의 것은 모두 출력되어야 한다
   on U.userid=B.userid
order by U.userid;

select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "연락처"
from  buytbl B 
   right outer join usertbl U--오른쪽테이블(buytbl)의 것은 모두 출력되어야 한다
   on U.userid=B.userid
order by U.userid;

select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "연락처"
from usertbl U
   right outer join buytbl B 
   on U.userid=B.userid
order by U.userid;

--물건 안산사람 제외
select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "연락처"
from usertbl U
   left outer join buytbl B --왼쪽테이블(usertbl)의 것은 모두 출력되어야 한다
   on U.userid=B.userid
   where B.prodname is not null
order by U.userid;

select U.userid,U.username,B.prodname,U.addr,U.mobile1 || U.mobile2 as "연락처"
from usertbl U
   full outer join buytbl B --양쪽조건해당되는것 모두 출력
   on U.userid=B.userid
order by U.userid;

--학생테이블위주로 처리
select S.stdname,S.addr,C.clubname,C.roomno
from stdtbl S
   left outer join stdclubtbl SC
   on S.stdname=SC.stdname
   left outer join clubtbl C
   on SC.clubname=C.clubname
order by S.stdname;

--동아리를 기준으로 출력하되 가입 학생이 하나도 없는 동아리도 출력
select C.clubname,C.roomno,S.stdname,S.addr
from stdtbl S
   left outer join stdclubtbl SC --두테이블조인
   on SC.stdname=S.stdname --조인조건:
   right outer join clubtbl C
   on SC.clubname=C.clubname
order by S.stdname;

--동아리에 가입하지 않은 학생도 출력되고 학생이 한명도 없는 동아리도 출력
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
union --중복제거
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

insert into sal values('001','홍길동','개발부');
insert into sal values('002','이순신','기획부');
insert into sal values('003','세종대왕','총무부');

insert into depart values('0001','개발부','서울');
insert into depart values('0002','기획부','부산');
insert into depart values('0003','총무부','인천');
--코드가같으면 한개만나옴, 다르면 다나옴
select name,part from sal
union 
select num,dname from depart;

commit;

--usertbl에서 (전화기가 없는 사람) 제외하고 조회
select username,concat(mobile1,mobile2) as "전화번호" from usertbl
where username not in (select username from usertbl where mobile1 is null);

--usertbl에서 전화기가 없는 사람 조회
--select username,concat(mobile1,mobile2) as "전화번호" from usertbl
--where mobile1 is null;
select username,concat(mobile1,mobile2) as "전화번호" from usertbl
where username in (select username from usertbl where mobile1 is null);

--procedu Language SQL
--set serveroutput on;
declare
    var1 number(5); --변수선언
begin
   var1:=100; --값을줌(대입)
   if var1=100 then --var1이 100이냐
       dbms_output.put_line('100입니다');
   else
       dbms_output.put_line('100이 아닙니다');
   end if;
end;

declare
  hiredate date;
  curdate date;
  wdays number(5);
  
begin
    select hire_date into hiredate --입사날짜
    from HR.employees
    where employee_id=200;
    curdate:=current_date(); --현재날짜
    wdays:=curdate-hiredate; --현재시간
    if(wdays/365) >= 5 then
        dbms_output.put_line('입사한지'||wdays||'일이나 지났습니다. 축하합니다!');
    else
        dbms_output.put_line('입사한지'||wdays||'일밖에 안되었네요. 열심히 일하세요');
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
    dbms_output.put_line('취득점수==>'||pnumber||',학점==>'||credit);
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
    dbms_output.put_line('취득점수==>'||pnumber||',학점==>'||credit);
end;

--buytbl에서 구매액(price*amount)이 1500원 이상인 고객은 '최우수 고객','1000원 이상인
--고객은 '우수고객',1원 이상은 고객은 '일반고객'으로 출력, 또한 전혀구매 실적이 없는
--고객은 '유령고객'이라고 출력
--buytbl에서 구매액(price*amount)을 사용자 아이디(userid)별로 그룹화한다. 또한 구매액이
--높은 순으로 정렬한다
select userid,sum(price*amount) as "총 구매액"
from buytbl 
group by userid
order by sum(price*amount) desc;

--usertbl과 조인해서 사용자 이름도 출력
select B.userid,U.username,sum(price*amount) as "총 구매액"
from buytbl B
    inner join usertbl U
    on B.userid=U.userid 
group by B.userid,U.username
order by sum(price*amount) desc;

--구매하지 않은 고객의 명단도 포함 출력
select B.userid,U.username,sum(price*amount) as "총 구매액"
from buytbl B
    right outer join usertbl U
    on B.userid=U.userid 
group by B.userid,U.username
order by sum(price*amount) desc nulls last;

--구매하지 않은 고객의 userid 출력
select U.userid,U.username,sum(price*amount) as "총 구매액"
from buytbl B
    right outer join usertbl U
    on B.userid=U.userid 
group by U.userid,U.username
order by sum(price*amount) desc nulls last;

select U.userid,U.username,sum(price*amount) as "총 구매액",
    case
        when(sum(price*amount)>= 1500) then '최우수고객'
        when(sum(price*amount)>= 1000) then '우수고객'
        when(sum(price*amount)>= 1) then '일반고객'
       else '유령고객'
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
        if mod(inum,7)=0 then --어떤수를 7로나눳을때 0과같냐
        inum:=inum+1; --나머지에+1
        continue; --다시반복문으로
        end if;
        hap:=hap+inum;
        if hap>1000 then
               exit;
           end if;
           inum:=inum+1;
        end loop;
        dbms_lock.sleep(5); --5초
        dbms_output.put_line(hap);
        dbms_output.put_line('5초간 멈춘 후 진행되었음');
end;

--Exception Handling
declare
      --테이블 열의 데이터 타입과 동일하게 변수 타입을 설정
    v_username usertbl.username%TYPE; --v_username이런 변수이름으로 쓰겟다
begin
    select username into v_username from usertbl
    where username like('김%');
     dbms_output.put_line('김씨 고객 이름은'||v_username||'입니다');
     exception
        when no_data_found then --데이터를 못찾을경우
            dbms_output.put_line('김씨 고객이 없습니다');
        when too_many_rows then --너무많을 경우
        dbms_output.put_line('김씨 고객이 너무 많네요');
 end;
 
--사용자 정의 예외처리
declare
      --테이블 열의 데이터 타입과 동일하게 변수 타입을 설정
    v_username usertbl.username%TYPE; --v_username이런 변수이름으로 쓰겟다
    userexception exception;
    pragma exception_init(userexception,-1422); --예외 등록,-1422:2개이상 행을 반환할때
begin
    select username into v_username from usertbl
    where username like('김%');
     dbms_output.put_line('김씨 고객 이름은'||v_username||'입니다');
     exception
        when no_data_found then --데이터를 못찾을경우
            dbms_output.put_line('김씨 고객이 없습니다');
        when too_many_rows then --너무많을 경우
        dbms_output.put_line('김씨 고객이 너무 많네요');
 end;
 --------------------------------------------------------------------
 declare
     v_username usertbl.username%type;
     zerodelete exception;
begin
     v_username:='무명씨';
     delete from usertbl where username=v_username;
     if sql%notfound then
          raise zerodelete;
        end if;
        exception
          when zerodelete then
            dbms_output.put_line(v_username||'데이터 없음. 확인 바랍니다^^');
end;





































