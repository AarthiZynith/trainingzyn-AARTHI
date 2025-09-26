codeunit 50253 "Zyn_MirrorCompanyContactSyn"
{
    var
        IsSyncing: Boolean;
    // Prevent Contact creation in slave company
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeInsertEvent', '', true, true)]
    local procedure ContactOnBeforeInsert(var Rec: Record Contact; RunTrigger: Boolean)
    var
        ZynCompany: Record Zyn_Company;
    begin
        // Get the current company record from Zyn_Company Table
        if ZynCompany.Get(COMPANYNAME) then begin
            // Block creation if the current company is a slave
            if (not ZynCompany."IsMaster") and (ZynCompany.MasterCompanyName <> '') then
                Error(CreateContactInSlaveErr);
        end;
    end;

    // Prevent modification in slave company
    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeModifyEvent', '', true, true)]
    local procedure ContactOnBeforeModify(var Rec: Record Contact; var xRec: Record Contact; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company";
    begin
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany.IsMaster) and (ZynCompany.MasterCompanyName <> '') then begin
                //  Allow if Modify is called with RunTrigger = FALSE
                // (typical when BC is creating Customer/Vendor)
                if RunTrigger then
                    Error(
                      'You cannot modify contacts in a slave company. ' +
                      'Modify contacts only in the master company.');
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterInsertEvent', '', true, true)]
    local procedure ContactOnAfterInsert(var Rec: Record Contact; RunTrigger: Boolean)
    var
        MasterCompany: Record Zyn_Company;
        SlaveCompany: Record Zyn_Company;
        NewContact: Record Contact;
    begin
        if IsSyncing then
            exit;
        IsSyncing := true;
        // Get the current company as master company
        if MasterCompany.Get(COMPANYNAME) then begin
            // Only replicate if this is a master company
            if MasterCompany."IsMaster" then begin
                // Find all slave companies linked to this master
                SlaveCompany.Reset();
                SlaveCompany.SetRange(MasterCompanyName, MasterCompany.Name);
                if SlaveCompany.FindSet() then
                    repeat
                        NewContact.ChangeCompany(SlaveCompany.Name);
                        if not NewContact.Get(Rec."No.") then begin
                            NewContact.Init();
                            NewContact.TransferFields(Rec, true);    // copy all fields from master contact
                            NewContact.Insert(true);
                        end;
                    until SlaveCompany.Next() = 0;
                exit;
            end;
        end;
        IsSyncing := false;
    end;

    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterModifyEvent', '', true, true)]
    local procedure ContactOnAfterModify(var Rec: Record Contact; var xRec: Record Contact; RunTrigger: Boolean)
    var
        MasterCompany: Record Zyn_Company;
        SlaveCompany: Record Zyn_Company;
        SlaveContact: Record Contact;
        MasterRef: RecordRef;
        SlaveRef: RecordRef;
        Field: FieldRef;
        SlaveField: FieldRef;
        i: Integer;
        IsDifferent: Boolean;
    begin
        if IsSyncing then
            exit;
        if MasterCompany.Get(COMPANYNAME) then begin
            if MasterCompany."IsMaster" then begin
                SlaveCompany.Reset();
                SlaveCompany.SetRange(MasterCompanyName, MasterCompany.Name);
                if SlaveCompany.FindSet() then
                    repeat
                        SlaveContact.ChangeCompany(SlaveCompany.Name);
                        if SlaveContact.Get(Rec."No.") then begin
                            // Open RecordRefs
                            MasterRef.GetTable(Rec);
                            SlaveRef.GetTable(SlaveContact);
                            IsDifferent := false;
                            // Loop through all fields
                            for i := 1 to MasterRef.FieldCount do begin
                                Field := MasterRef.FieldIndex(i);
                                // Skip FlowFields or non-normal fields
                                if Field.Class <> FieldClass::Normal then
                                    continue;
                                // Skip primary key fields (like "No.")
                                if Field.Number in [1] then
                                    continue;
                                SlaveField := SlaveRef.Field(Field.Number);
                                if SlaveField.Value <> Field.Value then begin
                                    IsDifferent := true;
                                    break; // no need to check further
                                end;
                            end;
                            // Only transfer fields if there is a difference
                            if IsDifferent then begin
                                IsSyncing := true;
                                SlaveContact.TransferFields(Rec, false);
                                SlaveContact."No." := Rec."No."; // restore PK
                                SlaveContact.Modify(true);
                                IsSyncing := false;
                            end;
                        end;
                    until SlaveCompany.Next() = 0;
            end;
        end;
    end;



    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnBeforeDeleteEvent', '', true, true)]
    local procedure ContactOnBeforeDelete(var Rec: Record Contact; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company";
        SlaveCompany: Record "Zyn_Company";
        SalesHeader: Record "Sales Header";
        PurchaseHeader: Record "Purchase Header";
        ContactNo: Code[20];
        ErrorText: Text[250];
    begin
        ContactNo := Rec."No.";
        ErrorText := '';
        // Only allow deletion from Master company
        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany."IsMaster") and (ZynCompany.MasterCompanyName <> '') then
                Error(DeleteContactInSlaveErr);
        //  Only check if current company is Master
        if not ZynCompany.Get(CompanyName()) then
            exit;

        if not ZynCompany.IsMaster then
            exit; // Slaves already blocked elsewhere
                  // If this is master, check slaves for open invoices
        if ZynCompany.IsMaster then
            // Find all slaves of this master
            SlaveCompany.Reset();
        SlaveCompany.SetRange(MasterCompanyName, ZynCompany.Name);

        if SlaveCompany.FindSet() then
            repeat
                // Switch to each Slave company
                SalesHeader.ChangeCompany(SlaveCompany.Name);
                PurchaseHeader.ChangeCompany(SlaveCompany.Name);

                //  Check Open Sales Invoices linked to Contact
                SalesHeader.Reset();
                SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);
                SalesHeader.SetFilter(Status, '%1|%2', SalesHeader.Status::Open, SalesHeader.Status::Released);
                SalesHeader.SetRange("Sell-to Contact No.", ContactNo);
                if SalesHeader.FindFirst() then
                    ErrorText += StrSubstNo(SalesInvoiceStatusCheckErr, ContactNo, SlaveCompany.Name) + '\';
                //   Error(SalesInvoiceStatusCheckErr, ContactNo, SlaveCompany.Name);

                //  Check Open Purchase Invoices linked to Contact
                PurchaseHeader.Reset();
                PurchaseHeader.SetRange("Document Type", PurchaseHeader."Document Type"::Invoice);
                PurchaseHeader.SetFilter(Status, '%1|%2', SalesHeader.Status::Open, SalesHeader.Status::Released);
                PurchaseHeader.SetRange("Buy-from Contact No.", ContactNo);
                if PurchaseHeader.FindFirst() then
                    ErrorText += StrSubstNo(PurchaseInvoiceStatusCheckErr, ContactNo, SlaveCompany.Name) + '\';
                //  If any errors were found, raise them
                if ErrorText <> '' then
                    Error(ErrorText);
            // Error(PurchaseInvoiceStatusCheckerr, ContactNo, SlaveCompany.Name);
            until SlaveCompany.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Table, Database::Contact, 'OnAfterDeleteEvent', '', true, true)]
    local procedure ContactOnAfterDelete(var Rec: Record Contact; RunTrigger: Boolean)
    var
        ZynCompany: Record "Zyn_Company";
        SlaveCompany: Record "Zyn_Company";
        SlaveContact: Record Contact;
        SlaveCustomer: Record Customer;
        SlaveVendor: Record Vendor;
        LinkRec: Record "Contact Business Relation";
    begin
        if IsSyncing then
            exit;

        if not ZynCompany.Get(CompanyName()) then
            exit;

        if not ZynCompany.IsMaster then
            exit;

        IsSyncing := true;

        // Loop through all slave companies
        SlaveCompany.Reset();
        SlaveCompany.SetRange(MasterCompanyName, ZynCompany.Name);

        if SlaveCompany.FindSet() then
            repeat
                // Switch context
                SlaveContact.ChangeCompany(SlaveCompany.Name);
                SlaveCustomer.ChangeCompany(SlaveCompany.Name);
                SlaveVendor.ChangeCompany(SlaveCompany.Name);
                LinkRec.ChangeCompany(SlaveCompany.Name);

                // Delete related Customer/Vendor
                LinkRec.SetRange("Contact No.", Rec."No.");
                if LinkRec.FindSet() then
                    repeat
                        case LinkRec."Link to Table" of
                            LinkRec."Link to Table"::Customer:
                                if SlaveCustomer.Get(LinkRec."No.") then
                                    SlaveCustomer.Delete(true);
                            LinkRec."Link to Table"::Vendor:
                                if SlaveVendor.Get(LinkRec."No.") then
                                    SlaveVendor.Delete(true);
                        end;

                        // Delete the relation itself
                        LinkRec.Delete(true);
                    until LinkRec.Next() = 0;

                // Finally delete the slave contact
                if SlaveContact.Get(Rec."No.") then
                    SlaveContact.Delete(true);

            until SlaveCompany.Next() = 0;

        IsSyncing := false;
    end;

    var
        CreateContactInSlaveErr: Label 'You cannot create contacts in a slave company. Create the contact in the master company only.';
        ModifyContactInSlaveErr: Label 'You cannot modify contacts in a slave company. Modify contacts only in the master company.';
        DeleteContactInSlaveErr: Label 'You cannot delete contacts in a slave company. Delete contacts only in the master company.';
        SalesInvoiceStatusCheckErr: Label 'Cannot delete Contact %1 because there is an OPEN Sales Invoice in Slave company %2.';
        PurchaseInvoiceStatusCheckerr: Label 'Cannot delete Contact %1 because there is an OPEN Purchase Invoice in Slave company %2.';
}

