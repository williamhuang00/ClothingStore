﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ClothingStore
{
    public partial class WebUserControl1 : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        [Category("Misc")]
        public string CurrentSize

        {

            get { return lblSize.Text; }

            set { lblSize.Text = value; }

        }
        protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if(rdbSize.SelectedIndex == 0)
            {
                lblSize.Text = "Small";
            } else if (rdbSize.SelectedIndex == 1)
            {
                lblSize.Text = "Medium";
            } else
            {
                lblSize.Text = "Large";
            }

        }
    }
}