using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CashierLibrary.Model
{
	/// <summary>
	/// 请求数据
	/// </summary>
	public class RequestDTO
	{

		private String fn1;

		private String tm1;

		private String ver1;

		private String token1;

		private Object data1;

        private String from;

        private String srcIp;

		/// <summary>
		/// 方法参数
		/// </summary>
		public string fn
		{
			get
			{
				return fn1;
			}

			set
			{
				fn1 = value;
			}
		}

		/// <summary>
		/// 时间戳
		/// </summary>
		public string tm
		{
			get
			{
				return tm1;
			}

			set
			{
				tm1 = value;
			}
		}

		/// <summary>
		/// 版本
		/// </summary>
		public string ver
		{
			get
			{
				return ver1;
			}

			set
			{
				ver1 = value;
			}
		}

		/// <summary>
		/// 验证令牌
		/// </summary>
		public string token
		{
			get
			{
				return token1;
			}

			set
			{
				token1 = value;
			}
		}

		/// <summary>
		/// Json数据
		/// </summary>
		public Object data
		{
			get
			{
				return data1;
			}

			set
			{
				data1 = value;
			}
		}

        public string From
        {
            get
            {
                return from;
            }

            set
            {
                from = value;
            }
        }

        public string SrcIp
        {
            get
            {
                return srcIp;
            }

            set
            {
                srcIp = value;
            }
        }
    }
}
