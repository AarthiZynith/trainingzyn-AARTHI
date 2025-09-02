table 50109 Income
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; IncomeID; Code[10]) { DataClassification = ToBeClassified; }
        field(2; Description; Text[100]) { DataClassification = ToBeClassified; }
        field(3; Amount; Decimal) { DataClassification = ToBeClassified; }
        field(4; Date; Date) { DataClassification = ToBeClassified; }

        // field(5; CategoryNo; Integer) // store only the key
        // {
        //     Caption = 'Category No';
        //     TableRelation = IncomeCategory.CategoryNo;
        // }

        field(6; CategoryName; code[100]) // always show name
        {
            Caption = 'Category';
            TableRelation = IncomeCategory.Name;

            //     FieldClass = FlowField;
            //     CalcFormula = Lookup(IncomeCategory.Name WHERE(CategoryNo = FIELD(CategoryNo)));
            //    // Editable = false;
            // }
        }
    }
    keys
    {
        key(PK; IncomeID) { Clustered = true; }
    }

}
