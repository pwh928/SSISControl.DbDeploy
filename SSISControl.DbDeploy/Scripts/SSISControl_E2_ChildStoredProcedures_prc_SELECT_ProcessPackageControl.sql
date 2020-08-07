/*
SSISControl_E2_ChildStoredProcedures_prc_SELECT_ProcessPackageControl
*/
use SSISControl
go

if exists(select name from sysobjects where name = 'prc_SELECT_ProcessPackageControl')
	drop proc prc_SELECT_ProcessPackageControl
go

/*******************************************************************************
Name:			prc_SELECT_ProcessPackageControl
Description:	Gets details of whether packages for a particular process are 
enabled to determine which child packages to execute
Used by:		SSIS package (parent)
Author:			Paul Wheeler
Created:		31 Jul 2020

To test:

exec prc_SELECT_ProcessPackageControl
		  @ProcessCode			= 'TFF'

*******************************************************************************/
create proc dbo.prc_SELECT_ProcessPackageControl
(
	  @ProcessCode	varchar(20)
)

as 

set nocount on

select
	  PackageName
	, IsEnabled
from ProcessPackageControl
where ProcessCode = @ProcessCode
order by
	  RunOrder