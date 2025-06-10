-- Check if the type already exists and drop it if it does
IF EXISTS (SELECT 1 FROM sys.types WHERE is_table_type = 1 AND name = 'UDT_GenericOrders')
BEGIN
    DROP TYPE dbo.UDT_GenericOrders;
END
GO
-- Create the new user-defined table type
CREATE TYPE [dbo].[UDT_GenericOrders] AS TABLE(
    [AccountNo] char NOT NULL,
    [Id] varchar NOT NULL,
    [CurrentOrderId] bigint,
    [ToDate] [datetime] NOT NULL,
    [FromDate] [datetime] NULL,
    [CurrentOrderType] char(2) NULL,
    [AltFromDate] [datetime] NULL
);
