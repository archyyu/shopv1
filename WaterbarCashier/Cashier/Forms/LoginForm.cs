using Cashier.Util;
using CashierLibrary.AutoRun;
using CashierLibrary.Model;
using CashierLibrary.Util; 
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Cashier.Forms
{
    public partial class LoginForm : Form
    {
        public LoginForm()
        {
            InitializeComponent();
        }

        private void LoginForm_Load(object sender, EventArgs e)
        {
            this.Text = "智慧网咖客户端登录" + Application.ProductVersion.ToString();
        
            
            if (ServerUtil.Debug)
            {
                this.textBox1.Visible = true;
            }
            else
            {
                this.textBox1.Visible = false;
            }

            LogHelper.WriteLog("cashier ");
 

			//设置自动自启
			//AutoRunHelper.SetAutoRun("Cashir", Application.ExecutablePath);
            
            LogHelper.WriteLog("【cashier】:Started");
 
            if (IniUtil.radiohost().Length <= 0)
            {
                SetForm form = new SetForm();
                form.ShowDialog();
            }


            List<String> printerList = PrinterHelper.GetPrinterList();
            this.comboPrinters.Items.Add("选择打印机");             
            foreach (String item in printerList)
            {
                comboPrinters.Items.Add(item);
            }
            comboPrinters.Text = "选择打印机";
	
            this.comboBoxWaterbar.Items.Add("选择打印机");
            foreach (String item in printerList)
            {
                this.comboBoxWaterbar.Items.Add(item);
            }
            this.comboBoxWaterbar.Text = "选择打印机";

            this.comboBoxCook.Items.Add("选择打印机");
            foreach (String item in printerList)
            {
                this.comboBoxCook.Items.Add(item);
            }
            this.comboBoxCook.Text = "选择打印机";

            String loginName = IniHelper.INIGetStringValue(IniUtil.file, "Cashier", "loginName", "");
            String password = IniHelper.INIGetStringValue(IniUtil.file, "Cashier", "loginPwd", "");
            String pringter = IniHelper.INIGetStringValue(IniUtil.file, "Cashier", "printer", "");
            String waterbarPrinter = IniHelper.INIGetStringValue(IniUtil.file, "Cashier", "waterbarPrinter", "");
            String cookPrinter = IniHelper.INIGetStringValue(IniUtil.file, "Cashier", "cookPrinter", "");
            if ((!String.IsNullOrEmpty(loginName)) && (!String.IsNullOrEmpty(password)) && (!String.IsNullOrEmpty(pringter)))
            {
                this.txbLoginName.Text = AesUtil.Decrypt(loginName);
                this.txbPassword.Text = AesUtil.Decrypt(password);
                this.comboPrinters.Text = pringter;
                this.comboBoxWaterbar.Text = waterbarPrinter;
                this.comboBoxCook.Text = cookPrinter;
                //this.Login();
            }
        }
        private void btnLogin_Click(object sender, EventArgs e)
        {
			this.Login();
		}

		/// <summary>
		/// 登录方法
		/// </summary>
		private void Login()
		{
			string loginname = this.txbLoginName.Text.Trim();
			string password = this.txbPassword.Text.Trim();

			if (loginname.Length <= 0)
			{
				MessageBox.Show("登录名不能为空");
				return;
			}

			if (password.Length <= 0)
			{
				MessageBox.Show("密码不能为空");
				return;
			}
            String printerName = this.comboPrinters.Text.Trim();
            if (string.IsNullOrEmpty(printerName)||printerName.Equals("选择打印机"))
            {
                MessageBox.Show("结帐打印机不能为空");
                return;
            }

            this.btnLogin.Enabled = false;
			this.btnLogin.Text = "登录中";

			IDictionary<string, string> parameters = HttpUtil.initParams();

			parameters.Add("loginname", loginname);
			parameters.Add("password", password);

			try
			{

				string result = HttpUtil.doPost(ServerUtil.LoginUrl, parameters);
				JObject json = JObject.Parse(result);

				if (json["result"].ToString() == "success")
				{
					User user = JsonUtil.DeserializeJsonToObject<User>(json["user"].ToString());
					user.password = password;
					ServerUtil.currentUser = user;
					ServerUtil.printerName = this.comboPrinters.Text.Trim();
					ServerUtil.cookPrinter = this.comboBoxCook.Text.Trim();
					ServerUtil.waterbarPrinter = this.comboBoxWaterbar.Text.Trim();

					this.DialogResult = DialogResult.OK;

					user.password = password;
					ServerUtil.currentUser = user;
					ServerUtil.printerName = this.comboPrinters.Text.Trim();

					this.DialogResult = DialogResult.OK;

					if (user.shopid < 0)
					{
						MessageBox.Show("登录角色错误");
						this.btnLogin.Text = "登录";
						this.btnLogin.Enabled = true;
						return;
					}

					user.password = password;
					ServerUtil.currentUser = user;
					ServerUtil.printerName = this.comboPrinters.Text.Trim();

					// 写入配置文件
					IniHelper.INIWriteValue(IniUtil.file, "Cashier", "loginName", AesUtil.Encrypt(loginname));
					IniHelper.INIWriteValue(IniUtil.file, "Cashier", "loginPwd", AesUtil.Encrypt(password));
					IniHelper.INIWriteValue(IniUtil.file, "Cashier", "printer", (ServerUtil.printerName));
                    IniHelper.INIWriteValue(IniUtil.file, "Cashier", "waterbarPrinter",(ServerUtil.waterbarPrinter));
                    IniHelper.INIWriteValue(IniUtil.file, "Cashier", "cookPrinter",(ServerUtil.cookPrinter));

                    this.DialogResult = DialogResult.OK;

					if (ServerUtil.Debug)
					{
                        ServerUtil.YunAddr = this.textBox1.Text.ToString();

                        ServerUtil.loadUrl = "http://" + ServerUtil.YunAddr + "/cashier/waterbarview/cashier";
                        ServerUtil.ClientUrl = "http://" + ServerUtil.YunAddr + "/cashier/waterbarview/backside?shopid=";
                        //ServerUtil.loadUrl = this.textBox1.Text.ToString();
                    }
					else
					{

					}
				}
				else
				{
					MessageBox.Show("账号或者密码错误");
					this.btnLogin.Text = "登录";
					this.btnLogin.Enabled = true;
					return;
				}

			}
			catch (Exception ex)
			{
				MessageBox.Show("错误:" + ex.ToString());
				this.btnLogin.Text = "登录";
				this.btnLogin.Enabled = true;
				return;
			}
		}

        private void LoginForm_FormClosing(object sender, FormClosingEventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
