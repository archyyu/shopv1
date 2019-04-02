using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;

namespace CashierLibrary.KeyBoard
{
    public class WinLockUtil
    {
        private const int GWL_STYLE = (-16);
        public const int WS_CAPTION = 0xC00000;
       

        [DllImport(@"\Libs\WinLockDll.dll", EntryPoint = "CtrlAltDel_Enable_Disable",
          CallingConvention = CallingConvention.StdCall, CharSet = CharSet.Unicode)]
        public static extern Int32 CtrlAltDel_Enable_Disable(int bEnableDisable);


        [DllImport(@"\Libs\WinLockDll.dll", EntryPoint = "DllInject",
        CallingConvention = CallingConvention.StdCall, CharSet = CharSet.Unicode)]
        public static extern Int32 DllInject(String dllPath,String processName);


        [DllImport("user32.dll", EntryPoint = "FindWindow")]
        private extern static IntPtr FindWindow(string lpClassName, string lpWindowName);


        [DllImport("coredll.dll", EntryPoint = "GetWindowLong")]
        private static extern IntPtr GetWindowLong(IntPtr hWnd, int nIndex);

        [DllImport("coredll.dll")]
        static extern int SetWindowLong(IntPtr hWnd, int nIndex, IntPtr newWndProc);

        [DllImport("coredll.dll")]
        static extern IntPtr CallWindowProc(IntPtr lpPrevWndFunc, IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);

        private static IntPtr oldWndProc = IntPtr.Zero;
        private static WndProcDelegate newWndProc;

        private const int GWL_WNDPROC = -4;
        private const int WM_SETFOCUS = 0x0007;
        private const int WM_HOTKEY = 0x0312;
        private const byte MOD_ALT = 0x0001;
        private const byte MOD_CONTROL = 0x0002;
        private const byte MOD_SHIFT = 0x0004;
        private const byte MOD_WIN = 0x0008;
        private const byte VK_DELETE = 0x2e;


        delegate IntPtr WndProcDelegate(IntPtr hWnd, uint msg, IntPtr wParam, IntPtr lParam);

        /// <summary>
        /// 禁用altDelCtrl
        /// </summary>
        public bool DisableCtrlAltDel()
        {
            Int32 nRet = CtrlAltDel_Enable_Disable(0);
            if (1 == nRet)
            {
                IntPtr hwnd = FindWindow("SAS Window class", "SAS window");
                newWndProc = new WndProcDelegate(WndProc);
                oldWndProc = GetWindowLong(hwnd, GWL_WNDPROC);
                int success = SetWindowLong(hwnd, GWL_WNDPROC, Marshal.GetFunctionPointerForDelegate(newWndProc));
                return 1 == success ? true : false;
            }
            else
            {
                return false;
            }
           
        }

        private uint MAKELONG(ushort x, ushort y)
        {
            return ((((uint)x) << 16) | y); //low order WORD 是指标的x位置； high order WORD是y位置. 
        }

        /// <summary>
        /// 新的方法
        /// </summary>
        /// <param name="hWnd"></param>
        /// <param name="msg"></param>
        /// <param name="wParam"></param>
        /// <param name="lParam"></param>
        /// <returns></returns>
        public IntPtr WndProc(IntPtr hWnd, uint msg, IntPtr wParam, IntPtr lParam)
        {
            if (msg == WM_HOTKEY)
            {
                Console.WriteLine("检测到del按键，禁用");
                // Ctrl+Alt+Del
                if (Marshal.ReadInt64(lParam) == MAKELONG(MOD_CONTROL | MOD_ALT, VK_DELETE))
                    return IntPtr.Zero;
            }
            return CallWindowProc(oldWndProc, hWnd, msg, wParam, lParam);
        }



    }
}
