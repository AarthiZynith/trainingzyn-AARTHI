pageextension 50112 "PurchaseOrderExt" extends "Purchase Order"
{
    layout
    {
        addlast(General)
        {
            field("Approval Status"; rec."Approval Status")//aapproval Status --- table name 
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the approval status of the purchase document.';
            }
        }
    }
}
