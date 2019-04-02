using System;
using System.Collections.Generic;

using System.Text;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;


using System.Net;
using System.IO;

namespace CashierLibrary.Util
{
	public class HttpUtil
    {

        private static readonly string DefaultUserAgent = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)";

        private static string key = "common*@@WanJia";

        public static double GetTimeStamp()
        {
            TimeSpan ts = DateTime.UtcNow - new DateTime(1970, 1, 1, 0, 0, 0, 0);
            return ts.TotalSeconds;
        }
        
        public static String generateToken(double tm)
        {
            String str = tm + key;
            return MD5Util.EncryptWithMd5(str);
        }

		public static String GenerateTokenFn(Int64 tm, String fn)
		{
            String str = fn + tm + "654321";
			return MD5Util.EncryptWithMd5(str);
		}

        public static IDictionary<string, string> initParams()
        {
            int tm = (int)GetTimeStamp();
            IDictionary<string, string> prms = new Dictionary<string, string>();
            prms.Add("time",tm + "");
            prms.Add("token",HttpUtil.generateToken(tm));
            return prms;
        }

        public static String doPost(string url, IDictionary<String, string> parameters)
        {
            return doPost(url, parameters, null, null, Encoding.GetEncoding("utf-8"), null);
        }

        public static String doPost(string url, String body)
        {
            return doPost(url, body, null, null, Encoding.GetEncoding("utf-8"), null);
        }

        public static String doPost(string url, IDictionary<string, string> parameters, int? timeout, string userAgent, Encoding requestEncoding, CookieCollection cookies)
        {
            String result = null;
            try
            {
                using (HttpWebResponse response = HttpUtil.CreatePostHttpResponse(url, parameters, timeout, userAgent, requestEncoding, cookies))
                {
                    using (System.IO.Stream responseStream = response.GetResponseStream())
                    {
                        using (System.IO.StreamReader reader = new System.IO.StreamReader(responseStream, requestEncoding))
                        {
                            result = reader.ReadToEnd();
                        }

                    }
                }
            }
            catch (Exception e)
            {
                
                throw e;
            }
            
            return result; 
        }

        /// <summary>
        /// get请求
        /// </summary>
        /// <param name="url"></param>
        /// <returns></returns>
        public static String doGet(String url)
        {
            return doGet(url, null,DefaultUserAgent, null);
        }

        /// <summary>
        /// post请求
        /// </summary>
        /// <param name="url"></param>
        /// <param name="body"></param>
        /// <param name="timeout"></param>
        /// <param name="userAgent"></param>
        /// <param name="requestEncoding"></param>
        /// <param name="cookies"></param>
        /// <returns></returns>
        public static String doPost(string url, String body, int? timeout, string userAgent, Encoding requestEncoding, CookieCollection cookies)
        {
            String result = null;
            try
            {
                using (HttpWebResponse response = HttpUtil.CreatePostHttpResponse(url, body, timeout, userAgent, requestEncoding, cookies))
                {
                    using (System.IO.Stream responseStream = response.GetResponseStream())
                    {
                        using (System.IO.StreamReader reader = new System.IO.StreamReader(responseStream, requestEncoding))
                        {
                            result = reader.ReadToEnd();
                        }

                    }
                }
            }
            catch (Exception e)
            {
                
                throw e;
            }
            
            return result;
        }


        /// <summary>
        /// post请求
        /// </summary>
        /// <param name="url"></param>
        /// <param name="body"></param>
        /// <param name="timeout"></param>
        /// <param name="userAgent"></param>
        /// <param name="requestEncoding"></param>
        /// <param name="cookies"></param>
        /// <returns></returns>
        public static String doGet(string url, int? timeout, string userAgent, CookieCollection cookies)
        {
            String result = null;
            try
            {
                using (HttpWebResponse response = HttpUtil.CreateGetHttpResponse(url, timeout, userAgent, cookies))
                {
                    using (System.IO.Stream responseStream = response.GetResponseStream())
                    {
                        using (System.IO.StreamReader reader = new System.IO.StreamReader(responseStream,Encoding.UTF8))
                        {
                            result = reader.ReadToEnd();
                        }

                    }
                }
            }
            catch (Exception e)
            {

                throw e;
            }

            return result;
        }

