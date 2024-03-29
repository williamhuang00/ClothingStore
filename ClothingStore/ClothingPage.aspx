﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClothingPage.aspx.cs" Inherits="ClothingStore.Clothing" %>

<%@ Register Src="~/SizePicker.ascx" TagPrefix="uc1" TagName="SizePicker" %>
<%@ Register Src="~/QuantityPicker.ascx" TagPrefix="uc1" TagName="QuantityPicker" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" href="assets/css/Navigation-with-Button.css" />
    <link rel="stylesheet" href="assets/css/styles.css/" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous" />

    <title></title>
    <link rel="stylesheet" href="NavBarStyle.css"/>


</head>
<body>
    <form id="form1" runat="server" class="text-center">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <div id="imageDiv" style="float:left;" class="col-md-6">
            <asp:Image ID="clothingImage" runat="server" ImageUrl="~/Images/Preppy V Neck.png" />
        </div>

        <div id="clothesInfoDiv" style="display:inline-block;" class="col-md-5 text-start">
            <div class="accordion" id="accordionExample">
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingOne">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                            Clothing Information
                        </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <asp:Label ID="lblName" runat="server" Text="Name: " class="h1"></asp:Label>
                            <br />
                            <asp:Label ID="lblColor" runat="server" Text="Color: "></asp:Label>
                            <br />
                            <asp:Label ID="lblDescription" runat="server" Text="Description: "></asp:Label>
                            <br />
                            <asp:Label ID="lblBrand" runat="server" Text="Brand: "></asp:Label><br />
                            <asp:Button ID="btnManage" runat="server" Text="Edit Clothing Item" Visible="false" class="btn btn-dark col-sm-5" OnClick="btnManage_Click" />
                            <div runat="server" id="shoppingOptions" visible="false">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                    <ContentTemplate>
                                                                    <asp:Label ID="lblPriceLabel" runat="server" Text="Price: "></asp:Label>
                            <asp:Label ID="lblPriceValue" runat="server" Visible="false" Text=""></asp:Label>
                                        <asp:Label ID="lblRatioedPrice" runat="server" Text="Choose Size: "></asp:Label>
                                        <asp:RadioButtonList ID="rdbSize" runat="server" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged" RepeatDirection="Horizontal">
                                            <asp:ListItem>Small</asp:ListItem>
                                            <asp:ListItem>Medium</asp:ListItem>
                                            <asp:ListItem>Large</asp:ListItem>
                                        </asp:RadioButtonList>
                                        <asp:Label ID="lblQuantity" runat="server" Text="Choose Quantity To Add: "></asp:Label>
                                        <uc1:QuantityPicker ID="QuantityPicker" runat="server" />
                                        <br />
                                        <asp:Button ID="btnAdd" runat="server" class="btn btn-dark" OnClick="btnAdd_Click" Text="Add To Bag" />
                                        <br />
                                        <asp:Label ID="lblPurchaseWarning" runat="server" Text=""></asp:Label>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                                <br />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="accordion-item">
                    <h2 class="accordion-header" id="headingTwo">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                            Ratings & Reviews         Ratings & Reviews</button>
                    </h2>
                    <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                        <div class="accordion-body">
                            <div class="accordion-body">
                                Average Comfort Rating:
        <asp:Label ID="lblComfortAv" runat="server" Text="" class="rating"></asp:Label>
                                <br />
                                Average Quality Rating:
        <asp:Label ID="lblQualityAv" runat="server" Text="" class="rating"></asp:Label>
                                <br />
                                Average Cost Rating:
        <asp:Label ID="lblCostAv" runat="server" Text="" class="rating"></asp:Label>
                                <br />
                                <br />

                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">

                                    <ContentTemplate>

                                        <div runat="server" id="reviews" class="row">
                                            <asp:Button ID="btnLoadReview" runat="server" Text="See Reviews" class="btn btn-dark col-sm-3" Style="margin-right: 1rem;" OnClick="btnLoadReview_Click"/>
                                            <asp:Button ID="btnAddReview" runat="server" Text="Write Review" Visible="false" class="btn btn-dark col-sm-3" Style="margin-right: 1rem;" OnClick="btnAddReview_Click" />
                                            <asp:Button ID="btnMyReview" runat="server" Text="Edit Review" Visible="false" class="btn btn-dark col-sm-3" OnClick="btnEditReview_Click" />
                                        </div>
                                        <br />
                                        <div runat="server" id="allreviews">
                                            <asp:ListView ID="lvReviews" runat="server" Style="text-align: left">
                                                <EmptyDataTemplate>
                                                    There are no reviews for this clothing item.
                                                </EmptyDataTemplate>
                                                <ItemTemplate>
                                                    <div class="list">
                                                        <table style="border: solid black 0.5px; width: 100%; margin-bottom: 1em; border-radius: 5px; border-collapse: separate !important;">
                                                            <tr>
                                                                <td>Cost Rating:<img src="images/star_black_24dp.svg" alt="Star" width="20"> <%#Eval("costRating")%></td>
                                                                <td class="rating">Comfort Rating:<img src="images/star_black_24dp.svg" alt="Star" width="20"> <%#Eval("comfortRating")%></td>
                                                                <td class="rating">Quality Rating:<img src="images/star_black_24dp.svg" alt="Star" width="20"> <%#Eval("qualityRating")%></td>
                                                            </tr>
                                                        </table>
                                                        <table>
                                                                                                                        <tr>
                                                                <td>User Name: <%#Eval("userName")%></td>
                                                            </tr>
                                                            <tr>
                                                                <td>User Review: <%#Eval("reviewContent")%></td>
                                                            </tr>
