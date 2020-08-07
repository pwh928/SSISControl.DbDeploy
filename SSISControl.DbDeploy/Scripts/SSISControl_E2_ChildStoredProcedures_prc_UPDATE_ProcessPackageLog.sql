/*
SSISControl_E2_ChildStoredProcedures_prc_UPDATE_ProcessPackageLog
*/
use SSISControl
go

if exists(select name from sysobjects where name = 'prc_UPDATE_ProcessPackageLog')
	drop proc prc_UPDATE_ProcessPackageLog
go

/*******************************************************************************
Name:			prc_UPDATE_ProcessPackageLog
Description:	Updates row in table ProcessPackageLog at end of SSIS package
execution
Used by:		SSIS package
Author:			Paul Wheeler
Created:		31 Jul 2020

To test:

exec prc_UPDATE_ProcessPackageLog
		  @LogID		= 1
		, @IsFailure	= 1
*******************************************************************************/
create proc dbo.prc_UPDATE_ProcessPackageLog
(
	  @LogID		int
	, @IsFailure	bit
)

as

set nocount on

update ppl
set
	  ppl.IsFailure		= @IsFailure
	, ppl.PackageEnd	= getdate()
from ProcessPackageLog as ppl
where ppl.LogID = @LogID