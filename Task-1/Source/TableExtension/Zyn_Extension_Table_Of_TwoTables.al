tableextension 50100 CustomerExtension extends Customer
{
    fields
    {
        field(50100; "Allowed Credit"; Decimal)
        {
            Caption = 'Allowed Credit';
            DataClassification = CustomerContent;
        }
 
        field(50101; "Credit Used"; Decimal)
        {
            Caption = 'Credit Used';
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Line"."Amount" WHERE(
                "Sell-to Customer No." = FIELD("No.")
            ));
            Editable = false;
        }

        field(50102;"Loyalty Points";Decimal){
            DataClassification=CustomerContent;
        }
//         field(50106; "Sales Amount"; Decimal)
// {
//     Caption = 'Sales Amount';
//     FieldClass = FlowField;
//    CalcFormula = Sum("Cust. Ledger Entry".Amount where ("Customer No."=field("No.")));



// }
//         field(50105; "Sales Year"; Code[4])
//        {
//     Caption = 'Sales Year';
//     FieldClass = FlowFilter;

    
//        }

    }
    trigger OnBeforeModify()
    begin
        CalcFields("Credit Used");
 
        if "Credit Used" > "Allowed Credit" then
            Error('Cannot save: Credit Used (%1) exceeds Allowed Credit (%2).', "Credit Used", "Allowed Credit");
    end;
}