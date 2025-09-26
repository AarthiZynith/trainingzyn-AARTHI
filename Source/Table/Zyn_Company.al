table 50240 Zyn_Company
{
    Caption = 'CompanyMirror';
    DataPerCompany = false;

    fields
    {
        field(1; Name; Text[30])
        {
            Caption = 'Name';
        }
        field(2; "Evaluation Company"; Boolean)
        {
            Caption = 'Evaluation Company';
        }
        field(3; "Display Name"; Text[250])
        {
            Caption = 'Display Name';
        }
        field(8000; Id; Guid)
        {
            Caption = 'Id';
        }
        field(8005; "Business Profile Id"; Text[250])
        {
            Caption = 'Business Profile Id';
        }
        field(4; IsMaster; Boolean)
        {
            Caption = 'IsMaster';
            trigger OnValidate()
            var
                MirrorRec: Record "Zyn_Company";
            begin
                if IsMaster then begin
                    // Check if some OTHER record is already master
                    MirrorRec.Reset();
                    MirrorRec.SetRange(IsMaster, true);
                    if MirrorRec.FindFirst() and (MirrorRec.Name <> Rec.Name) then
                        Error(MasterCompanyErr,
                              MirrorRec.Name);

                    // A Master cannot have a MasterCompanyName
                    if MasterCompanyName <> '' then
                        Error(MasterCantbeReferenceOfAnotherErr);
                end;
            end;
        }
        field(5; MasterCompanyName; Text[250])
        {
            Caption = 'MasterCompanyName';
            TableRelation = "Zyn_Company".Name;  // Optional dropdown of companies
            trigger OnValidate()
            var
                MasterRec: Record "Zyn_Company";
            begin
                if MasterCompanyName <> '' then begin
                    if IsMaster then
                        Error(MasterCantbeReferenceOfAnotherErr);

                    // Validate the selected company is actually the Master
                    if not MasterRec.Get(MasterCompanyName) then
                        Error(MasterCompanyNotExistsErr, MasterCompanyName);

                    if not MasterRec.IsMaster then
                        Error(CompanyNotMarkedUsMaster, MasterCompanyName);
                end;
            end;
        }
    }

    keys
    {
        key(PK; Name)
        {
            Clustered = true;
        }
    }

    Var
        MasterCompanyErr: Label 'Only one Master Company is allowed. "%1" is already set as Master.';
        MasterCantbeReferenceOfAnotherErr: Label 'A Master Company cannot reference another Master Company.';
        MasterCompanyNotExistsErr: Label 'The selected company "%1" does not exist.';
        CompanyNotMarkedUsMaster: Label 'The selected company "%1" is not marked as Master.';
}

