alter table Evidence
modify url varchar(500) NULL;

alter table Evidence
add isbn varchar(13) null after url;



 