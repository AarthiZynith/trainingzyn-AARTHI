table 50212 NotificationCustomTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(2; CustomerNo; code[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Customer Subscription"."Customer ID";
        }
        field(3; Message; Text[100]) { DataClassification = ToBeClassified; }
        field(4; DateCreated; DateTime) { DataClassification = ToBeClassified; }
    }


keys{
    key(Pk;CustomerNo,ID){Clustered=true;}
}
}