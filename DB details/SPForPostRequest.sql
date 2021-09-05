USE [BikeStores]
GO

/****** Object:  StoredProcedure [dbo].[AdminProductManagement_AddProduct]    Script Date: 05-09-2021 12:54:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[AdminProductManagement_AddProduct]
	@ProdName varchar(max),
	@BrandName varchar(255),
	@CatName varchar(255),
	@Year int,
	@ListPrice decimal (10,2),
	@WarehouseNo int,
	@WHType varchar(5),
	@WHUnits int

AS
BEGIN
---------------------------------------------ADDING PRODUCT IN PRODUCTS TABLE BASED ON BRAND's AND CATEGORY's EXISTENCE--------------------------------------------

BEGIN TRY

--CHECK IF GIVEN BRAND EXISTS OR NOT--

	IF not exists (select brand_name from BikeStores.Production.brands where brand_name = @BrandName)
	BEGIN
	
		insert into BikeStores.Production.brands
		values(@BrandName);
		
		declare @BrandId int;
		
		set @BrandId = (select brand_id from BikeStores.Production.brands where brand_name = @BrandName);
	
	END
	
	--CHECK IF GIVEN CATEGORY EXISTS OR NOT--
	
	IF not exists (select category_name from BikeStores.Production.categories where category_name = @CatName)
	BEGIN
	
		insert into BikeStores.Production.categories
		values(@CatName);
		
		declare @CatId int;
		
		set @CatId = (select category_id from BikeStores.Production.categories where category_name = @CatName);
	
	END
	
	--ADDING NEW PRODUCT IN MERCHANDISING--
	
	IF not exists (select product_name from BikeStores.Production.products where product_name = @ProdName)
	BEGIN
		
		set @BrandId = (select brand_id from BikeStores.Production.brands where brand_name = @BrandName);
		set @CatId = (select category_id from BikeStores.Production.categories where category_name = @CatName);
	
		insert into BikeStores.Production.products
		values (@ProdName,@BrandId,@CatId,@Year,@ListPrice);
		
		declare @ProdId int;
		
		set @ProdId = (select product_id from BikeStores.Production.products where product_name = @ProdName);
		
		--ADDING WAREHOUSE INVENTORY FOR THE NEW PRODUCT--
		
		insert into BikeStores.Production.Warehouse
		values (@WarehouseNo,@WHType,@ProdId,@WHUnits,'false');
	
	END
	
	ELSE
		THROW 15023, N'Record already exists', 1;

	set @ProdId = (select product_id from BikeStores.Production.products where product_name = @ProdName);
	exec [BikeStores].[dbo].[GetInventoryByID]
	@ProdID = @ProdId

END TRY

BEGIN CATCH

	insert into QueueRepository..ErrorQueue
	values(GETDATE(),'dbo.AdminProductManagement_AddProduct',ERROR_LINE(),ERROR_NUMBER(),ERROR_MESSAGE());

END CATCH

END
GO


