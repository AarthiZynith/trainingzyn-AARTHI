table 50138 Zyn_ProblemTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption='Entry No.';
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer."No.";
            DataClassification = CustomerContent;
        }
        field(3; "Customer Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup(Customer.Name WHERE("No." = FIELD("Customer No.")));
            Caption='Customer Name';
        }
        field(4; Problem; Enum Zyn_Problemenum)
        {
            DataClassification = ToBeClassified;
            Caption='Problem';

        }
        field(5; Dept; enum Zyn_TechnicianDepartment)
        {
            DataClassification = ToBeClassified;
            Caption=' Dept';

        }
        field(6; Technician; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Zyn_TechnicianTable.ID where(Dept = field(Dept));
            Caption='Technician';
        }
        field(7; Description; text[200])
        {
            DataClassification = ToBeClassified;
            Caption='Description';
        }
        field(8; Date; Date)
        {
            DataClassification = ToBeClassified;
            Caption='Date';
        }
    }

    keys
    {
        key(PK; "Entry No.", "Customer No.")
        {
            Clustered = true;
        }
    }
}