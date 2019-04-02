namespace PcWaterbar
{
    partial class MainForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(MainForm));
            this.debugBtn = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // debugBtn
            // 
            this.debugBtn.Location = new System.Drawing.Point(3, 1);
            this.debugBtn.Name = "debugBtn";
            this.debugBtn.Size = new System.Drawing.Size(75, 23);
            this.debugBtn.TabIndex = 0;
            this.debugBtn.Text = "调试";
            this.debugBtn.UseVisualStyleBackColor = true;
            this.debugBtn.Click += new System.EventHandler(this.debugBtn_Click);
            // 
            // MainForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(345, 753);
            this.Controls.Add(this.debugBtn);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.KeyPreview = true;
            this.Name = "MainForm";
            this.ShowIcon = false;
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.Manual;
            this.Text = "AidaForm";
            this.Load += new System.EventHandler(this.MainForm_Load);
            this.LocationChanged += new System.EventHandler(this.MainForm_LocationChanged);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button debugBtn;
    }
}

