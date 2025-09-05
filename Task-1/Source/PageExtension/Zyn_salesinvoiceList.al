pageextension 50146  "SalesInvoiceListExts" extends "sales invoice list"
{
    layout{
        //        modify(Amount)
        // {
        //     // Visible = false;
        // }

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
                RunObject= report "Bulk Sales Inv Posting";
            }
        }
    }
    

    // trigger OnAfterGetRecord()
    // begin
    //     if Rec."From Subscription" then
    //         Rec."Display Amount" := Rec."Subscription Plan Fee"
    //     else
    //         Rec."Display Amount" := Rec.Amount;
    // end;
}



   