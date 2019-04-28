using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using CefSharp;
using Cashier.Util;
using Newtonsoft.Json.Linq;
using CashierLibrary.Util;
using CashierLibrary.Model;
using Cashier.Forms;
using System.Diagnostics;
using System.Threading;
using Cashier.Model;
using CashierLibrary.KeyBoard;

namespace Cashier
{
    public partial class MainForm : Form
    {

		string username = string.Empty;
		string cardID = string.Empty;
		const int maxErrorTextLen = 64;

		public CefSharp.WinForms.ChromiumWebBrowser webCom = null;

		private ClientForm clientForm = null;

		private PrinterUtil printerUtil = new PrinterUtil();

        private Thread m_syncThread = null;
        private Thread m_printerThread = null;
        
		/// <summary>
		/// 显示窗体委托
		/// </summary>
		private delegate void DelageteShowFrm();
		/// <summary>
		/// 委托显示
		/// </summary>
		private Delegate ShowFrm;

        /// <summary>
        /// 定义事件处理委托
        /// </summary>
        public delegate void InvokeDelegate();

        /// <summary>
        /// 显示调试窗口
        /// </summary>
        private bool m_bIsShowDev=false;
        // 键盘钩子
        private  KeyboardHook k_hook;
       

        public MainForm()
        {
            InitializeComponent();
            this.WindowState = FormWindowState.Maximized;
            k_hook = new KeyboardHook();
            k_hook.KeyDownEvent += new System.Windows.Forms.KeyEventHandler(hook_KeyDown);
            k_hook.Start();
        }


        private void browserLoadEnd(object sender, FrameLoadEndEventArgs e)
        {
#if DEBUG
            this.webCom.GetBrowser().GetHost().ShowDevTools();
#else

#endif
        }

        private void Form1_Load(object sender, EventArgs e)
        {

            this.KeyPreview = true;
            this.Text = "收银端" + Application.ProductVersion.ToString();
            this.btnTest.Visible = ServerUtil.Debug;
            this.ShowFrm = new DelageteShowFrm(ShowClientForm);

            string url = ServerUtil.ClientUrl + ServerUtil.currentUser.shopid;

#if DEBUG
            // string url = ServerUtil.YunAddr + "/cashier/waterbarview/backside?shopid=" + ServerUtil.currentUser.shopid;
            ClientForm frm = new ClientForm(url);
            frm.MinimizeBox = true;
            frm.MaximizeBox = true;
            frm.FormBorderStyle = FormBorderStyle.Sizable;
            frm.WindowState = FormWindowState.Normal;
            this.clientForm = frm;
            this.Invoke(ShowFrm);
#else
            int screenCount = Screen.AllScreens.Count();
                Screen[] scs = Screen.AllScreens;
                if (screenCount > 1)
                {
                    foreach (Screen sc in scs)
                    {
                        if (!sc.Primary)
                        {
                            //string url = ServerUtil.YunAddr + "/cashier/waterbarview/backside?shopid=" + ServerUtil.currentUser.shopid;
                            ClientForm frm = new ClientForm(url);
                            this.clientForm = frm;
                            this.Invoke(ShowFrm);
                            this.showFormInScreen(sc, frm);
                        }
                        else
                        {
                            this.showFormInScreen(sc, this);
                        }
                    }
                  
                }
#endif
            this.InitChromeBrowser();
            this.InitPrinter();

        }


        private void MainForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult result = MessageBox.Show("确认退出收银端？", "提示信息", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (result == DialogResult.No)
            {
                e.Cancel = true;
                k_hook.Stop();
            }
            else
            {

            }

        }
        /// <summary>
        /// 显示调试按钮
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void button1_Click(object sender, EventArgs e)
        {
            this.webCom.ShowDevTools();
        }

        /// <summary>
        /// 调试
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void hook_KeyDown(object sender, KeyEventArgs e)
        {
            try
            {

                if (e.KeyValue == (int)Keys.D && (int)Control.ModifierKeys == (int)Keys.Alt)
                {
                    if (this.m_bIsShowDev)
                    {
                        if (this.webCom.IsBrowserInitialized)
                        {
                            this.webCom.CloseDevTools();
                            this.m_bIsShowDev = false;
                        }
                    }
                    else
                    {
                        if (this.webCom.IsBrowserInitialized)
                        {
                            this.webCom.ShowDevTools();
                            this.m_bIsShowDev = true;
                        }
                    }

                }
               
            }
            catch (Exception ex)
            {
                MessageBox.Show("按键处理函数失败,失败原因:" + ex.Message);
                LogHelper.WriteLog("按键调试失败!", ex);
            }
        }
        

        /// <summary>
        /// 显示客显屏
        /// </summary>
        private void ShowClientForm()
        {
            this.clientForm.Show();
        }

        private void showFormInScreen(Screen screen, Form form)
        {
            form.Location = new Point(screen.Bounds.Left, screen.Bounds.Top);
            form.StartPosition = FormStartPosition.CenterScreen;
            form.WindowState = FormWindowState.Maximized;
        }
        

        

