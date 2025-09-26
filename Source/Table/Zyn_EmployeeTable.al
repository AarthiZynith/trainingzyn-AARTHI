table 50161 Zyn_EmployeeTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; EmployeeID; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'EmployeeID';
        }
        field(2; Name; Text[100])
        {
            Caption = ' Name';
            DataClassification = ToBeClassified;
        }
        field(3; EmployeeRole; enum Zyn_EmployeeRoleEnum)
        {
            Caption = ' EmployeeRole';
            DataClassification = ToBeClassified;
        }
        field(4; Department; enum Zyn_EmployeeDepartmentEnum)
        {
            Caption = 'Department';
            DataClassification = ToBeClassified;
        }
        field(5; AssignedIndividualAssets; Integer)
        {
            Caption = 'AssignedIndividualAssets';
            FieldClass = FlowField;
            CalcFormula = count(EmployeeAsset where(EmployeeID = field(EmployeeID)));
        }
        field(6; Serial_No; code[100])
        {
            Caption = 'Serial_No';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_Assets.SerialNo;
        }

    }

    keys
    {
        key(PK; EmployeeID, name, Serial_No)
        {
            Clustered = true;
        }
    }



}