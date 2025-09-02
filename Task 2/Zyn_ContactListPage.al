// pageextension 50120 CustomerCardExt extends "Customer Card"
// {
//     actions
//     {
//         addlast(processing)
//         {


// action(CustomerContactList)
// {
//     ApplicationArea = All;
//     Caption = 'Customer Contacts';
//     trigger OnAction()
//     var
//         ContactRec: Record Contact;
//         TempContactRec: Record Contact temporary;
//     begin
//         Clear(TempContactRec);
//         TempContactRec.DeleteAll();

//         // Adjust the filters based on your data structure
//         ContactRec.SetRange("Company No.", '');
//         // ContactRec.SetRange("Type", ContactRec."Type"::Company);
//         ContactRec.SetRange("Contact Business Relation",'');

//         if ContactRec.FindSet() then
//             repeat
//                 TempContactRec := ContactRec;
//                 TempContactRec.Insert();
//             until ContactRec.Next() = 0;

//         Page.RunModal(Page::ReadonlyContactsList, TempContactRec);
//     end;
// }
//         }
//     }
// }



///// i think this is additional page

