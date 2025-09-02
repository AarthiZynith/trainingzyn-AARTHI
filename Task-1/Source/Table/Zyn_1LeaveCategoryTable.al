table 50166 LeaveCategoryTable
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;CategoryName; Text[100])
        {
            DataClassification = ToBeClassified;
            
        }
        field(2;Description;Text[100]){
            DataClassification=ToBeClassified;
        }
        field(3;"No of Days Allowed";Integer){
            DataClassification=ToBeClassified;
        }
        field(4;EmployeeID;Integer){
            DataClassification=ToBeClassified;
            TableRelation=EmployeeTable.EmployeeID;
        }
        field(5;Status;Integer){
            DataClassification=ToBeClassified;
            TableRelation= LeaveRequestTable.Status;
        }
    }
    
    keys
    {
        key(PK; CategoryName)
        {
            Clustered = true;
        }
    }
    
}