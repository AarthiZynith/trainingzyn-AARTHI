table 50254 "Zyn_SyncContext"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Context; Code[50])
        {
            Caption = 'Context';
        }
    }

    keys
    {
        key(PK; Context)
        {
            Clustered = true;
        }
    }
}
