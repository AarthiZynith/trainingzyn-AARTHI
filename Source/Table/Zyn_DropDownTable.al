table 50123 Zyn_DropDownTable
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "ID"; Integer)
        {Caption='ID';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Name"; Text[100])
        {Caption='Name';
            DataClassification = SystemMetadata;
        }
    }
}