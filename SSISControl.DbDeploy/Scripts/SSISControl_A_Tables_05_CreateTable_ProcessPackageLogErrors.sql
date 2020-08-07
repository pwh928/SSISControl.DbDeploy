/*
SSISControl_A_Tables_05_CreateTable_ProcessPackageLogErrors
*/
use SSISControl
go

if exists(select name from sysobjects where name = 'ProcessPackageLogErrors')
	drop table ProcessPackageLogErrors

create table ProcessPackageLogErrors
(
	  ErrorID			int			identity(1,1)		not null
	, LogID				int								not null
	, ProcessCode		varchar(20)						not null
	, PackageName		varchar(100)					not null
	, ErrorDescription	varchar(max)					not null
	, ErrorDate			datetime						not null	constraint DF_ProcessPackageLogErrors_ErrorDate default getdate()
	, constraint PK_ProcessPackageLogErrors primary key clustered
	(
		  ErrorID
		, LogID
	)
	, constraint FK_ProcessPackageLog_ProcessPackageLogErrors foreign key (LogID) references ProcessPackageLog(LogID) on delete cascade
	, constraint FK_Process_ProcessPackageLogErrors foreign key (ProcessCode) references Process(ProcessCode)
)