using PcWaterbar.Forms;
using PcWaterbar.Util;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using CefSharp;
using Newtonsoft.Json.Linq;
using CashierLibrary.Util;
using CashierLibrary.Model;

namespace PcWaterbar
{
    public partial class MainForm : Form
    {

        private CefSharp.WinForms.ChromiumWebBrowser webCom = null;

        private frmTopMostForm myTopMost = null;

        private System.Windows.Forms.Timer stopRectTimer = new System.Windows.Forms.Timer();

        private string openId = "";

        private double clickStamp ;

        public MainForm()
        {

            this.clickStamp = this.getCurrentTimeStamp();

            InitializeComponent();
            myTopMost = new frmTopMostForm(this);
            this.myTopMost.TopMost = false;
            this.Show();
            


        }

        private double getCurrentTimeStamp()
        {
            TimeSpan ts = DateTime.Now - new DateTime(1970, 1, 1);
            return ts.TotalMilliseconds;
        }

        private void setOpenId(string openId)
        {
            this.openId = openId;
        }

        private void MainForm_Load(object sender, EventArgs e)
        {
            this.debugBtn.Visible = ServerUtil.Debug;
            int shopid = IniUtil.getShopId();
            if (shopid == 0)
            {
                ResetForm form = new ResetForm(); 
                if (form.ShowDialog() == DialogResult.OK)
                {
                    MessageBox.Show("初始化成功");
                    shopid = IniUtil.getShopId();
                }
                else
                {
                    MessageBox.Show("初始化失败");
                }
            }

            Control.CheckForIllegalCrossThreadCalls = false;

            int y = 20;
            int x = SystemInformation.PrimaryMonitorSize.Width - this.Width;

            this.Location = new Point(x,y);
            string loadurl = "http://yun.aida58.com/cashier/view/oldsidebar?shopid=" + IniUtil.getShopId()
                + "&address=" + System.Environment.MachineName;

            this.webCom = new CefSharp.WinForms.ChromiumWebBrowser(loadurl);
            this.webCom.BrowserSettings.WebSecurity = CefState.Disabled;
            this.webCom.Dock = DockStyle.Fill;

            this.webCom.RegisterAsyncJsObject("waterbar",this);

            this.webCom.MenuHandler = new MenuHandler();
            this.webCom.DragHandler = new DragHandler();

            this.Controls.Add(this.webCom);

            //
            this.stopRectTimer.Enabled = true;
            this.stopRectTimer.Interval = 10 * 1000;
            this.stopRectTimer.Tick += new EventHandler(this.stopRectTick);
            this.stopRectTimer.Start();
        }

        private void stopRectTick(object sender, EventArgs e)
        {
            if (this.Bounds.Contains(Cursor.Position))
            {
                
            }
            else
            {

                double nnnow = this.getCurrentTimeStamp();
                if ((nnnow - this.clickStamp) > 30)
                {
                    this.Hide();
                    //this.myTopMost.setPos(Screen.PrimaryScreen.Bounds.Width - 200, 100);
                    this.myTopMost.Show();
                }    
            }

            //this.testHttp();

        }

        private void testHttp()
        {

            IDictionary<string, string> parameters = new Dictionary<string, string>();

            parameters.Add("loginname", "test");
            parameters.Add("password", "test");

            String body = JsonUtil.SerializeObject(parameters);

            try
            {

                string result = HttpUtil.doPost("http://192.168.1.136:17000/test", body);
                JObject json = JObject.Parse(result);

                if (json["result"].ToString() == "success")
                {
                    LogHelper.WriteLog("ok");
                }
            }
            catch (Exception ex)
            {
                LogHelper.WriteLog("err");
            }

        }

        internal AnchorStyles StopAanhor = AnchorStyles.None;

        private void mStopAnhor()
        {
            if (this.Top <= 0 && this.Left <= 0)
            {
                StopAanhor = AnchorStyles.None;
            }
            else if (this.Top <= 0)
            {
                StopAanhor = AnchorStyles.Top;
            }
            else if (this.Left <= 0)
            {
                StopAanhor = AnchorStyles.Left;
            }
            else if (this.Left >= Screen.PrimaryScreen.Bounds.Width - this.Width)
            {
                StopAanhor = AnchorStyles.Right;
            }
            else if (this.Top >= Screen.PrimaryScreen.Bounds.Height - this.Height)
            {
                StopAanhor = AnchorStyles.Bottom;
            }
            else
            {
                StopAanhor = AnchorStyles.None;
            }
        }

        private void waterbar()
        {

            WaterbarForm waterbarForm = new WaterbarForm(this.openId);
            waterbarForm.Show();
        }

        public void openWaterBar(String openId)
        {
            this.openId = openId;
            MethodInvoker MethInvo = new MethodInvoker(waterbar);
            this.BeginInvoke(MethInvo);
        }

        private void netfee()
        {
            NetbarForm netbarForm = new NetbarForm(this.openId);
            netbarForm.Show();
        }

        public void openNetfee(string openId)
        {
            this.openId = openId;
            MethodInvoker methInvo = new MethodInvoker(netfee);
            this.BeginInvoke(methInvo); 
        }

        public void openScreenLock()
        {
            string dir = System.AppDomain.CurrentDomain.SetupInformation.ApplicationBase;

            System.Diagnostics.Process aidatray = new System.Diagnostics.Process();
            aidatray.StartInfo.FileName = dir + "\\ScreenLock\\ScreenLock.exe";
            aidatray.StartInfo.Arguments = @"";
            aidatray.Start();
        }


        public void restoreWinform()
        {
            this.Location = new Point(Screen.PrimaryScreen.Bounds.Width - this.Width, this.Location.Y);
            this.clickStamp = this.getCurrentTimeStamp();
            this.Show();
        }

        private void MainForm_LocationChanged(object sender, EventArgs e)
        {
            this.mStopAnhor();
        }

        private void debugBtn_Click(object sender, EventArgs e)
        {
            this.webCom.ShowDevTools();
        }
    }
}
