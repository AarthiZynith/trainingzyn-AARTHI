table 50161 EmployeeTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EmployeeID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement=true;

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
    }

    keys
    {
        key(PK; EmployeeID,name)
        {
            Clustered = true;
        }
    }



}