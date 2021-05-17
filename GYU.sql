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














