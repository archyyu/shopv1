using System;
using System.Collections.Generic;
using System.Text;
using System.Net;
using System.Net.Sockets;
using CashierLibrary.Util;
using CashierLibrary.Model;
using System.Speech.Synthesis;

namespace Cashier.Util
{
	class PlayerUtil
    {
        
        public int playText(String text)
        {
            
            return this.playContent(text); 
        }

        private void PlayContent(String text)
        {
            LogHelper.WriteLog("读取语音：+++++++"+text);
            SpeechSynthesizer synth = new SpeechSynthesizer();
            synth.SpeakAsync(text);
        }

        public int playContent(String text)
        {

            IPAddress ip = IPAddress.Parse(IniUtil.radiohost());
            Socket clientSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);

            IAsyncResult connResult = clientSocket.BeginConnect(ip, 9194, null, null);
            connResult.AsyncWaitHandle.WaitOne(500, true);  //等待2秒
            if (!connResult.IsCompleted)
            {

                clientSocket.Close();
                Console.WriteLine("连接服务器失败");
                return -1;
            }
            else
            {
                //处理连接成功的动作
            }



            PlayVoice item = new PlayVoice();
            item.AppName = "common";
            item.VoiceStyle = "vcn=aisxmeng, spd=5, vol=x-loud";
            item.VoiceText = text;

            IDictionary<String, Object> map = new Dictionary<String, Object>();
            map.Add("PlayVoice", item);

            String body = JsonUtil.SerializeObject(map);

            Int32 size = System.Text.Encoding.Default.GetBytes(body.ToCharArray()).Length;
            byte[] arr = this.convertIntToByteArray(size);

            clientSocket.Send(arr);
            clientSocket.Send(Encoding.GetEncoding("GB18030").GetBytes(body));
            clientSocket.Shutdown(SocketShutdown.Both);
            clientSocket.Close();
            return 0;
        }

        public int PlayRealManVoice(String text)
        {
            IPAddress ip = IPAddress.Parse(IniUtil.radiohost());
            Socket clientSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
            IAsyncResult connResult = clientSocket.BeginConnect(ip, 9194, null, null);
            connResult.AsyncWaitHandle.WaitOne(500, true);  //等待2秒
            if (!connResult.IsCompleted)
            {
                clientSocket.Close();
                Console.WriteLine("连接服务器失败");
                return -1;
            }
            else
            {
                //处理连接成功的动作
            }

            PlayVoice item = new PlayVoice();
            item.AppName = "CallManager";
            item.VoiceStyle = "普通话";
            item.VoiceText = text;
            item.VoiceManner = "vcn=aisxmeng, spd=6, vol=3";
            item.VoicePlayVolume = "32";
            item.VoiceFileList = new List<string> { "常规1.mp3",
            "p.mp3",
            "c.mp3",
            "l.mp3",
            "u.mp3",
            "y.mp3",
            "a.mp3",
            "n.mp3",
            "g.mp3",
            "常规2.mp3" };
            String body = JsonUtil.SerializeObject(new { PlayVoice=item });
            Int32 size = System.Text.Encoding.Default.GetBytes(body.ToCharArray()).Length;
            byte[] arr = this.convertIntToByteArray(size);

            clientSocket.Send(arr);
            clientSocket.Send(Encoding.GetEncoding("GB18030").GetBytes(body));
            clientSocket.Shutdown(SocketShutdown.Both);
            clientSocket.Close();
            return 0;
        }

        public byte[] convertIntToByteArray(Int32 m)
        {
            byte[] arry = new byte[4];

            arry[0] = (byte)(m & 0xFF);
            arry[1] = (byte)((m & 0xFF00) >> 8);
            arry[2] = (byte)((m & 0xFF0000) >> 16);
            arry[3] = (byte)((m >> 24) & 0xFF);

            return arry;
        }

        public string strFilter(string str)
        {

            str = str.Replace('`', ' ');
            str = str.Replace('·', ' ');
            str = str.Replace('~', ' ');
            str = str.Replace('!', ' ');
            str = str.Replace('！', ' ');
            str = str.Replace('@', ' ');
            str = str.Replace('#', ' ');
            str = str.Replace('$', ' ');
            str = str.Replace('￥', ' ');
            str = str.Replace('%', ' ');
            str = str.Replace('^', ' ');
            str = str.Replace('…', ' ');
            str = str.Replace('&', ' ');
            str = str.Replace('*', ' ');
            str = str.Replace('(', ' ');
            str = str.Replace(')', ' ');
            str = str.Replace('（', ' ');
            str = str.Replace('）', ' ');
            str = str.Replace('-', ' ');
            str = str.Replace('_', ' ');
            str = str.Replace('+', ' ');
            str = str.Replace('=', ' ');
            str = str.Replace('|', ' ');
            str = str.Replace('\\', ' ');
            str = str.Replace('[', ' ');
            str = str.Replace(']', ' ');
            str = str.Replace('【', ' ');
            str = str.Replace('】', ' ');
            str = str.Replace('{', ' ');
            str = str.Replace('}', ' ');
            str = str.Replace(';', ' ');
            str = str.Replace('；', ' ');
            str = str.Replace(':', ' ');
            str = str.Replace('：', ' ');
            str = str.Replace('\'', ' ');
            str = str.Replace('"', ' ');
            str = str.Replace('“', ' ');
            str = str.Replace('”', ' ');
            str = str.Replace(',', ' ');
            str = str.Replace('，', ' ');
            str = str.Replace('<', ' ');
            str = str.Replace('>', ' ');
            str = str.Replace('《', ' ');
            str = str.Replace('》', ' ');
            str = str.Replace('.', ' ');
            str = str.Replace('。', ' ');
            str = str.Replace('/', ' ');
            str = str.Replace('、', ' ');
            str = str.Replace('?', ' ');
            str = str.Replace('？', ' ');

            return str;
        }


    }
}
