﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckoutPage.aspx.cs" Inherits="ClothingStore.CheckoutPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/Navigation-with-Button.css" />
    <link rel="stylesheet" href="assets/css/styles.css/" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />
    <title></title>

    <style>
        nav {
            padding-top: 10px;
        }
        #imageDiv {
            text-align: center;
        }

        #clothingImage {
            width: 100%;
            padding: 10%;
        }

        #clothesInfoDiv {
            display: inline-block;
            padding: 2.5%;
        }

        #reviews {
            padding-left: 5%;
        }

        #btnCheckOut {
            position: relative;
            top: 20px;
        }

        #navbar {
            background-color: lightgrey;
        }

        #lblCompany {
            margin-left: 2rem;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div>
                <asp:Label ID="lblCartSubmitDisplay" runat="server" Text=""></asp:Label>
        </div>
        <asp:GridView ID="gvOrder" runat="server" AutoGenerateColumns="False" style="margin:auto; width:75%; margin-top: 2.5%; margin-bottom: 2.5%" BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" ForeColor="Black" GridLines="Horizontal">
                                        <emptydatatemplate>
                                There are no items in your cart.
                            </emptydatatemplate>
            <Columns>
                <asp:BoundField DataField="ClothingName" HeaderText="Name" />
                <asp:BoundField DataField="ClothingColor" HeaderText="Color" />
                <asp:ImageField DataImageUrlField="ClothingImage" HeaderText="Image">
                    <ControlStyle Height="150px" Width="150px" />
                </asp:ImageField>
                <asp:BoundField DataField="OnClearance" HeaderText="Clearance" />
                <asp:BoundField DataField="ClearanceDiscountPercent" HeaderText="Discount Percent" />
                <asp:BoundField DataField="ClothingPrice" HeaderText="Price" />
                <asp:BoundField DataField="ClothingSize" HeaderText="Size" />
                <asp:BoundField DataField="ClothingQuantity" HeaderText="Quantity" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="btnDecrease" runat="server" Text="-" class="btn btn-success" OnClick="btnDecrease_Click"/>
                        <asp:Button ID="btnIncrease" runat="server" Text="+" class="btn btn-danger" OnClick="btnIncrease_Click" />
                        <asp:Button ID="btnDelete" runat="server" Text="Remove" class="btn btn-dark" OnClick="btnDelete_Click"/>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
                                        <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                        <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                        <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Right" />
                                        <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                        <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                        <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                        <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                        <SortedDescendingHeaderStyle BackColor="#242121" />
        </asp:GridView>
        <div class="text-center">
                        <asp:TextBox ID="txtOrderID" runat="server"></asp:TextBox>
                        <asp:Button ID="btnSubmitOrder" runat="server" Text="Submit Order" class="btn btn-primary" OnClick="btnSubmitOrder_Click"/>
        </div>

    </form>
</body>
</html>