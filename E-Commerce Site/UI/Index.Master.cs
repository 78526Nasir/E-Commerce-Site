﻿using BusinessAccessLayer;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_Commerce_Site.UI
{
    public partial class Index : System.Web.UI.MasterPage
    {
        public int flag = 1;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                flag = 0;
            }

            if (Session["User"] != null)
            {
                if (!IsPostBack)
                {
                    UserName.Text = Session["User"].ToString();
                    lblUserName.Text = Session["User"].ToString();

                    if (!string.IsNullOrEmpty(Session["UserImage"].ToString()))
                    {
                        userImage.ImageUrl = Session["UserImage"].ToString();
                        userImage2.ImageUrl = Session["UserImage"].ToString();
                    }
                }

                DataTable dt = (DataTable)Session["UserWholeRecord"];

                int userID = Convert.ToInt32(dt.Rows[0]["user_id"].ToString());

                ECommerceBusiness ecb = new ECommerceBusiness();

                dt = ecb.SelectAllCartedProduct(userID);
                string noOfCartedProduct = dt.Rows.Count.ToString();

                if (Convert.ToInt32(noOfCartedProduct) > 0)
                {
                    cartBadge.InnerText = noOfCartedProduct;
                    cartBadge.Style.Add("visibility", "visible");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (Request.UrlReferrer != null)
            {
                Session["PageName"] = System.IO.Path.GetFileName(Request.UrlReferrer.AbsolutePath);
            }
            Response.Redirect("UserLogin.aspx");
        }

        protected void btnProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("HomePage.aspx");
        }
    }
}