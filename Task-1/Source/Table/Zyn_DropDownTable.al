table 50123  DropDownTable{
    DataClassification=ToBeClassified;
    fields{
        field(1;"ID";Integer)
        {
            DataClassification=SystemMetadata;
            AutoIncrement = true;
        }
        field(2;"Name";Text[100])
        {
            DataClassification=SystemMetadata;
        }
    }
}