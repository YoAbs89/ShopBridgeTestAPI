using System;
using System.Collections.Generic;

#nullable disable

namespace ShopBridgeTestAPI.Models.DB
{
    public partial class Warehouse
    {
        public int WarehouseEntryId { get; set; }
        public int WarehouseNo { get; set; }
        public string WarehouseType { get; set; }
        public int ProductId { get; set; }
        public int? WarehouseUnits { get; set; }
        public bool IsAllocatedToStore { get; set; }

        public virtual Product Product { get; set; }
    }
}
