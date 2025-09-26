pageextension 50121 Zyn_SalesOrderExt extends "sales order"
{
    layout
    {
        addlast(content)
        {
            group("Beginning Text")
            {
                field("Beginning Text Code"; Rec."Beginning Text")
                {
                    ApplicationArea = All;
                    TableRelation = "Standard Text";
                    trigger OnValidate()
                    var
                        ExtText: Record "Extended Text Line";
                        Buffer: Record Zyn_SalesInvoiceSubpageExt;
                        Customer: Record Customer;
                        LineNo: Integer;
                    begin
                        if Rec."No." = '' then
                            Error('Please enter or save the Sales Invoice before selecting Beginning Text.');
                        Buffer.SetRange("document type", Rec."Document Type");
                        Buffer.SetRange("No.", Rec."No.");
                        Buffer.setrange("Enum Method", Buffer."Enum Method"::BeginText);
                        buffer.DeleteAll();

                        if Customer.Get(Rec."Sell-to Customer No.") then begin
                            ExtText.SetRange("No.", Rec."Beginning Text");
                            ExtText.SetRange("Language Code", Customer."Language Code");

                            LineNo := 10000;

                            repeat
                                Buffer.Init();
                                Buffer."Line No." := LineNo;
                                Buffer."Enum Method" := Buffer."Enum Method"::BeginText;
                                Buffer."customer no" := Rec."Sell-to Customer No.";
                                Buffer."Document Type" := Rec."Document Type";
                                Buffer."No." := Rec."No.";
                                Buffer."Language code" := Customer."Language Code";
                                Buffer."Description" := Rec."Beginning Text";
                                Buffer.Text := ExtText."Text";
                                Buffer.Insert();

                                LineNo += 10000;
                            until ExtText.Next() = 0;

                        end;

                        CurrPage."Extended Text Part".Page.SaveRecord();
                    end;

                }
            }

            part("Extended Text Part"; Zyn_SalesInvoiceSubPageextn)
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = field("Document Type"),
                              "No." = field("No."),
                              "Enum Method" = const(Zyn_BeginEndText::BeginText);
            }

            group("Ending Text")
            {
                field("Ending Text Code"; Rec."Ending Text")
                {
                    ApplicationArea = All;
                    TableRelation = "Standard Text";
                    trigger OnValidate()
                    var
                        ExtText: Record "Extended Text Line";
                        Buffer: Record Zyn_SalesInvoiceSubpageExt;
                        Customer: Record Customer;
                        LineNo: Integer;
                    begin
                        if Rec."No." = '' then
                            Error('Please enter or save the Sales Invoice before selecting Beginning Text.');
                        Buffer.SetRange("document type", Rec."Document Type");
                        Buffer.SetRange("No.", Rec."No.");
                        Buffer.setrange("Enum Method", Buffer."Enum Method"::EndText);
                        buffer.DeleteAll();

                        if Customer.Get(Rec."Sell-to Customer No.") then begin
                            ExtText.SetRange("No.", Rec."Ending Text");
                            ExtText.SetRange("Language Code", Customer."Language Code");

                            LineNo := 10000;

                            repeat
                                Buffer.Init();
                                Buffer."Line No." := LineNo;
                                Buffer."Enum Method" := Buffer."Enum Method"::EndText;
                                Buffer."customer no" := Rec."Sell-to Customer No.";
                                Buffer."Document Type" := Rec."Document Type";
                                Buffer."No." := Rec."No.";
                                Buffer."Language code" := Customer."Language Code";
                                Buffer."Description" := Rec."Ending Text";
                                Buffer.Text := ExtText."Text";
                                Buffer.Insert();

                                LineNo += 10000;
                            until ExtText.Next() = 0;

                        end;

                        CurrPage."Ending Text Part".Page.SaveRecord();
                    end;

                }
            }

            part("Ending Text Part"; Zyn_SalesInvoiceListPart)
            {
                ApplicationArea = All;
                SubPageLink = "Document Type" = field("Document Type"),
                              "No." = field("No."),
                              "Enum Method" = const(Zyn_BeginEndText::EndText);
            }

            field("Invoice Posted Begin  OrderText"; Rec.PostedInvoiceBegin)
            {
                ApplicationArea = All;


            }
            field("Invoice Posted End OrderText"; Rec.PostedInvoiceEnd)
            {
                ApplicationArea = All;

            }
            field("Last posted invoice price"; Rec."Last posted invoice price")
            {
                ApplicationArea = All;
            }
            // field(LastPostingDate;Rec.LastPostingDate){
            //     ApplicationArea=All;
            // }



        }
    }

    var
        "Beginning Text Code": Code[20];
        "Ending Text Code": Code[20];
}
