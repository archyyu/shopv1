using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace CashierLibrary.Model
{
    public class FileProcessor
    {
        /// <summary>
        /// 判断文件是否存在
        /// </summary>
        /// <param name="filename">文件名,带路径</param>
        /// <returns></returns>
        public static Boolean FileExist(String filename)
        {
            return File.Exists(filename);
        }
        /// <summary>
        /// 读取文件里所有内容到字节数组里
        /// </summary>
        /// <param name="filename">文件名</param>
        /// <param name="filedata">目标缓冲区</param>
        /// <returns>装载成功返回True;失败返回False</returns>
        public static Boolean ReadFileBytes(String filename, out Byte[] filedata)
        {
            filedata = null;
            Int32 filelen = GetFileLength(filename);
            if (filelen < 1)
            {
                return false;
            }

            filedata = File.ReadAllBytes(filename);
            return true;
        }
        /// <summary>
        /// 获取文件长度
        /// </summary>
        /// <param name="filename">文件名</param>
        /// <returns>文件不存在,返回-1.存在,返回文件长度</returns>
        public static Int32 GetFileLength(String filename)
        {
            Boolean blret = File.Exists(filename);
            if (!blret)
            {
                return -1;
            }

            FileInfo fi = new FileInfo(filename);
            Int32 ret = (Int32)fi.Length;
            return ret;
        }
    }
}
