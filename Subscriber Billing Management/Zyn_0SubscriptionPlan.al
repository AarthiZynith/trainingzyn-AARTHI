table 50201 Zyn_PlanTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; PlanID; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'PlanID';
        }
        field(2; PlanFee; Decimal)
        {
            Caption = 'PlanFee';
            DataClassification = ToBeClassified;
        }
        field(3; PlanName; Text[100])
        {
            Caption = 'PlanName';
            DataClassification = ToBeClassified;
        }
        field(4; Status; enum Zyn_SubscriptionStatusEnum)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
        }
        field(5; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(Key1; PlanID)
        {
            Clustered = true;
        }
    }


}