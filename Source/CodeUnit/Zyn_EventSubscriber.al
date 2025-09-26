codeunit 50101 Zyn_PurchasePostingControl
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc','', false, false)]
    local procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    begin
        if (PurchaseHeader."Approval Status" in [PurchaseHeader."Approval Status"::Open,
                                                 PurchaseHeader."Approval Status"::Pending,
                                                 PurchaseHeader."Approval Status"::Escalated]) then begin
            Error('You cannot post the purchase document unless it is Approved.');
        end;
    end;



    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', false, false)]
    local procedure OnAfterModifyCustomer(var Rec: Record Customer; xRec: Record Customer)
    var
        RecRef: RecordRef;
        
        xRecRef: RecordRef;
        FieldRef: FieldRef;
        xFieldRef: FieldRef;
        ModifyData: Record Zyn_CustomerModifyLog;
        i: Integer;
        MaxFields: Integer;
    begin
 
        RecRef.GetTable(Rec);
        xRecRef.GetTable(xRec);
 
        MaxFields := RecRef.FieldCount;
 
        for i := 1 to MaxFields do begin
            FieldRef := RecRef.FieldIndex(i);
            xFieldRef := xRecRef.FieldIndex(i);
 
            if Format(FieldRef.Value) <> Format(xFieldRef.Value) then begin
                        begin
                            clear(ModifyData);

                            ModifyData.Init();
                            // ModifyData."Entry No.":=0;
                            ModifyData."Customer No." := Rec."No.";
                            ModifyData."Field Name" := FieldRef.Name;
                            ModifyData."old Value" := Format(xFieldRef.Value);
                            ModifyData."New Value" := Format(FieldRef.Value);
                            ModifyData."User Id" := UserId;
                            ModifyData.Insert();
                        end;
                end;
            end;
        end;
    
}
 

