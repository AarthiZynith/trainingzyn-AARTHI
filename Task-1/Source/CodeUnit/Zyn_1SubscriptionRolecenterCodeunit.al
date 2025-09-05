// codeunit 50222 "Subscription Cue Mgt"
// {
//     procedure UpdateSubscriptionCue()
//     var
//         Cue: Record "Subscription Cue";
//         SubRec: Record "Customer Subscription";
//         SalesHeader: Record "Sales Header";
//         Revenue: Decimal;
//     begin
//         // Always use first record
//         if not Cue.Get(1) then begin
//             Cue.Init();
//             Cue."Primary Key" := 1;
//             Cue.Insert();
//         end;

//         // Active subscriptions count
//         Revenue := 0;
//         SalesHeader.Reset();
//         SalesHeader.SetRange("From Subscription", true);
//         SalesHeader.SetRange("Posting Date", CalcDate('<CM>', WorkDate()), CalcDate('<CM+1M-1D>', WorkDate()));
//         SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Invoice);

//         // Debug: see how many invoices match the filter
//         Message('Matching invoices: %1', SalesHeader.Count());

//         if SalesHeader.FindSet() then
//             repeat
//                // SalesHeader.CalcFields(Amount);
//                 Revenue += SalesHeader."Display Amount";
//             until SalesHeader.Next() = 0;

//         Cue."Revenue Generated" := Revenue;
//         Cue.Modify();
//     end;
// }
