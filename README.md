# DataBase_Lecture
(Oracle)

<pre>

<h2>데이터베이스 기본용어</h2>
Database(데이터베이스) : 저장소에 구분되는 가장 큰 단위.
Table(테이블) : 데이터베이스에 뭔가를 저장하기 위해 첫 단계에서 만드는 테이블 ( 쉽게 '표'라고 생각하자 )
Column(컬럼) : 관계형 데이터베이스에서 행(레코드)를 분류하는 기준. ( 표에서의 각 행에 들어갈 데이터들의 이름 ?)
Row(행) : 데이터를 저장하는 값으로, 컬럼(필드) 내의 단 하나의 값. (표 한줄)

<hr>

<h2>오라클 기타 명령문</h2>
<h4>오라클 버전 확인</h4>
select * from v$version
sqlplus
SELECT * FROM v$version WHERE banner LIKE 'Oracle%';

<h4>데이터베이스 관리 권한으로 접속</h4>
sqlplus
sqlplus / as sysdba
sqlplus system/1234 < 이 방법은 비밀번호 노출로 인해 권장하지는 않는다

<h4>sql 접속 후 다른 계정으로 접속하기 (로그인한 상태에서 다른 계정으로 로그인 하는것)</h4>
conn scott/tiger
connect sys/as sysdba

<h4>sql 화면 지우기</h4>
clear screen

<h4>포트번호 알아보기</h4>
select dbms_xdb.gethttpport() from dual;

<h4>포트번호 바꾸기</h4>
exec dbms_xdb.sethttpport(9090);

<h4>auto commit을 켜기</h4>
set autocommit on;

<h4>auto commit을 끄기</h4>
set autocommit off;

<h4>auto commit의 on/off 여부 확인</h4>
show autocommit;

<hr>

<h2>오라클 시퀀스 명령어</h2>
(시퀀스 = 쉽게설명하면 index값 자동설정??)

<h4>시퀀스의 현재 값을 확인</h4>
SELECT LAST_NUMBER FROM USER_SEQUENCES WHERE SEQUENCE_NAME = 'seq_board';

<h4>시퀀스의 INCREMENT를 현재 값만큼 빼도록 설정(아래는 현재값이 999999일 경우)</h4>
ALTER SEQUENCE seq_board INCREMENT BY -999999;

<h4>시퀀스에서 다음 값을 가져온다</h4>
SELECT seq_board.NEXTVAL FROM DUAL;

<h4>현재 값을 확인 해보면 -999999 만큼 증가했다</h4>
SELECT seq_board.CURRVAL FROM DUAL;

<h4>시퀀스의 INCREMENT를 1로 설정한다</h4>
ALTER SEQUENCE seq_board INCREMENT BY 1;

<h4>오라클 시퀀스 조회(검색)</h4>
select * from user_sequences

<h4>--시퀀스 검색(현재 계정의 모든 시퀀스를 보여줌)--</h4>
SELECT SEQUENCE_NAME, MIN_VALUE, MAX_VALUE, INCREMENT_BY, CYCLE_FLAG
FROM USER_SEQUENCES;

<h4>--시퀀스 삭제--</h4>
DROP SEQUENCE seq_board;

<h4>--시퀀스 생성--</h4>
CREATE SEQUENCE seq_board
START WITH 1 -- 시작값
INCREMENT BY 1 -- 증가값
MAXVALUE 10000 -- 최대값
MINVALUE 1 -- 최소값
NOCYCLE; -- 최대값이 됐을때 다시 시작값으로 돌아갈 것인지의 순환여부 ( 순환 시킬것이라면 CYCLE; )




</pre>
