using Cashier.Util;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Cashier.Forms
{
    public partial class SetForm : Form
    {
        public SetForm()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            IniUtil.setRadiohost(this.radioHostTxB.Text.ToString());
            this.Close();
        }

        private void SetForm_Load(object sender, EventArgs e)
        {

        }
    }
}
