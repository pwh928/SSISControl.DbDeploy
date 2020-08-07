/*
SSISControl_A_Tables_04_CreateTable_ProcessPackageLog
*/
use SSISControl
go

if exists(select name from sysobjects where name = 'ProcessPackageLog')
	drop table ProcessPackageLog

create table ProcessPackageLog
(
	  LogID					int		identity(1,1)		not null
	, ProcessInstanceID		int							not null
	, ProcessCode			varchar(20)					not null
	, PackageName			varchar(100)				not null
	, IsFailure				bit							not null	constraint DF_ProcessPackageLog_IsFailure		default(0)
	, PackageStart			datetime					not null	constraint DF_ProcessPackageLog_PackageStart	default getdate()
	, PackageEnd			datetime					not null 
	, constraint PK_ProcessPackageLog primary key clustered (LogID)
	, constraint FK_ProcessInstance_ProcessPackageLog foreign key (ProcessInstanceID) references ProcessInstance(ProcessInstanceID)
	, constraint FK_ProcessI_ProcessPackageLog foreign key (ProcessCode) references Process(ProcessCode)
)