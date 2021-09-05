USE [BikeStores]
GO

/****** Object:  StoredProcedure [dbo].[AdminProductManagement_ModifyProduct]    Script Date: 05-09-2021 12:54:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[AdminProductManagement_ModifyProduct]
	@ProdId int,
	@ProdName varchar(max),
	@Year int,
	@ListPrice decimal (10,2)
AS
BEGIN

BEGIN TRY

--UPDATE PRODUCT DETAILS LIKE NAME OR LIST PRICE--
	IF exists (select product_id from BikeStores.Production.products where product_id = @ProdId)
	BEGIN
		update BikeStores.Production.products
		set
		product_name = @ProdName,
		list_price = @ListPrice,
		model_year = @Year
		where product_id = @ProdId;
	END
	
	ELSE
	BEGIN
		insert into QueueRepository..ErrorQueue
		values(GETDATE(),'dbo.AdminProductManagement_AddProduct',000,404,'No record found. Please Add the product in Merchandising first.');
	END
	
	exec [BikeStores].[dbo].[GetInventoryByID]
	@ProdID = @ProdId

	END TRY
	
BEGIN CATCH
	
		insert into QueueRepository..ErrorQueue
		values(GETDATE(),'dbo.AdminProductManagement_AddProduct',ERROR_LINE(),ERROR_NUMBER(),ERROR_MESSAGE());
		
END CATCH

END
GO


