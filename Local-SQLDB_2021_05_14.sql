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
