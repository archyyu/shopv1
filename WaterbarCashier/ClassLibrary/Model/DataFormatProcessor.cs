using System;
using System.Collections.Generic;
using System.Text;
using System.Runtime.Serialization.Formatters.Binary;
using System.Runtime.Serialization;
using System.IO;


namespace CashierLibrary.Model
{

    public enum eDateFormat
    {
        System = 0,
        yyyy_MM_dd = 1,
        MM_dd_yyyy = 2,
        dd_MM_yyyy = 3,
    }

    public class DataFormatProcessor
    {

        public const Byte ASCII_0 = 48;
        public const Byte ASCII_9 = 57;
        public const Byte ASCII_A = 65;
        public const Byte ASCII_F = 70;
        public const Byte ASCII_Z = 90;
        public const Byte ASCII_a = 97;
        public const Byte ASCII_f = 102;
        public const Byte ASCII_z = 122;


        #region 比特位处理


        //下标-比特位序号. 内容-该比特位为1时,字节的值
        public static readonly Byte[] BitIndex_ByteValue_8 = new Byte[]
        {
            1, 2, 4, 8, 16, 32, 64, 128
        };

        //下标-比特位序号. 内容-该比特位为0,其他比特位为1时,字节的值
        //实际上就是BitIndex_ByteValue_8的按位取反
        public static readonly Byte[] BitIndex_ByteValueNot_8 = new Byte[]
        {
            0xFE, 0xFD, 0xFB, 0xF7, 0xEF, 0xDF, 0xBF, 0x7F
        };

        /// <summary>
        /// 字节 转换为8个元素的Boolean数组
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        public static Boolean[] ByteToBooleanArray(Byte byteval)
        {
            Boolean[] ret = new Boolean[8];
            for (Int32 bitidx = 0; bitidx < 8; ++bitidx)
            {
                if ((BitIndex_ByteValue_8[bitidx] & byteval) > 0)
                {
                    ret[bitidx] = true;
                }
                else
                {
                    ret[bitidx] = false;
                }
            }

            return ret;
        }

        /// <summary>
        /// 字节 转换为8个元素的Int32数组.
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        public static Int32[] ByteToInt32Array(Byte byteval)
        {
            Int32[] ret = new Int32[8];
            for (Int32 bitidx = 0; bitidx < 8; ++bitidx)
            {
                if ((BitIndex_ByteValue_8[bitidx] & byteval) > 0)
                {
                    ret[bitidx] = 1;
                }
                else
                {
                    ret[bitidx] = 0;
                }
            }

            return ret;
        }


        /// <summary>
        /// 8个元素的Boolean数组 转换为 字节 
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        public static Byte BooleanArrayToByte(Boolean[] bitarray)
        {
            if (bitarray == null || bitarray.Length < 8)
            {
                return 0;
            }

            Byte ret = 0;
            for (Int32 bitidx = 0; bitidx < 8; ++bitidx)
            {
                if (bitarray[bitidx])
                {
                    ret = (Byte)(ret | BitIndex_ByteValue_8[bitidx]);
                }
            }

            return ret;
        }

        /// <summary>
        /// 获取字节某个比特位的值
        /// </summary>
        /// <param name="byteval">目标字节</param>
        /// <param name="bitidx">比特位下标</param>
        /// <param name="bitval">比特位值</param>
        /// <returns></returns>
        public static Boolean GetBitValue(Byte byteval, Int32 bitidx)
        {
            if (bitidx < 0 || bitidx > 7)
            {
                return false;
            }

            if ((byteval & BitIndex_ByteValue_8[bitidx]) == 0)
            {
                return false;
            }
            else
            {
                return true;
            }
        }


        /// <summary>
        /// 设置字节某个比特位的值
        /// </summary>
        /// <param name="bitidx">比特位下标</param>
        /// <param name="bitval">比特位值</param>
        /// <param name="byteval">目标字节</param>
        /// <returns></returns>
        public static void SetBitValue(Int32 bitidx, Boolean bitval, ref Byte byteval)
        {
            if (bitidx < 0 || bitidx > 7)
            {
                return;
            }

            if (bitval)
            {
                byteval = (Byte)(byteval | BitIndex_ByteValue_8[bitidx]);
            }
            else
            {
                byteval = (Byte)(byteval & BitIndex_ByteValueNot_8[bitidx]);
            }
        }
        #endregion

        #region 字节与字符串的转换

        /// <summary>
        /// IP地址和端口号转为字节数组
        /// </summary>
        /// <param name="ip"></param>
        /// <param name="port"></param>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static Boolean IPPortIntoBytes(String ip, String port, ref Byte[] bytes)
        {
            //            Boolean bl = CommonCompute.ValidateIPPort(port);
            //            if (!bl) return false;

            Int32 portval = Int32.Parse(port);
            IPPortIntoBytes(ip, portval, ref bytes);
            return true;
        }

        /// <summary>
        /// IP地址和端口号转为字节数组
        /// </summary>
        /// <param name="ip"></param>
        /// <param name="port"></param>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static Boolean IPPortIntoBytes(String ip, Int32 port, ref Byte[] bytes)
        {
            String[] ipary = ip.Split('.');
            if (ipary.Length != 4)
            {
                return false;
            }

            bytes = new Byte[6];
            for (Int32 i = 0; i < 4; ++i)
            {
                bytes[i] = Byte.Parse(ipary[i]);
            }

            DataFormatProcessor.Int16ToBytes(port, ref bytes, 4);
            return true;
        }

        /// <summary>
        ///字节数组 转为 IP地址和端口号
        /// </summary>
        /// <param name="ip"></param>
        /// <param name="port"></param>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static Boolean BytesToIPPort(Byte[] bytes, ref String ip, ref Int32 port)
        {
            if (bytes.Length != 6)
            {
                return false;
            }
            ip = bytes[0].ToString() + "." +
                 bytes[1].ToString() + "." +
                  bytes[2].ToString() + "." +
                   bytes[3].ToString();

            port = DataFormatProcessor.BytesToInt16(bytes, 4);
            return true;
        }

        /// <summary>
        /// 判断输入的值是否为0-9,a-f
        /// </summary>
        /// <param name="c"></param>
        /// <returns></returns>
        public static Boolean IsHexChar(Char c)
        {
            if ((c >= '0' && c <= '9') ||
            (c >= 'A' && c <= 'F') ||
            (c >= 'a' && c <= 'f'))
            {
                return true;
            }

            return false;
        }
        /// <summary>
        /// 字节转换为字符串
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        public static String ByteToHexChar(Byte val)
        {
            return val.ToString("X2");
        }

        /// <summary>
        /// 字节转换为字符串
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        public static String ByteToBitString(Byte val)
        {
            if (val == 0)
            {
                return "00000000";
            }
            if (val == 255)
            {
                return "11111111";
            }

            String ret = String.Empty;
            Int32 bitval = 0;
            for (int bitidx = 7; bitidx > -1; --bitidx)
            {
                if ((bitval & BitIndex_ByteValue_8[bitidx]) > 0)
                {
                    ret = ret + "1";
                }
                else
                {
                    ret = ret + "0";
                }
            }
            return ret;
        }

