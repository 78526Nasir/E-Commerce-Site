﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="E_Commerce_Site.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <meta charset="utf-8" />
    <meta name="author" content="Nasir Islam Sujan" />
    
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="~/css/loginStyle.css" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
        <h1 class="title1">Login to Admin Panel</h1>
        <div class="container">
            <asp:Image ID="usericon" CssClass="img-style" ImageUrl="~/images/user1.png" AlternateText="User Icon"  runat="server"/>
            <br />
            <asp:TextBox ID="txtUsername" CssClass="username" runat="server" placeholder="Enter username"></asp:TextBox>
            <br />
            <asp:TextBox ID="txtPassword" CssClass="password" runat="server" placeholder="Enter password" TextMode="Password" ></asp:TextBox>
            <br />
            <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="LoginButtonClickPerformed"/>
            <br />
            <br />
            <asp:Label ID="lblStatus" CssClass="label" runat="server" ></asp:Label>
        </div>

    </form>
</body>
</html>
