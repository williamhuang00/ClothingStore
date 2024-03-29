﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Navbar.ascx.cs" Inherits="ClothingStore.Navbar" %>


            <nav id="navbar" class="text-start">
                <asp:ImageButton ID="ImageButton1" src="images/clothingLogo.jpg" href="Catalog.aspx" style="text-decoration: none; width: 15%;" runat="server" OnClick="ImageButton1_Click" />
    <ul class="col-md-5" style="display: inline-block; list-style-type: none;">
        <li style="display: inline-block;"><a href="Catalog.aspx" class="btn btn-outline-dark">Catalog</a></li>

        <li style="display: inline-block;"><a href="Clearance.aspx" class="btn btn-outline-dark">Clearance</a></li>

        <li style="display: inline-block;">
            <a runat="server" id="navPurchaseHistory" visible="false" href="PastOrders.aspx" class="btn btn-outline-dark">Purchase History</a></li>

        <li style="display: inline-block;"><a runat="server" id="navManageRefunds" visible="false" href="ManageRefunds.aspx" class="btn btn-outline-dark">Manage Refunds</a></li>

    </ul>
    <ul class="text-end col-md-5" style="display: inline-block; list-style-type: none;">


        <li style="display: inline-block;">
            <a runat="server" id="navCheckoutPage" type="button" visible="false" class="btn position-relative" href="CheckoutPage.aspx">
                <img src="/Images/black-24dp/2x/outline_shopping_bag_black_24dp.png" />
                <span runat="server" id="CartSpan" visible="false" class="position-absolute start-50 badge rounded-pill bg-danger">
                    <asp:Label ID="lblCartTotalQuantity" runat="server" Text=""></asp:Label>
                </span>
            </a>
        </li>

        <asp:Label ID="lblUser" runat="server" Text="" style="margin-right: 1rem;position: relative;top: -20px;"></asp:Label>

        <li style="display: inline-block;"><a runat="server" id="navSignIn" visible="false" href="Login.aspx" class="btn btn-outline-success">Sign In</a></li>
        <li style="display: inline-block;"><a runat="server" id="navSignOut" visible="false" href="Login.aspx" class="btn btn-outline-danger">Sign Out</a></li>
    </ul>
</nav>