<%--                                                            <tr class="">
                                                                <td><asp:Button ID="btnFlag" runat="server" Text="Flag Review" class="btn btn-danger"/></td>
                                                            </tr>--%>
                                                        </table>
                                                                                                                    <br />

                                                    </div>
                                                </ItemTemplate>
                                            </asp:ListView>
                                        </div>

                                        <div runat="server" id="writereview" class="" style="margin: auto;" visible="false">

                                            <asp:Label ID="lblReviewContent" runat="server" Text="Write Your Review: " class="form-label"></asp:Label>
                                            <asp:TextBox ID="txtReviewContent" runat="server" class="form-control" placeholder="Write Your Review Here." TextMode="MultiLine" Rows="3"></asp:TextBox>
                                            <span runat="server" visible="false" id="reviewContentValidator" style="color: red;">* Required Field</span>
             <br />

                                            <asp:Label ID="lblCostRating" runat="server" Text="Rate The Cost: "></asp:Label>

                                            <asp:DropDownList ID="ddlCost" runat="server" class="form-control">
                                                <asp:ListItem>1</asp:ListItem>
                                                <asp:ListItem>2</asp:ListItem>
                                                <asp:ListItem>3</asp:ListItem>
                                                <asp:ListItem>4</asp:ListItem>
                                                <asp:ListItem Value="5"></asp:ListItem>
                                            </asp:DropDownList>

                                            <asp:Label ID="lblQualityRating" runat="server" Text="Rate The Quality: "></asp:Label>

                                            <asp:DropDownList ID="ddlQuality" runat="server" class="form-control">
                                                <asp:ListItem>1</asp:ListItem>
                                                <asp:ListItem>2</asp:ListItem>
                                                <asp:ListItem>3</asp:ListItem>
                                                <asp:ListItem>4</asp:ListItem>
                                                <asp:ListItem Value="5"></asp:ListItem>
                                            </asp:DropDownList>

                                            <asp:Label ID="lblComfortRating" runat="server" Text="Rate The Comfort: "></asp:Label>

                                            <asp:DropDownList ID="ddlComfort" runat="server" class="form-control">
                                                <asp:ListItem>1</asp:ListItem>
                                                <asp:ListItem>2</asp:ListItem>
                                                <asp:ListItem>3</asp:ListItem>
                                                <asp:ListItem>4</asp:ListItem>
                                                <asp:ListItem Value="5"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:Button ID="btnSubmitReview" runat="server" Text="Submit Review" class="btn btn-dark" OnClick="btnSubmitReview_Click" />
                                            <asp:Button ID="btnDelete" runat="server" Text="Delete Review" Visible="false" class="btn btn-danger" OnClick="btnDelete_Click" />
                                            <br />
                                            <asp:Label ID="lblSubmitReviewDisplay" runat="server" Text=""></asp:Label>
                                        </div>


                                    </ContentTemplate>

                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>





    </form>
    <script>
        window.onload = function () {
            showStars();            
        }

        function showStars() {
            var ratingsArray = document.getElementsByClassName("rating"); //get all the ratings that are in num form
            for (let i = 0; i < ratingsArray.length; i++) { //loop through each to modify them
                var numStars = ratingsArray[i].innerHTML; //select the rating number in the html
                //ratingsArray[i].innerHTML = "";
                var newNode = document.createElement("p");
                for (x = 0; x < numStars; x++) {
                    var imgStar = document.createElement("img");
                    imgStar.classList.add("imgStar");
                    imgStar.src = "Images/star_black_24dp.svg";
                    newNode.appendChild(imgStar);
                }
                for (y = 0; y < 5 - numStars; y++) {
                    var imgStar = document.createElement("img");
                    imgStar.classList.add("imgStar");
                    imgStar.src = "Images/star_outline_black_24dp.svg";
                    newNode.appendChild(imgStar);
                }
                ratingsArray[i].appendChild(newNode);
            }
        }
        
    </script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
