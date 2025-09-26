table 50212 Zyn_NotificationCustom
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
            TableRelation = Zyn_CustomerSubscription."Customer ID";
        }
        field(3; Message; Text[100]) { DataClassification = ToBeClassified; }
        field(4; DateCreated; DateTime) { DataClassification = ToBeClassified; }
    }


    keys
    {
        key(Pk; CustomerNo, ID) { Clustered = true; }
    }
}