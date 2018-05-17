alter table tbl_user
add column sessionkey varchar(50) not null default 'none';

alter table tbl_user
add column sessionlimit timestamp;