codeunit 50134 "Zyn_creditmemoTextHandler"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesCrMemoHeaderInsert', '', false, false)]
    local procedure OnAfterSalesCrMemoHeaderInsert(
        var SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesHeader: Record "Sales Header";
        CommitIsSuppressed: Boolean;
        WhseShip: Boolean;
        WhseReceive: Boolean;
        var TempWhseShptHeader: Record "Warehouse Shipment Header";
        var TempWhseRcptHeader: Record "Warehouse Receipt Header")
    begin
        CopyEditedBeginningTextToPosted(SalesHeader, SalesCrMemoHeader);
        ClearUnpostedBeginningText(SalesHeader);
    end;

    local procedure CopyEditedBeginningTextToPosted(
        SalesHeader: Record "Sales Header";
        PostedCreditMemo: Record "Sales Cr.Memo Header")
    var
        SourceBuffer: Record Zyn_SalesInvoiceSubpageExt;
        TargetBuffer: Record Zyn_SalesInvoiceSubpageExt;
        NewLineNo: Integer;
        SelectionType: Enum Zyn_BeginEndText;
    begin
        // Loop for both Begin and End types
        SelectionType := SelectionType::BeginText;
        repeat
            SourceBuffer.Reset();
            SourceBuffer.SetRange("No.", SalesHeader."No.");
            SourceBuffer.SetRange("customer no", SalesHeader."Sell-to Customer No.");
            SourceBuffer.SetRange("Enum Method", SelectionType);

            if SourceBuffer.FindSet() then begin
                repeat
                    NewLineNo := GetNextLineNo(TargetBuffer, PostedCreditMemo."No.", PostedCreditMemo."Sell-to Customer No.", SelectionType);
                    TargetBuffer.Init();
                    TargetBuffer."No." := PostedCreditMemo."No.";
                    TargetBuffer."Line No." := NewLineNo;
                    TargetBuffer."Language code" := SourceBuffer."Language code";
                    TargetBuffer."Enum Method" := SourceBuffer."Enum Method";
                    TargetBuffer."customer no" := PostedCreditMemo."Sell-to Customer No.";
                    TargetBuffer.Description := SourceBuffer.Description;
                    TargetBuffer.Text := SourceBuffer.Text;
                    TargetBuffer.Insert(true);
                until SourceBuffer.Next() = 0;
            end;

            // Move to next enum value (Begin -> End)
            if SelectionType = SelectionType::BeginText then
                SelectionType := SelectionType::EndText
            else
                exit;

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
}