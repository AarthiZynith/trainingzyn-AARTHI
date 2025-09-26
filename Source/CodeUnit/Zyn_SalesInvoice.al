codeunit 50131 Zyn_PostedBeginningTextHandler
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    local procedure OnAfterPostSalesDoc(
        var SalesHeader: Record "Sales Header";
        var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        SalesShptHdrNo: Code[20];
        RetRcpHdrNo: Code[20];
        SalesInvHdrNo: Code[20];
        SalesCrMemoHdrNo: Code[20];
        CommitIsSuppressed: Boolean;
        InvtPickPutaway: Boolean;
        var CustLedgerEntry: Record "Cust. Ledger Entry";
        WhseShip: Boolean;
        WhseReceiv: Boolean;
        PreviewMode: Boolean)
    var
        PostedSalesInvoice: Record "Sales Invoice Header";

        PostedDisp: Record "Standard Text";
    begin
        if SalesInvHdrNo <> '' then begin
            if PostedSalesInvoice.Get(SalesInvHdrNo) then
                CopyEditedBeginningTextToPosted(SalesHeader, PostedSalesInvoice);
                UpdateLastSoldPrices(PostedSalesInvoice);
                
                //CopyInvoiceTextToPosted(SalesHeader, PostedSalesInvoice);
 
            ClearUnpostedBeginningText(SalesHeader);
        end;
    end;
 
    local procedure CopyEditedBeginningTextToPosted(SalesHeader: Record "Sales Header"; PostedInvoice: Record "Sales Invoice Header")
    var
        SourceBuffer: Record Zyn_SalesInvoiceSubpageExt
    ;
        TargetBuffer: Record Zyn_SalesInvoiceSubpageExt;
        NewLineNo: Integer;
        SelectionType: Enum Zyn_BeginEndText;
    begin
        // Loop Begin and End separately
        SelectionType := SelectionType::BeginText;
        repeat
            SourceBuffer.Reset();
            SourceBuffer.SetRange("No.", SalesHeader."No.");
            SourceBuffer.SetRange("customer no", SalesHeader."Sell-to Customer No.");
            SourceBuffer.SetRange("Enum Method", SelectionType);
 
            if SourceBuffer.FindSet() then begin 
                repeat
                    NewLineNo := GetNextLineNo(TargetBuffer, PostedInvoice."No.", PostedInvoice."Sell-to Customer No.", SelectionType);
                    TargetBuffer.Init();
                    TargetBuffer."No." := PostedInvoice."No.";
                    TargetBuffer."Line No." := NewLineNo;
                    TargetBuffer."Language code" := SourceBuffer."Language code";
                    TargetBuffer."Enum Method" := SourceBuffer."Enum Method";
                    TargetBuffer."customer no" := PostedInvoice."Sell-to Customer No.";
                    TargetBuffer.Description := SourceBuffer.Description;
                    TargetBuffer.Text := SourceBuffer.Text;
                    TargetBuffer.Insert(true);
                until SourceBuffer.Next() = 0;
            end;
 
            // Move to next enum value (Begin -> End)
            if SelectionType = SelectionType::BeginText then
                SelectionType := SelectionType::EndText
            else
                exit; // break loop
 
        until false;
    end;
 
    local procedure ClearUnpostedBeginningText(SalesHeader: Record "Sales Header")
    var
        SourceBuffer: Record Zyn_SalesInvoiceSubpageExt;
    begin
        SourceBuffer.SetRange("No.", SalesHeader."No.");
        SourceBuffer.SetRange("customer no", SalesHeader."Sell-to Customer No.");
        SourceBuffer.DeleteAll();
    end;
 
    local procedure GetNextLineNo(Buffer: Record Zyn_SalesInvoiceSubpageExt; DocNo: Code[20]; CustNo: Code[20]; Sel: Enum Zyn_BeginEndText): Integer
    var
        MaxLineNo: Integer;
    begin
        Buffer.Reset();
        Buffer.SetRange("No.", DocNo);
        Buffer.SetRange("customer no", CustNo);
        Buffer.SetRange("Enum Method", Sel);
        if Buffer.FindLast() then
            MaxLineNo := Buffer."Line No.";
        exit(MaxLineNo + 10000);
    end;
 
    local procedure CopyInvoiceTextToPosted(SalesHeader: Record "Sales Header"; PostedInvoice: Record "Sales Invoice Header")
    var
        StdText: Record "Extended Text Line";
        Buffer: Record Zyn_SalesInvoiceSubpageExt;
        Customer: Record Customer;
        NewLineNo: Integer;
        SelectionType: Enum Zyn_BeginEndText;
    begin
        if not Customer.Get(SalesHeader."Sell-to Customer No.") then
            exit;
 
        // BEGINNING INVOICE TEXT
        if SalesHeader.PostedInvoiceBegin <> '' then begin
            StdText.SetRange("No.", SalesHeader.PostedInvoiceBegin);
            StdText.SetRange("Language Code", Customer."Language Code");
 
            SelectionType := SelectionType::BeginText;
            if StdText.FindSet() then
                repeat
                    Buffer.Init();
                    Buffer."Enum Method" := SelectionType;
                    Buffer."No." := PostedInvoice."No.";
                    Buffer."customer no" := PostedInvoice."Sell-to Customer No.";
                    //Buffer."Document Type" := SalesHeader."Document Type";
                    Buffer."Language code" := Customer."Language Code";
                    Buffer.Description := SalesHeader."Beginning Text";
                    Buffer.Text := StdText."Text";
                    Buffer."Line No." := GetNextLineNo(Buffer, Buffer."No.", Buffer."customer no", Buffer."Enum Method");
                    Buffer.Insert(true);
                until StdText.Next() = 0;
        end;
 
        // ENDING INVOICE TEXT
        if SalesHeader.PostedInvoiceEnd <> '' then begin
            StdText.Reset();
            StdText.SetRange("No.", SalesHeader.PostedInvoiceEnd);
            StdText.SetRange("Language Code", Customer."Language Code");
 
            SelectionType := SelectionType::EndText;
            if StdText.FindSet() then
                repeat
                    Buffer.Init();
                    Buffer."Enum Method" := SelectionType;
                    Buffer."No." := PostedInvoice."No.";
                    Buffer."customer no" := PostedInvoice."Sell-to Customer No.";
                    //Buffer."Document Type" := SalesHeader."Document Type";
                    Buffer."Language code" := Customer."Language Code";
                    Buffer.Description := SalesHeader.PostedInvoiceEnd;
                    Buffer.Text := StdText."Text";
                    Buffer."Line No." := GetNextLineNo(Buffer, Buffer."No.", Buffer."customer no", Buffer."Enum Method");
                    Buffer.Insert(true);
                until StdText.Next() = 0;
        end;
    end;

    local procedure UpdateLastSoldPrices(PostedInvoice: Record "Sales Invoice Header")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        LastSoldPrice: Record Zyn_HighestSalesPrice;
    begin
        SalesInvoiceLine.SetRange("Document No.", PostedInvoice."No.");
        if SalesInvoiceLine.FindSet() then
            repeat
                LastSoldPrice.Init();
                LastSoldPrice."Customer No" := SalesInvoiceLine."Sell-to Customer No.";
                LastSoldPrice."Item No" := SalesInvoiceLine."No.";
                LastSoldPrice."Item Price":= SalesInvoiceLine."Unit Price";
                LastSoldPrice."Posting date" := PostedInvoice."Posting Date";
                LastSoldPrice.Insert(true);
            until SalesInvoiceLine.Next() = 0;
    end;
 
 
}
 