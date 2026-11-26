
create view [dbo].[vw_LN_Inv_OrderTypes] as
select 1 as OrderType, 'SFC Production Order' as OrderTypeDesc union
select 2, 'Purchase Order' union
select 3, 'Sales Order' union
select 4, 'Planned Production Order' union
select 5, 'Planned Purchase Order' union
select 6, 'Purchase Schedule' union
select 7, 'Sales Schedule' union
select 8, 'Purchase Order Advice' union
select 9, 'ASC Production Order' union
select 11, 'Forecast' union
select 12, 'ATP Reservation' union
select 13, 'Sales Quotation' union
select 14, 'Purchase Contract' union
select 15, 'Sales Contract' union
select 16, 'Warehouse Order' union
select 17, 'Service Order' union
select 18, 'PRP Purchase Order (TP)' union
select 19, 'PRP Warehouse Order (TP)' union
select 21, 'Warehousing Assembly Order' union
select 22, 'Warehouse Transfer' union
select 26, 'Production Batch' union
select 29, 'Planned Activities Service' union
select 30, 'Planned Distribution Order' union
select 31, 'Assembly Part Demand' union
select 32, 'SFC Production Order (Manual)' union
select 33, 'Purchase Order (Manual)' union
select 34, 'Sales Order (Manual)' union
select 35, 'Service Order (Manual)' union
select 36, 'Warehouse Transfer (Manual)' union
select 37, 'Maintenance Sales Order' union
select 38, 'Maintenance Work Order' union
select 39, 'Maintenance Sales Order (Manual)' union
select 40, 'Request for Quotation' union
select 41, 'Sales Schedule Forecast' union
select 42, 'Maintenance Work Order (Manual)' union
select 43, 'Freight' union
select 44, 'Stock' union
select 45, 'Safety Stock' union
select 46, 'ASC Production Order (Manual)' union
select 47, 'Purchase Requisition' union
select 49, 'Production Plan' union
select 50, 'Purchase Plan' union
select 51, 'Cycle Counting Order' union
select 52, 'Adjustment Order' union
select 55, 'Revaluation Order' union
select 56, 'Production Schedule' union
select 57, 'Production Kanban' union
select 58, 'Project' union
select 59, 'Project (Manual)' union
select 60, 'Warehouse Transfer (Distribution)' union
select 65, 'PCS Project' union
select 69, 'Allocation Change Order' union
select 70, 'Inventory Ownership Change Order' union
select 71, 'Expected Supply' union
select 72, 'Confirmed Supply' union
select 74, 'Forecast from Customer' union
select 76, 'Forecast to Supplier' union
select 78, 'Buy-From BP Transfer (Purchase)' union
select 80, 'Buy-From BP Transfer (Schedule)' union
select 82, 'Sold-To BP Transfer (Sales)' union
select 84, 'Sold-To BP Transfer (Schedule)' union
select 86, 'Sold-To BP Transfer (WH Manual)' union
select 88, 'Sold-To BP Transfer (Manual)' union
select 90, 'Sold-To BP Transfer (WH Distribution)' union
select 92, 'Planned Cost Peg Transfer' union
select 93, 'Cost Peg Transfer' union
select 95, 'Project Contract' union
select 96, 'Customer Claim' union
select 97, 'Supplier Claim' union
select 98, 'Quarantine Inventory' union
select 100, 'Not Applicable'

GO

