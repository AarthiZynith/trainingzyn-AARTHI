codeunit 50135 Zyn_UpgradeLastSoldPrize
{
    Subtype = Upgrade;
 
    trigger OnUpgradePerCompany()
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
        SalesInvHeader: Record "Sales Invoice Header";
        LastSoldPrice: Record Zyn_HighestSalesPrice;
        UpgradeTag:Codeunit "Upgrade Tag";
    begin
    if not UpgradeTag.HasUpgradeTag('LastSoldPrice1') then begin
        if SalesInvoiceLine.FindSet() then
            repeat
                if SalesInvHeader.Get(SalesInvoiceLine."Document No.") then begin
                    LastSoldPrice.Reset();
                    LastSoldPrice.SetRange("Customer No", SalesInvoiceLine."Sell-to Customer No.");
                    LastSoldPrice.SetRange("Item No", SalesInvoiceLine."No.");
 
                    if LastSoldPrice.FindFirst() then begin
                        LastSoldPrice."Item Price" := SalesInvoiceLine."Unit Price";
                        LastSoldPrice."Posting date":= SalesInvHeader."Posting Date";
                        LastSoldPrice.Modify(true);
                    end else begin  
                        LastSoldPrice.Init();
                        LastSoldPrice."Customer No" := SalesInvoiceLine."Sell-to Customer No.";
                        LastSoldPrice."Item No":= SalesInvoiceLine."No.";
                        LastSoldPrice."Item Price" := SalesInvoiceLine."Unit Price";
                        LastSoldPrice."Posting Date":= SalesInvHeader."Posting Date";
                        LastSoldPrice.Insert(true);
                    end;
                end;
            until SalesInvoiceLine.Next() = 0;
            UpgradeTag.SetUpgradeTag('LastSoldPrice1');
        end;
    end;
}
 
 