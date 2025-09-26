pageextension 50141 Zyn_ContactListExt extends "Contact List"
{

    actions
    {
        addfirst(processing)
        {
            action(CustomerContactList)
            {
                ApplicationArea = All;
                Caption = 'Customer Contacts';
                trigger OnAction()
                var
                    ContactRec: Record Contact;
                    TempContactRec: Record Contact temporary;
                    ContactBusinessRelation: Record "Contact Business Relation";

                begin

                    ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);


                    if ContactRec.FindSet() then
                        repeat
                            TempContactRec := ContactRec;
                            TempContactRec.Insert();
                        until ContactRec.Next() = 0;

                    Page.RunModal(Page::Zyn_ReadonlyContactsList, TempContactRec);
                end;
            }

            action(VendorContactList)
            {
                ApplicationArea = All;
                Caption = 'Vendor Contacts';
                trigger OnAction()
                var
                    ContactRec: Record Contact;
                    TempContactRec: Record Contact temporary;
                    ContactBusinessRelation: Record "Contact Business Relation";

                begin
                    /*Clear(TempContactRec);
                    TempContactRec.DeleteAll();

                    // Adjust the filters based on your data structure
                    ContactRec.SetRange("Company No.", '');*/
                    ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Vendor);


                    if ContactRec.FindSet() then
                        repeat
                            TempContactRec := ContactRec;
                            TempContactRec.Insert();
                        until ContactRec.Next() = 0;

                    Page.RunModal(Page::Zyn_ReadonlyContactsList, TempContactRec);
                end;
            }

            action(BankContactList)
            {
                ApplicationArea = All;
                Caption = 'Banking Contacts';
                trigger OnAction()
                var
                    ContactRec: Record Contact;
                    TempContactRec: Record Contact temporary;
                    ContactBusinessRelation: Record "Contact Business Relation";

                begin
                    /*Clear(TempContactRec);
                    TempContactRec.DeleteAll();

                    // Adjust the filters based on your data structure
                    ContactRec.SetRange("Company No.", '');*/
                    ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::"Bank Account");


                    if ContactRec.FindSet() then
                        repeat
                            TempContactRec := ContactRec;
                            TempContactRec.Insert();
                        until ContactRec.Next() = 0;

                    Page.RunModal(Page::Zyn_ReadonlyContactsList, TempContactRec);
                end;
            }
        }
    }
}