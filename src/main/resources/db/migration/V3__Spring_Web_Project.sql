create table tbl_reply ( 
	rno INT NOT NULL AUTO_INCREMENT, 
	bno INT NOT NULL default 0, 
	replytext varchar(1000) NOT NULL, 
	replyer varchar(50) NOT NULL, 
	regdate timestamp NOT NULL default now(), 
	updatedate timestamp NOT NULL default now(), 
	primary key(rno) 
);

alter table tbl_reply 
	add constraint fk_board 
	foreign key (bno) references tbl_board(bno);