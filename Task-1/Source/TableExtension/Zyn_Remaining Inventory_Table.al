tableextension 50110 ItemExtension extends Item
{
    fields
    {
        field(50100; "Remaining Inventory"; Decimal)
        {
            Caption = 'Remaining Inventory';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Sum("Item Ledger Entry"."Remaining Quantity" WHERE("Item No." = FIELD("No.")));
            //DataClassification = Inventory;
        }
    }
}
