pageextension 50254  Zyn_VendorList extends "Vendor List"
{
    layout{
       
    }

 actions
    {
        addlast(processing)
        {
           
            action(SendToSlave)
            {
                Caption = 'Send';
                ApplicationArea = All;
                Image = SendTo;

                trigger OnAction()
                var
                    CurrentCompanyRec: Record "Zyn_Company";
                    SlaveCompanyRec: Record "Zyn_Company";
                    MirrorMgt: Codeunit "Zyn_MasterSlaveMgt";
                begin
                    // Ensure current is Master company
                    if not CurrentCompanyRec.Get(CompanyName()) then
                        exit;

                    if not CurrentCompanyRec.IsMaster then
                        Error(VendorToMasterErr);

                    // Open lookup page to select a slave company
                    if Page.RunModal(Page::"Zyn_SlaveCompanyLookup", SlaveCompanyRec) = Action::LookupOK then begin
                        // Call mirror logic, passing the selected slave company name
                        MirrorMgt.MirrorVendorToSlave(Rec."No.", SlaveCompanyRec.Name);
                    end;
                end;
            }
        }
    }
    var
     VendorToMasterErr:Label 'You can send Vendors only from a Master company.';
}
