pageextension 50146  "SalesInvoiceListExts" extends "sales invoice list"
{
    actions{
        addlast(processing){
            action("BulkPosting"){

                ApplicationArea=All;
                Image=Report;
                RunObject= report "Bulk Sales Inv Posting";
            }
        }
    }
}



   