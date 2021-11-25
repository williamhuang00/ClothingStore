﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Classes;
using System.Data;

namespace ClothingStore
{
    public partial class ManageRefunds : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //check role and update label on top right and set visibility of buttons
                if (Session["Role"].ToString() == "RewardsCustomer")
                {
                    navPurchaseHistory.Visible = true;
                    navCheckoutPage.Visible = true;
                    lblUser.Text = "Hello " + "Rewards Customer";
                    navSignOut.Visible = true;
                }
                else if (Session["Role"].ToString() == "Administrator")
                {
                    navManageRefunds.Visible = true;
                    lblUser.Text = "Hello " + "Administrator";
                    navSignOut.Visible = true;
                }
                else
                {
                    //visitor
                    navCheckoutPage.Visible = true;
                    lblUser.Text = "Hello " + "Visitor";
                    navSignIn.Visible = true;
                }
                StoredProcedures SP = new StoredProcedures();
                //call stored procedure to get a dataset of orders that have refundrequest column set to true
                //set the repeater datasource and databind
                DataSet orders = SP.GetRefundRequests();
                rptOrders.DataSource = orders;
                rptOrders.DataBind();

            }
        }

        protected void rptOrders_ItemCommand(Object sender, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            int rowIndex = e.Item.ItemIndex;

            // Retrieve a value from a control in the Repeater's Items collection

            Label myLabel = (Label)rptOrders.Items[rowIndex].FindControl("lblOrderID");

            String orderNumber = myLabel.Text;

            lblDisplay.Text = "You selected orderNumber " + orderNumber;

            //call stored procedure to delete a order
            StoredProcedures SP = new StoredProcedures();
            int retVal = SP.ConfirmRefund(int.Parse(orderNumber));

            if (retVal == 1)
            {
                //let admin know the refund was issued
                lblRefundResult.Text = "Refund was successfully issued.";
            } else
            {
                //let admin know there was an error and refund was not issued
                lblRefundResult.Text = "Refund was NOT successfully issued.";
            }
        }
    }
}