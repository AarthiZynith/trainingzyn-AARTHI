table 50133 TechnicianTable
{
    DataClassification=ToBeClassified;

    fields{
    field(1;"ID";Code[200]){
            DataClassification=CustomerContent;
    }
     field(2;"Name";text[120]){
            DataClassification=CustomerContent;
    }
     field(3;"Ph.No";text[200]){
            DataClassification=CustomerContent;
    }
     field(4;"Dept"; Enum "TechnicianDepartment"){
            DataClassification=CustomerContent;
    }

    field(5;"Problem Count";Integer){
        FieldClass=FlowField;
        CalcFormula=count(ProblemTable where(Technician=field(ID)));
        Editable=false;

    }
    }


keys{
        key(PK;ID){

        }
}
}

