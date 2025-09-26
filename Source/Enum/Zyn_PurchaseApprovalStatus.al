enum 50112 Zyn_PurchaseApprovalStatus
{
    Extensible = true;
    Caption = 'Purchase Approval Status';

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; Pending)
    {
        Caption = 'Pending';
    }
    value(2; Approved)
    {
        Caption = 'Approved';
    }
    value(3; Escalated)
    {
        Caption = 'Escalated';
    }
}
