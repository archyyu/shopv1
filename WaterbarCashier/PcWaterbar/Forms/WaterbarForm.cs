using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using CefSharp;
using PcWaterbar.Util;
using CashierLibrary.Model;

namespace PcWaterbar.Forms
{
    public partial class WaterbarForm : Form
    {

        private CefSharp.WinForms.ChromiumWebBrowser webCom;

        private string openId;

        public WaterbarForm()
        {
            InitializeComponent();
        }

        public WaterbarForm(string openId)
        {
            this.openId = openId;
            InitializeComponent();
        }

        private void WaterbarForm_Load(object sender, EventArgs e)
        {
            this.debugBtn.Visible = ServerUtil.Debug;
            int shopid = IniUtil.getShopId();
            string loadUrl = "http://yun.aida58.com/cashier/view/clientwaterbar?shopid=" + shopid
                    + "&openId=" + this.openId
                    + "&address=" + System.Environment.MachineName
                    + "&version=1";

            this.webCom = new CefSharp.WinForms.ChromiumWebBrowser(loadUrl);
            this.webCom.BrowserSettings.WebSecurity = CefState.Disabled;

            this.webCom.MenuHandler = new MenuHandler();
            this.webCom.DragHandler = new DragHandler();

            this.webCom.Dock = DockStyle.Fill;

            this.Controls.Add(this.webCom);

        }

        private void debugBtn_Click(object sender, EventArgs e)
        {
            this.webCom.ShowDevTools();
        }
    }
}
