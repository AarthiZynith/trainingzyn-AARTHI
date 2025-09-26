// tableextension 50250 ContactExtension extends Contact
// {
//     fields
//     {
//         field(50000; "MasterContactId"; Guid)
//         {
//             Caption = 'Master Contact Id';
//         }
//     }
// trigger OnBeforeInsert()
// var
//     EmptyGuid: Guid;
// begin
//     if "MasterContactId" = EmptyGuid then
//         "MasterContactId" := CreateGuid();
// end;

// }
