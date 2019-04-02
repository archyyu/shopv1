using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Runtime.InteropServices;

namespace CashierLibrary.Util
{
    public class MemoryUtil
    {
        const int PROCESS_WM_READ = 0x0010;
        [DllImport("kernel32.dll")]
        public static extern IntPtr OpenProcess(int dwDesiredAccess, bool bInheritHandle, int dwProcessId);
        [DllImport("kernel32.dll")]
        public static extern bool ReadProcessMemory(int hProcess, int lpBaseAddress, byte[] lpBuffer, int dwSize, ref int lpNumberOfBytesRead);

        public const int FILE_MAP_READ = 0x0004;

        [DllImport("Kernel32", CharSet = CharSet.Auto, SetLastError = true)]
        internal static extern IntPtr OpenFileMapping(int dwDesiredAccess,
            bool bInheritHandle, StringBuilder lpName);

        [DllImport("Kernel32", CharSet = CharSet.Auto, SetLastError = true)]
        internal static extern IntPtr MapViewOfFile(IntPtr hFileMapping,
            int dwDesiredAccess, int dwFileOffsetHigh, int dwFileOffsetLow,
            int dwNumberOfBytesToMap);

        [DllImport("Kernel32.dll")]
        internal static extern bool UnmapViewOfFile(IntPtr map);

        [DllImport("kernel32.dll")]
        internal static extern bool CloseHandle(IntPtr hObject);

        public static String ReadFromMemory()
        {

            IntPtr hMappingHandle = IntPtr.Zero;
            IntPtr hVoid = IntPtr.Zero;
            int nFlagSize = sizeof(int);

            hMappingHandle = OpenFileMapping(FILE_MAP_READ, false, new StringBuilder("_GAMEINFO_"));
            if (hMappingHandle == IntPtr.Zero)
            {
                //打开共享内存失败，记log  
                return null;
            }

            //前4个字节标记长度，先取出共享内存的长度
            hVoid = MapViewOfFile(hMappingHandle, FILE_MAP_READ, 0, 0, nFlagSize);
            if (hVoid == IntPtr.Zero)
            {
                return null;
            }
            int structSize = 15;//Marshal.ReadInt32(hVoid);

            hVoid = MapViewOfFile(hMappingHandle, FILE_MAP_READ, 0, 0, nFlagSize + structSize);
            if (hVoid == IntPtr.Zero)
            {
                //文件映射失败，记log  
                return null;
            }

            byte[] content = new byte[structSize];
            Marshal.Copy(hVoid + nFlagSize, content, 0, structSize);
            string obj = System.Text.Encoding.UTF8.GetString(content);

            if (hVoid != IntPtr.Zero)
            {
                UnmapViewOfFile(hVoid);
                hVoid = IntPtr.Zero;
            }
            if (hMappingHandle != IntPtr.Zero)
            {
                CloseHandle(hMappingHandle);
                hMappingHandle = IntPtr.Zero;
            }
            return obj;
        }


    }
}
