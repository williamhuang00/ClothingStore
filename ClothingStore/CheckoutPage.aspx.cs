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
            if (Session["Cart"] != null)
            {
                List<Classes.Clothing> Cart = (List<Classes.Clothing>)Session["Cart"];
                decimal price = 0.00m;
                int quantity = 0;

                if (Session["Role"] != null && Session["Role"].ToString() == "Administrator")
                {
                    //prevent the page to load the html and give a warning somehow
                    this.Controls.Clear();
                    Response.Write("You are not allowed here buddy");
                    return;
                }

                if (!IsPostBack)
                {
                    gvOrder.DataSource = Session["Cart"];
                    gvOrder.DataBind();
                }

                foreach (Classes.Clothing clothing in Cart)
                {

                    OrdersService.CheckoutProcessor wsProxy = new OrdersService.CheckoutProcessor();

                    price += wsProxy.TotalCaluator(clothing.ClearanceDiscountPercent, clothing.ClothingPrice, clothing.ClothingQuantity);
                    quantity += clothing.ClothingQuantity;
                }
                price = price + (price * 0.06m);

                gvOrder.FooterRow.Cells[0].Text = "Total: ";
                gvOrder.FooterRow.Cells[5].Text = "$" + price.ToString("0.00");
                gvOrder.FooterRow.Cells[7].Text = quantity.ToString();
            }
            else
            {
                lblWarning.Visible = true;
                gvOrder.Visible = false;
                btnSubmitOrder.Visible = false;
                lblWarning.Text = "There is nothing in your cart";
                return;
            }
        }

        protected void btnSubmitOrder_Click(object sender, EventArgs e)
        {
            btnSubmitOrder.Visible = false;
            lblAddress.Visible = true;
            lblAddress2.Visible = true;
            lblBilling.Visible = true;
            lblCardNumber.Visible = true;
            lblCity.Visible = true;
            lblCountry.Visible = true;
            lblCVV.Visible = true;
            lblEmail.Visible = true;
            lblExpirationDate.Visible = true;
            lblName.Visible = true;
            lblPayment.Visible = true;
            lblPhoneNumber.Visible = true;
            lblState.Visible = true;
            lblZip.Visible = true;
            tbName.Visible = true;
            tbAddress1.Visible = true;
            tbAddress2.Visible = true;
            tbCardNumber.Visible = true;
            tbCity.Visible = true;
            tbCVV.Visible = true;
            tbEmail.Visible = true;
            tbPhoneNumber.Visible = true;
            tbState.Visible = true;
            tbZip.Visible = true;
            ddlCountry.Visible = true;
            ddlMonth.Visible = true;
            ddlYear.Visible = true;
            btnSubmitFinal.Visible = true;

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            //Get the row that contains this button
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;

            Response.Write("Clothing Name: " + gvr.Cells[0].Text);
            //grab the cart from session. remove the clothing item using name + size to locate which to remove
            List<Classes.Clothing> Cart = (List<Classes.Clothing>)Session["Cart"];
            foreach(Classes.Clothing clothing in Cart)
            {
                Cart.Remove(clothing);
                Session["Cart"] = Cart;

                if (Cart.Count == 0)
                {
                    Session["Cart"] = null;
                }

                Response.Redirect("CheckoutPage.aspx");
            }

        }

        protected void btnIncrease_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            //Get the row that contains this button
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;
            OrdersService.CheckoutProcessor wsProxy = new OrdersService.CheckoutProcessor();

            Response.Write("Clothing Name: " + gvr.Cells[0].Text);
            //grab the cart from session. increment quantity of the clothing item using name + size to locate which to remove
            List<Classes.Clothing> Cart = (List<Classes.Clothing>)Session["Cart"];
            foreach (Classes.Clothing clothing in Cart)
            {
                int clothingID = Int32.Parse(gvr.Cells[0].Text);
                string sizeName = gvr.Cells[7].Text;
                int quantity = Int32.Parse(gvr.Cells[8].Text);

                if (clothing.ClothingQuantity != wsProxy.MaxStock(clothingID, sizeName))
                {
                    clothing.ClothingQuantity++;
                }

                Session["Cart"] = Cart;

                Response.Redirect("CheckoutPage.aspx");

            }
        }

        protected void btnDecrease_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;

            //Get the row that contains this button
            GridViewRow gvr = (GridViewRow)btn.NamingContainer;

            Response.Write("Clothing Name: " + gvr.Cells[0].Text);
            //grab the cart from session. decrement quantity of the clothing item using name + size to locate which to remove
            List<Classes.Clothing> Cart = (List<Classes.Clothing>)Session["Cart"];
            foreach (Classes.Clothing clothing in Cart)
            {
                if (clothing.ClothingID == Int32.Parse(gvr.Cells[0].Text) && clothing.ClothingSize == gvr.Cells[7].Text)
                {
                    if (clothing.ClothingQuantity == 1)
                    {
                        Cart.Remove(clothing);
                    }
                    else
                    {
                        clothing.ClothingQuantity--;
                    }
                    Session["Cart"] = Cart;

                    if (Cart.Count == 0)
                    {
                        Session["Cart"] = null;
                    }
                    
                    Response.Redirect("CheckoutPage.aspx");
                    
                }
            }
        }

        protected void btnSubmitFinal_Click(object sender, EventArgs e)
        {
            if (tbName.Text != "" && tbAddress1.Text != "" && tbCardNumber.Text != "" && tbCity.Text != "" && tbCVV.Text != "" && tbEmail.Text != "" && tbPhoneNumber.Text != "" && tbState.Text != "" && tbZip.Text != "" && ddlCountry.SelectedValue != "Select a country")
            {
                string email = tbEmail.Text;
                Classes.Validation val = new Classes.Validation();

                if (val.IsEmail(email))
                {
                    string name = tbName.Text;
                    string address1 = tbAddress1.Text;
                    string address2 = tbAddress2.Text;
                    string cardNumber = tbCardNumber.Text;
                    string city = tbCity.Text;
                    string cvv = tbCVV.Text;
                    string phoneNumber = tbPhoneNumber.Text;
                    string state = tbState.Text;
                    string zip = tbZip.Text;
                    string country = ddlCountry.SelectedValue;
                    string month = ddlMonth.SelectedValue;
                    string year = ddlYear.SelectedValue;

                    StoredProcedures StoredProc = new StoredProcedures();
                    List<Classes.Clothing> Cart = (List<Classes.Clothing>)Session["Cart"];
                    OrdersService.CheckoutProcessor wsProxy = new OrdersService.CheckoutProcessor();
                   
                    
                    foreach (GridViewRow row in gvOrder.Rows)
                    {
                        int clothingID = Int32.Parse(row.Cells[0].Text);
                        string sizeName = row.Cells[7].Text;
                        int quantity = Int32.Parse(row.Cells[8].Text);
                        int stockUpdated = wsProxy.StockReturn(clothingID, quantity, sizeName);
                    }


                    decimal totalPrice = 0.00m;

                    foreach (Classes.Clothing clothing in Cart)
                    {
                        OrdersService.CheckoutProcessor CalcWSProxy = new OrdersService.CheckoutProcessor();

                        totalPrice += CalcWSProxy.TotalCaluator(clothing.ClearanceDiscountPercent, clothing.ClothingPrice, clothing.ClothingQuantity);
                    }
                    totalPrice = totalPrice + (totalPrice * 0.06m);

                    DateTime localDate = DateTime.Now; //gets current datetime
                    int refundRequest = 0;
                    int userID = Int32.Parse(Session["UserID"].ToString());
                    // Serialize the OrderItem List object

                    BinaryFormatter serializer = new BinaryFormatter();
                    MemoryStream memStream = new MemoryStream();

                    Byte[] byteArray;

                    serializer.Serialize(memStream, Cart);

                    byteArray = memStream.ToArray();

                    // price, localDate, refundRequest, userID, byteArray

                    // Create the Web Service Proxy Object used to talk to the Web Service in SOAP
                    

                    OrdersService.Order currentOrder = new OrdersService.Order(); // makes an order obj of the current order

                    currentOrder.orderTotal = totalPrice;
                    currentOrder.orderDate = localDate;
                    currentOrder.refundRequested = refundRequest;
                    currentOrder.userID = userID;
                    currentOrder.orderItems = byteArray;

                    bool result = wsProxy.Storing(currentOrder);


                    Session["Cart"] = null;
                    Response.Redirect("Catalog.aspx");
                }
                else
                {
                    nameValidator.Visible = true;
                    emailValidator.Visible = true;
                    cvvValidator.Visible = true;
                    countryValidator.Visible = true;
                    address1Validator.Visible = true;
                    zipValidator.Visible = true;
                    phoneNumberValidator.Visible = true;
                    stateValidator.Visible = true;
                    cityValidator.Visible = true;
                    cardNumberValidator.Visible = true;
                }
            }
            else 
            {
                nameValidator.Visible = true;
                emailValidator.Visible = true;
                cvvValidator.Visible = true;
                countryValidator.Visible = true;
                address1Validator.Visible = true;
                zipValidator.Visible = true;
                phoneNumberValidator.Visible = true;
                stateValidator.Visible = true;
                cityValidator.Visible = true;
                cardNumberValidator.Visible = true;

            }
        }
    }
}