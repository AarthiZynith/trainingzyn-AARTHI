tableextension 50111 "PurchaseHeaderExt" extends "Purchase Header"
{
    fields
    {
        field(50100; "Approval Status"; Enum "Purchase Approval Status")//purchase approval status---enum name
        {
            Caption = 'Approval Status';
            DataClassification = ToBeClassified;
            InitValue = Open; // Default
        }
    }
}
