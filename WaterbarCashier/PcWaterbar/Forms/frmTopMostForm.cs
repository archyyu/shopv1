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
    public partial class frmTopMostForm : Form
    {

        private Point ptMouseCurrrnetPos, ptMouseNewPos, ptFormPos, ptFormNewPos;
        private bool blnMouseDown = false;
        private MainForm pParent;

        public frmTopMostForm()
        {
            InitializeComponent(); 
        }

        private void frmTopMostForm_MouseDoubleClick(object sender, MouseEventArgs e)
        {
            this.SwitchToMain();
        }

        private void frmTopMostForm_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                blnMouseDown = true;
                ptMouseCurrrnetPos = Control.MousePosition;
                ptFormPos = Location;
            }
        }

        private void frmTopMostForm_MouseMove(object sender, MouseEventArgs e)
        {
            if (blnMouseDown)
            {
                ptMouseNewPos = Control.MousePosition;
                ptFormNewPos.X = ptMouseNewPos.X - ptMouseCurrrnetPos.X + ptFormPos.X;
                ptFormNewPos.Y = ptMouseNewPos.Y - ptMouseCurrrnetPos.Y + ptFormPos.Y;
                Location = ptFormNewPos;
                ptFormPos = ptFormNewPos;
                ptMouseCurrrnetPos = ptMouseNewPos;
            }
        }

        private void frmTopMostForm_MouseUp(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Left)
            {
                blnMouseDown = false;
            }
        }

        private void frmTopMostForm_MouseClick(object sender, MouseEventArgs e)
        {
            this.SwitchToMain();
        }

        public frmTopMostForm(MainForm mainForm)
        {
            InitializeComponent();
            this.pParent = mainForm;
            this.setPos(Screen.PrimaryScreen.Bounds.Width - 200, 100);
        }

        private void frmTopMostForm_Load(object sender, EventArgs e)
        {

        }

        public void setPos(int x, int y)
        {
            this.Location = new Point(x,y);
        }


        private void SwitchToMain()
        {
            this.pParent.restoreWinform();
            //this.Hide();
        }

    }
}
