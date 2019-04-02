using Cashier.Forms;
using CashierLibrary.Util;
using System;
using System.Windows.Forms;

namespace Cashier
{
	static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main(string[] Args)
        {

            Boolean createdNew;
            System.Threading.Mutex instance = new System.Threading.Mutex(true, "Cashier", out createdNew);
            if (createdNew)
            {
                //处理未捕获的异常   
                Application.SetUnhandledExceptionMode(UnhandledExceptionMode.CatchException);
                //处理UI线程异常   
                Application.ThreadException += Application_ThreadException;
                //处理非UI线程异常   
                AppDomain.CurrentDomain.UnhandledException += CurrentDomain_UnhandledException;

                //创建Windows用户主题
                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);
                log4net.Config.XmlConfigurator.Configure();
                LoginForm loginForm = new LoginForm();
                if (loginForm.ShowDialog() == DialogResult.OK)
                {
                    Application.Run(new MainForm());
                }
                instance.ReleaseMutex();
            }
            else
            {
                MessageBox.Show("您已经打开了一个收银端，请关闭后打开");
                LogHelper.WriteLog("您已经打开了一个收银端，请关闭后打开");
                Application.Exit();
            }
           
        }

        /// <summary>
        ///错误弹窗
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        static void Application_ThreadException(object sender, System.Threading.ThreadExceptionEventArgs e)
        {
            string str;
            var strDateInfo = "出现应用程序未处理的异常：" + DateTime.Now + "\r\n";
            var error = e.Exception;
            if (error != null)
            {
                str = string.Format(strDateInfo + "异常类型：{0}\r\n异常消息：{1}\r\n异常信息：{2}\r\n",
                     error.GetType().Name, error.Message, error.StackTrace);
            }
            else
            {
                str = string.Format("应用程序线程错误:{0}", e);
            }

            LogHelper.WriteLog("【Application】:" + str, e.Exception);
            MessageBox.Show("发生错误，请查看程序日志！", "系统错误", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }

        static void CurrentDomain_UnhandledException(object sender, UnhandledExceptionEventArgs e)
        {
            var error = e.ExceptionObject as Exception;
            var strDateInfo = "出现应用程序未处理的异常：" + DateTime.Now + "\r\n";
            var str = error != null ? string.Format(strDateInfo + "Application UnhandledException:{0};\n\r堆栈信息:{1}", error.Message, error.StackTrace) : string.Format("Application UnhandledError:{0}", e);
            LogHelper.WriteLog("【Application】:" + str, error);
            MessageBox.Show("发生错误，请查看程序日志！", "系统错误", MessageBoxButtons.OK, MessageBoxIcon.Error);
        }
    }
}
