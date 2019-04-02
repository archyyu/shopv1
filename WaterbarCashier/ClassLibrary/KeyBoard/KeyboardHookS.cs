using CashierLibrary.Util;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.InteropServices;
using System.Text;
using static System.Net.Mime.MediaTypeNames;

namespace CashierLibrary.KeyBoard
{
    /// <summary>
    /// 键盘钩子
    /// </summary>
    public class KeyboardHookS
    {

        public delegate int KeyboardProc(int nCode, IntPtr wParam, IntPtr lParam);

        static int hKeyboardHook = 0;
        KeyboardProc KeyboardHookProcedure;

        /// <summary>
        /// 钩子函数,需要引用空间(using System.Reflection;)
        /// 线程钩子监听键盘消息设为2,全局钩子监听键盘消息设为13
        /// 线程钩子监听鼠标消息设为7,全局钩子监听鼠标消息设为14
        /// </summary>

        public const int WH_KEYBOARD = 13;
        public const int WH_MOUSE_LL = 14;

        public struct KeyboardMSG
        {
            public int vkCode;
            public int scanCode;
            public int flags;
            public int time;
            public int dwExtraInfo;

        }
        //private FileStream MyFs;
        //各种键位的ASC码
        private const byte LLKHF_ALTDOWN = 0x20;
        private const byte VK_CAPITAL = 0x14;
        private const byte VK_ESCAPE = 0x1B;
        private const byte VK_F4 = 0x73;
        private const byte VK_LCONTROL = 0xA2;
        private const byte VK_NUMLOCK = 0x90;
        private const byte VK_RCONTROL = 0xA3;
        private const byte VK_SHIFT = 0x10;
        private const byte VK_TAB = 0x09;
        //public const int WH_KEYBOARD = 13;
        private const int WH_KEYBOARD_LL = 13;
        private const int WH_MOUSE = 7;
        //private const int WH_MOUSE_LL = 14;
        private const int WM_KEYDOWN = 0x100;
        private const int WM_KEYUP = 0x101;
        private const int WM_LBUTTONDBLCLK = 0x203;
        private const int WM_LBUTTONDOWN = 0x201;
        private const int WM_LBUTTONUP = 0x202;
        private const int WM_MBUTTONDBLCLK = 0x209;
        private const int WM_MBUTTONDOWN = 0x207;
        private const int WM_MBUTTONUP = 0x208;
        private const int WM_MOUSEMOVE = 0x200;
        private const int WM_MOUSEWHEEL = 0x020A;
        private const int WM_RBUTTONDBLCLK = 0x206;
        private const int WM_RBUTTONDOWN = 0x204;
        private const int WM_RBUTTONUP = 0x205;
        private const int WM_SYSKEYDOWN = 0x104;
        private const int WM_SYSKEYUP = 0x105;
        //private static int hKeyboardHook = 0;

        /// <summary>
        /// vs2008中的声明方法，在vs2010中略有不同

        /// </summary>
        /// <returns></returns>
        [DllImport("kernel32")]
        public static extern int GetCurrentThreadId();

        [DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall)]
        public static extern int SetWindowsHookEx(int idHook, KeyboardProc lpfn, IntPtr hInstance, int threadId);

