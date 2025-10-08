tableextension 50133 Zyn_SalesHeader extends "Sales Header"
{
    Fields
    {
        field(50100; "Beginning Text"; Text[250])
        {
            Caption = 'Beginning Text';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;
            // trigger OnValidate()
            // var
            //     ExtText: Record "Extended Text Line";
            //     Buffer: Record Zyn_SalesInvoiceSubpageExt;
            //     Customer: Record Customer;
            //     LineNo: Integer;
            // begin
            //     Buffer.SetRange("Enum Method", Buffer."Enum Method"::BeginText);
            //     if Rec."No." = '' then
            //         Error('Please enter or save the Sales Invoice before selecting Beginning Text.');
            //     Buffer.SetRange("customer no", Rec."Sell-to Customer No.");
            //     Buffer.SetRange("No.", Rec."No.");
            //     Buffer.DeleteAll();
            //     if Customer.Get(Rec."Sell-to Customer No.") then begin
            //         ExtText.SetRange("No.", Rec."Beginning Text");
            //         ExtText.SetRange("Language Code", Customer."Language Code");
            //         LineNo := 10000;
            //         if ExtText.FindSet() then begin
            //             repeat
            //                 Buffer.Init();
            //                 Buffer."customer no" := Rec."Sell-to Customer No.";
            //                 Buffer."No." := Rec."No.";
            //                 Buffer."Language code" := Customer."Language Code";
            //                 Buffer."Line No." := LineNo;
            //                 Buffer."Description" := Rec."Beginning Text";
            //                 Buffer."Enum Method" := Buffer."Enum Method"::BeginText;
            //                 Buffer.Text := ExtText.Text;
            //                 Buffer.Insert();
            //                 LineNo += 10000;
            //             until ExtText.Next() = 0;
            //         end;
            //     end;
            // end;

            trigger OnValidate()
            var
                ExtText: Record "Extended Text Line";
                Buffer: Record Zyn_SalesInvoiceSubpageExt;
                Customer: Record Customer;
                LastBuffer: Record Zyn_SalesInvoiceSubpageExt;
                NextLineNo: Integer;
            begin
                // Validate that the invoice exists before proceeding
                if Rec."No." = '' then
                    Error('Please save the Sales Invoice before selecting Ending Text.');

                // Filter buffer for the current Customer & Invoice only
                Buffer.SetRange("Customer No", Rec."Sell-to Customer No.");
                Buffer.SetRange("No.", Rec."No.");
                Buffer.SetRange("Enum Method", Buffer."Enum Method"::BeginText);

                // Remove old lines for this combination
                Buffer.DeleteAll();

                // Get Customer
                if not Customer.Get(Rec."Sell-to Customer No.") then
                    exit;

                // Filter Extended Text dynamically
                ExtText.SetRange("No.", Rec."Ending Text");
                ExtText.SetRange("Language Code", Customer."Language Code");

                if ExtText.FindSet() then begin
                    // Calculate next starting Line No. dynamically
                    // (use max existing + 10000, or start at 10000 if none)
                    LastBuffer.Reset();
                    LastBuffer.SetRange("Customer No", Rec."Sell-to Customer No.");
                    LastBuffer.SetRange("No.", Rec."No.");
                    if LastBuffer.FindLast() then
                        NextLineNo := LastBuffer."Line No." + 10000
                    else
                        NextLineNo := 10000;

                    repeat
                        Buffer.Init();
                        Buffer.Validate("Customer No", Rec."Sell-to Customer No.");
                        Buffer.Validate("No.", Rec."No.");
                        Buffer.Validate("Language Code", Customer."Language Code");
                        Buffer.Validate("Line No.", NextLineNo);
                        Buffer.Validate("Enum Method", Buffer."Enum Method"::BeginText);
                        Buffer.Validate(Text, ExtText.Text);
                        Buffer.Validate(Description, Rec."Ending Text"); // or another dynamic source
                        Buffer.Insert();

                        NextLineNo += 10000; // dynamic increment, no fixed start
                    until ExtText.Next() = 0;
                end;
            end;

        }
        field(50101; "Ending Text"; Text[200])
        {
            Caption = 'Ending Text';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;

            trigger OnValidate()
            var
                ExtText: Record "Extended Text Line";
                Buffer: Record Zyn_SalesInvoiceSubpageExt;
                Customer: Record Customer;
                LastBuffer: Record Zyn_SalesInvoiceSubpageExt;
                NextLineNo: Integer;
            begin
                // Validate that the invoice exists before proceeding
                if Rec."No." = '' then
                    Error('Please save the Sales Invoice before selecting Ending Text.');

                // Filter buffer for the current Customer & Invoice only
                Buffer.SetRange("Customer No", Rec."Sell-to Customer No.");
                Buffer.SetRange("No.", Rec."No.");
                Buffer.SetRange("Enum Method", Buffer."Enum Method"::EndText);

                // Remove old lines for this combination
                Buffer.DeleteAll();

                // Get Customer
                if not Customer.Get(Rec."Sell-to Customer No.") then
                    exit;

                // Filter Extended Text dynamically
                ExtText.SetRange("No.", Rec."Ending Text");
                ExtText.SetRange("Language Code", Customer."Language Code");

                if ExtText.FindSet() then begin
                    // Calculate next starting Line No. dynamically
                    // (use max existing + 10000, or start at 10000 if none)
                    LastBuffer.Reset();
                    LastBuffer.SetRange("Customer No", Rec."Sell-to Customer No.");
                    LastBuffer.SetRange("No.", Rec."No.");
                    if LastBuffer.FindLast() then
                        NextLineNo := LastBuffer."Line No." + 10000
                    else
                        NextLineNo := 10000;

                    repeat
                        Buffer.Init();
                        Buffer.Validate("Customer No", Rec."Sell-to Customer No.");
                        Buffer.Validate("No.", Rec."No.");
                        Buffer.Validate("Language Code", Customer."Language Code");
                        Buffer.Validate("Line No.", NextLineNo);
                        Buffer.Validate("Enum Method", Buffer."Enum Method"::EndText);
                        Buffer.Validate(Text, ExtText.Text);
                        Buffer.Validate(Description, Rec."Ending Text"); // or another dynamic source
                        Buffer.Insert();

                        NextLineNo += 10000; // dynamic increment, no fixed start
                    until ExtText.Next() = 0;
                end;
            end;
        }
        field(50102; "PostedInvoiceBegin"; Text[100])
        {
            Caption = 'PostedInvoiceBegin';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;

        }
        field(50103; "PostedInvoiceEnd"; Text[100])
        {
            Caption = 'PostedInvoiceEnd';
            DataClassification = CustomerContent;
            TableRelation = "Standard Text".Code;
        }
        field(50104; "Last posted invoice price"; Decimal)
        {
            Caption = 'Last posted invoice price';
            FieldClass = FlowField;
            CalcFormula = max(Zyn_HighestSalesPrice."Item Price" where("Customer No" = field("Sell-to Customer No."), "Posting date" = field(LastPostingDate)));
        }
        field(50105; "LastPostingDate"; Date)
        {
            Caption = 'LastPostingDate';
            FieldClass = FlowField;
            CalcFormula = max(Zyn_HighestSalesPrice."Posting date" where("Customer No" = field("Sell-to Customer No.")));

        }
        field(50106; "From Subscription"; Boolean)
        {
            Caption = 'From Subscription';
            DataClassification = ToBeClassified;
        }
        field(50107; "Subscription Plan ID"; Code[100])
        {
            Caption = 'Subscription Plan ID';
            DataClassification = ToBeClassified;
            TableRelation = Zyn_PlanTable.PlanID;
        }
        field(50108; "Subscription Plan Fee"; Decimal)
        {
            Caption = 'Subscription Plan Fee';
            DataClassification = ToBeClassified;
        }
        field(50109; "Display Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
            Caption = 'Amount';
        }

    }

}
