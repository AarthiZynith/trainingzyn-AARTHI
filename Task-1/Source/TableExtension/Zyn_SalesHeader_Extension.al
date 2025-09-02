tableextension 50133 SalesHeader extends  "Sales Header"
{
    Fields{
        field(50100;"Beginning Text";Text[250]){
            DataClassification=CustomerContent;
            TableRelation="Standard Text".Code; 
             trigger OnValidate()
                    var
                        ExtText: Record "Extended Text Line";
                        Buffer: Record SalesInvoiceSubpageExt;
                        Customer: Record Customer;
                        LineNo: Integer;
                    begin
                        Buffer.SetRange("Enum Method", Buffer."Enum Method"::BeginText);
                        if Rec."No." = '' then
                            Error('Please enter or save the Sales Invoice before selecting Beginning Text.');
                        Buffer.SetRange("customer no", Rec."Sell-to Customer No.");
                        Buffer.SetRange("No.", Rec."No.");
                        Buffer.DeleteAll();

                        if Customer.Get(Rec."Sell-to Customer No.") then begin
                            ExtText.SetRange("No.", Rec."Beginning Text");
                            ExtText.SetRange("Language Code", Customer."Language Code");

                            LineNo := 10000;
                            //LineNo := GetNextLineNo(Rec."No.", Buffer."Enum Method"::BeginText);


                            if ExtText.FindSet() then begin
                                repeat
                                    Buffer.Init();
                                    Buffer."customer no" := Rec."Sell-to Customer No.";
                                    Buffer."No." := Rec."No.";
                                    Buffer."Language code" := Customer."Language Code";
                                    Buffer."Line No." := LineNo;
                                    Buffer."Description" := Rec."Beginning Text";
                                    Buffer."Enum Method" := Buffer."Enum Method"::BeginText;
                                    Buffer.Text := ExtText.Text;
                                    Buffer.Insert();

                                    LineNo += 10000;
                                until ExtText.Next() = 0;
                            end;
                        end;

                      // CurrPage."Extended Text Part".Page.SaveRecord();
                    end;
  
        }
        field(50101;"Ending Text";Text[200]){
            DataClassification=CustomerContent;
            TableRelation="Standard Text".Code;

            trigger OnValidate()
                    var
                        ExtText: Record "Extended Text Line";
                        Buffer: Record SalesInvoiceSubpageExt;
                        Customer: Record Customer;
                        LineNo: Integer;
                    begin
                        Buffer.SetRange("Enum Method", Buffer."Enum Method"::EndText);
                        if Rec."No." = '' then
                            Error('Please enter or save the Sales Invoice before selecting Beginning Text.');
                        Buffer.SetRange("customer no", Rec."Sell-to Customer No.");
                        Buffer.SetRange("No.", Rec."No.");
                        Buffer.DeleteAll();

                        if Customer.Get(Rec."Sell-to Customer No.") then begin
                            ExtText.SetRange("No.", Rec."Ending Text");
                            ExtText.SetRange("Language Code", Customer."Language Code");

                              LineNo := 10000;
                           // LineNo := GetNextLineNo(Rec."No.", Buffer."Enum Method"::EndText);


                            if ExtText.FindSet() then begin
                                repeat
                                    Buffer.Init();
                                    Buffer."customer no" := Rec."Sell-to Customer No.";
                                    Buffer."No." := Rec."No.";
                                    Buffer."Language code" := Customer."Language Code";
                                    Buffer."Line No." := "LineNo";
                                    Buffer."Description" := Rec."Beginning Text";
                                    Buffer."Enum Method" := Buffer."Enum Method"::EndText;
                                    Buffer.Text := ExtText.Text;
                                    Buffer.Insert();

                                    LineNo += 10000;
                                until ExtText.Next() = 0;
                            end;
                        end;

                      //  CurrPage."Extended Text".Page.SaveRecord();
                    end;

        }


        field(50102;"PostedInvoiceBegin";Text[100]){
            DataClassification=CustomerContent;
             TableRelation="Standard Text".Code;
            
        }
        field(50103;"PostedInvoiceEnd";Text[100]){
            DataClassification=CustomerContent;
             TableRelation="Standard Text".Code;
        }


        field(50104;"Last posted invoice price";Decimal){
            FieldClass=FlowField;
            CalcFormula=max(HighestSalesPrice."Item Price"where("Customer No"=field("Sell-to Customer No."),"Posting date"=field(LastPostingDate)));
        }
        field(50105;"LastPostingDate";Date){
            FieldClass=FlowField;
            CalcFormula=max(HighestSalesPrice."Posting date"where("Customer No"=field("Sell-to Customer No.")));
            
        }


        }

    }
