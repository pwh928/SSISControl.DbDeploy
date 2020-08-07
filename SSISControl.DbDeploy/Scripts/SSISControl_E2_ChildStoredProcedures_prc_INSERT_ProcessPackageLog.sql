/*
SSISControl_E2_ChildStoredProcedures_prc_INSERT_ProcessPackageLog
*/
use SSISControl
go

if exists(select name from sysobjects where name = 'prc_INSERT_ProcessPackageLog')
	drop proc prc_INSERT_ProcessPackageLog
go

/*******************************************************************************
Name:			prc_INSERT_ProcessPackageLog
Description:	Inserts row to ProcessInstanceproviding @ProcessInstanceID as
output variable.
Used by:		SSIS packages
Author:			Paul Wheeler
Created:		31 Jul 2020

To test:

insert into Process(ProcessCode, ProcessName) select 'TFF', 'ThinkfolioFeed'

declare @MyLogID int

exec prc_INSERT_ProcessPackageLog
		  @LogID		= @MyLogID output
		, @ProcessCode	= 'TFF'
		, @PackageName	= 'Test'

select @MyLogID

select * from ProcessPackageLog where LogID = @MyLogID
*******************************************************************************/
create proc dbo.prc_INSERT_ProcessPackageLog
(
	  @LogID				int			output
	, @ProcessInstanceID	int			= null
	, @ProcessCode			varchar(20)	= null
	, @PackageName			varchar(100)
)

as

set nocount on

insert into ProcessPackageLog
(
	  ProcessInstanceID
	, ProcessCode
	, PackageName
)
select
	  @ProcessInstanceID
	, @ProcessCode
	, @PackageName

select @LogID = @@IDENTITY