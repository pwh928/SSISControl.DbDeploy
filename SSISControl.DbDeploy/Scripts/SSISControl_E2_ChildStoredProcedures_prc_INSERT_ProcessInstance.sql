/*
SSISControl_E2_ChildStoredProcedures_prc_INSERT_ProcessInstance
*/
use SSISControl
go

if exists(select name from sysobjects where name = 'prc_INSERT_ProcessInstance')
	drop proc prc_INSERT_ProcessInstance
go

/*******************************************************************************
Name:			prc_INSERT_ProcessInstance
Description:	Inserts row to ProcessInstanceproviding @ProcessInstanceID as
output variable.
Used by:		SSIS packages
Author:			Paul Wheeler
Created:		31 Jul 2020

To test:

insert into Process(ProcessCode, ProcessName) select 'TFF', 'ThinkfolioFeed'

declare @MyProcessInstanceID int

exec prc_INSERT_ProcessInstance
		  @ProcessCode			= 'TFF'
		, @ProcessInstanceID	= @MyProcessInstanceID output

select @MyProcessInstanceID
*******************************************************************************/
create proc dbo.prc_INSERT_ProcessInstance
(
	  @ProcessCode			varchar(20)
	, @ProcessInstanceID	int			output
)

as

set nocount on

insert into ProcessInstance
(
	  ProcessCode
)
select @ProcessCode

select @ProcessInstanceID = @@IDENTITY