        /// <summary>
        /// 判断一个字符是否为 0-9，A-F
        /// </summary>
        /// <param name="c"></param>
        /// <returns></returns>
        public static Boolean IsValidHexStringChar(Char c)
        {
            Boolean bl = (c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F');
            return bl;
        }

        /// <summary>
        /// 2个HEX字符转换为1个字节数组
        /// </summary>
        /// <param name="hexstr">"A1"</param>
        /// <param name="bytes">161</param>
        /// <returns></returns>
        public static Boolean HexStringToByte(String hexstr, out Byte byteval)
        {
            byteval = 0;
            hexstr = hexstr.Trim();
            if (hexstr.Length != 2) return false;

            Boolean bl = IsValidHexStringChar(hexstr[0]);
            if (!bl) return false;
            bl = IsValidHexStringChar(hexstr[1]);
            if (!bl) return false;

            byteval = Convert.ToByte(hexstr, 16);
            return true;
        }

        /// <summary>
        /// 判断是否为hexstring
        /// </summary>
        /// <param name="hexstr"></param>
        /// <returns></returns>
        public static Boolean IsByteHexString(String hexstr)
        {
            if (hexstr.Length < 1)
            {
                return false;
            }

            for (Int32 bidx = 0; bidx < hexstr.Length; ++bidx)
            {
                if ((hexstr[bidx] >= '0' && hexstr[bidx] <= '9') ||
                    (hexstr[bidx] >= 'a' && hexstr[bidx] <= 'f') ||
                    (hexstr[bidx] >= 'A' && hexstr[bidx] <= 'F'))
                {
                    continue;
                }
                else
                {
                    return false;
                }
            }
            return true;
        }

        /// <summary>
        /// 从字符串里过滤无效字符,得到hex字符串
        /// </summary>
        /// <param name="rawstring"></param>
        /// <returns></returns>
        public static String FilterHexString(String rawstring)
        {
            if (rawstring.Length < 1)
            {
                return String.Empty;
            }

            StringBuilder strb = new StringBuilder(rawstring.Length);
            for (Int32 charidx = 0; charidx < rawstring.Length; ++charidx)
            {
                if ((rawstring[charidx] >= '0' && rawstring[charidx] <= '9') ||
                    (rawstring[charidx] >= 'a' && rawstring[charidx] <= 'f') ||
                    (rawstring[charidx] >= 'A' && rawstring[charidx] <= 'F'))
                {
                    strb.Append(rawstring[charidx]);
                }
            }

            String ret = strb.ToString();
            strb = null;
            return ret;
        }

        /// <summary>
        /// HEX字符串转换为字节数组
        /// </summary>
        /// <param name="hexstr"></param>
        /// <param name="bytes"></param>
        /// <param name="lowbytesfirst">true-首个字符为最低字节,false-首个字符为最高字节</param>
        /// <returns></returns>
        public static Boolean HexStringToBytes(String hexstr, ref Byte[] bytes, Int32 start, Boolean lowbytesfirst = true)
        {
            if (start < 0)
            {
                return false;
            }

            Byte[] puredata = null;
            Boolean bl = HexStringToBytes(hexstr, out puredata, lowbytesfirst);
            if (!bl)
            {
                return false;
            }

            if ((bytes == null) || (bytes.Length < start + puredata.Length))
            {
                bytes = new Byte[start + puredata.Length];
            }

            Array.Copy(puredata, 0, bytes, start, puredata.Length);
            return true;
        }

        /// <summary>
        /// HEX字符串转换为字节数组
        /// 举例: "01234A"
        /// 先高字节模式,转换为 0x01234A; 先低字节模式,转换为 0x4A2301
        /// </summary>
        /// <param name="hexstr"></param>
        /// <param name="bytes"></param>
        /// <param name="lowbytesfirst">true-首个字符为最低字节,false-首个字符为最高字节</param>
        /// <returns></returns>
        public static Boolean HexStringToBytes(String hexstr, out Byte[] bytes, Boolean lowbytesfirst = true)
        {
            //先过滤无效字符 
            bytes = null;
            hexstr = FilterHexString(hexstr);
            if ((hexstr == null) || (hexstr.Length < 2) || (hexstr.Length % 2 == 1))
            {
                return false;
            }

            int bytelen = hexstr.Length / 2;
            bytes = new Byte[bytelen];
            String curbytestr = String.Empty;

            //由于先调用了 FilterHexString, 因此必定能转换成功 
            for (int bidx = 0; bidx < bytelen; bidx++)
            {
                curbytestr = hexstr.Substring(bidx * 2, 2);
                //数字的进制，它必须是 2、8、10和16.
                bytes[bidx] = Convert.ToByte(curbytestr, 16);
            }


            //输入为 "00 11 22 33" 
            //目前bytes里保存的是 0x33221100
            //如果传输的是先低字节,则期待转换为 0x33221100
            //如果传输的是先高字节,则期待转换为 0x00112233
            //因此,如果是 先高字节模式,还需要进行高低字节翻转
            if (!lowbytesfirst)
            {
                Array.Reverse(bytes);
            }
            return true;
        }

        /// <summary>
        /// HEX字符串转换为字节数组
        /// </summary>
        /// <param name="hexstr"></param>
        /// <param name="bytes"></param>
        /// <param name="lowbytesfirst">true-首个字符为最低字节,false-首个字符为最高字节</param>
        /// <returns></returns>
        public static Byte[] HexStringToBytes(String hexstr, Boolean lowbytesfirst = true)
        {
            Byte[] puredata = null;
            Boolean bl = HexStringToBytes(hexstr, out puredata, lowbytesfirst);
            return puredata;
        }

        /// <summary>
        ///  字符串转换为Int32
        /// </summary>
        /// <param name="hexstr"></param>
        /// <param name="val"></param>
        /// <returns></returns>
        public static Boolean HexStringToInt32(String hexstr, ref Int32 val, Boolean lowfirst = true)
        {
            if (hexstr.Length < 8)
            {
                return false;
            }

            hexstr = hexstr.Substring(0, 8);
            Byte[] bytes = null;
            Boolean bl = HexStringToBytes(hexstr, out bytes, lowfirst);
            if (!bl)
            {
                return false;
            }

            if (bytes == null || bytes.Length != 4)
            {
                return false;
            }

            val = BytesToInt32(bytes);
            return true;
        }


        /// <summary>
        ///  字符串转换为Int16
        /// </summary>
        /// <param name="hexstr"></param>
        /// <param name="val"></param>
        /// <returns></returns>
        public static Boolean HexStringToInt16(String hexstr, ref Int32 val, Boolean lowfirst = true)
        {
            if (hexstr.Length < 4)
            {
                return false;
            }

            hexstr = hexstr.Substring(0, 4);
            Byte[] bytes = null;
            Boolean bl = HexStringToBytes(hexstr, out bytes, lowfirst);
            if (!bl)
            {
                return false;
            }

            if (bytes == null || bytes.Length != 2)
            {
                return false;
            }

            val = BytesToInt16(bytes);
            return true;
        }

        /// <summary>
        /// 翻转hexstring
        /// </summary>
        /// <param name="?"></param>
        /// <returns></returns>
        public static Boolean ReverseHexString(ref String hexstr)
        {
            if (hexstr.Length < 1)
            {
                return false;
            }
            if (hexstr.Length % 2 != 0)
            {
                return false;
            }

            StringBuilder ret = new StringBuilder(hexstr.Length);
            Int32 charidx = hexstr.Length - 2;
            while (charidx >= 0)
            {
                ret.Append(hexstr.Substring(charidx, 2));
                charidx -= 2;
            }

            hexstr = ret.ToString();
            return true;
        }

        /// <summary>
        /// 字节数组转换为字符串
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static String BytesToHexString(Byte[] bytes, Boolean lowfirst = true)
        {
            if (bytes == null || bytes.Length < 1)
            {
                return String.Empty;
            }

            StringBuilder str = new StringBuilder(bytes.Length * 2);
            for (int i = 0; i < bytes.Length; i++)
            {
                str.Append(bytes[i].ToString("X2"));
            }

            String ret = str.ToString();
            if (!lowfirst)
            {
                ReverseHexString(ref ret);
            }
            return ret;
        }

        /// <summary>
        /// 字节数组转换为字符串
        /// </summary>
        /// <param name="bytes"></param>
        /// <param name="splitter"></param>
        /// <returns></returns>
        public static String BytesToHexString(Byte[] bytes, char splitter, Boolean lowfirst = true)
        {
            if (bytes == null || bytes.Length < 1)
            {
                return String.Empty;
            }

            StringBuilder str = new StringBuilder(bytes.Length * 2);
            if (splitter == 0)
            {
                for (int i = 0; i < bytes.Length; i++)
                {
                    str.Append(bytes[i].ToString("X2"));
                }
            }
            else
            {
                for (int i = 0; i < bytes.Length; i++)
                {
                    str.Append(bytes[i].ToString("X2"));
                    str.Append(splitter);
                }
            }

            String ret = str.ToString();
            if (!lowfirst)
            {
                ReverseHexString(ref ret);
            }
            return ret;
        }

        /// <summary>
        /// 字节数组转换为字符串
        /// </summary>
        /// <param name="bytes"></param>
        /// <param name="start">待转换的首个字节下标</param>
        /// <param name="len"></param>
        /// <param name="eachlinebytes">每隔多少字节,就插入一个换行符.0表示不换行</param>
        /// <returns></returns>
        public static String BytesToHexStringWithNewline(Byte[] bytes, Int32 start, Int32 len,
            Int32 eachlinebytes, Boolean lowfirst = true)
        {
            if (bytes == null || bytes.Length < 1 || start < 0 || len < 1 || start + len > bytes.Length)
            {
                return String.Empty;
            }

            Int32 curlinebytes = 0;
            StringBuilder str = new StringBuilder(bytes.Length * 2);
            for (int i = 0; i < len; i++)
            {
                str.Append(bytes[i + start].ToString("X2"));
                if (eachlinebytes > 0)
                {
                    curlinebytes++;
                    if (curlinebytes >= eachlinebytes)
                    {
                        str.Append(Environment.NewLine);
                        curlinebytes = 0;
                    }
                }
            }

            String ret = str.ToString();
            if (!lowfirst)
            {
                ReverseHexString(ref ret);
            }
            return ret;
        }


        /// <summary>
        /// 字节数组转换为字符串
        /// </summary>
        /// <param name="bytes"></param>
        /// <param name="start">待转换的首个字节下标</param>
        /// <param name="len"></param>
        /// <param name="eachlinebytes">每隔多少字节,就插入一个换行符.0表示不换行</param>
        /// <returns></returns>
        public static String BytesToHexString(Byte[] bytes, Int32 start, Int32 len,
            Boolean lowfirst = true)
        {
            String ret = BytesToHexStringWithNewline(bytes, start, len, 0, lowfirst);
            return ret;
        }

        /// <summary>
        /// 字节数组转换为带间隔符的字符串,显示用
        /// </summary>
        /// <param name="bytes"></param>
        /// <param name="start">待转换的首个字节下标</param>
        /// <param name="len"></param>
        /// <param name="splitter"></param>
        /// <param name="eachlinebytes">每隔多少字节,就插入一个换行符.0表示不换行</param>
        /// <returns></returns>
        public static String BytesToHexStringWithNewline(Byte[] bytes, Int32 start, Int32 len,
            Char splitter, Int32 eachlinebytes = 0, Boolean lowfirst = true)
        {
            if (bytes == null || bytes.Length < 1 || start < 0 || len < 1 || start + len > bytes.Length)
            {
                return String.Empty;
            }

            Int32 curlinebytes = 0;
            StringBuilder str = new StringBuilder(bytes.Length * 2);

            if (splitter == 0) //不添加0
            {
                for (int i = 0; i < len; i++)
                {
                    str.Append(bytes[i + start].ToString("X2"));
                    if (eachlinebytes > 0)
                    {
                        curlinebytes++;
                        if (curlinebytes >= eachlinebytes)
                        {
                            str.Append(Environment.NewLine);
                            curlinebytes = 0;
                        }
                    }
                }
            }
            else
            {
                for (int i = 0; i < len; i++)
                {
                    str.Append(bytes[i + start].ToString("X2"));
                    str.Append(splitter);//添加间隔符

                    if (eachlinebytes > 0)
                    {
                        curlinebytes++;
                        if (curlinebytes >= eachlinebytes)
                        {
                            str.Append(Environment.NewLine);
                            curlinebytes = 0;
                        }
                    }
                }
            }

            str.Remove(str.Length - 1, 1);
            String ret = str.ToString();
            if (!lowfirst)
            {
                ReverseHexString(ref ret);
            }
            return ret;
        }

        /// <summary>
        /// 字节数组转换为带间隔符的字符串,显示用
        /// </summary>
        /// <param name="bytes"></param>
        /// <param name="start">待转换的首个字节下标</param>
        /// <param name="len"></param>
        /// <param name="splitter"></param>
        /// <param name="eachlinebytes">每隔多少字节,就插入一个换行符.0表示不换行</param>
        /// <returns></returns>
        public static String BytesToHexString(Byte[] bytes, Int32 start, Int32 len, Char splitter, Boolean lowfirst = true)
        {
            String ret = BytesToHexStringWithNewline(bytes, start, len, splitter, 0, lowfirst);
            return ret;
        }


        /// <summary>
        /// 字节数组转换为ASCII字符串
        /// </summary>
        /// <param name="bytes"></param>
        /// <param name="start"></param>
        /// <param name="len"></param>
        /// <param name="leftislow"></param>
        /// <returns></returns>
        public static String BytesToString(Byte[] bytes, Int32 start, Int32 len, Encoding encoding, Boolean leftislow = false)
        {
            if (start < 0 || len < 1)
            {
                return String.Empty;
            }

            Byte[] tempary = new Byte[len];
            Array.Copy(bytes, start, tempary, 0, len);

            if (!leftislow)
            {
                Array.Reverse(tempary);
            }
            String ret = encoding.GetString(tempary, 0, len);
            return ret;
        }


        /// <summary>
        /// 字节数组转换为ASCII字符串
        /// </summary>
        /// <param name="bytes"></param>
        /// <param name="start"></param>
        /// <param name="len"></param>
        /// <param name="leftislow"></param>
        /// <returns></returns>
        public static String BytesToString(Byte[] bytes, Int32 start, Int32 len, String encoding, Boolean leftislow = false)
        {
            if (start < 0 || len < 1)
            {
                return String.Empty;
            }

            Byte[] tempary = new Byte[len];
            Array.Copy(bytes, start, tempary, 0, len);

            if (!leftislow)
            {
                Array.Reverse(tempary);
            }

            Encoding ecd = GetEncodingByName(encoding);
            String ret = ecd.GetString(tempary, 0, len);
            return ret;
        }


        /// <summary>
        /// 字节数组转换为ASCII字符串
        /// </summary>
        /// <param name="bytes"></param>
        /// <param name="start"></param>
        /// <param name="len"></param>
        /// <param name="leftislow"></param>
        /// <returns></returns>
        public static String BytesToString(Byte[] bytes, Int32 start, Int32 len, Boolean leftislow = false)
        {
            return BytesToString(bytes, start, len, Encoding.Default, leftislow);
        }

        /// <summary>
        /// 字节数组转换为ASCII字符串
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static String BytesToString(Byte[] bytes, Encoding encoding, Boolean leftislow = false)
        {
            String ret = encoding.GetString(bytes);
            return ret;
        }

        /// <summary>
        /// 字节数组转换为ASCII字符串
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static String BytesToString(Byte[] bytes, String encoding, Boolean leftislow = false)
        {
            Encoding ecd = GetEncodingByName(encoding);
            String ret = ecd.GetString(bytes);
            return ret;
        }

        /// <summary>
        /// 字节数组转换为ASCII字符串
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static String BytesToString(Byte[] bytes, Boolean leftislow = false)
        {
            String ret = BytesToString(bytes, Encoding.Default, leftislow);
            return ret;
        }


        /// <summary>
        /// 字节数组转换为ASCII字符串
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static String BytesToASCIIString(Byte[] bytes)
        {
            Int32 idx = Array.IndexOf(bytes, (Byte)0);
            Byte[] purestr = bytes;
            if (idx == 0)
            {
                return "";
            }
            if (idx < 0)
            {
                purestr = bytes;
            }
            else
            {
                purestr = new byte[idx];
                Array.Copy(bytes, purestr, idx);
            }
            String ret = Encoding.ASCII.GetString(purestr);
            return ret;
        }

        /// <summary>
        /// ASCII字符串转换为字节数组
        /// </summary>
        /// <param name="asciistr"></param>
        /// <param name="bytes"></param>
        /// <param name="leftislow"></param>
        /// <returns></returns>
        public static Byte[] StringToBytes(String asciistr, Encoding encoding, Boolean leftislow = true)
        {
            if (asciistr == null || asciistr.Length < 1)
            {
                return null;
            }

            Byte[] bytes = encoding.GetBytes(asciistr);
            if (!leftislow)
            {
                Array.Reverse(bytes);
            }
            return bytes;
        }


        /// <summary>
        /// ASCII字符串转换为字节数组
        /// </summary>
        /// <param name="asciistr"></param>
        /// <param name="bytes"></param>
        /// <param name="leftislow"></param>
        /// <returns></returns>
        public static Byte[] StringToBytes(String asciistr, String encoding, Boolean leftislow = true)
        {
            Encoding ecd = GetEncodingByName(encoding);
            if (asciistr == null || asciistr.Length < 1)
            {
                return null;
            }

            Byte[] bytes = ecd.GetBytes(asciistr);
            if (!leftislow)
            {
                Array.Reverse(bytes);
            }
            return bytes;
        }


        /// <summary>
        /// ASCII字符串转换为字节数组
        /// </summary>
        /// <param name="asciistr"></param>
        /// <param name="bytes"></param>
        /// <param name="leftislow"></param>
        /// <returns></returns>
        public static Byte[] StringToBytes(String asciistr, Boolean leftislow = true)
        {
            if (asciistr == null || asciistr.Length < 1)
            {
                return null;
            }

            Byte[] bytes = Encoding.Default.GetBytes(asciistr);
            if (!leftislow)
            {
                Array.Reverse(bytes);
            }
            return bytes;
        }

        /// <summary>
        /// ASCII字符串转换为字节数组
        /// </summary>
        /// <param name="asciistr"></param>
        /// <param name="bytes"></param>
        /// <param name="leftislow"></param>
        /// <returns></returns>
        public static Boolean StringToBytes(String asciistr, out Byte[] bytes, Boolean leftislow = true)
        {
            bytes = Encoding.Default.GetBytes(asciistr);
            if (bytes == null || bytes.Length < 1)
            {
                return false;
            }

            if (!leftislow)
            {
                Array.Reverse(bytes);
            }
            return true;
        }

        #endregion

        #region  时间处理

        /// <summary>
        /// 验证日期是否正确
        /// </summary>
        /// <param name="month"></param>
        /// <param name="day"></param>
        /// <returns></returns>
        public static Boolean ValidateDate(Int32 month, Int32 day)
        {
            if (month < 1 || month > 12 || day < 1 || day > 31)
            {
                return false;
            }


            //1,3,5,7,8,10,12 月为31天; 4,6,9,11 月为30天,2月为28天
            if (month == 2)
            {
                if (day > 28)
                {
                    return false;
                }
            }
            else if (month == 4 || month == 6 || month == 9 || month == 11)
            {
                if (day > 30)
                {
                    return false;
                }
            }

            return true;
        }

        /// <summary>
        /// 验证日期是否正确
        /// </summary>
        /// <param name="year"></param>
        /// <param name="month"></param>
        /// <param name="day"></param>
        /// <returns></returns>
        public static Boolean ValidateDate(Int32 year, Int32 month, Int32 day)
        {
            if (year < 1000 || year > 9999 || month < 1 || month > 12 || day < 1 || day > 31)
            {
                return false;
            }

            //判断是否为闰年
            Boolean leapyear = (year % 400 == 0) || ((year % 4 == 0) && (year % 100 != 0));
            //1,3,5,7,8,10,12 月为31天; 4,6,9,11 月为30天,2月为28天
            if (month == 2)
            {
                if (leapyear)//闰年最多29天
                {
                    if (day > 29) return false;
                }
                else
                {
                    if (day > 28) return false;
                }
            }

            if (month == 4 || month == 6 || month == 9 || month == 11)
            {
                if (day > 30)
                {
                    return false;
                }
            }

            return true;
        }

        /// <summary>
        /// 获取当前日期时间
        /// </summary>
        /// <returns></returns>
        public static String GetCurrentTimeString(eDateFormat format)
        {
            String datestr = GetDateTimeString(DateTime.Now, format);
            return datestr;
        }

        /// <summary>
        /// 是否已经得到系统时间格式
        /// </summary>
        private static Boolean m_getsystemtimefmt = false;
        /// <summary>
        /// 系统时间格式的类型
        /// </summary>
        private static eDateFormat m_sysTimeFmt = eDateFormat.System;
        /// <summary>
        /// 获取系统时间格式
        /// </summary>
        /// <returns></returns>
        public static Boolean InitSystemTimeString()
        {
            if (m_getsystemtimefmt)
            {
                return true;
            }

            m_getsystemtimefmt = true;
            //判断系统时间格式的处理方式: 2000-1-5
            DateTime dt = new DateTime(2000, 1, 5, 0, 0, 0);
            String dtstr = dt.ToShortDateString();//判断 2000, 1, 5 的位置的前后
            Int32 idxofYear = dtstr.IndexOf("2000");
            Int32 idxofMon = dtstr.IndexOf("1");
            Int32 idxofday = dtstr.IndexOf("5");

            if (idxofYear < idxofMon && idxofMon < idxofday)
            {
                m_sysTimeFmt = eDateFormat.yyyy_MM_dd;
                return true;
            }

            if (idxofday < idxofMon && idxofMon < idxofYear)
            {
                m_sysTimeFmt = eDateFormat.dd_MM_yyyy;
                return true;
            }

            //其他全都认为是 mm-DD-YYYY
            m_sysTimeFmt = eDateFormat.MM_dd_yyyy;

            m_getsystemtimefmt = true;
            return true;
        }

        public static String GetDebugTimeString()
        {
            String ret = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss") + " " +
                DateTime.Now.Millisecond.ToString();
            return ret;
        }

        /// <summary>
        /// 获取日期时间格式字符串
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public static String GetDateTimeString(DateTime datetime, eDateFormat format)
        {
            if (!m_getsystemtimefmt)
            {
                InitSystemTimeString();
            }

            String datestr = String.Empty;
            if (format == eDateFormat.System)
            {
                format = m_sysTimeFmt;
            }
            switch (format)
            {
                case eDateFormat.yyyy_MM_dd:
                    datestr = datetime.ToString("yyyy/MM/dd");
                    break;
                case eDateFormat.dd_MM_yyyy:
                    datestr = datetime.ToString("dd/MM/yyyy");
                    break;
                case eDateFormat.MM_dd_yyyy:
                case eDateFormat.System:
                default:
                    datestr = datetime.ToString("MM/dd/yyyy");
                    break;
            }

            datestr = datestr + " " + datetime.ToString("HH:mm:ss");
            return datestr;
        }
        /// <summary>
        /// 获取日期时间格式字符串
        /// </summary>
        /// <param name="datetime">日期</param>
        /// <param name="format">格式</param>
        /// <param name="datespiltor">间隔符</param>
        /// <returns></returns>
        public static String GetDateTimeString(DateTime datetime,
            eDateFormat format, String datespiltor)
        {
            if (!m_getsystemtimefmt)
            {
                InitSystemTimeString();
            }

            String datestr = String.Empty;
            if (format == eDateFormat.System)
            {
                format = m_sysTimeFmt;
            }
            switch (format)
            {
                case eDateFormat.yyyy_MM_dd:
                    datestr = datetime.Year.ToString("D4") + datespiltor +
                         datetime.Month.ToString("D2") + datespiltor +
                         datetime.Day.ToString("D2");
                    break;
                case eDateFormat.dd_MM_yyyy:
                    datestr = datetime.Day.ToString("D2") + datespiltor +
                        datetime.Month.ToString("D2") + datespiltor +
                        datetime.Year.ToString("D4");
                    break;
                case eDateFormat.MM_dd_yyyy:
                case eDateFormat.System:
                default:
                    datestr = datetime.Month.ToString("D2") + datespiltor +
                        datetime.Day.ToString("D2") + datespiltor +
                        datetime.Year.ToString("D4");
                    break;
            }

            datestr = datestr + " " + datetime.ToString("HH:mm:ss");
            return datestr;
        }
        /// <summary>
        /// 获取日期时间格式字符串
        /// </summary>
        /// <param name="date"></param>
        /// <returns></returns>
        public static String GetDateTimeString(DateTime datetime)
        {
            return GetDateTimeString(datetime, eDateFormat.System);
        }

        /// <summary>
        /// 获取指定日期的00:00:00的时间对象
        /// </summary>
        /// <param name="srcdate"></param>
        /// <returns></returns>
        public static DateTime GetStartDateTime(DateTime date)
        {
            DateTime ret = new DateTime(date.Year, date.Month, date.Day, 0, 0, 0);
            return ret;
        }

        /// <summary>
        /// 获取指定日期的23:59:59的时间对象
        /// </summary>
        /// <param name="srcdate"></param>
        /// <returns></returns>
        public static DateTime GetEndDateTime(DateTime date)
        {
            DateTime ret = new DateTime(date.Year, date.Month, date.Day, 23, 59, 59);
            return ret;
        }

        /// <summary>
        /// 获取上月1号0点0分0秒的时间字符串
        /// </summary>
        /// <param name="datetime"></param>
        /// <returns></returns>
        public static DateTime GetStartTimeOfLastMonth()
        {
            DateTime lastmon = DateTime.Now.AddMonths(-1);
            DateTime ret = new DateTime(lastmon.Year, lastmon.Month, 1,
                0, 0, 0);
            return ret;
        }

        /// <summary>
        /// 获取当月1号0点0分0秒的时间字符串
        /// </summary>
        /// <param name="datetime"></param>
        /// <returns></returns>
        public static DateTime GetStartTimeOfMonth(DateTime startdatetime)
        {
            DateTime ret = new DateTime(startdatetime.Year, startdatetime.Month, 1,
                0, 0, 0);
            return ret;
        }

        /// <summary>
        /// 获取当月1号0点0分0秒的时间字符串
        /// </summary>
        /// <param name="datetime"></param>
        /// <returns></returns>
        public static String GetStartTimeStringOfMonth(DateTime datetime, eDateFormat format = eDateFormat.System)
        {
            datetime = new DateTime(datetime.Year, datetime.Month, 1, 0, 0, 0);
            String ret = GetDateTimeString(datetime, format);
            return ret;
        }

        /// <summary>
        /// 获取当月最后一天23点59分59秒的时间
        /// </summary>
        /// <param name="datetime"></param>
        /// <returns></returns>
        public static DateTime GetEndTimeOfMonth(DateTime datetime)
        {
            //1 先获取 指定日期的下个月第一天的起始时间
            DateTime curmon = GetStartTimeOfMonth(datetime);
            curmon = curmon.AddMonths(1);

            //2 把下个月起始时间减去1秒，就得到当月的最后一天日期
            DateTime lasttime = curmon.AddSeconds(-1);
            return lasttime;
        }

        /// <summary>
        /// 获取当月最后一天23点59分59秒的时间字符串
        /// </summary>
        /// <param name="datetime"></param>
        /// <returns></returns>
        public static String GetEndTimeStringOfMonth(DateTime datetime, eDateFormat format = eDateFormat.System)
        {
            DateTime retdate = GetEndTimeOfMonth(datetime);
            String ret = GetDateTimeString(retdate, format);
            return ret;
        }

        /// <summary>
        /// 计算2个日期之间,间隔的月份数
        /// 仅计算日历里的月间隔,不按照天数计算
        /// </summary>
        /// <param name="starttime"></param>
        /// <param name="endtime"></param>
        /// <returns></returns>
        public static Int32 GetMonthInterval(DateTime starttime, DateTime endtime)
        {
            if (starttime >= endtime)
            {
                return 0;
            }

            //以开始日期所在年份的1月, 作为起始
            Int32 mon1 = starttime.Month;
            Int32 mon2 = endtime.Month + (endtime.Year - starttime.Year) * 12;
            Int32 ret = mon2 - mon1;
            if (ret < 0)
            {
                ret = 0;
            }
            return ret;
        }

        #endregion

        #region BCD_HEX


        /// <summary>
        /// 1个字节的BCD转换为HEX
        /// 0x12->12
        /// </summary>
        /// <param name="bcd">BCD字节</param>
        /// <returns>Int32</returns>
        public static Byte ByteBCDToHex(Byte bcd)
        {
            Byte result = (Byte)(bcd & 0x0F); //个位
            bcd >>= 4;
            result += (Byte)(bcd * 10);       //十位
            return result;            //返回结果
        }

        /// <summary>
        /// 把数组里的每个字节,都从HEX 转换为BCD
        /// </summary> 
        /// <returns></returns>
        public static Boolean ByteArrayHexToBCD(Byte[] hexbytes, Int32 hexstart, Byte[] bcdbytes, Int32 bcdstart, Int32 len)
        {
            if (hexbytes == null || bcdbytes == null ||
                hexbytes.Length < 1 || bcdbytes.Length < 1 ||
                hexstart < 0 || bcdstart < 0 ||
                hexstart + len > hexbytes.Length ||
                bcdstart + len > bcdbytes.Length)
            {
                return false;
            }

            for (Int32 idx = 0; idx < len; ++idx)
            {
                bcdbytes[bcdstart + idx] = ByteHexToBCD(hexbytes[hexstart + idx]);
            }
            return true;
        }

        /// <summary>
        /// 把数组里的每个字节,都从BCD转换为HEX 
        /// </summary> 
        /// <returns></returns>
        public static Boolean ByteArrayBCDToHex(Byte[] bcdbytes, Int32 bcdstart, Byte[] hexbytes, Int32 hexstart, Int32 len)
        {
            if (hexbytes == null || bcdbytes == null ||
                hexbytes.Length < 1 || bcdbytes.Length < 1 ||
                hexstart < 0 || bcdstart < 0 ||
                hexstart + len > hexbytes.Length ||
                bcdstart + len > bcdbytes.Length)
            {
                return false;
            }

            for (Int32 idx = 0; idx < len; ++idx)
            {
                hexbytes[hexstart + idx] = ByteBCDToHex(bcdbytes[bcdstart + idx]);
            }
            return true;
        }

        /// <summary>
        /// 1个字节的HEX转换为BCD
        /// 64->0x64
        /// </summary>
        /// <param name="bcd">BCD字节</param>
        /// <returns>Int32</returns>
        public static Byte ByteHexToBCD(Byte val)
        {
            //如果超过99,则转换99
            if (val > 99)
            {
                return 0x99;
            }
            Byte lowval = (Byte)(val % 10);//个位
            Byte highval = (Byte)((val / 10) % 10);//十位
            Byte ret = (Byte)(lowval + (highval << 4));
            return ret;
        }

        #endregion

        #region  数值,Boolean,枚举

        /// <summary>
        /// 小数转换为字符串
        /// 不用ToString("F2")的原因是法语系统里,小数点为英文逗号
        /// </summary>
        /// <param name="val"></param>
        /// <param name="deciamlplaces"></param>
        /// <returns></returns>
        public static String FloatToString(double val, Int32 deciamlplaces = 2)
        {
            if (deciamlplaces < 1)
            {
                Int32 intval = (Int32)val;
                return intval.ToString();
            }

            if (deciamlplaces > 4)
            {
                deciamlplaces = 4;
            }

            String ret = val.ToString("F" + deciamlplaces.ToString());
            ret = ret.Replace(',', '.');
            return ret;
        }

        #region 小数转换为字符串


        /// <summary>
        /// 是否已经判断过小数点格式
        /// </summary>
        private static Boolean m_floatformatchecked = false;
        /// <summary>
        /// 是否需要手动强制转换小数为string
        /// </summary>
        private static Boolean m_ManualFloatToString = false;
        /// <summary>
        /// 判断小数点格式
        /// </summary>
        private static void CheckFloatFormat()
        {
            float f = 123.6789f;
            String ret = f.ToString();
            if (ret[3] == '.')
            {
                m_ManualFloatToString = false;
            }
            else
            {
                //区域与语言选项里,小数点不是 . 符号，则需要强制转换格式
                m_ManualFloatToString = true;
            }
            m_floatformatchecked = true;
        }

        /// <summary>
        /// 当区域与语言选项里,小数点不是'.'时，需要强制转换,把整数与小数部分分别转换,进行拼接
        /// </summary>
        /// <param name="val"></param>
        /// <param name="deciamlplaces"></param>
        /// <returns></returns>
        private static String ManualFloatToString(Decimal val, Int32 deciamlplaces = 2)
        {
            Int32 i = (Int32)val;
            Decimal d = val - i;

            String dstr = d.ToString("F" + deciamlplaces.ToString());
            //假设 小数点为 'cha', 则 0.123456 显示为 0cha123456 
            dstr = dstr.Substring(dstr.Length - deciamlplaces);
            String ret = i.ToString() + "." + dstr;
            return ret;
        }


        /// <summary> 
        /// 小数转换为字符串
        /// 不用ToString("F2")的原因是法语系统里,小数点为英文逗号
        /// </summary>
        /// <param name="val"></param>
        /// <param name="deciamlplaces"></param>
        /// <returns></returns>
        public static String FloatToString(Decimal val, Int32 deciamlplaces = 2)
        {
            if (!m_floatformatchecked)
            {
                CheckFloatFormat();
            }

            //不需要小数位数的,直接转换为整数
            if (deciamlplaces < 1)
            {
                Int32 intval = (Int32)val;
                return intval.ToString();
            }

            if (deciamlplaces > 6)
            {
                deciamlplaces = 6;
            }

            String ret = String.Empty;
            //需要手动转换小数点格式
            if (m_ManualFloatToString)
            {
                ret = ManualFloatToString(val, deciamlplaces);
            }
            else
            {
                ret = val.ToString("F" + deciamlplaces.ToString());
            }

            return ret;
        }

        #endregion

        /// <summary>
        /// Boolean 转换为 Int32 
        /// </summary>
        /// <param name="bl"></param>
        /// <returns></returns>
        public static Int32 BooleanToInt32(Boolean bl)
        {
            return bl ? 1 : 0;
        }

        /// <summary>
        /// Boolean 转换为 Int32 的字符串
        /// </summary>
        /// <param name="bl"></param>
        /// <returns></returns>
        public static String BooleanToInt32String(Boolean bl)
        {
            return bl ? "1" : "0";
        }

        /// <summary>
        /// Int32  转换为 Boolean
        /// </summary>
        /// <param name="intval"></param>
        /// <returns></returns>
        public static Boolean Int32ToBoolean(Int32 intval)
        {
            return (intval == 0) ? false : true;
        }

        /// <summary>
        /// 各种枚举值转换为Int32String
        /// </summary>
        /// <param name="bl"></param>
        /// <returns></returns>
        public static String Int32ToString(Int32 intval)
        {
            return intval.ToString();
        }

        /// <summary>
        /// 转换为16进制字符串
        /// </summary>
        /// <param name="bl"></param>
        /// <returns></returns>
        public static String ByteToHexString(Byte val)
        {
            return val.ToString("X2");
        }

        /// <summary>
        /// 转换为16进制字符串
        /// </summary>
        /// <param name="bl"></param>
        /// <returns></returns>
        public static String Int16ToHexString(Int32 val, Boolean leftisLow = false)
        {
            val = val & 0xFFFF;
            String hexstr = val.ToString("X4");
            String ret = hexstr;
            if (leftisLow)
            {
                ret = hexstr.Substring(2, 2) + hexstr.Substring(0, 2);
            }
            return ret;
        }

        /// <summary>
        /// 转换为16进制字符串
        /// </summary>
        /// <param name="bl"></param>
        /// <returns></returns>
        public static String Int32ToHexString(Int32 val, Boolean leftisLow = false)
        {
            String hexstr = val.ToString("X8");
            String ret = hexstr;
            if (leftisLow)
            {
                ret = hexstr.Substring(6, 2) + hexstr.Substring(4, 2) +
                    hexstr.Substring(2, 2) + hexstr.Substring(0, 2);
            }
            return ret;
        }

        /// <summary>
        /// Int32 的字符串  转换为 Boolean 
        /// </summary>
        /// <param name="intstr"></param>
        /// <returns></returns>
        public static Boolean Int32StringToBoolean(String intstr)
        {
            if (intstr.Length < 1)
            {
                return false;
            }
            return (intstr[0] == '0') ? false : true;
        }

        /// <summary>
        /// float列表转换为decimal列表
        /// </summary>
        /// <param name="floatlist"></param>
        /// <returns></returns>
        public static List<Decimal> FloatListToDecimalList(List<float> floatlist)
        {
            List<Decimal> ret = new List<Decimal>();
            if (floatlist == null || floatlist.Count < 1)
            {
                return ret;
            }

            foreach (float floatval in floatlist)
            {
                ret.Add((Decimal)floatval);
            }
            return ret;
        }
        #endregion

        #region 数值数组,数值列表与String的转换

        /// <summary>
        /// 使用指定间隔符,把字符串分割为多个子串,把其中每个子串转换为Int,合并到List
        /// </summary>
        /// <param name="rawdata"></param>
        /// <param name="splitter"></param>
        /// <param name="strlist"></param>
        /// <returns></returns>
        public static Boolean StringToIntArray(String rawdata, char splitter, ref Int32[] intarray)
        {
            List<Int32> intlist = new List<Int32>();
            Boolean bl = StringToIntList(rawdata, splitter, ref intlist);
            if (!bl)
            {
                return false;
            }

            intarray = intlist.ToArray();
            return true;
        }

        /// <summary>
        /// 使用指定间隔符,把字符串分割为多个子串,合并为List
        /// </summary>
        /// <param name="rawdata"></param>
        /// <param name="splitter"></param>
        /// <param name="strlist"></param>
        /// <returns></returns>
        public static Boolean StringToIntList(String rawdata, char splitter, ref List<Int32> intlist)
        {
            List<String> strlst = null;
            Boolean bl = StringToList(rawdata, splitter, ref strlst);
            if (!bl)
            {
                return false;
            }

            intlist = new List<int>();
            Int32 val;
            for (int i = 0; i < strlst.Count; i++)
            {
                bl = Int32.TryParse(strlst[i], out val);
                if (bl)
                {
                    intlist.Add(val);
                }
            }

            return (intlist.Count > 0);
        }

        /// <summary>
        /// 使用指定间隔符,把字符串分割为多个子串,合并为List
        /// </summary>
        /// <param name="rawdata"></param>
        /// <param name="splitter"></param>
        /// <param name="doublelist"></param>
        /// <returns></returns>
        public static Boolean StringToDoubleList(String rawdata, char splitter, ref List<Double> doublelist)
        {
            List<String> strlst = null;
            Boolean bl = StringToList(rawdata, splitter, ref strlst);
            if (!bl)
            {
                return false;
            }

            doublelist = new List<Double>();
            Double val;
            for (int i = 0; i < strlst.Count; i++)
            {
                bl = Double.TryParse(strlst[i], out val);
                if (bl)
                {
                    doublelist.Add(val);
                }
            }

            return (doublelist.Count > 0);
        }

        /// <summary>
        /// 使用指定间隔符,把List合并为一个字符串
        /// </summary>
        /// <param name="strlist"></param>
        /// <param name="splitter"></param>
        /// <param name="result"></param>
        /// <returns></returns>
        public static Boolean ListToString(List<String> strlist, char splitter, out String result)
        {
            result = String.Empty;
            if ((strlist == null || strlist.Count < 1))
            {
                return false;
            }

            foreach (String item in strlist)
            {
                result = result + item + splitter;
            }

            result = result.Remove(result.Length - 1, 1);
            return true;
        }


        /// <summary>
        /// 使用指定间隔字符串,把List合并为一个字符串
        /// </summary>
        /// <param name="strlist"></param>
        /// <param name="connstr"></param>
        /// <returns></returns>
        public static String ListToString(List<String> strlist, String connstr)
        {
            if ((strlist == null || strlist.Count < 1))
            {
                return String.Empty;
            }

            StringBuilder retbuild = new StringBuilder(4096);
            for (Int32 idx = 0; idx < strlist.Count; ++idx)
            {
                retbuild.Append(strlist[idx]);

                //最后一个项目,不要添加连接字符串
                if (idx < strlist.Count - 1)
                {
                    retbuild.Append(connstr);
                }
            }
            String result = retbuild.ToString();
            return result;
        }

        /// <summary>
        /// 使用指定间隔符,把List合并为一个字符串
        /// </summary>
        /// <param name="strlist"></param>
        /// <param name="connchar"></param>
        /// <returns></returns>
        public static String ListToString(List<String> strlist, Char connchar)
        {
            if ((strlist == null || strlist.Count < 1))
            {
                return String.Empty;
            }

            StringBuilder retbuild = new StringBuilder(4096);
            for (Int32 idx = 0; idx < strlist.Count; ++idx)
            {
                retbuild.Append(strlist[idx]);

                //最后一个项目,不要添加连接字符串
                if (idx < strlist.Count - 1)
                {
                    retbuild.Append(connchar);
                }
            }
            String result = retbuild.ToString();
            return result;
        }


        /// <summary>
        /// ASCII字符串转换为数值
        /// </summary>
        /// <param name="intstr"></param>
        /// <param name="defaultval"></param>
        /// <returns></returns>
        public static Int32 StringToInt(String intstr, Int32 defaultval = 0)
        {
            if (intstr.Length < 1 || intstr.Length > 10)
            {
                return defaultval;
            }

            StringBuilder retstr = new StringBuilder(8);
            Byte curchar = 0;
            Byte maxchar = (Byte)('9');
            Byte minchar = (Byte)('0');
            for (Int32 cidx = 0; cidx < intstr.Length; ++cidx)
            {
                curchar = (Byte)intstr[cidx];
                if (curchar < minchar || curchar > maxchar)//找到第一个非法的字符,就退出
                {
                    break;
                }
                retstr.Append(intstr[cidx]);
            }

            //现在尝试转换
            Int32 ret = defaultval;
            Boolean bl = Int32.TryParse(retstr.ToString(), out ret);
            return ret;
        }

        /// <summary>
        /// ASCII字符串转换为数值
        /// </summary>
        /// <param name="intstr"></param>
        /// <param name="defaultval"></param>
        /// <returns></returns>
        public static Double StringToFloat(String floatstr, Double defaultval = 0)
        {
            if (floatstr.Length < 1 || floatstr.Length > 10)
            {
                return defaultval;
            }

            StringBuilder retstr = new StringBuilder(8);
            Byte curchar = 0;
            Byte maxchar = (Byte)('9');
            Byte minchar = (Byte)('0');
            for (Int32 cidx = 0; cidx < floatstr.Length; ++cidx)
            {
                curchar = (Byte)floatstr[cidx];
                if ((curchar >= minchar && curchar <= maxchar) || (curchar == '.'))//找到第一个非法的字符,就退出
                {
                    retstr.Append(floatstr[cidx]);
                }
            }

            //现在尝试转换
            Double ret = defaultval;
            Boolean bl = Double.TryParse(retstr.ToString(), out ret);
            return ret;
        }

        /// <summary>
        /// 使用指定间隔符,把字符串分割为多个子串,合并为List
        /// </summary>
        /// <param name="rawdata"></param>
        /// <param name="splitter"></param>
        /// <param name="strlist"></param>
        /// <returns></returns>
        public static Boolean StringToList(String rawdata, char splitter,
            ref List<String> strlist, Boolean excludeempty = true)
        {
            if (String.IsNullOrEmpty(rawdata))
            {
                return false;
            }

            String[] ary = rawdata.Split(splitter);
            if ((ary == null) || (ary.Length < 1))
            {
                return false;
            }

            if (!excludeempty)
            {
                return true;
            }

            strlist = new List<string>();
            //过滤空行
            for (int i = 0; i < ary.Length; ++i)
            {
                ary[i] = ary[i].Trim();
                if (ary[i].Length > 0)
                {
                    strlist.Add(ary[i]);
                }
            }
            return true;
        }

        /// <summary>
        /// 使用指定间隔符,把字符串分割为多个子串,合并为List
        /// </summary>
        /// <param name="rawdata"></param>
        /// <param name="splitter"></param>
        /// <param name="strlist"></param>
        /// <returns></returns>
        public static Boolean StringToList(String rawdata, String splitterstr,
            ref List<String> strlist, Boolean excludeempty = true)
        {
            if (String.IsNullOrEmpty(rawdata) || String.IsNullOrEmpty(splitterstr))
            {
                return false;
            }

            strlist = new List<string>();
            Int32 itemstart = 0; //当前有效字符串的起始字符下标
            Int32 matchidx = 0;//匹配项所在下标
            String itemstr = String.Empty;
            while (true)
            {
                //从上次字符串末尾开始,查找下一个 匹配项
                matchidx = rawdata.IndexOf(splitterstr, itemstart);
                if (matchidx < 0)
                {
                    //把最后一部分内容添加到列表里
                    if (itemstart < rawdata.Length - 1)
                    {
                        itemstr = rawdata.Substring(itemstart);
                        itemstr = itemstr.Trim();
                        strlist.Add(itemstr);
                    }
                    break;
                }

                //0123AB6789 10 AB 13 14
                //start = 6, matchidx = 11, len = matchidx-start
                //Next item start = 13 = matchidx + len
                if (matchidx > itemstart)
                {
                    itemstr = rawdata.Substring(itemstart, matchidx - itemstart);
                    itemstr = itemstr.Trim();
                    strlist.Add(itemstr);
                }
                else
                {
                    if (!excludeempty)
                    {
                        //添加空行
                        strlist.Add(String.Empty);
                    }
                }

                itemstart = matchidx + splitterstr.Length;
            }

            return ((strlist != null) && (strlist.Count > 0));
        }

        #endregion

        #region Boolean数组与Int数组,String转换


        /// <summary>
        /// 把字符串列表转换为Boolean数组
        /// </summary>
        /// <param name="boolliststr"></param>
        /// <param name="boolary"></param>
        /// <returns></returns>
        public static Boolean StringToBooleanArray(String boolliststr, ref Boolean[] boolary)
        {
            if (boolary == null)
            {
                return false;
            }

            Int32 len = (boolliststr.Length > boolary.Length) ? boolary.Length : boolliststr.Length;
            for (Int32 idx = 0; idx < len; ++idx)
            {
                boolary[idx] = (boolliststr[idx] == '0') ? false : true;
            }

            return true;
        }

        /// <summary>
        /// 把Boolean数组转换为字符串列表
        /// </summary>
        /// <param name="boolary"></param>
        /// <param name="boolliststr"></param>
        /// <returns></returns>
        public static String BooleanArrayToString(Boolean[] boolary)
        {
            if (boolary == null)
            {
                return String.Empty;
            }
            String boolliststr = String.Empty;
            String itemstr = String.Empty;
            foreach (Boolean bl in boolary)
            {
                itemstr = bl ? "1" : "0";
                boolliststr = boolliststr + itemstr;
            }

            return boolliststr;
        }

        /// <summary>
        /// 把Boolean数组转换为数值数组
        /// </summary>
        /// <param name="boolary"></param>
        /// <param name="intarray"></param>
        /// <returns></returns>
        public static Boolean BooleanArrayToInt32Array(Boolean[] boolary, Int32[] intarray)
        {
            if (boolary == null || intarray == null ||
                boolary.Length < 1 || intarray.Length < 1 || boolary.Length != intarray.Length)
            {
                return false;
            }

            for (Int32 idx = 0; idx < intarray.Length; ++idx)
            {
                intarray[idx] = boolary[idx] ? 1 : 0;
            }
            return true;
        }

        /// <summary>
        /// 把Boolean数组转换为数值数组
        /// </summary>
        /// <param name="boolary"></param>
        /// <param name="intarray"></param>
        /// <returns></returns>
        public static Int32[] BooleanArrayToInt32Array(Boolean[] boolary)
        {
            if (boolary == null || boolary.Length < 1)
            {
                return null;
            }

            Int32[] intarray = new Int32[boolary.Length];
            for (Int32 idx = 0; idx < boolary.Length; ++idx)
            {
                intarray[idx] = boolary[idx] ? 1 : 0;
            }
            return intarray;
        }

        /// <summary>
        /// 把数值数组转换为Boolean数组
        /// </summary>
        /// <param name="boolary"></param>
        /// <param name="intarray"></param>
        /// <returns></returns>
        public static Boolean Int32ArrayToBooleanArray(Int32[] intarray, Boolean[] boolary)
        {
            if (boolary == null || intarray == null ||
                boolary.Length < 1 || intarray.Length < 1 || boolary.Length != intarray.Length)
            {
                return false;
            }

            for (Int32 idx = 0; idx < intarray.Length; ++idx)
            {
                boolary[idx] = (intarray[idx] == 0) ? false : true;
            }
            return true;
        }


        /// <summary>
        /// 把数值数组转换为Boolean数组
        /// </summary>
        /// <param name="boolary"></param>
        /// <param name="intarray"></param>
        /// <returns></returns>
        public static Boolean[] Int32ArrayToBooleanArray(Int32[] intarray)
        {
            if (intarray == null || intarray.Length < 1)
            {
                return null;
            }
            Boolean[] boolary = new Boolean[intarray.Length];
            for (Int32 idx = 0; idx < intarray.Length; ++idx)
            {
                boolary[idx] = (intarray[idx] == 0) ? false : true;
            }
            return boolary;
        }

        #endregion

        #region 字节数组与数值转换

        /// <summary>
        /// 单字节无符号数转换为有符号数字
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        public static Int32 UnsignedByteToSignedInt(Byte val)
        {
            //0-127 直接转换
            //128-255 ->  -128 - -1
            if (val < 128)
            {
                return val;
            }

            Int32 ret = (Int32)val - 256;
            return 0;
        }

        /// <summary>
        /// 单字节无符号数转换为有符号数字
        /// </summary>
        /// <param name="val"></param>
        /// <returns></returns>
        public static Byte SignedIntToUnsignedByte(Int32 val)
        {
            Byte ret = 0;
            if (val > 127)
            {
                return 127;
            }

            //0-127 直接转换
            if (val >= 0)
            {
                ret = (Byte)val;
                return ret;
            }

            //-128 - -1  ->  128-255
            ret = (Byte)(val + 256);
            return ret;
        }


        /// <summary>
        /// 字节转换为Int16
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static Int32 BytesToInt16(Byte[] bytes, Int32 startidx, Boolean lowfirst = true)
        {
            if (bytes == null || startidx < 0 || startidx + 2 > bytes.Length)
            {
                return 0;
            }

            Int32 ret = 0;
            if (lowfirst) //低字节存放低位
            {
                ret = bytes[startidx] + (bytes[startidx + 1] << 8);
            }
            else
            {
                //低字节存放高位
                ret = (bytes[startidx] << 8) + bytes[startidx + 1];
            }
            return ret;
        }

        /// <summary>
        /// BCD字节转换为Int16
        /// 举例: 0x12 0x34 -> 1234
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static Int32 BCDBytesToInt16(Byte[] bytes, Int32 startidx, Boolean lowfirst = true)
        {
            if (bytes == null || startidx < 0 || startidx + 2 > bytes.Length)
            {
                return 0;
            }

            Byte b0 = ByteBCDToHex(bytes[startidx]);
            Byte b1 = ByteBCDToHex(bytes[startidx + 1]);
            Int32 ret = 0;
            if (lowfirst) //低字节存放低位
            {
                ret = b0 + b1 * 100;
            }
            else
            {
                //低字节存放高位
                ret = b0 * 100 + b1;
            }
            return ret;
        }

        /// <summary>
        /// 字节转换为Int16
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static Int32 BytesToInt16(Byte[] bytes, Boolean lowfirst = true)
        {
            return BytesToInt16(bytes, 0, lowfirst);
        }

        /// <summary>
        /// 字节转换为Int16
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static Int32 BCDBytesToInt16(Byte[] bytes, Boolean lowfirst = true)
        {
            return BCDBytesToInt16(bytes, 0, lowfirst);
        }

        /// <summary>
        /// 字节转换为Int32
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static Int32 BytesToInt32(Byte[] bytes, Int32 startidx, Boolean lowfirst = true)
        {
            if (bytes == null || startidx < 0 || startidx + 4 > bytes.Length)
            {
                return 0;
            }
            Int32 ret = 0;

            if (lowfirst)
            {
                ret = bytes[startidx] +
                     (bytes[startidx + 1] << 8) +
                     (bytes[startidx + 2] << 16) +
                     (bytes[startidx + 3] << 24);
            }
            else
            {
                ret = bytes[startidx + 3] +
                     (bytes[startidx + 2] << 8) +
                     (bytes[startidx + 1] << 16) +
                     (bytes[startidx] << 24);
            }
            return ret;
        }

        /// <summary>
        /// 字节转换为Int32
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static Int32 BCDBytesToInt32(Byte[] bytes, Int32 startidx, Boolean lowfirst = true)
        {
            if (bytes == null || startidx < 0 || startidx + 4 > bytes.Length)
            {
                return 0;
            }
            Int32 ret = 0;

            Byte[] hexbytes = new Byte[4];
            ByteArrayBCDToHex(bytes, startidx, hexbytes, 0, 4);
            if (lowfirst)
            {
                ret = hexbytes[0] +
                     (hexbytes[1] * 100) +
                     (hexbytes[2] * 10000) +
                     (hexbytes[3] * 1000000);
            }
            else
            {
                ret = hexbytes[3] +
                     (hexbytes[2] * 100) +
                     (hexbytes[1] * 10000) +
                     (hexbytes[0] * 1000000);
            }
            return ret;
        }

        /// <summary>
        /// 字节转换为Int32
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static Int32 BytesToInt32(Byte[] bytes, Boolean lowfirst = true)
        {
            return BytesToInt32(bytes, 0, lowfirst);
        }

        /// <summary>
        /// 字节转换为Int32
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static Int32 BCDBytesToInt32(Byte[] bytes, Boolean lowfirst = true)
        {
            return BCDBytesToInt32(bytes, 0, lowfirst);
        }

        /// <summary>
        /// 数值转换为2字节数组
        /// </summary>
        /// <param name="val"></param>
        /// <param name="bytes"></param>
        /// <param name="start"></param>
        public static void Int16ToBytes(Int32 val, ref Byte[] bytes, Int32 start, Boolean lowfirst = true)
        {
            if (bytes == null || bytes.Length < 2 || bytes.Length < start + 2)
            {
                bytes = new Byte[start + 2];
            }

            bytes[start] = (Byte)(val & 0xFF);
            bytes[start + 1] = (Byte)((val >> 8) & 0xFF);

            if (!lowfirst)
            {
                Array.Reverse(bytes, start, 2);
            }
        }

        /// <summary>
        /// 数值转换为2字节数组
        /// </summary>
        /// <param name="val"></param>
        /// <param name="bytes"></param>
        public static void Int16ToBytes(Int32 val, ref Byte[] bytes, Boolean lowfirst = true)
        {
            Int16ToBytes(val, ref bytes, 0, lowfirst);
        }

        /// <summary>
        /// 数值转换为2字节数组
        /// </summary>
        /// <param name="val"></param>
        /// <param name="bytes"></param>
        /// <param name="start"></param>
        public static void Int16ToBCDBytes(Int32 val, ref Byte[] bytes, Int32 start, Boolean lowfirst = true)
        {
            if (bytes == null || bytes.Length < 2 || bytes.Length < start + 2)
            {
                bytes = new Byte[start + 2];
            }

            //1234 -> 0x1234
            bytes[start] = ByteHexToBCD((Byte)(val % 100));
            bytes[start + 1] = ByteHexToBCD((Byte)((val / 100) % 100));

            if (!lowfirst)
            {
                Array.Reverse(bytes, start, 2);
            }
        }

        /// <summary>
        /// 数值转换为2字节数组
        /// </summary>
        /// <param name="val"></param>
        /// <param name="bytes"></param>
        public static void Int16ToBCDBytes(Int32 val, ref Byte[] bytes, Boolean lowfirst = true)
        {
            Int16ToBytes(val, ref bytes, 0, lowfirst);
        }

        /// <summary>
        /// 数值转换为4字节数组
        /// </summary>
        /// <param name="val"></param>
        /// <param name="bytes"></param>
        public static Boolean Int32ToBytes(Int32 val, ref Byte[] bytes, Int32 start, Boolean lowfirst = true)
        {
            if (bytes == null || bytes.Length < 4 || bytes.Length < start + 4)
            {
                bytes = new Byte[start + 4];
            }

            for (Int32 bidx = 0; bidx < 4; ++bidx)
            {
                bytes[bidx + start] = (Byte)(val & 0xFF);
                val = val >> 8;
            }
            if (!lowfirst)
            {
                Array.Reverse(bytes);
            }
            return true;
        }

        /// <summary>
        /// 数值转换为4字节数组
        /// </summary>
        /// <param name="val"></param>
        /// <param name="bytes"></param>
        public static Boolean Int32ToBytes(Int32 val, ref Byte[] bytes, Boolean lowfirst = true)
        {
            Boolean bl = Int32ToBytes(val, ref bytes, 0, lowfirst);
            return bl;
        }

        /// <summary>
        /// 数值转换为4字节数组
        /// </summary>
        /// <param name="val"></param>
        /// <param name="bytes"></param>
        /// <param name="start"></param>
        public static Boolean Int32ToBCDBytes(Int32 val, ref Byte[] bytes, Int32 start, Boolean lowfirst = true)
        {
            if (bytes == null || bytes.Length < 4 || bytes.Length < start + 4)
            {
                bytes = new Byte[start + 4];
            }

            for (Int32 bidx = 0; bidx < 4; ++bidx)
            {
                bytes[start + bidx] = ByteHexToBCD((Byte)(val % 100));
                val = val / 100;
            }

            if (!lowfirst)
            {
                Array.Reverse(bytes, start, 4);
            }
            return true;
        }

        /// <summary>
        /// 数值转换为4字节数组
        /// </summary>
        /// <param name="val"></param>
        /// <param name="bytes"></param>
        public static void Int32ToBCDBytes(Int32 val, ref Byte[] bytes, Boolean lowfirst = true)
        {
            Int32ToBCDBytes(val, ref bytes, 0, lowfirst);
        }

        #endregion

        #region 对象序列化反序列化


        /// <summary>
        /// 把对象转换为字节流
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static Boolean ObjectToBytes(Object obj, ref Byte[] bytes)
        {
            if (obj == null)
            {
                return false;
            }

            IFormatter formatter = new BinaryFormatter();
            MemoryStream stream = new MemoryStream();
            formatter.Serialize(stream, obj);

            bytes = stream.ToArray();
            stream.Close();

            if (bytes == null || bytes.Length < 1)
            {
                return false;
            }
            return true;
        }


        /// <summary>
        /// 把字节流转换为对象
        /// </summary>
        /// <param name="obj"></param>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static Boolean BytesToObject(Byte[] bytes, ref Object obj)
        {
            obj = null;
            if (bytes == null || bytes.Length < 1)
            {
                return false;
            }

            MemoryStream stream = new MemoryStream(bytes);
            IFormatter formatter = new BinaryFormatter();
            obj = formatter.Deserialize(stream);
            stream.Close();

            if (obj == null)
            {
                return false;
            }
            return true;
        }

        #endregion

        #region 显示处理

        /// <summary>
        /// 把int类型的数据转换成K或则M
        /// </summary>
        /// <param name="bytes"></param>
        /// <returns></returns>
        public static String GetDispDataLengthString(long bytes)
        {
            String datalenstr = "";
            float flen = 0;
            if (bytes < 1024)
            {
                datalenstr = bytes.ToString() + " B";
            }
            else if (bytes >= 1024 && bytes < 1024 * 1024)
            {
                flen = (float)bytes / 1024;
                datalenstr = flen.ToString("F2") + " K";
            }
            else
            {
                flen = (float)bytes / (1024 * 1024);
                datalenstr = flen.ToString("F2") + " M";
            }
            return datalenstr;
        }

        #endregion

        #region HTTP协议相关

        /// <summary>
        /// 普通文本转换为URL格式文本.
        /// 中国ab12!#  -> %e4%b8%ad%e5%9b%bdab12!%23
        /// </summary>
        /// <param name="rawstring">普通文本</param>
        /// <param name="encoding">编码器</param>
        /// <returns>URL格式文本</returns>
        public static String StringToHttpURL(String rawstring, Encoding encoding)
        {
            if (String.IsNullOrEmpty(rawstring))
            {
                return String.Empty;
            }
            String utfstr = Uri.EscapeUriString(rawstring);

            return utfstr;
        }

        /// <summary>
        /// 根据名称获取编码器
        /// </summary>
        /// <param name="encoding"></param>
        /// <returns></returns>
        public static Encoding GetEncodingByName(String encoding)
        {
            Encoding ecd = Encoding.Default;
            try
            {
                ecd = Encoding.GetEncoding(encoding);
            }
            catch (System.Exception ex)
            {
                Console.WriteLine("StringToHttpURL err:" + ex.Message);
                ecd = Encoding.Default;
            }

            return ecd;
        }

        /// <summary>
        /// 普通文本转换为URL格式文本.
        /// 中国ab12!#  -> %e4%b8%ad%e5%9b%bdab12!%23
        /// </summary>
        /// <param name="rawstring">普通文本</param>
        /// <param name="encoding">编码类型,GB2312,UTF-8, US-ASCII,UTF-16</param>
        /// <returns>URL格式文本</returns>
        public static String StringToHttpURL(String rawstring, String encoding)
        {
            Encoding ecd = GetEncodingByName(encoding);
            String utfstr = StringToHttpURL(rawstring, ecd);
            return utfstr;
        }

        /// <summary>
        /// 普通文本转换为URL格式文本.
        /// 中国ab12!#  -> %e4%b8%ad%e5%9b%bdab12!%23
        /// </summary>
        /// <param name="rawstring">普通文本</param>
        /// <param name="encoding">编码类型,GB2312,UTF-8, US-ASCII,UTF-16</param>
        /// <returns>URL格式文本</returns>
        public static String StringToHttpURL(String rawstring)
        {
            String utfstr = StringToHttpURL(rawstring, Encoding.Default);
            return utfstr;
        }

        /// <summary>
        /// URL格式文本 转换为 普通文本
        /// %e4%b8%ad%e5%9b%bdab12!%23 -> 中国ab12!# 
        /// </summary>
        /// <param name="urlstring">URL格式文本</param>
        /// <param name="encoding">编码器</param>
        /// <returns>普通文本</returns>
        public static String HttpURLToString(String urlstring, Encoding encoding)
        {
            if (String.IsNullOrEmpty(urlstring))
            {
                return String.Empty;
            }
            String decodestr = Uri.UnescapeDataString(urlstring);
            return decodestr;
        }


        /// <summary>
        /// URL格式文本 转换为 普通文本
        /// %e4%b8%ad%e5%9b%bdab12!%23 -> 中国ab12!# 
        /// </summary>
        /// <param name="urlstring">URL格式文本</param>
        /// <param name="encoding">编码类型,GB2312,UTF-8, US-ASCII,UTF-16</param>
        /// <returns>普通文本</returns>
        public static String HttpURLToString(String urlstring, String encoding)
        {
            Encoding ecd = GetEncodingByName(encoding);
            String rawstr = HttpURLToString(urlstring, ecd);
            return rawstr;
        }

        /// <summary>
        /// URL格式文本 转换为 普通文本
        /// %e4%b8%ad%e5%9b%bdab12!%23 -> 中国ab12!# 
        /// </summary>
        /// <param name="urlstring">URL格式文本</param>
        /// <param name="encoding">编码类型,GB2312,UTF-8, US-ASCII,UTF-16</param>
        /// <returns>普通文本</returns>
        public static String HttpURLToString(String urlstring)
        {
            String rawstr = HttpURLToString(urlstring, Encoding.Default);
            return rawstr;
        }

        /// <summary>
        /// URL字符串转换为哈希表
        /// </summary>
        /// <param name="urlpathquery"></param>
        /// <param name="key_valdic"></param>
        /// <param name="keyTolower">key固定转换为小写</param>
        /// <returns></returns>
        public static Boolean URLStringToDictionary(String urlpathquery, ref Dictionary<String, String> key_valdic,
                                                    Boolean keyTolower = true)
        {
            if (String.IsNullOrEmpty(urlpathquery))
            {
                return false;
            }
            Boolean bl = false;
            List<String> strlist = new List<String>();
            bl = DataFormatProcessor.StringToList(urlpathquery, '&', ref strlist);
            if (!bl || strlist == null || strlist.Count < 1)
            {
                return false;
            }
            String name = String.Empty;
            String value = String.Empty;
            key_valdic = new Dictionary<String, String>();
            foreach (String stritem in strlist)
            {
                if (keyTolower)
                {
                    name = name.ToLower();//固定使用小写
                }
                bl = DataFormatProcessor.GetStringPair(stritem, '=', ref name, ref value);
                if (bl)
                {
                    key_valdic[name] = value;
                }
            }
            return true;
        }

        #endregion

        #region 字符串处理


        /// <summary>
        /// 从原始字符串里指定位置开始,读取到下个分隔符之前的字符串.
        /// 随后把指针位置指向到分隔符后1字符
        /// 若没有分隔符，则返回失败
        /// </summary>
        /// <param name="rawstr">原始字符串</param>
        /// <param name="splitter">分隔字符</param>
        /// <param name="startidx">起始位置,不允许为分隔符</param>
        /// <returns>获取到非空字符串返回true,其他返回false</returns>
        public static Boolean ReadStringBeforeSplitter(String rawstr, Char splitter, out String valstr, ref Int32 startidx)
        {
            valstr = String.Empty;
            if ((rawstr.Length < 2) || (startidx + 1 >= rawstr.Length))
            {
                return false;
            }

            Int32 splitidx = rawstr.IndexOf(splitter, startidx);
            if ((startidx < 0) || (splitidx < 0) || (startidx >= splitidx))
            {
                return false;
            }
            valstr = rawstr.Substring(startidx, splitidx - startidx);
            startidx = splitidx + 1;
            return true;
        }


        /// <summary>
        /// 获取间隔符之前的字符串
        /// </summary>
        /// <param name="rawstr"></param>
        /// <param name="splitter"></param>
        /// <returns></returns>
        public static String GetNameOfPair(String rawstr, char splitter)
        {
            if (rawstr.Length < 1)
            {
                return String.Empty;
            }
            int idx = rawstr.IndexOf(splitter);
            if (idx < 1)
            {
                return String.Empty;
            }

            //ABC=123, idx==3
            string ret = rawstr.Substring(0, idx);
            return ret;
        }

        /// <summary>
        /// 获取间隔符之后的字符串
        /// </summary>
        /// <param name="rawstr"></param>
        /// <param name="splitter"></param>
        /// <returns></returns>
        public static String GetValueOfPair(String rawstr, char splitter)
        {
            int idx = rawstr.IndexOf(splitter);
            if (idx < 0)
            {
                return String.Empty;
            }

            if (idx >= rawstr.Length - 1)
            {
                return String.Empty;
            }

            string ret = rawstr.Substring(idx + 1);
            return ret;
        }

        /// <summary>
        /// 获取间隔符前后的字符串
        /// </summary>
        /// <param name="rawstr"></param>
        /// <param name="splitter"></param>
        /// <param name="name"></param>
        /// <param name="value"></param>
        /// <param name="ignorespace">过滤空格</param>
        /// <returns></returns>
        public static Boolean GetStringPair(String rawstr, char splitter,
            ref String name, ref String value, bool excludespace = true)
        {
            int idx = rawstr.IndexOf(splitter);
            if (idx < 1 || idx + 1 >= rawstr.Length)
            {
                return false;
            }

            name = rawstr.Substring(0, idx);
            value = rawstr.Substring(idx + 1);

            if (excludespace)
            {
                name = name.Trim();
                value = value.Trim();
                if (name.Length < 1 || value.Length < 1)
                {
                    return false;
                }
            }

            return true;
        }

        /// <summary>
        /// 获取字符串的行数
        /// </summary>
        /// <param name="rawstr"></param>
        /// <returns></returns>
        public static Int32 GetLines(String rawstr)
        {
            if (rawstr.Length < 1)
            {
                return 0;
            }

            rawstr = rawstr.Trim();
            Int32 lines = 0;
            for (Int32 idx = 0; idx < rawstr.Length; ++idx)
            {
                if (rawstr[idx] == '\n')
                {
                    ++lines;
                }
            }
            return lines;
        }

        #endregion

    }
}
