USE [BikeStores]
GO

/****** Object:  StoredProcedure [dbo].[GetFullMerchandiseInventory]    Script Date: 05-09-2021 18:59:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetFullMerchandiseInventory]
AS
BEGIN
select
BPP.product_id [ProductID],
BPP.product_name [ProductName],
BPB.brand_id [BrandID],
BPB.brand_name [BrandName],
BPC.category_name [ProductCategory],
BPW.Warehouse_No [Warehouse],
[DistributionType] =
case BPW.Warehouse_Type
WHEN 'REG' THEN 'Regular Inventory'
WHEN 'ONORD' THEN 'On-Order Inventory'
END,
BPW.Warehouse_Units [SOH]
from
BikeStores.Production.products BPP join BikeStores.Production.brands BPB
on BPP.brand_id = BPB.brand_id join BikeStores.Production.categories BPC
on BPP.category_id = BPC.category_id join BikeStores.Production.Warehouse BPW
on BPP.product_id = BPW.Product_Id
order by ProductID,ProductName,BrandID,BrandName,ProductCategory,Warehouse,SOH
END
GO


