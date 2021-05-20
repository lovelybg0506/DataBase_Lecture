create table topic (
        id NUMBER NOT NULL, -- id값은 무조건 입력 되어야 한다.(NOT NULL의 효과)
        title VARCHAR2(50) NOT NULL, -- VARCHAR2 = 어떤길이의 문자가 들어올지 모른다면(가변적이라면)
        description VARCHAR2(4000), -- VARCHAR2는 최대 4000글자까지 수용가능하다.
        created DATE NOT NULL -- DATE 라는 오라클이 제공하는 날짜 데이터
);
INSERT INTO topic
        (id,title,description,created)
        VALUES
        (1,'ORACLE','ORACLE is ...', SYSDATE); -- SYSDATE : 현재시각을 알려준다
        
INSERT INTO topic
        (id,title,description,created)
        VALUES
        (2,'MySQL','MySQL is ...', SYSDATE);
        
INSERT INTO topic
        (id,title,description,created)
        VALUES
        (3,'SQL Server','SQL Server is ...', SYSDATE);

SELECT * FROM topic;

SELECT id, title, created FROM topic;

SELECT * FROM topic WHERE id = 1; -- id가 1인 행 을 select

SELECT * FROM topic WHERE id > 1;

SELECT id, title, created FROM topic WHERE id = 1;

SELECT * FROM topic ORDER BY id DESC; -- DESC = 큰숫자가 먼저 나오게한다 , ASC = 작은 숫자가 먼저 나오게 한다.

UPDATE topic  -- UPDATE : 수정
        SET
          title = 'MSSQL',
          description = 'MSSQL is...'
        WHERE
          id = 3;
          
commit; -- commit 은 실제로 데이터에 반영이 되게 하는 명령어.

DELETE FROM topic WHERE id = 3;

SELECT * FROM topic;

SELECT id, title, created FROM topic;

DROP TABLE topic; -- topic이라는 테이블 전체 삭제

create table topic (
        id NUMBER NOT NULL, -- id값은 무조건 입력 되어야 한다.(NOT NULL의 효과)
        title VARCHAR2(50) NOT NULL, -- VARCHAR2 = 어떤길이의 문자가 들어올지 모른다면(가변적이라면)
        description VARCHAR2(4000), -- VARCHAR2는 최대 4000글자까지 수용가능하다.
        created DATE NOT NULL, -- DATE 라는 오라클이 제공하는 날짜 데이터
        CONSTRAINT PK_TOPIC PRIMARY KEY(id) -- constraint : 제약조건(존재 하지 않은 값만 넣을 수 있게 만드는)
);
                                                        -- primary key를 사용하면 프로그램이 더욱 빠르게 찾을수있다.
INSERT INTO topic
        (id,title,description,created)
        VALUES
        (1,'ORACLE','ORACLE is ...', SYSDATE);
        
INSERT INTO topic
        (id,title,description,created)
        VALUES
        (2,'MySQL','MySQL is ...', SYSDATE); -- 아이디 부분이 1이라면, primary key 때문에 아이디가 1로 동일한 행이 있으므로 오류가 발생함.
        
INSERT INTO topic
        (id,title,description,created)
        VALUES
        (3,'SQL Server','SQL Server is ...', SYSDATE);

SELECT id,title FROM topic WHERE id = 2;

commit;

CREATE TABLE author(
id NUMBER NOT NULL,
name VARCHAR2(20) NOT NULL,
profile VARCHAR2(50),
CONSTRAINT PK_AUTHOR PRIMARY KEY(id)
);

CREATE SEQUENCE SEQ_AUTHOR;

INSERT INTO author (id,name,profile)VALUES(SEQ_AUTHOR.nextval,'egoing','developer');
INSERT INTO author (id,name,profile)VALUES(SEQ_AUTHOR.nextval,'duru','DBA');
INSERT INTO author (id,name,profile)VALUES(SEQ_AUTHOR.nextval,'taeho','data scientist');

ALTER TABLE TOPIC ADD(AUTHOR_ID NUMBER);

UPDATE TOPIC SET AUTHOR_ID='1' WHERE id = 1;
UPDATE TOPIC SET AUTHOR_ID='1' WHERE id = 1;
UPDATE TOPIC SET AUTHOR_ID='2' WHERE id = 2;
UPDATE TOPIC SET AUTHOR_ID='3' WHERE id = 3;

SELECT T.id TOPIC_ID,
        title,
        name 
FROM topic T
    LEFT JOIN author A 
    ON T.author_id = A.id
WHERE
    T.id = 1
;


























