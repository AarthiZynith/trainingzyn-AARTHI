table 50144 SalesInvoiceSubpageExt
{
    fields
    {
        field(1; "Line No."; Integer)
        {
            DataClassification = SystemMetadata;

        }
        field(2; "No."; Code[200])
        {
            DataClassification = ToBeClassified;
            //TableRelation= "Sales Header"."No." where("Document Type"=const("Invoice"));
        }
        field(3; "Customer No"; code[100])
        {
            DataClassification = ToBeClassified;
            // TableRelation="Sales Header"."Sell-to Customer No." where("Document Type"=const("Invoice"));
        }

        field(4; "Language Code"; code[100])
        {
            DataClassification = ToBeClassified;
            //TableRelation="Extended Text Header"."Language Code";
        }
        field(5; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Text"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(7; Bold; Boolean)
        {
            DataClassification = ToBeClassified;
        }
         field(8; Italic; Boolean)
        {
            DataClassification = ToBeClassified;
        }
         field(9; "Under Line"; Boolean)
        {
            DataClassification = ToBeClassified;
        }


        field(10;"Document Type";enum "Sales Document Type"){
            DataClassification=ToBeClassified;
        }
        field(11;"Enum Method"; enum BeginEndText){
            DataClassification=ToBeClassified;
        }


    }
    keys
    {
        key(Pk; "Line No.", "No.", "Language Code", "Enum Method","Document Type")
        {

        }
    }
}