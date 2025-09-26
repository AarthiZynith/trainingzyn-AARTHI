table 50191 Zyn_AssignedAssets
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; serial_No; code[100])
        {
            Caption = 'serial_No';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_Assets.SerialNo;
        }
        field(2; TotalAssets; Integer)
        {
            Caption = 'TotalAssets';
            FieldClass = FlowField;
            CalcFormula = count(Zyn_Assets);
        }
    }

    keys
    {
        key(Key1; serial_No)
        {
            Clustered = true;
        }
    }

}