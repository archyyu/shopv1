using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CashierLibrary.Model
{
    public class OrderProduct
    {

        public String name
        {
            get;
            set;
        }
        public String num
        {
            get;
            set;
        }
        public String price
        {
            get;
            set;
        }
        public String settleprice
        {
            get;
            set;
        }
        public String sum
        {
            get;
            set;
        }

        public Int32 ishalf
        {
            get;
            set;
        }

        public Int32 isdiy
        {
            get;
            set;
        }

        public Int32 makeSource
        {
            get;
            set;
        }

    }
}
