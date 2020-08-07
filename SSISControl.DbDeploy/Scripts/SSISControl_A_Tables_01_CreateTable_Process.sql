/*
SSISControl_A_Tables_01_CreateTable_Process
*/
use SSISControl
go

if exists(select name from sysobjects where name = 'Process')
	drop table Process

create table Process
(
	  ProcessCode	varchar(20) not null
	, ProcessName	varchar(50)	not null
	, constraint PK_Process primary key clustered
	(
		  ProcessCode
	)
)