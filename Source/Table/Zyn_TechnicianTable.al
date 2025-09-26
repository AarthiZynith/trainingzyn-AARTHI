table 50133 Zyn_TechnicianTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "ID"; Code[200])
        {
            Caption = 'ID';
            DataClassification = CustomerContent;
        }
        field(2; "Name"; text[120])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; "Ph.No"; text[200])
        {
            Caption = 'Ph.No';
            DataClassification = CustomerContent;
        }
        field(4; "Dept"; Enum Zyn_TechnicianDepartment)
        {
            Caption = 'Dept';
            DataClassification = CustomerContent;
        }

        field(5; "Problem Count"; Integer)
        {
            Caption = 'Problem Count';
            FieldClass = FlowField;
            CalcFormula = count(Zyn_ProblemTable where(Technician = field(ID)));
            Editable = false;

        }
    }

    keys
    {
        key(PK; ID)
        {

        }
    }
}

