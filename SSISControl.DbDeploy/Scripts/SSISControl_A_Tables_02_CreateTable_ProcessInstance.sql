/*
SSISControl_A_Tables_02_CreateTable_ProcessInstance
*/
use SSISControl
go

if exists(select name from sysobjects where name = 'ProcessInstance')
	drop table ProcessInstance

create table ProcessInstance
(
	  ProcessInstanceID		int			identity(1,1)	not null
	, ProcessCode			varchar(20)					not null
	, ProcessStart			datetime					not null constraint DF_ProcessInstance_ProcessStart default getdate()
	, constraint PK_ProcessInstance primary key clustered (ProcessInstanceID)
	, constraint FK_Process_ProcessInstance foreign key (ProcessCode) references Process(ProcessCode) on delete cascade
)