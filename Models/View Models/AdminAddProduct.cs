using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ShopBridgeTestAPI.Models.View_Models
{
    public class AdminAddProduct
    {
        public string ProductName { get; set; }
        public string BrandName { get; set; }
        public string ProductCategory { get; set; }
        public short ModelYear { get; set; }
        public decimal ListPrice { get; set; }
        public int Warehouse { get; set; }
        public string DistributionType { get; set; }
        public int? SOH { get; set; }
    }
}
