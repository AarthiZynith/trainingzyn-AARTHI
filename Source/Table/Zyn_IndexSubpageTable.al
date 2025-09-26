table 50128 Zyn_IndexSubpage
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; code; code[10])
        {
            Caption = 'code';
            DataClassification = ToBeClassified;
        }
        field(2; EntryNo; Integer)
        {
            Caption = 'EntryNo';
            DataClassification = ToBeClassified;
        }
        field(3; Year; Integer)
        {
            Caption = ' Year';
            DataClassification = ToBeClassified;
        }
        field(4; value; Decimal)
        {
            Caption = ' value';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; code, EntryNo)
        {
            Clustered = true;
        }
    }
}