﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Runtime.Serialization.Formatters.Binary;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Classes;

namespace ClothingStore
{
    public partial class CheckoutPage : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            //check role and update label on top right and set visibility of buttons
            Navbar ctrl = (Navbar)LoadControl("Navbar.ascx");
            Form.Controls.AddAt(0, ctrl);
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                gvOrder.DataSource = Session["Cart"];
                gvOrder.DataBind();
            }

        }

        protected void btnSubmitOrder_Click(object sender, EventArgs e)
        {
            //create order


            //appending the list of clothes bought to the orderitems column of the order
            StoredProcedures SP = new StoredProcedures();
            //call stored procedure that sets the order given an order ID
            List<Classes.Clothing> Cart = (List<Classes.Clothing>)Session["Cart"];
            // Serialize the OrderItem List object

            BinaryFormatter serializer = new BinaryFormatter();

            MemoryStream memStream = new MemoryStream();

            Byte[] byteArray;

            serializer.Serialize(memStream, Cart);

            byteArray = memStream.ToArray();
            int orderID = int.Parse(txtOrderID.Text);
            int retVal = SP.StoreOrderItems(orderID, byteArray);
            // Check to see whether the update was successful

            if (retVal > 0)

                lblCartSubmitDisplay.Text = "The order items were successfully stored for this account.";

            else

                lblCartSubmitDisplay.Text = "A problem occured in storing the order items.";
        }
    }
}