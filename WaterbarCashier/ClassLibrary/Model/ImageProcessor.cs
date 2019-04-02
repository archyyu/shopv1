using System;
using System.Collections.Generic;
using System.Text;
using System.IO;
using System.Windows.Forms;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;

namespace CashierLibrary.Model
{

    public enum ePictureFileFormat
    {
        Bmp = 0,
        Gif = 1,
        Icon = 2,
        Jpeg = 3,
        Png = 4,
    }

    /// <summary>
    /// 转为灰度图像的方式
    /// </summary>
    public enum eGrayMode
    {
        /// <summary>
        /// 算数平均
        /// </summary>
        ArithmeticAverage = 0,
        /// <summary>
        /// 加权平均
        /// </summary>
        WeightedAverage = 1,
    }

    /// <summary>
    /// 比较2个图片的指定区域范围,像素的相同类型
    /// </summary>
    public enum eAreaDifferentType
    {
        /// <summary>
        /// 所有像素都相同
        /// </summary>
        AllSame = 0,
        /// <summary>
        /// 所有像素都不同
        /// </summary>
        AllDifferent = 1,
        /// <summary>
        /// 部分相同部分不同
        /// </summary>
        Partial = 2,
    }

    public class ImageProcessor
    {
        #region 常量定义

        public const Byte Const_BrightnessWhite = 255;
        public const Byte Const_BrightnessBlack = 0;


        /// <summary>
        /// 比较结果的图片里，亮度相同部分的填充颜色
        /// </summary>
        public static Color Const_SameBrightnessColor = Color.Black;
        /// <summary>
        /// 比较结果的图片里，亮度相同部分的填充颜色
        /// </summary>
        public static Color Const_DifferentBrightnessColor = Color.White;

        public const Byte Const_BlackBrightness = 0;
        public const Byte Const_WhiteBrightness = 255;
        public const Int32 Const_MaxBrightness = 255;

        public const Int32 Const_MinBrightness = -255;

        /// <summary>
        /// 亮度的中间值
        /// </summary>
        public const Int32 Const_MiddleBrightness = 128;
        #endregion
        /// <summary>         
        /// 重新设置图片尺寸     
        /// </summary> 
        /// <param name="srcbitmap">original Bitmap</param>         
        /// <param name="newW">new width</param>         
        /// <param name="newH">new height</param>         
        /// <returns>worked bitmap</returns> 
        public static Boolean ResizeImage(Bitmap srcimg, int newW, int newH, ref Bitmap destimage)
        {
            if (srcimg == null)
            {
                return false;
            }

            destimage = new Bitmap(newW, newH);
            Graphics graph = Graphics.FromImage(destimage);
            Boolean bl = true;
            try
            {
                graph.InterpolationMode = InterpolationMode.HighQualityBicubic;
                graph.DrawImage(srcimg, new Rectangle(0, 0, newW, newH),
                    new Rectangle(0, 0, srcimg.Width, srcimg.Height),
                    GraphicsUnit.Pixel);

                graph.Dispose();
            }
            catch (Exception ex)
            {
                //Console.WriteLine("ResizeImage error" + ex.Message);
                bl = false;
            }
            return bl;
        }
        /// <summary>
        /// 装载图像文件
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        public static Bitmap LoadBitImage(String filename)
        {
            Bitmap ret = (Bitmap)LoadImage(filename);
            return ret;
        }
        /// <summary>
        /// 把图片转换为非黑即白的二色图.
        /// </summary>
        /// <param name="bitmap">原始图</param>
        /// <param name="brightnessGate">亮度门限.超过此亮度认为白点,否则认为黑点</param>
        /// <param name="bitary">每个像素点是否为黑点的数组</param>
        /// <param name="trueAsblack">true-每个元素黑点为true,白点为false; false-每个元素白点为true,黑点为false</param>
        /// <returns></returns>
        public static Boolean ToBooleanArray(Bitmap bitmap, Byte brightnessGate, ref Boolean[] bitary, Boolean trueAsblack = true)
        {
            if (bitmap == null)
            {
                return false;
            }

            bitary = new Boolean[bitmap.Width * bitmap.Height];

            int width = bitmap.Width;
            int height = bitmap.Height;

            byte curcolor = 0;
            Int32 pixidx = 0;
            Boolean bl = false;
            try
            {
                BitmapData srcData = bitmap.LockBits(new Rectangle(0, 0, width, height),
                    ImageLockMode.ReadWrite, PixelFormat.Format24bppRgb);
                unsafe
                {
                    byte* curpix = (byte*)srcData.Scan0.ToPointer();

                    for (int y = 0; y < height; y++)
                    {
                        for (int x = 0; x < width; x++)
                        {
                            curcolor = (byte)((float)(curpix[0] + curpix[1] + curpix[2]) / 3.0f);

                            if (trueAsblack)//true为黑点
                            {
                                bitary[pixidx] = (curcolor < brightnessGate);
                            }
                            else
                            {
                                //true为白点
                                bitary[pixidx] = (curcolor > brightnessGate);
                            }
                            ++pixidx;
                            curpix += 3;
                        }
                        curpix += srcData.Stride - width * 3;
                    }
                    bitmap.UnlockBits(srcData);
                }

                bl = true;
            }
            catch (Exception ex)
            {
                //Console.WriteLine("ToGray error:" + ex.Message);
                bl = false;
            }

            return bl;
        }
        public static Image LoadImage(String filename)
        {
            //Boolean bl = FileProcessor.FileExist(filename);
            //if (!bl)
            //{
            //    return null;
            //}
            //Bitmap image = (Bitmap)Bitmap.FromFile(filename);
            //return image;

            //以上方法会导致图片文件被锁定,无法删除移动

            Byte[] photodata = null;
            Boolean bl = FileProcessor.FileExist(filename);
            if (!bl)
            {
                return null;
            }

            bl = FileProcessor.ReadFileBytes(filename, out photodata);
            if (!bl)
            {
                return null;
            }

            MemoryStream ms = null;
            Image myImage = null;
            try
            {
                ms = new MemoryStream(photodata);
                myImage = Bitmap.FromStream(ms);
                ms.Close();
            }
            catch (System.Exception ex)
            {
                //Console.WriteLine("LoadImage error:" + ex.Message);
                myImage = null;
            }
            return myImage;
        }
    }
}
