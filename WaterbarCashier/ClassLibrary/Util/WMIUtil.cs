using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Management;
using System.Net;
using System.Net.NetworkInformation;
using System.Net.Sockets;
using System.Text;

/// <summary>
/// 公共信息管理类
/// </summary>
namespace CashierLibrary.Util
{
    public class WMIUtil
    {
        /// <summary>
        /// 获取本地使用mac
        /// </summary>
        /// <returns></returns>
        public static String GetMac()
        {
            const int MIN_MAC_ADDR_LENGTH = 12;
            string macAddress = string.Empty;
            long maxSpeed = -1;

            foreach (NetworkInterface nic in NetworkInterface.GetAllNetworkInterfaces())
            {

                string tempMac = nic.GetPhysicalAddress().ToString();
                if (nic.Speed > maxSpeed &&
                    !string.IsNullOrEmpty(tempMac) &&
                    tempMac.Length >= MIN_MAC_ADDR_LENGTH)
                {
                    maxSpeed = nic.Speed;
                    macAddress = tempMac;
                }
            }

            return macAddress;
        }

        /// <summary>
        /// 获取计算机名称
        /// </summary>
        /// <returns></returns>
        public static String GetComputerName()
        {
            try
            {
                String machineName = System.Environment.GetEnvironmentVariable("ComputerName");
                return machineName;
            }
            catch (Exception ex)
            {
                LogHelper.WriteLog("未找到计算机名",ex);
                return "unKnow";
            }
            
        }

        /// <summary>
        /// 重启机器
        /// </summary>
        public static void ReStartPC()
        {
            ProcessStartInfo proc = new ProcessStartInfo();
            proc.WindowStyle = ProcessWindowStyle.Hidden;
            proc.FileName = "cmd";
            proc.Arguments = "/C shutdown -f -r -t 5";
            Process.Start(proc);
        }

        public static string GetLocalIPv4(NetworkInterfaceType _type)
        {
            string output = "";
            foreach (NetworkInterface item in NetworkInterface.GetAllNetworkInterfaces())
            {
                if (item.NetworkInterfaceType == _type && item.OperationalStatus == OperationalStatus.Up)
                {
                    IPInterfaceProperties adapterProperties = item.GetIPProperties();

                    if (adapterProperties.GatewayAddresses.FirstOrDefault() != null)
                    {
                        foreach (UnicastIPAddressInformation ip in adapterProperties.UnicastAddresses)
                        {
                            if (ip.Address.AddressFamily == System.Net.Sockets.AddressFamily.InterNetwork)
                            {
                                output = ip.Address.ToString();
                            }
                        }
                    }
                }
            }

            return output;
        }


        /// <summary>
        /// 获取本地ip
        /// </summary>
        /// <returns>本地ip</returns>
        public static String GetLocalIP()
        {
            var host = Dns.GetHostEntry(Dns.GetHostName());
            foreach (var ip in host.AddressList)
            {
                if (ip.AddressFamily == AddressFamily.InterNetwork)
                {
                    return ip.ToString();
                }
            }
            throw new Exception("No network adapters with an IPv4 address in the system!");
        }

        /// <summary>
        /// ip地址转换为Uint32数值
        /// </summary>
        /// <param name="ip">本地地址</param>
        /// <returns></returns>
        public static UInt32 IptoUint(String ip)
        {
            try
            {
                return BitConverter.ToUInt32(IPAddress.Parse(ip).GetAddressBytes(), 0);
            }
            catch (Exception ex)
            {

                LogHelper.WriteLog("AidaClient,转换Ip地址出错!", ex);

            }
            return 0;
        }

    }
}
