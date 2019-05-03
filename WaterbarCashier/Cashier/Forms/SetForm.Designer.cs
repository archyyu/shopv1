namespace Cashier.Forms
{
    partial class SetForm
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(SetForm));
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.radioHostTxB = new System.Windows.Forms.TextBox();
            this.button1 = new System.Windows.Forms.Button();
            this.comboBoxCook = new System.Windows.Forms.ComboBox();
            this.comboBoxWaterbar = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.comboPrinters = new System.Windows.Forms.ComboBox();
            this.label3 = new System.Windows.Forms.Label();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(119, 45);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(0, 12);
            this.label1.TabIndex = 0;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(119, 57);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(101, 12);
            this.label2.TabIndex = 1;
            this.label2.Text = "语音插件IP地址：";
            // 
            // radioHostTxB
            // 
            this.radioHostTxB.Location = new System.Drawing.Point(243, 54);
            this.radioHostTxB.Name = "radioHostTxB";
            this.radioHostTxB.Size = new System.Drawing.Size(168, 21);
            this.radioHostTxB.TabIndex = 3;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(208, 203);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 4;
            this.button1.Text = "确认";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // comboBoxCook
            // 
            this.comboBoxCook.FormattingEnabled = true;
            this.comboBoxCook.Location = new System.Drawing.Point(243, 157);
            this.comboBoxCook.Name = "comboBoxCook";
            this.comboBoxCook.Size = new System.Drawing.Size(112, 20);
            this.comboBoxCook.TabIndex = 15;
            // 
            // comboBoxWaterbar
            // 
            this.comboBoxWaterbar.FormattingEnabled = true;
            this.comboBoxWaterbar.Location = new System.Drawing.Point(243, 123);
            this.comboBoxWaterbar.Name = "comboBoxWaterbar";
            this.comboBoxWaterbar.Size = new System.Drawing.Size(112, 20);
            this.comboBoxWaterbar.TabIndex = 14;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(143, 160);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(77, 12);
            this.label5.TabIndex = 18;
            this.label5.Text = "厨房打印机：";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(143, 126);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(77, 12);
            this.label4.TabIndex = 17;
            this.label4.Text = "水吧打印机：";
            // 
            // comboPrinters
            // 
            this.comboPrinters.FormattingEnabled = true;
            this.comboPrinters.Location = new System.Drawing.Point(243, 90);
            this.comboPrinters.Name = "comboPrinters";
            this.comboPrinters.Size = new System.Drawing.Size(112, 20);
            this.comboPrinters.TabIndex = 13;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(143, 93);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(77, 12);
            this.label3.TabIndex = 16;
            this.label3.Text = "结账打印机：";
            // 
            // SetForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(516, 252);
            this.Controls.Add(this.comboBoxCook);
            this.Controls.Add(this.comboBoxWaterbar);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.comboPrinters);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.radioHostTxB);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.MinimizeBox = false;
            this.Name = "SetForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "初始化设置";
            this.Load += new System.EventHandler(this.SetForm_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox radioHostTxB;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.ComboBox comboBoxCook;
        private System.Windows.Forms.ComboBox comboBoxWaterbar;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ComboBox comboPrinters;
        private System.Windows.Forms.Label label3;
    }
}