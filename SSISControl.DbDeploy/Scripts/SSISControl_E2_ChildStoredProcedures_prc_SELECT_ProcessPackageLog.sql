/*
SSISControl_E2_ChildStoredProcedures_prc_SELECT_ProcessPackageLog
*/
use SSISControl
go

if exists(select name from sysobjects where name = 'prc_SELECT_ProcessPackageLog')
	drop proc prc_SELECT_ProcessPackageLog
go

/*******************************************************************************
Name:			prc_SELECT_ProcessPackageLog
Description:	Select data from ProcessPackageLog for review
Used by:		Ad hoc report
Author:			Paul Wheeler
Created:		31 Jul 2020

To test:

exec prc_SELECT_ProcessPackageLog
		  @ProcessCode			= 'TFF'
		, @ProcessInstanceID	= 1
*******************************************************************************/
create proc dbo.prc_SELECT_ProcessPackageLog
(
	  @ProcessCode			varchar(20)
	, @ProcessInstanceID	int			= null
)

as

set nocount on

if @ProcessInstanceID is null
	select @ProcessInstanceID = max(ProcessInstanceID)
	from ProcessInstance
	where ProcessCode = @ProcessCode

select
	  ProcessInstanceID
	, ProcessCode
	, IsFailure
	, PackageStart
	, PackageEnd
	, datediff(s, PackageStart, PackageEnd) as PackageDurationInSeconds
from ProcessPackageLog 
where ProcessInstanceID = @ProcessInstanceID
