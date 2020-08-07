/*
SSISControl_E2_ChildStoredProcedures_prc_INSERT_ProcessPackageLogErrors
*/
use SSISControl
go

if exists(select name from sysobjects where name = 'prc_INSERT_ProcessPackageLogErrors')
	drop proc prc_INSERT_ProcessPackageLogErrors
go

/*******************************************************************************
Name:			prc_INSERT_ProcessPackageLogErrors
Description:	Inserts row to table ProcessPackageLogErrors when a SSIS error
occurs
Used by:		SSIS packages
Author:			Paul Wheeler
Created:		31 Jul 2020

To test:

exec prc_INSERT_ProcessPackageLogErrors
		  @LogID				= 1
		, @ProcessCode			= 'TFF'
		, @PackageName			= 'test'
		, @ErrorDescription		= 'test'

select * from ProcessPackageLogErrors
*******************************************************************************/
create proc dbo.prc_INSERT_ProcessPackageLogErrors
(
	  @LogID				int			
	, @ProcessCode			varchar(20)	
	, @PackageName			varchar(100)
	, @ErrorDescription		varchar(max)
)

as

set nocount on

insert into ProcessPackageLogErrors
(
	  LogID
	, ProcessCode
	, PackageName
	, ErrorDescription
)
select
	  @LogID
	, @ProcessCode
	, @PackageName
	, @ErrorDescription

