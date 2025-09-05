table 50201 PlanTable
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;PlanID; Code[100])
        {
            DataClassification = ToBeClassified;
            
        }
        field(2;PlanFee;Decimal){DataClassification=ToBeClassified;}
        field(3;PlanName;Text[100]){
            DataClassification=ToBeClassified;
        }
        field(4;Status;enum SubscriptionStatusEnum){DataClassification=ToBeClassified;}
        field(5;Description;Text[100]){DataClassification=ToBeClassified;}

    }
    
    keys
    {
        key(Key1; PlanID)
        {
            Clustered = true;
        }
    }
    
    
}