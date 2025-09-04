table 50191 AssignedAssets
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;serial_No; code[100])
        {
            DataClassification = ToBeClassified;
           // AutoIncrement=true;
           TableRelation=Assets.SerialNo;
            
        }
        field(2;TotalAssets;Integer){FieldClass=FlowField;
        CalcFormula=count(Assets);
        }
    }
    
    keys
    {
        key(Key1;serial_No)
        {
            Clustered = true;
        }
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}