tableextension 50111 Zyn_PurchaseHeaderExt extends "Purchase Header"
{
    fields
    {
        field(50100; "Approval Status"; Enum Zyn_PurchaseApprovalStatus)//purchase approval status---enum name
        {
            Caption = 'Approval Status';
            DataClassification = ToBeClassified;
            InitValue = Open; // Default
        }
    }
}
