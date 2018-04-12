# springWebProject_2nd
코드로 배우는 스프링 웹 프로젝트

[Part 1]
create table tbl_member (
	userid varchar(50) not null,
    userpw varchar(50) not null,
    username varchar(50) not null,
    email varchar(100) not null,
    regdate timestamp default now(),
    updatedate timestamp default now(),
    
    primary key(userid)
);