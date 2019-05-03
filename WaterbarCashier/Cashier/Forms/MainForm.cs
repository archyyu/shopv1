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
        

        public MainForm()
        {
            InitializeComponent();
            this.WindowState = FormWindowState.Maximized;
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

            string url = ServerUtil.ClientUrl + "1";

#if DEBUG
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

        }


        private void MainForm_FormClosing(object sender, FormClosingEventArgs e)
        {
            DialogResult result = MessageBox.Show("确认退出收银端？", "提示信息", MessageBoxButtons.YesNo, MessageBoxIcon.Question);
            if (result == DialogResult.No)
            {
                e.Cancel = true;
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

            String loadUrl = "http://pinshangy.com/web/cashier.php?f=index&do=Product";
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
