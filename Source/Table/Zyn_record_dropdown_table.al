table 50101 Zyn_FieldValueBuffer
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Field Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Field Name';
        }
        field(2; "Record Id"; RecordId)
        {
            DataClassification = ToBeClassified;
            Caption = 'Record Id';
        }
        field(3; "Field Id"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Field Id';
        }
    }

    keys
    {
        key(PK; "Field Name", "Field Id")
        {
            Clustered = true;
        }
    }
}
