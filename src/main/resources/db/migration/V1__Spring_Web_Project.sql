create table tbl_member (
	userid varchar(50) not null,
    userpw varchar(50) not null,
    username varchar(50) not null,
    email varchar(100) not null,
    regdate timestamp default now(),
    updatedate timestamp default now(),
    
    primary key(userid)
);

insert into tbl_member (userid, userpw, username, email) values ('prettykara', '1111', '남상범', 'prettykara@gmail.com');


create table tbl_board (
	bno INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    content TEXT NULL,
    writer VARCHAR(50) NOT NULL,
    regdate TIMESTAMP NOT NULL DEFAULT now(),
    updatedate TIMESTAMP NOT NULL DEFAULT now(),
    viencnt INT DEFAULT 0,
    
    primary key(bno)
);

insert into tbl_board (bno, title, content, writer) values (1, '타이틀1', '타이틀1 내용', 'prettykara');

commit;