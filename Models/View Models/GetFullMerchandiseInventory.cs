using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ShopBridgeTestAPI.Models.View_Models
{
    public class GetFullMerchandiseInventory
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public int BrandId { get; set; }
        public string BrandName { get; set; }
        public string ProductCategory { get; set; }
        public int Warehouse { get; set; }
        public string DistributionType { get; set; }
        public int? SOH { get; set; }
    }
}
