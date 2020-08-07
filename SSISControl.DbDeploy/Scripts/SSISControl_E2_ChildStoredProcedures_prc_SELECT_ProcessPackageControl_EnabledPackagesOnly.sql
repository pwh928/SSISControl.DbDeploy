/*
SSISControl_E2_ChildStoredProcedures_prc_SELECT_ProcessPackageControl_EnabledPackagesOnly
*/
use SSISControl
go

if exists(select name from sysobjects where name = 'prc_SELECT_ProcessPackageControl_EnabledPackagesOnly')
	drop proc prc_SELECT_ProcessPackageControl_EnabledPackagesOnly
go

/*******************************************************************************
Name:			prc_SELECT_ProcessPackageControl_EnabledPackagesOnly
Description:	Gets details of enabled packages only for a particular process 
Used by:		SSIS package (parent)
Author:			Paul Wheeler
Created:		31 Jul 2020

To test:

exec prc_SELECT_ProcessPackageControl_EnabledPackagesOnly
		  @ProcessCode			= 'TFF'
*******************************************************************************/
create proc dbo.prc_SELECT_ProcessPackageControl_EnabledPackagesOnly
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
and IsEnabled = 1
order by
	  RunOrder