        /// <summary>  
        /// 创建GET方式的HTTP请求  
        /// </summary>  
        /// <param name="url">请求的URL</param>  
        /// <param name="timeout">请求的超时时间</param>  
        /// <param name="userAgent">请求的客户端浏览器信息，可以为空</param>  
        /// <param name="cookies">随同HTTP请求发送的Cookie信息，如果不需要身份验证可以为空</param>  
        /// <returns></returns>  
        public static HttpWebResponse CreateGetHttpResponse(string url, int? timeout, string userAgent, CookieCollection cookies)
        {
            if (string.IsNullOrEmpty(url))
            {
                throw new ArgumentNullException("url");
            }
            HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
            request.Method = "GET";
            request.ContentType = "text/html;charset=UTF-8";
            request.UserAgent = DefaultUserAgent;
            if (!string.IsNullOrEmpty(userAgent))
            {
                request.UserAgent = userAgent;
            }
            if (timeout.HasValue)
            {
                request.Timeout = timeout.Value;
            }
            if (cookies != null)
            {
                request.CookieContainer = new CookieContainer();
                request.CookieContainer.Add(cookies);
            }
            return request.GetResponse() as HttpWebResponse;
        }


        /// <summary>  
        /// 创建POST方式的HTTP请求  
        /// </summary>  
        /// <param name="url">请求的URL</param>  
        /// <param name="parameters">随同请求POST的参数名称及参数值字典</param>  
        /// <param name="timeout">请求的超时时间</param>  
        /// <param name="userAgent">请求的客户端浏览器信息，可以为空</param>  
        /// <param name="requestEncoding">发送HTTP请求时所用的编码</param>  
        /// <param name="cookies">随同HTTP请求发送的Cookie信息，如果不需要身份验证可以为空</param>  
        /// <returns></returns>  
        public static HttpWebResponse CreatePostHttpResponse(string url, String body, int? timeout, string userAgent, Encoding requestEncoding, CookieCollection cookies) //throws WebException
        {

            if (string.IsNullOrEmpty(url))
            {
                throw new ArgumentNullException("url");
            }
            if (requestEncoding == null)
            {
                throw new ArgumentNullException("requestEncoding");
            }
            HttpWebRequest request = null;
            //如果是发送HTTPS请求  
            if (url.StartsWith("https", StringComparison.OrdinalIgnoreCase))
            {
                ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(CheckValidationResult);
                request = WebRequest.Create(url) as HttpWebRequest;
                request.ProtocolVersion = HttpVersion.Version10;
            }
            else
            {
                request = WebRequest.Create(url) as HttpWebRequest;
            }
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";

            if (!string.IsNullOrEmpty(userAgent))
            {
                request.UserAgent = userAgent;
            }
            else
            {
                request.UserAgent = DefaultUserAgent;
            }

            if (timeout.HasValue)
            {
                request.Timeout = timeout.Value;
            }
            if (cookies != null)
            {
                request.CookieContainer = new CookieContainer();
                request.CookieContainer.Add(cookies);
            }
            //如果需要POST数据  
             
            StringBuilder buffer = new StringBuilder();
                
            buffer.AppendLine(body);
            byte[] data = requestEncoding.GetBytes(buffer.ToString());

            Stream stream = null;
            try
            {
                stream = request.GetRequestStream();
                stream.Write(data, 0, data.Length);
            }
            catch (Exception e)
            {
                if (null != request)
                {
                    request.Abort();
                    request = null;
                }
                LogHelper.WriteLog("Http请求出错:",e);
                throw e;
            }
            finally
            {
                if (null != stream)
                {
                    stream.Close();
                }
            }
                 

            HttpWebResponse response = request.GetResponse() as HttpWebResponse;

            if (null == response)
            {
                throw new WebException("请求返回错误");
            }
            if (response.StatusCode != HttpStatusCode.OK)
            {
                throw new WebException("请求状态错误");
            }

            return response;
        }


