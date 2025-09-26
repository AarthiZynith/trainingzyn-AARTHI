enum 50233 Zyn_ExpenseClaimStatus
{
    Extensible = true;

    value(0; PendingApproval)
    {
        Caption = 'PendingApproval';
    }
    value(1; Approved)
    {
        Caption = 'Approved';
    }
    value(2; Rejected)
    {
        Caption = 'Rejected';
    }
    value(3; Cancelled)
    {
        Caption = 'Cancelled';
    }
}