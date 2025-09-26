codeunit 50100 Zyn_LoyaltyPointsHandler
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure OnBeforePostSalesDoc(
        var SalesHeader: Record "Sales Header";
        // var SalesLines: Record "Sales Line";
        PreviewMode: Boolean)
    var
        CustomerRec: Record Customer;
    begin
        if (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) or (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then
        begin 
        if CustomerRec.Get(SalesHeader."Sell-to Customer No.") then
            if CustomerRec."Loyalty Points"  >= 100 then
           Error('Loyalty Points limit (100) exceeded. Cannot post the invoice.');
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', true, true)]
    local procedure OnAfterPostSalesDoc(
        var SalesHeader: Record "Sales Header")
    //var SalesLines: Record "Sales Line";
    // SalesShptHeader: Record "Sales Shipment Header";
    //  SalesInvHeader: Record "Sales Invoice Header")
    var
        CustomerRec: Record Customer;
    begin
        // if SalesHeader."Document Type" <> SalesHeader."Document Type"::Invoice then
        //     exit;

        if CustomerRec.Get(SalesHeader."Sell-to Customer No.") then begin
            CustomerRec."Loyalty Points" += 10;
            CustomerRec.Modify();
        end;
    end;



     
}



// codeunit 50100 "Loyalty Points Handler"
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
//     local procedure AddLoyaltyPoints(
//         var SalesHeader: Record "Sales Header";
//         var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
//         SalesShptHdrNo: Code[20];
//         RetRcpHdrNo: Code[20];
//         SalesInvHdrNo: Code[20];
//         SalesCrMemoHdrNo: Code[20];
//         CommitIsSuppressed: Boolean;
//         InvtPickPutaway: Boolean;
//         var CustLedgerEntry: Record "Cust. Ledger Entry";
//         WhseShip: Boolean;
//         PreviewMode: Boolean)
//     var
//         Customer: Record Customer;
//     begin
//         if PreviewMode then
//             exit;
 
//         // Only process if an invoice was posted
//         if SalesInvHdrNo = '' then
//             exit;
 
//         if Customer.Get(SalesHeader."Sell-to Customer No.") then begin
//             Customer."Loyalty Points" := Customer."Loyalty Points" + 10;
//             Customer.Modify();
//         end;
//     end;
// }
 
// codeunit 50108 "Loyalty Points PreCheck"
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
//     local procedure PreventPosting(
//         var SalesHeader: Record "Sales Header";
//         var IsHandled: Boolean)
//     var
//         Customer: Record Customer;
//     begin
//         if (SalesHeader."Document Type" = SalesHeader."Document Type"::Invoice) or (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) then begin
//             if Customer.Get(SalesHeader."Sell-to Customer No.") then begin
//                 Customer.CalcFields("Loyalty Points");
 
//                 if Customer."Loyalty Points" >= 30 then begin
//                     Error('Posting blocked. Customer has more than 40 loyalty points.');
//                 end;
//             end;
//         end;
//     end;
// }
