table 50117 "Customer Modify Log"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(9; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(1; "Customer No."; Code[20]) { }
        field(2; "Field Name"; Text[100]) { }
        field(3; "Old Value"; Text[250]) { }
        field(4; "New Value"; Text[250]) { }
        field(5; "User ID"; Code[50]) { }
        field(6; "Modified On"; DateTime) { }
    }

    keys
    {
        key(PK; "Entry No.", "Customer No.", "Field Name", "Modified On") { Clustered = true; }
    }
}
