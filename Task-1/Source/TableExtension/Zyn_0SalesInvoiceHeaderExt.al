tableextension 50231 "Sales Invoice Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        field(50200; "From Subscription"; Boolean)
        {
            Caption = 'From Subscription';
            DataClassification = ToBeClassified;
        }

        field(50201; "Subscription Plan ID"; Code[100])
        {
            Caption = 'Subscription Plan ID';
            DataClassification = ToBeClassified;
        }

        field(50202; "Subscription Plan Fee"; Decimal)
        {
            Caption = 'Subscription Plan Fee';
            DataClassification = ToBeClassified;
        }
    }
}
