table 50220 "Subscription Cue"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Active Subscriptions"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Revenue Generated"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
}
