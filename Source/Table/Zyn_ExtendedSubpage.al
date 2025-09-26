table 50144 Zyn_SalesInvoiceSubpageExt
{
    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;

        }
        field(2; "No."; Code[200])
        {
            Caption = 'No.';
            DataClassification = ToBeClassified;

        }
        field(3; "Customer No"; code[100])
        {
            Caption = 'Customer No';
            DataClassification = ToBeClassified;

        }

        field(4; "Language Code"; code[100])
        {
            Caption = 'Language Code';
            DataClassification = ToBeClassified;

        }
        field(5; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
        field(6; "Text"; Text[200])
        {
            Caption = 'Text';
            DataClassification = ToBeClassified;
        }
        field(7; Bold; Boolean)
        {
            Caption = 'Bold';
            DataClassification = ToBeClassified;
        }
        field(8; Italic; Boolean)
        {
            Caption = ' Italic';
            DataClassification = ToBeClassified;
        }
        field(9; "Under Line"; Boolean)
        {
            Caption = 'Under Line';
            DataClassification = ToBeClassified;
        }
        field(10; "Document Type"; enum "Sales Document Type")
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
        }
        field(11; "Enum Method"; enum Zyn_BeginEndText)
        {
            Caption = 'Enum Method';
            DataClassification = ToBeClassified;
        }

    }
    keys
    {
        key(Pk; "Line No.", "No.", "Language Code", "Enum Method", "Document Type")
        {
            Clustered = true;
        }
    }
}