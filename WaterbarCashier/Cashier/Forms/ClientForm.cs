using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using CefSharp.WinForms;
using CefSharp;
using CashierLibrary.Util;
using Cashier.Util;

namespace Cashier.Forms
{
    public partial class ClientForm : Form
    {

        private string url = "";

        private ChromiumWebBrowser webCom = null;

        public ClientForm()
        {
            InitializeComponent();
        }

        public ClientForm(string url)
        {
            InitializeComponent();
            this.url = url;
            this.initBrowser();
        }

        private void initBrowser()
        {
			try
			{
				this.webCom = new ChromiumWebBrowser(this.url);
				this.webCom.BrowserSettings.WebSecurity = CefState.Disabled;
				this.webCom.BrowserSettings.FileAccessFromFileUrls = CefState.Disabled;
				this.webCom.FrameLoadEnd += this.browserLoadEnd;
				this.webCom.Dock = DockStyle.Fill;
				this.Controls.Add(this.webCom);
			}
			catch (Exception ex)
			{
				MessageBox.Show("初始化浏览器出错,错误:\n"+ex.Message);
			}
            
        }

        private void ClientForm_Load(object sender, EventArgs e)
        {
            
        }

        private void browserLoadEnd(object sender, FrameLoadEndEventArgs e)
        {
            if (ServerUtil.Debug)
            {
                this.webCom.ShowDevTools();
            }
            //this.webCom.GetBrowser().GetHost().ShowDevTools();
        }

        public void excuteScript(String js)
        {
            LogHelper.WriteLog(js);
            this.webCom.ExecuteScriptAsync(js);
        }

    }
}
