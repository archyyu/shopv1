namespace PcWaterbar.Forms
{
    partial class WaterbarForm
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
            this.debugBtn = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // debugBtn
            // 
            this.debugBtn.Location = new System.Drawing.Point(13, 13);
            this.debugBtn.Name = "debugBtn";
            this.debugBtn.Size = new System.Drawing.Size(75, 23);
            this.debugBtn.TabIndex = 0;
            this.debugBtn.Text = "调试";
            this.debugBtn.UseVisualStyleBackColor = true;
            this.debugBtn.Click += new System.EventHandler(this.debugBtn_Click);
            // 
            // WaterbarForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1063, 679);
            this.Controls.Add(this.debugBtn);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "WaterbarForm";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "智慧网咖水吧客户端";
            this.Load += new System.EventHandler(this.WaterbarForm_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button debugBtn;
    }
}