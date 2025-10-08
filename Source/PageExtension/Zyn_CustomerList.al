pageextension 50133 Zyn_CustomerListExtension extends "Customer List"
{

    layout
    {
        addlast(factboxes)
        {


            part(CustomerStats; Zyn_CustomerStatsFactBox)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part(ActiveSubscriptionstatus; Zyn_SubscriptionFactbox)
            {
                ApplicationArea = All;
            }
        }
    }



    actions
    {
        addlast(processing)
        {
            action(Empty)
            {
                ApplicationArea = All;
                Image = Report;
                // RunObject = report AmountReplaced;
            }

            action(SendToSlave)
            {
                Caption = 'Send';
                ApplicationArea = All;
                Image = SendTo;

                trigger OnAction()
                var
                    CurrentCompany: Record "Zyn_Company";
                    SlaveCompany: Record "Zyn_Company";
                    MirrorMgt: Codeunit "Zyn_MasterSlaveMgt";
                begin
                    // Ensure we are in a Master company
                    if not CurrentCompany.Get(CompanyName()) then
                        exit;
                    if not CurrentCompany.IsMaster then
                        Error(CustomerToMasterErr);

                    // Show the list of slave companies and let the user pick one
                    if Page.RunModal(Page::"Zyn_SlaveCompanyLookup", SlaveCompany) = Action::LookupOK then
                        MirrorMgt.MirrorCustomerToSlave(Rec."No.", SlaveCompany.Name);
                end;
            }

        }
    }
    var
        CustomerToMasterErr: Label 'You can send customers only from a Master company.';
}

//need to check the Amount replaced report 