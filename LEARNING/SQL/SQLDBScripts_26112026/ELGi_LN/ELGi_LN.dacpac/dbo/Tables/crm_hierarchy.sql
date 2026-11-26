CREATE TABLE [dbo].[crm_hierarchy] (
    [Parent_id]   UNIQUEIDENTIFIER NULL,
    [ParentName]  NVARCHAR (200)   NULL,
    [ParentEmail] NVARCHAR (100)   NULL,
    [Child_Id]    UNIQUEIDENTIFIER NULL,
    [ChildName]   NVARCHAR (200)   NULL,
    [ChildEmail]  NVARCHAR (100)   NULL,
    [plan]        INT              NULL,
    [actual]      INT              NULL,
    [Pemail]      NVARCHAR (105)   NOT NULL,
    [Cemail]      NVARCHAR (105)   NOT NULL
);


GO

