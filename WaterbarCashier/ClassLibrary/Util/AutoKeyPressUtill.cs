using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;

namespace CashierLibrary.Util
{
    /// <summary>
    /// 根据窗体句柄，更改窗体控件显示
    /// </summary>
    public class AutoKeyPressUtill
    {
        //寻找目标进程窗口       
        [DllImport("USER32.DLL")]
        public static extern IntPtr FindWindow(string lpClassName, string lpWindowName);
        [DllImport("USER32.DLL", EntryPoint = "FindWindowEx", SetLastError = true)]
        public static extern IntPtr FindWindowEx(IntPtr hwndParent, uint hwndChildAfter, string lpszClass, string lpszWindow);
        //设置进程窗口到最前       
        [DllImport("USER32.DLL")]
        public static extern bool SetForegroundWindow(IntPtr hWnd);
        //模拟键盘事件         
        [DllImport("USER32.DLL")]
        public static extern void keybd_event(Byte bVk, Byte bScan, Int32 dwFlags, Int32 dwExtraInfo);
        public delegate bool CallBack(IntPtr hwnd, int lParam);
        [DllImport("USER32.DLL")]
        public static extern int EnumChildWindows(IntPtr hWndParent, CallBack lpfn, int lParam);
        //给CheckBox发送信息
        [DllImport("USER32.DLL", EntryPoint = "SendMessage", SetLastError = true, CharSet = CharSet.Auto)]
        public static extern int SendMessage(IntPtr hwnd, UInt32 wMsg, int wParam, int lParam);
        //给Text发送信息
        [DllImport("USER32.DLL", EntryPoint = "SendMessage")]
        private static extern int SendMessage(IntPtr hWnd, UInt32 Msg, IntPtr wParam, string lParam);
        [DllImport("USER32.DLL")]
        public static extern IntPtr GetWindow(IntPtr hWnd, int wCmd);
    }
}
