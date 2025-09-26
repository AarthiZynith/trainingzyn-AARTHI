codeunit 50242 Zyn_CompanyMirrorHelper
{
    // Helper does only the actual insert/modify/delete on the target records.
    // DO NOT keep an IsSyncRunning flag here (we'll handle recursion in subscriber).

    procedure SyncModifyToMirror(var BCCompany: Record Company; var MirrorCompany: Record Zyn_Company)
    begin
        if MirrorCompany.Get(BCCompany.Name) then begin
            MirrorCompany."Display Name" := BCCompany."Display Name";
            MirrorCompany."Evaluation Company" := BCCompany."Evaluation Company";
            MirrorCompany.Id := BCCompany.Id;
            MirrorCompany."Business Profile Id" := BCCompany."Business Profile Id";
            MirrorCompany.Modify();
        end;
    end;

    procedure SyncInsertToMirror(var BCCompany: Record Company; var MirrorCompany: Record Zyn_Company)
    begin
        if not MirrorCompany.Get(BCCompany.Name) then begin
            MirrorCompany.Init();
            MirrorCompany.Name := BCCompany.Name;
            MirrorCompany."Display Name" := BCCompany."Display Name";
            MirrorCompany."Evaluation Company" := BCCompany."Evaluation Company";
            MirrorCompany.Id := BCCompany.Id;
            MirrorCompany."Business Profile Id" := BCCompany."Business Profile Id";
            MirrorCompany.Insert();
        end;
    end;

    procedure SyncModifyToBC(var MirrorCompany: Record Zyn_Company; var BCCompany: Record Company)
    begin
        if BCCompany.Get(MirrorCompany.Name) then begin
            BCCompany."Display Name" := MirrorCompany."Display Name";
            BCCompany."Evaluation Company" := MirrorCompany."Evaluation Company";
            //BCCompany.Id := MirrorCompany.Id; // usually ID is system generated — uncomment only if you are certain
            BCCompany."Business Profile Id" := MirrorCompany."Business Profile Id";
            BCCompany.Modify();
        end;
    end;

    procedure SyncInsertToBC(var MirrorCompany: Record Zyn_Company; var BCCompany: Record Company)
    begin
        if not BCCompany.Get(MirrorCompany.Name) then begin
            BCCompany.Init();
            BCCompany.Name := MirrorCompany.Name;
            BCCompany."Display Name" := MirrorCompany."Display Name";
            BCCompany."Evaluation Company" := MirrorCompany."Evaluation Company";
            BCCompany.Id := MirrorCompany.Id;
            BCCompany."Business Profile Id" := MirrorCompany."Business Profile Id";
            BCCompany.Insert();
        end;
    end;

    procedure DeleteMirror(var Name: Text[30]; var MirrorCompany: Record Zyn_Company)
    begin
        if MirrorCompany.Get(Name) then
            MirrorCompany.Delete();
    end;

    procedure DeleteBC(var Name: Text[30]; var BCCompany: Record Company)
    begin
        if BCCompany.Get(Name) then
            BCCompany.Delete();
    end;
}
