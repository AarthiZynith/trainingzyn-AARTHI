table 50117 Zyn_CustomerModifyLog
{
    DataClassification = ToBeClassified;

    fields
    {
        field(9; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No';
            DataClassification = ToBeClassified;
        }
        field(2; "Field Name"; Text[100])
        {
            Caption = 'Field Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Old Value"; Text[250])
        {
            Caption = 'Old Value';
            DataClassification = ToBeClassified;
        }
        field(4; "New Value"; Text[250])
        {
            Caption = 'New Value';
            DataClassification = ToBeClassified;
        }
        field(5; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
        }
        field(6; "Modified On"; DateTime)
        {
            Caption = 'Modified On';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.", "Customer No.", "Field Name", "Modified On")
        {
            Clustered = true;
        }
    }
}
