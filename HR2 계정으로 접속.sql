create table freeboard (
    id number constraint PK_freeboard_id Primary key,   -- �ڵ� ���� �÷�
    name varchar2(10) not null,
    password varchar2(100) null,
    email varchar2(100) null,
    subject varchar2(100) not null,     -- �� ����
    content varchar2(2000) not null,    -- �� ����
    inputdate varchar2(100)not null,    -- �� �� ��¥
    masterid number default 0 ,         -- ���� �亯�� �Խ��ǿ��� �亯�� ���� �׷��� �� �� ���
    readcount number default 0,         -- �� ��ȸ��
    replaynum number default 0,         
    step number default 0
    );
    


-- �亯���� �����ϴ� ���̺��� ��� �� �� , ������ ���ؼ� �����;� �Ѵ�.
select * from freeboard
order by masterid desc, replaynum, step, id;

-- id �÷� : ���ο� ���� ��� �� �� ������ id�÷��� �ִ밪�� �����ͼ� +1 <= �� �� ��ȣ�� �ѹ���.
-- �亯���� ó���ϴ� �÷��� 3�� �ʿ��ϴ�. (masterid, replayNum, step)

-- masterid     : ���� �亯�� ���� �׷��� , id �÷��� ���� �״�� �� ���, �亯���� �ƴϴ�. ó����
-- replayNum    : 
-- step         :


select * from freeboard;
delete freeboard;
commit;    
INSERT INTO freeboard (id, name, password, email, subject,
        content,
        inputdate, masterid, readcount, replaynum, step)
values (1,'ȫ�浿','1234','ccc@ccc.com','ù��° �� �Դϴ�.',
    'ù ��° ���� �Դϴ�. �� ���� �Դϴ�. �� ���� 2 �Դϴ�.',
    '22-05-11 11:52 ����',1,0,0,0);
		
