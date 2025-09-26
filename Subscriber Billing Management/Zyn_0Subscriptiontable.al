table 50205 Zyn_CustomerSubscription
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Subscription ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption='Subscription ID';
        }
        field(2; "Customer ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer."No.";
            Caption='Customer ID';
        }
        field(3; "Plan ID"; Code[100])
        {
            DataClassification = ToBeClassified;
            Caption='Plan ID';
            TableRelation = Zyn_PlanTable.PlanID;
        }
        field(4; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                if "Start Date" <> 0D then begin
                    "Next Bill Date" := CalcDate('<+1M>', "Start Date");
                    if ("End Date" <> 0D) and ("Next Bill Date" > "End Date") then
                        "Next Bill Date" := 0D;

                end else
                    "Next Bill Date" := 0D;

            end;
        }
        field(5; "Duration (Months)"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(6; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Next Bill Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(8; "Status"; Enum Zyn_CustomerSubscriptionStatus)
        {
            DataClassification = ToBeClassified;
        }
        field(9; NextRenewalDate; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(10; ReminderSent; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Subscription ID", "Plan ID", "Customer ID") { Clustered = true; }
    }
}
