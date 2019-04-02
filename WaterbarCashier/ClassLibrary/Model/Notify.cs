using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CashierLibrary.Model
{
    class Notify
    {

        public String notifyType { get; set; }

        public String msg { get; set; }

        public Order order { get; set; }

    }
}