        private string generateToken(string fn, string tm)
        {
            string result = MD5Util.EncryptWithMd5(fn + tm + IniUtil.key());
            return result;
        }


        private int orderPayTypeToRechargeWay(string paytype)
        {
            int type = Int32.Parse(paytype);

            if (type == 0 || type == 3)
            {
                return 1;//微信支付
            }

            if (type == 6)
            {
                return 3;
            }

            return 4;
        }

        private int orderSourceToRechargeSource(string source)
        {
            int ordersource = Int32.Parse(source);

            if (ordersource == 0)
            {
                return 3;
            }
            if (ordersource == 1)
            {
                return 1;
            }

            return 4;
        }
        
        private int getOrderRechargeWay(Order order)
        {

            int payType =  order.paytype;

            if (payType == 0)
            {
                return 1;//说明是微信支付
            }
            else if (payType == 5 || payType == 4)
            {
                return 2;//卡劵兑换 积分 归到 银行卡收入 
            }
            else if (payType == 1)
            {
                return 1;//余额支付
            }

            return 4;
        }
        

        /// <summary>
		/// 初始化web控件
		/// </summary>
		private void InitChromeBrowser()
		{

            String loadUrl = "http://pinshangy.com/web/cashier.php?__uniacid=1&f=index&do=Product";
			this.webCom = new CefSharp.WinForms.ChromiumWebBrowser(loadUrl);
			this.webCom.MenuHandler = new CashierLibrary.Model.MenuHandler();
			this.webCom.BrowserSettings.WebSecurity = CefState.Disabled;
			this.webCom.BrowserSettings.FileAccessFromFileUrls = CefState.Disabled;

			this.webCom.Dock = DockStyle.Fill;
			this.Controls.Add(this.webCom);
			this.webCom.FrameLoadEnd += this.browserLoadEnd;

			this.webCom.DragHandler = new DragHandler();
             
            // 注册对象
			this.webCom.RegisterJsObject("printer", this.printerUtil);
			this.webCom.RegisterJsObject("player", new PlayerUtil());
			this.webCom.RegisterJsObject("clientForm", this.clientForm);
            this.webCom.RegisterJsObject("cashier",this);
            this.webCom.RegisterJsObject("iniUtil",new IniUtil());

		}
        

        /// <summary>
        /// 启动定时器线程
        /// </summary>
        private void InitPrinter()
        {
            if (null == this.m_printerThread)
            {
                ParameterizedThreadStart startDelegete = new ParameterizedThreadStart(this.HandlePrint);
                this.m_printerThread = new Thread(startDelegete);
                this.m_printerThread.IsBackground = true;
                this.m_printerThread.Start(this);
            }
        }

        /// <summary>
        /// 将窗体函数传入处理
        /// </summary>
        /// <param name="obj"></param>
        private void HandlePrint(Object obj)
        {
            MainForm mform = (MainForm)obj;
            while (true)
            {
                try
                {
                    mform.HandlePrinter();
                }
                catch (Exception ex)
                {
                    LogHelper.WriteLog("error", ex);
                }
                Thread.Sleep(2000);
                
            }
            
        }

        /// <summary>
        /// 处理打印机
        /// </summary>
        public void HandlePrinter()
        {
            try
            {
                User user = ServerUtil.currentUser;
                IDictionary<string, string> parameters = HttpUtil.initParams();
                parameters.Add("shopid", user.shopid + "");

                string str = HttpUtil.doPost(ServerUtil.PrintRequestUrl, parameters);
                JObject result = JObject.Parse(str);
                if (result["result"].ToString().Equals("success"))
                {
                    Packet pack = JsonUtil.DeserializeJsonToObject<Packet>(result["body"].ToString());

                    if (pack.cmd.Equals("print"))
                    {

                        Order order = JsonUtil.DeserializeJsonToObject<Order>(pack.cmdParms);
                        this.printerUtil.PrintOrder(order, ServerUtil.printerName);
                        
                    }

                }
                else
                {

                }
            }
            catch (Exception ex)
            {

                LogHelper.WriteLog("error", ex);
            }
        }

        /// <summary>
        /// 调用js
        /// </summary>
        /// <param name="fn"></param>
        /// <param name="param"></param>
        public void CallJs(String fn, String param)
		{
			if (null != this.webCom)
			{

                if (this.webCom.IsBrowserInitialized)
                {
                    String strScript = "Cashier." + fn + "('" + param + "')";
                    LogHelper.WriteLog("Cashir:调用js:" + strScript);
                    this.webCom.ExecuteScriptAsync(strScript);
                }
                
            }
		}
        

        /// <summary>
        /// 测试播放语音
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnTest_Click(object sender, EventArgs e)
        {
            String str = "测试语音";
            PlayerUtil player = new PlayerUtil();
            player.PlayRealManVoice(str);
        }

        
    }
}
