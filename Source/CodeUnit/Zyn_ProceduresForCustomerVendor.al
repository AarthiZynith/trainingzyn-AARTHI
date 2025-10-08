
codeunit 50263 "Zyn_MasterSlaveMgt"
{
    var
        IsInternalSync: Boolean;

    //---------------------------------------
    // Mirror Customer
    //---------------------------------------
    procedure MirrorCustomerToSlave(CustomerNo: Code[20]; SlaveCompany: Text[30])
    var
        MasterCust: Record Customer;
        SlaveCust: Record Customer;
        DummyRecord: Record Customer;
        OriginalCompany: Text[30];
        MasterCompany: Text[30];
    begin
        if IsInternalSync then
            exit;

        OriginalCompany := CompanyName();
        IsInternalSync := true;

        if not MasterCust.Get(CustomerNo) then begin
            IsInternalSync := false;
            Error('Customer %1 not found in Master.', CustomerNo);
        end;

        // Switch to slave
        SlaveCust.ChangeCompany(SlaveCompany);

        if not SlaveCust.Get(CustomerNo) then begin
            // Insert new customer
            SlaveCust.Init();
            SlaveCust.TransferFields(MasterCust, false);
            SlaveCust."No." := MasterCust."No.";
            SlaveCust.Insert(false); // triggers disabled
        end else begin
            // Modify only if values differ
            if not AreCustomersEqual(MasterCust, SlaveCust) then begin
                SlaveCust.TransferFields(MasterCust, false);
                SlaveCust.Modify(true);
            end;
        end;
        // 🔹 Update Contact's Business Relation in Slave
        UpdateContactBusinessRelation(MasterCust."No.",SlaveCompany); // call the procedure here
        // Get the current company (Master)
        MasterCompany := CompanyName();

        // Call MirrorContactBusinessRelations
        MirrorCustomerContactBusinessRelation(MasterCust, SlaveCompany);

        if CompanyName() <> OriginalCompany then
            DummyRecord.ChangeCompany(OriginalCompany);

        IsInternalSync := false;
    end;

    //---------------------------------------
    // Compare Customers
    //---------------------------------------
    local procedure AreCustomersEqual(MasterCust: Record Customer; SlaveCust: Record Customer): Boolean
    var
        MasterRef: RecordRef;
        SlaveRef: RecordRef;
        i: Integer;
    begin
        MasterRef.GetTable(MasterCust);
        SlaveRef.GetTable(SlaveCust);

        for i := 1 to MasterRef.FieldCount do
            if not CompareField(MasterRef, SlaveRef, i) then
                exit(false);

        exit(true);
    end;


    //---------------------------------------
    // Compare individual fields
    //---------------------------------------
    local procedure CompareField(MasterRef: RecordRef; SlaveRef: RecordRef; FieldIndex: Integer): Boolean
    var
        MasterField: FieldRef;
        SlaveField: FieldRef;
    begin
        MasterField := MasterRef.FieldIndex(FieldIndex);

        // Skip system fields & primary keys
        if MasterField.Class <> FieldClass::Normal then exit(true);
        if MasterField.Number in [1, 2, 3] then exit(true);

        SlaveField := SlaveRef.Field(MasterField.Number);
        exit(MasterField.Value = SlaveField.Value);
    end;

    procedure MirrorCustomerContactBusinessRelation(MasterCustomer: Record Customer; SlaveCompanyName: Text[30])
    var
        SourceBusRel: Record "Contact Business Relation";
        SlaveBusRel: Record "Contact Business Relation";
        SourceContact: Record Contact;
        SlaveContact: Record Contact;
        SlaveCustomer: Record Customer;
        FoundSlaveContactNo: Code[20];
    begin
        if not MasterCustomer.Get(MasterCustomer."No.") then
            exit;

        // Switch to slave
        SlaveCustomer.ChangeCompany(SlaveCompanyName);
        SlaveContact.ChangeCompany(SlaveCompanyName);
        SlaveBusRel.ChangeCompany(SlaveCompanyName);

        if not SlaveCustomer.Get(MasterCustomer."No.") then
            exit; // Customer must exist in slave first

        // Switch to Master company to read relations
        SourceBusRel.ChangeCompany(COMPANYNAME);
        SourceContact.ChangeCompany(COMPANYNAME);

        SourceBusRel.SetRange("Business Relation Code", 'CUST');
        SourceBusRel.SetRange("No.", MasterCustomer."No.");

        if SourceBusRel.FindSet() then
            repeat
                if SourceContact.Get(SourceBusRel."Contact No.") then begin
                    FoundSlaveContactNo := '';

                    // Try to find existing contact in Slave by Name
                    if SourceContact.Name <> '' then begin
                        SlaveContact.Reset();
                        SlaveContact.SetRange(Name, SourceContact.Name);
                        if SlaveContact.FindFirst() then
                            FoundSlaveContactNo := SlaveContact."No.";
                    end;

                    // If no contact found in Slave, create it
                    if FoundSlaveContactNo = '' then begin
                        SlaveContact.Init();
                        SlaveContact."No." := SourceContact."No.";
                        SlaveContact.Name := SourceContact.Name;
                        SlaveContact.Insert(false);
                        FoundSlaveContactNo := SlaveContact."No.";
                    end;

                    // Create Business Relation if not exists
                    SlaveBusRel.Reset();
                    SlaveBusRel.SetRange("Contact No.", FoundSlaveContactNo);
                    SlaveBusRel.SetRange("Link to Table", SlaveBusRel."Link to Table"::Customer);
                    SlaveBusRel.SetRange("No.", SlaveCustomer."No.");

                    if not SlaveBusRel.FindFirst() then begin
                        SlaveBusRel.Init();
                        SlaveBusRel."Contact No." := FoundSlaveContactNo;
                        SlaveBusRel."Link to Table" := SlaveBusRel."Link to Table"::Customer;
                        SlaveBusRel."No." := SlaveCustomer."No.";
                        SlaveBusRel."Business Relation Code" := 'CUST';
                        SlaveBusRel.Insert(false);
                        // After inserting the relation, update the Contact's Business Relation field in slave
                        SlaveContact.ChangeCompany(SlaveCompanyName);
                        if SlaveContact.Get(SourceBusRel."Contact No.") then begin
                            SlaveContact.UpdateBusinessRelation();
                            SlaveContact.Modify(true);
                        end;

                    end;
                end;
            until SourceBusRel.Next() = 0;
    end;



    procedure UpdateContactBusinessRelation(ContactNo: Code[20];SlaveCompanyName: Text[30])
    var
        ContactRec: Record Contact;
        Cust: Record Customer;
        Vend: Record Vendor;
        NewCBR: Enum "Contact Business Relation";
  
    begin


        // Make sure all records refer to the Slave company
    ContactRec.ChangeCompany(SlaveCompanyName);
    Cust.ChangeCompany(SlaveCompanyName);
    Vend.ChangeCompany(SlaveCompanyName);
        if not ContactRec.Get(ContactNo) then
            exit;

        // Check if linked Customer exists
        Cust.Reset();
        Cust.SetRange("No.", ContactNo);
        // Check if linked Vendor exists
        Vend.Reset();
        Vend.SetRange("No.", ContactNo);

        // Determine the new Contact Business Relation value
        if Cust.FindFirst() and Vend.FindFirst() then
            NewCBR := NewCBR::Multiple
        else if Cust.FindFirst() then
            NewCBR := NewCBR::Customer
        else if Vend.FindFirst() then
            NewCBR := NewCBR::Vendor
        else
            NewCBR := NewCBR::None;

        // Update Contact Business Relation enum field
        if ContactRec."Contact Business Relation" <> NewCBR then begin
            ContactRec."Contact Business Relation" := NewCBR;
            ContactRec.Modify(true);
        end;
    end;

   
    procedure DeleteContactBusinessRelation(CustomerNo: Code[20]; SlaveCompany: Text)
    var
        SlaveContactBR: Record "Contact Business Relation";
    begin
        // Switch to Slave and reset record
        clear(SlaveContactBR);
        SlaveContactBR.ChangeCompany(SlaveCompany);
        SlaveContactBR.Reset();

        // Filter by Customer
        SlaveContactBR.SetRange("Business Relation Code", 'CUST');
        SlaveContactBR.SetRange("Link to Table", SlaveContactBR."Link to Table"::Customer);
        SlaveContactBR.SetRange("No.", CustomerNo);

        if SlaveContactBR.FindSet() then
            //exit;
            repeat
                SlaveContactBR.Delete(true); // Run triggers
            until SlaveContactBR.Next() = 0;
    end;


    // Vendors
    procedure GetIsInternalSync(): Boolean
    begin
        exit(IsInternalSync);
    end;

    procedure MirrorVendorToSlave(VendorNo: Code[20]; SlaveCompany: Text[30])
    var
        MasterVend: Record Vendor;
        SlaveVend: Record Vendor;
        DummyRecord: Record Vendor;
        OriginalCompany: Text[30];
        MasterCompany: Text[30];
    begin
        if IsInternalSync then
            exit;

        OriginalCompany := CompanyName();
        IsInternalSync := true;

        // Get Vendor from master
        if not MasterVend.Get(VendorNo) then begin
            IsInternalSync := false;
            Error('Vendor %1 not found in Master.', VendorNo);
        end;

        // Switch to slave
        SlaveVend.ChangeCompany(SlaveCompany);

        if not SlaveVend.Get(VendorNo) then begin
            // Insert new vendor
            SlaveVend.Init();
            SlaveVend.TransferFields(MasterVend, false);
            SlaveVend."No." := MasterVend."No.";
            SlaveVend.Insert(false); // triggers disabled
        end else begin
            // Modify only if values differ
            if not AreVendorsEqual(MasterVend, SlaveVend) then begin
                SlaveVend.TransferFields(MasterVend, false);
                SlaveVend.Modify(true);
            end;
        end;

        // 🔹 Update Contact's Business Relation in Slave
        UpdateContactBusinessRelation(MasterVend."No.",SlaveCompany);
        // Get the current company (Master)
        MasterCompany := CompanyName();

        // Call Vendor contact business relations mirror
        MirrorVendorContactBusinessRelation(MasterVend, SlaveCompany);

        // Restore original company
        if CompanyName() <> OriginalCompany then
            DummyRecord.ChangeCompany(OriginalCompany);

        IsInternalSync := false;
    end;

    //---------------------------------------
    // Compare Vendors
    //---------------------------------------
    local procedure AreVendorsEqual(MasterVend: Record Vendor; SlaveVend: Record Vendor): Boolean
    var
        MasterRef: RecordRef;
        SlaveRef: RecordRef;
        i: Integer;
    begin
        MasterRef.GetTable(MasterVend);
        SlaveRef.GetTable(SlaveVend);

        for i := 1 to MasterRef.FieldCount do
            if not CompareField(MasterRef, SlaveRef, i) then
                exit(false);

        exit(true);
    end;


    //---------------------------------------
    // Vendor contact business relation mirror
    //---------------------------------------
    procedure MirrorVendorContactBusinessRelation(MasterVendor: Record Vendor; SlaveCompanyName: Text[30])
    var
        SourceBusRel: Record "Contact Business Relation";
        SlaveBusRel: Record "Contact Business Relation";
        SourceContact: Record Contact;
        SlaveContact: Record Contact;
        SlaveVendor: Record Vendor;
        FoundSlaveContactNo: Code[20];
    begin
        if not MasterVendor.Get(MasterVendor."No.") then
            exit;

        // Switch to slave
        SlaveVendor.ChangeCompany(SlaveCompanyName);
        SlaveContact.ChangeCompany(SlaveCompanyName);
        SlaveBusRel.ChangeCompany(SlaveCompanyName);

        if not SlaveVendor.Get(MasterVendor."No.") then
            exit; // Vendor must exist in slave first

        // Switch to Master company to read relations
        SourceBusRel.ChangeCompany(COMPANYNAME);
        SourceContact.ChangeCompany(COMPANYNAME);

        SourceBusRel.SetRange("Business Relation Code", 'VEND'); // Vendor code
        SourceBusRel.SetRange("No.", MasterVendor."No.");

        if SourceBusRel.FindSet() then
            repeat
                if SourceContact.Get(SourceBusRel."Contact No.") then begin
                    FoundSlaveContactNo := '';

                    // Try to find existing contact in Slave by Name
                    if SourceContact.Name <> '' then begin
                        SlaveContact.Reset();
                        SlaveContact.SetRange(Name, SourceContact.Name);
                        if SlaveContact.FindFirst() then
                            FoundSlaveContactNo := SlaveContact."No.";
                    end;

                    // If no contact found in Slave, create it
                    if FoundSlaveContactNo = '' then begin
                        SlaveContact.Init();
                        SlaveContact."No." := SourceContact."No.";
                        SlaveContact.Name := SourceContact.Name;
                        SlaveContact.Insert(false);
                        FoundSlaveContactNo := SlaveContact."No.";
                    end;

                    // Create Business Relation if not exists
                    SlaveBusRel.Reset();
                    SlaveBusRel.SetRange("Contact No.", FoundSlaveContactNo);
                    SlaveBusRel.SetRange("Link to Table", SlaveBusRel."Link to Table"::Vendor);
                    SlaveBusRel.SetRange("No.", SlaveVendor."No.");

                    if not SlaveBusRel.FindFirst() then begin
                        SlaveBusRel.Init();
                        SlaveBusRel."Contact No." := FoundSlaveContactNo;
                        SlaveBusRel."Link to Table" := SlaveBusRel."Link to Table"::Vendor;
                        SlaveBusRel."No." := SlaveVendor."No.";
                        SlaveBusRel."Business Relation Code" := 'VEND';
                        SlaveBusRel.Insert(false);
                        // After inserting the relation, update the Contact's Business Relation field in slave
                        SlaveContact.ChangeCompany(SlaveCompanyName);
                        if SlaveContact.Get(SourceBusRel."Contact No.") then begin
                            SlaveContact.UpdateBusinessRelation();
                            SlaveContact.Modify(true);
                        end;
                    end;
                end;
            until SourceBusRel.Next() = 0;
    end;


    procedure DeleteVendorContactBusinessRelation(VendorNo: Code[20]; SlaveCompany: Text)
    var
        SlaveContactBR: Record "Contact Business Relation";
    begin
        // Switch to Slave company and reset the record
        clear(SlaveContactBR);
        SlaveContactBR.ChangeCompany(SlaveCompany);
        SlaveContactBR.Reset();

        // Filter by Vendor
        SlaveContactBR.SetRange("Business Relation Code", 'VEND');
        SlaveContactBR.SetRange("Link to Table", SlaveContactBR."Link to Table"::Vendor);
        SlaveContactBR.SetRange("No.", VendorNo);

        // Delete all business relations for this Vendor
        if SlaveContactBR.FindSet() then
            repeat
                SlaveContactBR.Delete(true); // Run triggers
            until SlaveContactBR.Next() = 0;
    end;

}
