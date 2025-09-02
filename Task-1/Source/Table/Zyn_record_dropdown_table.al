table 50101 "FieldValueBuffer"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Field Name"; Text[250]) { }


        field(2; "Record Id"; RecordId) { }

        field(3; "Field Id"; Integer) { }
    }


    keys
    {
        key(PK; "Field Name","Field Id") { Clustered = true; }
    }
}
