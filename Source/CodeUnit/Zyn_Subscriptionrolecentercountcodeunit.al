// // codeunit 50211 subscriptionBillDate
// // {
// //     procedure createInvoiceForSubscription(var Subscription: Record "Customer Subscription")
// //     var
// //         salesheader: Record "Sales Header";
// //         plan: record PlanTable;
// //     begin
// //         plan.get(Subscription."Plan ID");
// //         salesheader.Init();
// //         salesheader.Validate("Document Type", salesheader."Document Type"::Invoice);
// //         salesheader.Validate("Sell-to Customer No.", Subscription."Customer ID");
// //         salesheader.Validate(SubscriptionPlanFee, plan.PlanFee);
// //         salesheader.Validate(SubscriptionPlanID, Subscription."Plan ID");
// //         salesheader.Validate("From Subscription", true);
// //         salesheader.Insert(true);
// //         UpdateNextBillDate(Subscription);
// //     end;

// //     procedure UpdateNextBillDate(var Subscription: Record "Customer Subscription")
// //     begin
// //         if (Subscription."Next Bill Date" <> 0D) then begin
// //             Subscription."Next Bill Date" := CalcDate('<+1M>', Subscription."Next Bill Date");

// //             // Stop if it exceeds End Date
// //             if (Subscription."End Date" <> 0D) and (Subscription."Next Bill Date" > Subscription."End Date") then begin
// //                 Subscription."Next Bill Date" := 0D;
// //                 Subscription.Status := Subscription.Status::Expired;
// //             end;

// //             Subscription.Modify();
// //         end;
// //     end;


// // }


// codeunit 50222 "Subscription Cue Mgt"
// {
//     procedure UpdateSubscriptionCue()
//     var
//         Cue: Record "Subscription Cue";
//         Sub: Record "Customer Subscription";
//         Inv: Record "Sales Invoice Header";
//     begin
//         // Ensure we have a single record
//         if not Cue.FindFirst() then begin
//             Cue.Init();
//             Cue.Insert();
//         end;

//         // Active subscriptions
//         Sub.Reset();
//         Sub.SetRange(Status, Sub.Status::Active);
//         Cue."Active Subscriptions" := Sub.Count();

//         // Revenue generated this month (from subscription invoices only)
//         Inv.Reset();
//         Inv.SetRange("From Subscription", true);
//         Inv.SetRange("Posting Date", CalcDate('<CM>', WorkDate)); // Current Month
//         if Inv.FindSet() then
//             repeat
//                 Cue."Revenue Generated" += Inv."Amount Including VAT";
//             until Inv.Next() = 0;

//         Cue.Modify(true);
//     end;
// }
