table 50220 Zyn_SubscriptionCue
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Integer)
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Active Subscriptions"; Integer)
        {
            Caption = 'Active Subscriptions';
            DataClassification = ToBeClassified;
        }
        field(3; "Revenue Generated"; Decimal)
        {
            Caption = 'Revenue Generated';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
