codeunit 50243 Zyn_CompanyMirrorSubscriber
{
    var
        SyncHelper: Codeunit 50242;
        MirrorCompany: Record Zyn_Company;
        BCCompany: Record Company;

        // Single guard used by ALL event handlers in this subscriber.
        // This solves the recursion problem because event handlers live in the same codeunit instance.
        IsSyncRunning: Boolean;// default value is false

    // -------------------- BC Company subscribers --------------------
    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterInsertEvent', '', true, true)]
    local procedure CompanyAfterInsert(var Rec: Record Company)
    begin
        if IsSyncRunning then
            exit;
        IsSyncRunning := true;
        SyncHelper.SyncInsertToMirror(Rec, MirrorCompany);
        IsSyncRunning := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterModifyEvent', '', true, true)]
    local procedure CompanyAfterModify(var Rec: Record Company; var xRec: Record Company)
    begin
        if IsSyncRunning then
            exit;
        IsSyncRunning := true;
        // Only modify mirror if something relevant changed (optional optimization)
        if (Rec."Display Name" <> xRec."Display Name") or
           (Rec."Evaluation Company" <> xRec."Evaluation Company") or
           (Rec."Business Profile Id" <> xRec."Business Profile Id") then
            SyncHelper.SyncModifyToMirror(Rec, MirrorCompany);
        IsSyncRunning := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterDeleteEvent', '', true, true)]
    local procedure CompanyAfterDelete(var Rec: Record Company)
    begin
        if IsSyncRunning then
            exit;
        IsSyncRunning := true;
        SyncHelper.DeleteMirror(Rec.Name, MirrorCompany);
        IsSyncRunning := false;
    end;

    // -------------------- Mirror Company subscribers --------------------
    [EventSubscriber(ObjectType::Table, Database::Zyn_Company, 'OnAfterInsertEvent', '', true, true)]
    local procedure MirrorAfterInsert(var Rec: Record Zyn_Company)
    begin
        if IsSyncRunning then
            exit;
        IsSyncRunning := true;
        SyncHelper.SyncInsertToBC(Rec, BCCompany);
        IsSyncRunning := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Zyn_Company, 'OnAfterModifyEvent', '', true, true)]
    local procedure MirrorAfterModify(var Rec: Record Zyn_Company; var xRec: Record Zyn_Company)
    begin
        if IsSyncRunning then
            exit;
        IsSyncRunning := true;
        // Only modify BC if relevant fields changed (optional optimization)
        if (Rec."Display Name" <> xRec."Display Name") or
           (Rec."Evaluation Company" <> xRec."Evaluation Company") or
           (Rec."Business Profile Id" <> xRec."Business Profile Id") then
            SyncHelper.SyncModifyToBC(Rec, BCCompany);
        IsSyncRunning := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Zyn_Company, 'OnAfterDeleteEvent', '', true, true)]
    local procedure MirrorAfterDelete(var Rec: Record Zyn_Company)
    begin
        if IsSyncRunning then
            exit;
        IsSyncRunning := true;
        SyncHelper.DeleteBC(Rec.Name, BCCompany);
        IsSyncRunning := false;
    end;
}
