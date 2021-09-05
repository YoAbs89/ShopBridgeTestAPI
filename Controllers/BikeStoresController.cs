using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using ShopBridgeTestAPI.Models.DB;
using ShopBridgeTestAPI.Models.View_Models;
using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ShopBridgeTestAPI.Controllers
{
    [Route("ShopBridge")]
    [ApiController]
    public class BikeStoresController : Controller
    {
        private readonly BikeStoresContext _bikeStores;

        public BikeStoresController(BikeStoresContext bikeStores)
        {
            _bikeStores = bikeStores;
        }

        [HttpGet]
        [Route("ShowWarehouseInventory")]
        public async Task<IActionResult> GetInventory()
        {
            try
            {
                var SPGet = "exec [BikeStores].[dbo].[GetFullMerchandiseInventory]";
                IEnumerable<GetFullMerchandiseInventory> GFMI = await _bikeStores.GetFullMerchandiseInventories.FromSqlRaw(SPGet).ToListAsync();
                return Ok(GFMI);
            }
            catch (Exception e)
            {
                return NotFound(e.Message);
            }
        }

        [HttpPost]
        [Route("Create")]
        public async Task<IActionResult> AddInventory(AdminAddProduct Add)
        {
            try
            {
                var SPAdd = "exec [BikeStores].[dbo].[AdminProductManagement_AddProduct] \n"
                    + "@ProdName = '" + Add.ProductName + "',\n"
                    + "@BrandName = '" + Add.BrandName + "',\n"
                    + "@CatName = '" + Add.ProductCategory + "',\n"
                    + "@Year = " + Add.ModelYear + ",\n"
                    + "@ListPrice = " + Add.ListPrice + ",\n"
                    + "@WarehouseNo = " + Add.Warehouse + ",\n"
                    + "@WHType = '" + Add.DistributionType + "',\n"
                    + "@WHUnits = " + Add.SOH;

                var RowsAdded =  await _bikeStores.AdminAddProducts.FromSqlRaw(SPAdd).ToListAsync();
                if (RowsAdded == null)
                {
                    return Json(new { success = true, message = "Failed to Add a Product" });
                }
                await _bikeStores.SaveChangesAsync();
                return Json(new { success = true, message = "Operation Successful" });
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpPut]
        [Route("Update")]
        public async Task<IActionResult> UpdateInventory(AdminModifyProduct Update)
        {
            try
            {
                var SPUpdate = "exec [BikeStores].[dbo].[AdminProductManagement_ModifyProduct]\n"
                    + "@ProdId = " + Update.ProductId + ",\n"
                    + "@ProdName = '" + Update.ProductName + "',\n"
                    + "@Year = " + Update.ModelYear + ",\n"
                    + "@ListPrice = " + Update.ListPrice;

                var RowsUpdated = await _bikeStores.AdminAddProducts.FromSqlRaw(SPUpdate).ToListAsync();
                if (RowsUpdated == null)
                {
                    return Json(new { success = true, message = "Failed to update the Product" });
                }
                await _bikeStores.SaveChangesAsync();
                return Json(new { success = true, message = "Operation Successful" });
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpDelete]
        [Route("Remove")]
        public async Task<IActionResult> DeleteInventory(AdminDeleteProduct Delete)
        {
            try
            {
                var SPDelete = "exec [BikeStores].[dbo].[AdminProductManagement_DeleteProduct]\n"
                    + "@ProdId = " + Delete.ProductId;

                var ProductIDExists = await _bikeStores.AdminAddProducts.FromSqlRaw(SPDelete).ToListAsync();
                if (ProductIDExists.Count == 0)
                {
                    return Json(new { success = true, message = "Operation Successful" });
                }
                await _bikeStores.SaveChangesAsync();
                return Json(new { success = true, message = "Failed to delete the Product" });
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}
