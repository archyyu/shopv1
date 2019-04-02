using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CashierLibrary.Model
{
    public class Member
    {

        public String account { get; set; }

        public long activeTime { get; set; }

        public String address { get; set; }

        public String areaName { get; set; }

        public Int32 areaType { get; set; }

        public float awardBalance { get; set; }

        public String bRoomOwner { get; set; }

        public float baseBalance { get; set; }

        public String birthday { get; set; }

        public float cashBalance { get; set; }

        public Int32 cityID { get; set; }

        public Int32 costType { get; set; }

        public Int32 districtID { get; set; }


        public String identifyNum { get; set; }

        public Int32 identifyType { get; set; }

        public Int32 ignoreTime { get; set; }

        public long lastCostTime { get; set; }

        public String machineName { get; set; }

        public Int32 machineState { get; set; }

        public long maxEndTime { get; set; }
        
        public long memberID { get; set; }
        
        public String memberName { get; set; }

        public Int32 memberType { get; set; }
        
        public String memberTypeDesc { get; set; }

        public long nextCostTime { get; set; }

        public long offLineTime { get; set; }

        public float onlineFee { get; set; }

        public long onlineStartTime { get; set; }
        
        public String openID { get; set; }
        
        public float periodBegin { get; set; }

        public float periodEnd { get; set; }
        
        public String phone { get; set; }

        public float price { get; set; }

        public Int32 provinceID { get; set; }

        public String qq { get; set; }

        public Int32 ruleId { get; set; }

        public float ruleValue { get; set; }

        public Int32 sex { get; set; }

        public float startPrice { get; set; }

    }
}
