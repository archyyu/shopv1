using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CashierLibrary.Model
{
    public class User
    {
		/// <summary>
		/// 是否是连锁
		/// </summary>
		private int isChain;

		public int id
        {
            get;
            set;
        }

        public String loginname
        {
            get;
            set;
        }

        public String username
        {
            get;
            set;
        }

        public String password
        {
            get;
            set;
        }

        public int shopid
        {
            get;
            set;
        }

        public String shopName
        {
            get;
            set;
        }

		/// <summary>
		/// 是否连锁
		/// </summary>
		public int IsChain
		{
			get
			{
				return isChain;
			}

			set
			{
				isChain = value;
			}
		}
	}
}
