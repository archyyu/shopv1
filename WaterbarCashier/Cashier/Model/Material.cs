using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Cashier.Model
{
    public class Material
    {
        public Int32 id { get; set; } 
        public string name { get; set; } 
        public string unit { get; set; } 
        public float inventory { get; set; }
        public Int32 type { get; set; }
        public string typestr { get; set; }

    }
}
