using CashierLibrary.Util;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;


namespace CashierLibrary.AutoRun
{
	public class AutoRunHelper
	{
		#region 设置自动启动

		/// <summary>
		/// 设置启动项
		/// </summary>
		/// <param name="key">该应用的名称，需唯一</param>
		/// <param name="path">应用启动路径 Application.ExecutablePath</param>
		public static void SetAutoRun(String key,String path)
		{
			if (!IsExsitRestry(key,path))
			{
				Debug.WriteLine("写入注册表");
				LogHelper.WriteLog("写入注册表");
				RegistryKey(key,path);
			}
		}

		/// <summary>
		/// 判断是否存在自动启动项
		/// </summary>
		/// <returns></returns>
		private static bool IsExsitRestry(String key, String path)
		{
			try
			{
				RegistryKey rk = Registry.LocalMachine;
				RegistryKey rk2 = rk.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run", false);
				if (null != rk2.GetValue(key))
				{
					if (rk2.GetValue(key).Equals(path))
					{
						return true;
					}

				}

			}
			catch (Exception ex)
			{

				Debug.WriteLine("cashiServer:判断注册表存在失败,错误:{0}", ex.Message);
				LogHelper.WriteLog("cashiServer:判断注册表存在失败", ex);
			}
			return false;
		}

		/// <summary>
		/// 添加开机启动项
		/// </summary>
		private static void RegistryKey(String key, String path)
		{

			try
			{
				string execPath = path;
				RegistryKey rk = Registry.LocalMachine;
				RegistryKey rk2 = rk.CreateSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run");
				rk2.SetValue(key, execPath);
				Debug.WriteLine(string.Format("[注册表操作]添加注册表键值：path = {0}, key = {1}, value = {2} 成功", rk2.Name, "TuniuAutoboot", execPath));
				LogHelper.WriteLog("cashirServer:注册表增加自动启动");

			}
			catch (Exception ex)
			{
				Debug.WriteLine(string.Format("[注册表操作]向注册表写开机启动信息失败, Exception: {0}", ex.Message));

			}
		}



		#endregion
	}
}
