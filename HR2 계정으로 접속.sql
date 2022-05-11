create table freeboard (
    id number constraint PK_freeboard_id Primary key,   -- 자동 증가 컬럼
    name varchar2(10) not null,
    password varchar2(100) null,
    email varchar2(100) null,
    subject varchar2(100) not null,     -- 글 제목
    content varchar2(2000) not null,    -- 글 내용
    inputdate varchar2(100)not null,    -- 글 쓴 날짜
    masterid number default 0 ,         -- 질문 답변형 게시판에서 답변의 글을 그룹핑 할 때 사용
    readcount number default 0,         -- 글 조회수
    replaynum number default 0,         
    step number default 0
    );
    


-- 답변글이 존재하는 테이블을 출력 할 때 , 정렬을 잘해서 가져와야 한다.
select * from freeboard
order by masterid desc, replaynum, step, id;

-- id 컬럼 : 새로운 글이 등록 될 때 기존의 id컬럼의 최대값을 가져와서 +1 <= 새 글 번호의 넘버링.
-- 답변글을 처리하는 컬럼이 3개 필요하다. (masterid, replayNum, step)

-- masterid     : 글의 답변에 대한 그룹핑 , id 컬럼의 값이 그대로 들어간 경우, 답변글이 아니다. 처음글
-- replayNum    : 
-- step         :


select * from freeboard;
delete freeboard;
commit;    
INSERT INTO freeboard (id, name, password, email, subject,
        content,
        inputdate, masterid, readcount, replaynum, step)
values (1,'홍길동','1234','ccc@ccc.com','첫번째 글 입니다.',
    '첫 번째 내용 입니다. 글 내용 입니다. 글 내용 2 입니다.',
    '22-05-11 11:52 오전',1,0,0,0);
		
