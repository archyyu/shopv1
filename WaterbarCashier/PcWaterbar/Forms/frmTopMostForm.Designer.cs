namespace PcWaterbar.Forms
{
    partial class frmTopMostForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.SuspendLayout();
            // 
            // frmTopMostForm
            // 
            this.BackColor = System.Drawing.SystemColors.ActiveBorder;
            //this.BackgroundImage = global::PcWaterbar.Properties.Resources.wcicon;
            this.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.ClientSize = new System.Drawing.Size(128, 64);
            this.ControlBox = false;
            this.ForeColor = System.Drawing.Color.Transparent;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Margin = new System.Windows.Forms.Padding(18, 36, 18, 36);
            this.Name = "frmTopMostForm";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
            this.Text = "frmTopMostForm";
            this.Load += new System.EventHandler(this.frmTopMostForm_Load);
            this.MouseClick += new System.Windows.Forms.MouseEventHandler(this.frmTopMostForm_MouseClick);
            this.MouseDoubleClick += new System.Windows.Forms.MouseEventHandler(this.frmTopMostForm_MouseDoubleClick);
            this.MouseDown += new System.Windows.Forms.MouseEventHandler(this.frmTopMostForm_MouseDown);
            this.MouseMove += new System.Windows.Forms.MouseEventHandler(this.frmTopMostForm_MouseMove);
            this.MouseUp += new System.Windows.Forms.MouseEventHandler(this.frmTopMostForm_MouseUp);
            this.ResumeLayout(false);

        }

        #endregion
    }
}