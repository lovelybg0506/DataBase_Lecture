create table topic (
        id NUMBER NOT NULL, -- id���� ������ �Է� �Ǿ�� �Ѵ�.(NOT NULL�� ȿ��)
        title VARCHAR2(50) NOT NULL, -- VARCHAR2 = ������� ���ڰ� ������ �𸥴ٸ�(�������̶��)
        description VARCHAR2(4000), -- VARCHAR2�� �ִ� 4000���ڱ��� ���밡���ϴ�.
        created DATE NOT NULL -- DATE ��� ����Ŭ�� �����ϴ� ��¥ ������
);
INSERT INTO topic
        (id,title,description,created)
        VALUES
        (1,'ORACLE','ORACLE is ...', SYSDATE); -- SYSDATE : ����ð��� �˷��ش�
        
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

SELECT * FROM topic WHERE id = 1; -- id�� 1�� �� �� select

SELECT * FROM topic WHERE id > 1;

SELECT id, title, created FROM topic WHERE id = 1;

SELECT * FROM topic ORDER BY id DESC; -- DESC = ū���ڰ� ���� �������Ѵ� , ASC = ���� ���ڰ� ���� ������ �Ѵ�.

UPDATE topic  -- UPDATE : ����
        SET
          title = 'MSSQL',
          description = 'MSSQL is...'
        WHERE
          id = 3;
          
commit; -- commit �� ������ �����Ϳ� �ݿ��� �ǰ� �ϴ� ��ɾ�.

DELETE FROM topic WHERE id = 3;

SELECT * FROM topic;

SELECT id, title, created FROM topic;

DROP TABLE topic; -- topic�̶�� ���̺� ��ü ����

create table topic (
        id NUMBER NOT NULL, -- id���� ������ �Է� �Ǿ�� �Ѵ�.(NOT NULL�� ȿ��)
        title VARCHAR2(50) NOT NULL, -- VARCHAR2 = ������� ���ڰ� ������ �𸥴ٸ�(�������̶��)
        description VARCHAR2(4000), -- VARCHAR2�� �ִ� 4000���ڱ��� ���밡���ϴ�.
        created DATE NOT NULL, -- DATE ��� ����Ŭ�� �����ϴ� ��¥ ������
        CONSTRAINT PK_TOPIC PRIMARY KEY(id) -- constraint : ��������(���� ���� ���� ���� ���� �� �ְ� �����)
);
                                                        -- primary key�� ����ϸ� ���α׷��� ���� ������ ã�����ִ�.
INSERT INTO topic
        (id,title,description,created)
        VALUES
        (1,'ORACLE','ORACLE is ...', SYSDATE);
        
INSERT INTO topic
        (id,title,description,created)
        VALUES
        (2,'MySQL','MySQL is ...', SYSDATE); -- ���̵� �κ��� 1�̶��, primary key ������ ���̵� 1�� ������ ���� �����Ƿ� ������ �߻���.
        
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


























