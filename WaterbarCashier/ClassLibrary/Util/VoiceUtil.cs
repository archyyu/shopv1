using NAudio.Wave;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;

namespace CashierLibrary.Util
{
    public class VoiceUtil
    {

        private static String API_KEY = "O1Yv9AeW0skrrbEGCbqsRMIB";
        private static String SECRET_KEY = "166ilz44P5Vaf7hEOSpLxrvrwuyOanMC";

        public static void PlayText(string text)
        {
            Thread threadB = new Thread(
                () => {
                    VoiceUtil.playInner(text);
                }
                );
            threadB.Start();
        }

        private static void playInner(String text)
        {
            try
            {
                var client = new Baidu.Aip.Speech.Tts(API_KEY, SECRET_KEY);
                // 可选参数
                var option = new Dictionary<string, object>()
                {
                    {"spd", 5}, // 语速
                    {"vol", 7}, // 音量
                    {"per", 0}  // 发音人，4：情感度丫丫童声
                };
                var result = client.Synthesis(text, option);

                if (result.ErrorCode == 0)  // 或 result.Success
                {
                    using (var sm = new MemoryStream(result.Data))
                    using (var rdr = new Mp3FileReader(sm))
                    using (var wavStream = WaveFormatConversionStream.CreatePcmStream(rdr))
                    using (var baStream = new BlockAlignReductionStream(wavStream))
                    using (var waveOut = new WaveOut(WaveCallbackInfo.FunctionCallback()))
                    {
                        waveOut.Init(baStream);
                        waveOut.Play();
                        while (waveOut.PlaybackState == PlaybackState.Playing)
                        {
                            Thread.Sleep(100);
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                LogHelper.WriteLog("ex",ex);
            }
        }

    }
}