        /// <summary>  
        /// 创建POST方式的HTTP请求  
        /// </summary>  
        /// <param name="url">请求的URL</param>  
        /// <param name="parameters">随同请求POST的参数名称及参数值字典</param>  
        /// <param name="timeout">请求的超时时间</param>  
        /// <param name="userAgent">请求的客户端浏览器信息，可以为空</param>  
        /// <param name="requestEncoding">发送HTTP请求时所用的编码</param>  
        /// <param name="cookies">随同HTTP请求发送的Cookie信息，如果不需要身份验证可以为空</param>  
        /// <returns></returns>  
        public static HttpWebResponse CreatePostHttpResponse(string url, IDictionary<string, string> parameters, int? timeout, string userAgent, Encoding requestEncoding, CookieCollection cookies) //throws WebException
        {

            if (string.IsNullOrEmpty(url))
            {
                throw new ArgumentNullException("url");
            }
            if (requestEncoding == null)
            {
                throw new ArgumentNullException("requestEncoding");
            }
            HttpWebRequest request = null;
            //如果是发送HTTPS请求  
            if (url.StartsWith("https", StringComparison.OrdinalIgnoreCase))
            {
                ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(CheckValidationResult);
                request = WebRequest.Create(url) as HttpWebRequest;
                request.ProtocolVersion = HttpVersion.Version10;
            }
            else
            {
                request = WebRequest.Create(url) as HttpWebRequest;
            }
            request.Method = "POST";
            request.ContentType = "application/x-www-form-urlencoded";

            if (!string.IsNullOrEmpty(userAgent))
            {
                request.UserAgent = userAgent;
            }
            else
            {
                request.UserAgent = DefaultUserAgent;
            }

            if (timeout.HasValue)
            {
                request.Timeout = timeout.Value;
            }
            if (cookies != null)
            {
                request.CookieContainer = new CookieContainer();
                request.CookieContainer.Add(cookies);
            }
            //如果需要POST数据  
            if (!(parameters == null || parameters.Count == 0))
            {
                StringBuilder buffer = new StringBuilder();
                int i = 0;
                foreach (string key in parameters.Keys)
                {
                    if (i > 0)
                    {
                        buffer.AppendFormat("&{0}={1}", key, parameters[key]);
                    }
                    else
                    {
                        buffer.AppendFormat("{0}={1}", key, parameters[key]);
                    }
                    i++;
                }
                byte[] data = requestEncoding.GetBytes(buffer.ToString());

                Stream stream = null;
                try
                {
                    stream = request.GetRequestStream();
                    stream.Write(data, 0, data.Length);
                }
                catch (Exception e)
                {
                    if (null != request)
                    {
                        request.Abort();
                        request = null;
                    }
                    LogHelper.WriteLog("Http请求出错:", e);
                    throw e;
                }
                finally
                {
                    if (null != stream)
                    {
                        stream.Close();
                    }
                }

            }

            HttpWebResponse response = request.GetResponse() as HttpWebResponse;

            if (null == response)
            {

                throw new WebException("请求返回错误");
            }
            if (response.StatusCode != HttpStatusCode.OK)
            {

                throw new WebException("请求状态错误");
            }

            return response;
        }

        private static bool CheckValidationResult(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors errors)
        {
            return true; //总是接受  
        }

        public static long SaveFileFromUrl(string FileName, string Url)
        {
            long Value = 0;

            WebResponse response = null;
            Stream stream = null;

            try
            {
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(Url);

                response = request.GetResponse();
                stream = response.GetResponseStream();

                if (!response.ContentType.ToLower().StartsWith("text/"))
                {
                    SaveBinaryFile(response, FileName);
                    Value = response.ContentLength;
                }

            }
            catch (Exception err)
            {
                Value = 0;
                string aa = err.ToString();
            }
            return Value;
        }

        private static bool SaveBinaryFile(WebResponse response, string FileName)
        {
            bool Value = true;
            byte[] buffer = new byte[1024];

            try
            {
                if (File.Exists(FileName))
                    File.Delete(FileName);
                Stream outStream = System.IO.File.Create(FileName);
                Stream inStream = response.GetResponseStream();

                int l;
                do
                {
                    l = inStream.Read(buffer, 0, buffer.Length);
                    if (l > 0)
                        outStream.Write(buffer, 0, l);
                }
                while (l > 0);

                outStream.Close();
                inStream.Close();
            }
            catch
            {
                Value = false;
            }
            return Value;
        }


    }
}