        [DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall)]
        public static extern bool UnhookWindowsHookEx(int idHook);

        [DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall)]
        public static extern int CallNextHookEx(int idHook, int nCode, IntPtr wParam, IntPtr lParam);

        [DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.Winapi)]
        public static extern short GetKeyState(int keycode);

        [DllImport("kernel32.dll")]
        public static extern IntPtr GetModuleHandle(string name);

        //在这里你可以自己定义要拦截的键。
        private int KeyboardHookProc(int nCode, IntPtr wParam, IntPtr lParam)
        {
            KeyboardMSG m = (KeyboardMSG)Marshal.PtrToStructure(lParam, typeof(KeyboardMSG));
            if (
           ((int)m.vkCode == 91) || ((int)m.vkCode == 92) ||
           //两个组合键
           ((m.vkCode == VK_TAB) && ((m.flags & LLKHF_ALTDOWN) != 0)) ||

           ((m.vkCode == VK_ESCAPE) && ((m.flags & LLKHF_ALTDOWN) != 0)) ||
           ((m.vkCode == VK_F4) && ((m.flags & LLKHF_ALTDOWN) != 0)) ||
           //用于三个组合键
           (m.vkCode == VK_ESCAPE) && ((GetKeyState(VK_LCONTROL) & 0x8000) != 0) ||
           ((int)m.vkCode >= 65 && (int)m.vkCode <= 90 && ((GetKeyState(0x12) & 0x8000) != 0)) ||
           ((int)m.vkCode >= 65 && (int)m.vkCode <= 90 && ((GetKeyState(0x11) & 0x8000) != 0)) ||
           (m.vkCode == VK_ESCAPE) && ((GetKeyState(VK_RCONTROL) & 0x8000) != 0)
           )
            {
                return 1;
            }
            return CallNextHookEx(hKeyboardHook, nCode, wParam, lParam);
        }
        // 安装钩子
        public void KeyMaskStart(String path,bool bforbiddenTask=true)
        {
            if (hKeyboardHook == 0)
            {
                // 创建HookProc实例
                KeyboardHookProcedure = new KeyboardProc(KeyboardHookProc);
                // 设置线程钩子
                hKeyboardHook = SetWindowsHookEx(WH_KEYBOARD, KeyboardHookProcedure,
                    GetModuleHandle(Process.GetCurrentProcess().MainModule.ModuleName), 0);
                // 如果设置钩子失败
                if (hKeyboardHook == 0)
                {
                    KeyMaskStop();
                    throw new Exception("SetWindowsHookEx failed.");
                }
                if (bforbiddenTask)
                {
                    //先用注册表方式关闭进程管理
                    this.SetTaskManager(false);
                }
               
                //String dllPath = path + @"\amd64\AidaGuard.dll";
                //int nRet = WinLockUtil.DllInject(dllPath, "winlogon.exe");
                //if (nRet > 0)
                //{
                //    LogHelper.WriteLog("注入成功");
                //}
                //else
                //{
                //    LogHelper.WriteLog("注入失败");
                //}

                //WinLockUtil win = new WinLockUtil();
                //if (!win.DisableCtrlAltDel())
                //{
                //    LogHelper.WriteLog("没有禁用系统热键!");
                //}
               
            }
        }

        /// <summary>
        /// 禁用 taskManageer
        /// </summary>
        /// <param name="enable"></param>
        public void SetTaskManager(bool enable)
        {
       
            RegistryKey objRegistryKey = Registry.CurrentUser.CreateSubKey(
                @"Software\Microsoft\Windows\CurrentVersion\Policies\System",RegistryKeyPermissionCheck.ReadWriteSubTree);
            if (enable && objRegistryKey.GetValue("DisableTaskMgr") != null)
            {
                objRegistryKey.DeleteValue("DisableTaskMgr");
                LogHelper.WriteLog("删除注册表");
            }
            else
            {
                objRegistryKey.SetValue("DisableTaskMgr", "1");
                LogHelper.WriteLog("设置注册表不能启用");
            }
                
            objRegistryKey.Close();
        }

        // 卸载钩子
        public void KeyMaskStop()
        {
            bool retKeyboard = true;
            if (hKeyboardHook != 0)
            {
                retKeyboard = UnhookWindowsHookEx(hKeyboardHook);
                hKeyboardHook = 0;
            }
            if (!(retKeyboard))
            {
                throw new Exception("UnhookWindowsHookEx  failed.");
            }
            //if (null != this.MyFs)
            //{
            //    MyFs.Dispose();
            //    MyFs = null;
            //}
        }
    }

}
