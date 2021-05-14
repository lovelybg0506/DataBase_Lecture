create table userTBL(
userid char(8) not null primary key, -- 사용자 아이디(Primary Key)
username nvarchar2(10) not null, -- 이름
birthyear number(4) not null, -- 출생년도
addr nchar(2) not null, -- 지역(경기,서울,경남 등등 2글자만 입력)
mobile1 char(3), -- 휴대폰의 국번(010,011,016,017,018,019)
mobile2 char(8), -- 휴대폰의 나머지 번호(하이픈 제외)
height number(3), -- 키
mdate date -- 회원 가입일
);

create table buyTBL(
idnum number(8) not null primary key, -- 순번(PK)
userid char(8) not null, -- 아이디 (FK)
prodname nchar(6) not null, -- 물품명
groupName nchar(4), -- 분류
price number(8) not null, -- 단가
amount number(3) not null, -- 수량
foreign key (userid) references usertbl(userid)

);