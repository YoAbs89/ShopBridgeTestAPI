using System;
using System.Collections.Generic;

#nullable disable

namespace ShopBridgeTestAPI.Models.DB
{
    public partial class Product
    {
        public Product()
        {
            Warehouses = new HashSet<Warehouse>();
        }

        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public int BrandId { get; set; }
        public int CategoryId { get; set; }
        public short ModelYear { get; set; }
        public decimal ListPrice { get; set; }

        public virtual Brand Brand { get; set; }
        public virtual Category Category { get; set; }
        public virtual ICollection<Warehouse> Warehouses { get; set; }
    }
}
