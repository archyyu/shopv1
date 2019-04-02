using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CashierLibrary.Model
{
	public class ResponseDTO
	{
		private String state;

		private String info;

		private Object data;

		/// <summary>
		/// 状态码返回数据
		/// </summary>
		public String Info
		{
			get { return info; }
			set { info = value; }
		}

		/// <summary>
		/// 序列化后的json串
		/// </summary>
		public Object Data
		{
			get { return data; }
			set { data = value; }
		}

		public string State
		{
			get
			{
				return state;
			}

			set
			{
				state = value;
			}
		}
	}
}
