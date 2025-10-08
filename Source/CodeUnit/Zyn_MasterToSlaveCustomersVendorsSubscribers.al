
codeunit 50260 "Zyn_MasterSlaveCustomerVendor"
{
    var
        IsCustomerSyncRunning: Boolean;
        IsVendorSyncRunning: Boolean;
        IsSyncing: Boolean;

    //---------------------------------------
    // Customer Events
    //---------------------------------------
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeInsertEvent', '', true, true)]
    local procedure CustomerOnBeforeInsert(var Rec: Record Customer; RunTrigger: Boolean)
    var
        ZynCompany: Record Zyn_Company;
    begin
        if IsCustomerSyncRunning then
            exit; // skip internal sync

        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany.IsMaster) and (ZynCompany.MasterCompanyName <> '') then
                Error(CreateCustomerErr);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeModifyEvent', '', true, true)]
    local procedure CustomerOnBeforeModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    var
        ZynCompany: Record Zyn_Company;
    begin
        if IsCustomerSyncRunning then
            exit;

        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany.IsMaster) and (ZynCompany.MasterCompanyName <> '') then
                if RunTrigger then
                    Error(ModifyCustomerErr);
    end;


    //Prevent Delete in Slave
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnBeforeDeleteEvent', '', true, true)]
    local procedure CustomerOnBeforeDelete(var Rec: Record Customer; RunTrigger: Boolean)
    var
        ZynCompany: Record Zyn_Company;
    begin
        if IsCustomerSyncRunning then
            exit;

        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany.IsMaster) and (ZynCompany.MasterCompanyName <> '') then
                if RunTrigger then
                    Error(DeleteCustomersErr);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Contact Business Relation", 'OnBeforeUpdateContactBusinessRelation', '', true, true)]
    local procedure OnBeforeUpdateContactBusinessRelation(ContactBusinessRelation: Record "Contact Business Relation"; var IsHandled: Boolean)
    var
        SingleInstanceMgt: Codeunit "Zyn_Single Instance Management";
        Contact: Record Contact;
    begin
        if SingleInstanceMgt.GetFromCreateAs() then
            IsHandled := true;

        if ContactBusinessRelation."Contact No." <> '' then
            if Contact.Get(ContactBusinessRelation."Contact No.") then begin
                if Contact.UpdateBusinessRelation() then
                    Contact.Modify();

                Contact.SetFilter("No.", '<>%1', ContactBusinessRelation."Contact No.");
                Contact.SetRange("Company No.", ContactBusinessRelation."Contact No.");
                if Contact.FindSet(true) then
                    repeat
                        if Contact.UpdateBusinessRelation() then
                            Contact.Modify();
                    until Contact.Next() = 0;
            end;
    end;



    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', true, true)]
    local procedure CustomerOnAfterModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    var
        MasterCompany: Record Zyn_Company;
        SlaveCompany: Record Zyn_Company;
        SlaveCustomer: Record Customer;
        MasterRef: RecordRef;
        SlaveRef: RecordRef;
        Field: FieldRef;
        SlaveField: FieldRef;
        i: Integer;
        IsDifferent: Boolean;
        slavebusinessrelation: Enum "Contact Business Relation";
        ZynCompany: Record Zyn_Company;

    begin
        // Validation: prevent recursive sync
        if IsSyncing then
            exit;
        // Condition: master company exists
        if MasterCompany.Get(COMPANYNAME) then begin
            // Validation: only replicate if master
            if MasterCompany.IsMaster then begin
                // Set filter: find slave companies for this master
                SlaveCompany.Reset();
                SlaveCompany.SetRange(MasterCompanyName, MasterCompany.Name);

                // Loop: iterate slave companies
                if SlaveCompany.FindSet() then
                    repeat
                        SlaveCustomer.ChangeCompany(SlaveCompany.Name);

                        // Condition: contact exists in slave
                        if SlaveCustomer.Get(Rec."No.") then begin
                            //slavebusinessrelation := SlaveContact."Contact Business Relation";

                            // Open RecordRefs for comparison
                            MasterRef.GetTable(Rec);
                            SlaveRef.GetTable(SlaveCustomer);
                            IsDifferent := false;

                            // Loop: compare all fields
                            for i := 1 to MasterRef.FieldCount do begin
                                Field := MasterRef.FieldIndex(i);

                                // Condition: skip non-normal or primary key fields
                                if Field.Class <> FieldClass::Normal then
                                    continue;
                                if Field.Number in [1] then
                                    continue;

                                SlaveField := SlaveRef.Field(Field.Number);

                                // Validation: check difference
                                if SlaveField.Value <> Field.Value then begin
                                    IsDifferent := true;
                                    break; // exit loop if different
                                end;
                            end;

                            // Condition: only transfer fields if different
                            if IsDifferent then begin
                                IsSyncing := true;
                                SlaveCustomer.TransferFields(Rec, false);
                                //SlaveContact."Contact Business Relation" := slavebusinessrelation;
                                SlaveCustomer."No." := Rec."No."; // restore PK
                                SlaveCustomer.Modify(true);
                                IsSyncing := false;
                            end;
                        end;
                    until SlaveCompany.Next() = 0; // Loop ends

            end
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterDeleteEvent', '', true, true)]
    local procedure CustomerOnAfterDelete(var Rec: Record Customer; RunTrigger: Boolean)
    var
        MasterCompany: Record Zyn_Company;
        SlaveCompany: Record Zyn_Company;
        SlaveCust: Record Customer;
        ContactBusinessRelationDelete: Codeunit "Zyn_MasterSlaveMgt";
    begin
        if IsCustomerSyncRunning then
            exit;

        if not MasterCompany.Get(CompanyName()) or not MasterCompany.IsMaster then
            exit;

        IsCustomerSyncRunning := true;

        // Loop through all slave companies
        SlaveCompany.Reset();
        SlaveCompany.SetRange(MasterCompanyName, MasterCompany.Name);
        if SlaveCompany.FindSet() then
            repeat
                if SlaveCompany.Name <> CompanyName() then begin
                    // Switch to slave company
                    SlaveCust.ChangeCompany(SlaveCompany.Name);

                    // 🔹 Delete Contact Business Relation first
                    ContactBusinessRelationDelete.DeleteContactBusinessRelation(Rec."No.", SlaveCompany.Name);

                    // 🔹 Delete Customer in Slave
                    if SlaveCust.Get(Rec."No.") then
                        SlaveCust.Delete(true);
                end;
            until SlaveCompany.Next() = 0;

        IsCustomerSyncRunning := false;
    end;




    //---------------------------------------
    // Vendor Events
    //---------------------------------------
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeInsertEvent', '', true, true)]
    local procedure VendorOnBeforeInsert(var Rec: Record Vendor; RunTrigger: Boolean)
    var
        ZynCompany: Record Zyn_Company;
    begin
        if IsVendorSyncRunning then
            exit; // skip internal sync

        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany.IsMaster) and (ZynCompany.MasterCompanyName <> '') then
                Error(CreateVendorsErr);
    end;

    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeModifyEvent', '', true, true)]
    local procedure VendorOnBeforeModify(var Rec: Record Vendor; var xRec: Record Vendor; RunTrigger: Boolean)
    var
        ZynCompany: Record Zyn_Company;
    begin
        if IsVendorSyncRunning then
            exit; // skip internal sync

        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany.IsMaster) and (ZynCompany.MasterCompanyName <> '') then
                if RunTrigger then
                    Error(ModifyVendorErr);
    end;

    //Prevent Delete in Slave
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnBeforeDeleteEvent', '', true, true)]
    local procedure VendorOnBeforeDelete(var Rec: Record Vendor; RunTrigger: Boolean)
    var
        ZynCompany: Record Zyn_Company;
    begin
        if IsVendorSyncRunning then
            exit;

        if ZynCompany.Get(CompanyName()) then
            if (not ZynCompany.IsMaster) and (ZynCompany.MasterCompanyName <> '') then
                if RunTrigger then
                    Error(DeleteVendorsErr);
    end;

[EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterModifyEvent', '', true, true)]
    local procedure VendorOnAfterModify(var Rec: Record Vendor; var xRec: Record Vendor; RunTrigger: Boolean)
    var
        MasterCompany: Record Zyn_Company;
        SlaveCompany: Record Zyn_Company;
        SlaveVendor: Record Vendor;
        MasterRef: RecordRef;
        SlaveRef: RecordRef;
        Field: FieldRef;
        SlaveField: FieldRef;
        i: Integer;
        IsDifferent: Boolean;
        slavebusinessrelation: Enum "Contact Business Relation";
        ZynCompany: Record Zyn_Company;

    begin
        // Validation: prevent recursive sync
        if IsSyncing then
            exit;
        // Condition: master company exists
        if MasterCompany.Get(COMPANYNAME) then begin
            // Validation: only replicate if master
            if MasterCompany.IsMaster then begin
                // Set filter: find slave companies for this master
                SlaveCompany.Reset();
                SlaveCompany.SetRange(MasterCompanyName, MasterCompany.Name);

                // Loop: iterate slave companies
                if SlaveCompany.FindSet() then
                    repeat
                        SlaveVendor.ChangeCompany(SlaveCompany.Name);

                        // Condition: contact exists in slave
                        if SlaveVendor.Get(Rec."No.") then begin
                            //slavebusinessrelation := SlaveContact."Contact Business Relation";

                            // Open RecordRefs for comparison
                            MasterRef.GetTable(Rec);
                            SlaveRef.GetTable(SlaveVendor);
                            IsDifferent := false;

                            // Loop: compare all fields
                            for i := 1 to MasterRef.FieldCount do begin
                                Field := MasterRef.FieldIndex(i);

                                // Condition: skip non-normal or primary key fields
                                if Field.Class <> FieldClass::Normal then
                                    continue;
                                if Field.Number in [1] then
                                    continue;

                                SlaveField := SlaveRef.Field(Field.Number);

                                // Validation: check difference
                                if SlaveField.Value <> Field.Value then begin
                                    IsDifferent := true;
                                    break; // exit loop if different
                                end;
                            end;

                            // Condition: only transfer fields if different
                            if IsDifferent then begin
                                IsSyncing := true;
                                SlaveVendor.TransferFields(Rec, false);
                                //SlaveContact."Contact Business Relation" := slavebusinessrelation;
                                SlaveVendor."No." := Rec."No."; // restore PK
                                SlaveVendor.Modify(true);
                                IsSyncing := false;
                            end;
                        end;
                    until SlaveCompany.Next() = 0; // Loop ends

            end
        end;
    end;




    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterDeleteEvent', '', true, true)]
    local procedure VendorOnAfterDelete(var Rec: Record Vendor; RunTrigger: Boolean)
    var
        MasterCompany: Record Zyn_Company;
        SlaveCompany: Record Zyn_Company;
        SlaveVend: Record Vendor;
        MasterSlaveMgt: Codeunit "Zyn_MasterSlaveMgt";
    begin
        if IsVendorSyncRunning then
            exit;

        if not MasterCompany.Get(CompanyName()) or not MasterCompany.IsMaster then
            exit;

        IsVendorSyncRunning := true;
        SlaveCompany.Reset();
        SlaveCompany.SetRange(MasterCompanyName, MasterCompany.Name);
        if SlaveCompany.FindSet() then
            repeat
                if SlaveCompany.Name <> CompanyName() then begin
                    SlaveVend.ChangeCompany(SlaveCompany.Name);

                    //  Delete Vendor record
                    if SlaveVend.Get(Rec."No.") then
                        SlaveVend.Delete(true);

                    //  Delete related Contact Business Relations
                    MasterSlaveMgt.DeleteVendorContactBusinessRelation(Rec."No.", SlaveCompany.Name);
                end;
            until SlaveCompany.Next() = 0;

        IsVendorSyncRunning := false;
    end;


    var
        CreateContactInSlaveErr: Label 'You cannot create contacts in a slave company. Create the contact in the master company only.';
        CreateCustomerErr: Label 'You cannot create Customers directly in a Slave company. Create them only in the Master company.';
        CreateVendorsErr: Label 'You cannot create Vendors directly in a Slave company. Create them only in the Master company.';
        ModifyCustomerErr: Label 'You cannot modify Customers in a Slave company. Modify them only in the Master company.';
        ModifyVendorErr: Label 'You cannot modify Vendors in a Slave company. Modify them only in the Master company.';
        DeleteCustomersErr: Label 'You cannot delete Customers in a Slave company. Delete them only in the Master company.';
        DeleteVendorsErr: Label 'You cannot delete Vendors in a Slave company. Delete them only in the Master company.';
}


