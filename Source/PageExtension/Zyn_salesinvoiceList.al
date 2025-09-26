pageextension 50146  Zyn_SalesInvoiceListExts extends "sales invoice list"
{
    layout{

        addafter(Amount)
        {
            field("Display Amount"; Rec."Display Amount")
            {
                ApplicationArea = All;
                Caption = 'Amount';
            }
        }
    }
    actions{
        addlast(processing){
            action("BulkPosting"){

                ApplicationArea=All;
                Image=Report;
                RunObject= report Zyn_BulkSalesInvPosting;
            }
        }
    }
   
}



   