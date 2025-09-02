table 50138 ProblemTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

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

        }
        field(4; Problem; Enum problemenum)
        {
            DataClassification = ToBeClassified;

        }
        field(5; Dept; enum TechnicianDepartment)
        {
            DataClassification = ToBeClassified;

        }
        field(6; Technician; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = TechnicianTable.ID where(Dept = field(Dept));

        }
        field(7; Description; text[200])
        {
            DataClassification = ToBeClassified;

        }
        field(8; Date; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Entry No.", "Customer No."
    )
        {

        }
    }



}