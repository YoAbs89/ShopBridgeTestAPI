USE [BikeStores]
GO

/****** Object:  StoredProcedure [dbo].[AdminProductManagement_DeleteProduct]    Script Date: 05-09-2021 13:57:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[AdminProductManagement_DeleteProduct]
	@ProdId int
AS
BEGIN

BEGIN TRY

--DELETING PRODUCT AND WAREHOUSE STOCK OF AN EXISTING BRAND--
	IF exists (select product_id from BikeStores.Production.products where product_id = @ProdId)
		BEGIN		
			delete from BikeStores.Production.Warehouse
			where Product_Id = @ProdId;
			
			delete from BikeStores.Production.products
			where product_id = @ProdId;		
		END
	
	ELSE
		BEGIN
			insert into QueueRepository..ErrorQueue
			values(GETDATE(),'dbo.AdminProductManagement_DeleteProduct',000,404,'No record found. Please Add the product in Merchandising first.');
		END

	exec [BikeStores].[dbo].[GetInventoryByID]
	@ProdID = @ProdId
	
END TRY

BEGIN CATCH

	insert into QueueRepository..ErrorQueue
	values(GETDATE(),'dbo.AdminProductManagement_DeleteProduct',ERROR_LINE(),ERROR_NUMBER(),ERROR_MESSAGE());
	
END CATCH

END
GO


