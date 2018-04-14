delete from tbl_member where userid='prettykara';
insert into tbl_member (userid, userpw, username, email) values ('prettykara', '1111', '남상범', 'prettykara@gmail.com');

delete from tbl_board where bno='1';
insert into tbl_board (bno, title, content, writer) values (1, '타이틀1', '타이틀1 내용', 'prettykara');