table 50161 EmployeeTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EmployeeID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(2; Name; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; EmployeeRole; enum EmployeeRoleEnum)
        {
            DataClassification = ToBeClassified;
        }
        field(4; Department; enum EmployeeDepartmentEnum)
        {
            DataClassification = ToBeClassified;
        }
        field(5;AssignedIndividualAssets;Integer){FieldClass=FlowField;
        CalcFormula=count(EmployeeAsset where(EmployeeID=field(EmployeeID)));}
        field(6;Serial_No;code[100]){
            DataClassification=ToBeClassified;
            TableRelation=Assets.SerialNo;
        }

       
        }
        

    keys
    {
        key(PK; EmployeeID, name,Serial_No)
        {
            Clustered = true;
        }
    }



}