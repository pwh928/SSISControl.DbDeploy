/*
SSISControl_A_Tables_03_CreateTable_ProcessPackageControl
*/
use SSISControl
go

if exists(select name from sysobjects where name = 'ProcessPackageControl')
	drop table ProcessPackageControl

create table ProcessPackageControl
(
	  ProcessCode			varchar(20)					not null
	, PackageName			varchar(100)				not null
	, PackageFullPath		varchar(255)				not null
	, RunOrder				int							not null
	, IsEnabled				bit							not null
	, constraint PK_ProcessPackageControl primary key clustered
	(
		  ProcessCode
		, PackageName
	)
	, constraint FK_Process_ProcessPackageControl foreign key (ProcessCode) references Process(ProcessCode) on delete cascade
)