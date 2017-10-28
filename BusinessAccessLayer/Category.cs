﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BusinessAccessLayer
{
    public class Category
    {
        public string CategoryName { get; set; }
        public string CategoryDescription { get; set; }
        
        // Do not create any constructor 
        // creating property that are dynamically initialize on runtime
    }
}
