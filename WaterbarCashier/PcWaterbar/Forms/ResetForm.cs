using CashierLibrary.Util;
using Newtonsoft.Json.Linq;
using PcWaterbar.Model;
using PcWaterbar.Util;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace PcWaterbar.Forms
{
    public partial class ResetForm : Form
    {
        public ResetForm()
        {
            InitializeComponent();
        }

        private void btnLogin_Click(object sender, EventArgs e)
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

            this.btnLogin.Enabled = false;
            this.btnLogin.Text = "设置中";

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

                    if (user.shopid < 0)
                    {
                        MessageBox.Show("角色错误");
                        this.btnLogin.Text = "设置";
                        this.btnLogin.Enabled = true;
                        return;
                    }
                    

                    user.password = password;
                    ServerUtil.currentUser = user;
                    IniUtil.setShopId(ServerUtil.currentUser.shopid);
                    
                    this.DialogResult = DialogResult.OK;
                    

                }
                else
                {
                    MessageBox.Show("账号或者密码错误");
                    this.btnLogin.Text = "设置";
                    this.btnLogin.Enabled = true;
                    return;
                }
            }
            catch (Exception ex)
            {

            }

        }
    }
}
