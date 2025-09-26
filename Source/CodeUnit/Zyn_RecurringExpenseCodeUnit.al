codeunit 50161 Zyn_RecurringExpenseJobQueue
{
    Subtype = Normal;

    trigger OnRun()
    var
        RecurringExpense: Record Zyn_RecurringExpenses; // your recurring table
        Expense: Record Zyn_Expense;                   // actual expense table
    begin
        // Filter: Only take Recurring Expenses whose NextCycleDate = WORKDATE
        RecurringExpense.SetRange("NextCycleDate", WorkDate);

        if RecurringExpense.FindSet() then
            repeat
                // Insert into actual Expense table
                clear(Expense);
                Expense.Init();
                // copies common fields
                Expense.CategoryName := RecurringExpense.Category;
                Expense.Amount := RecurringExpense.Amount;
                Expense.Date := WorkDate;
                Expense.Insert(true);

                // Update the NextCycleDate for next cycle
                case RecurringExpense."Cycle" of
                    RecurringExpense."Cycle"::Weekly:
                        RecurringExpense."NextCycleDate" := CalcDate('1W', WorkDate);

                    RecurringExpense."Cycle"::Monthly:
                        RecurringExpense."NextCycleDate" := CalcDate('1M', WorkDate);
                    RecurringExpense."Cycle"::Quarterly:
                        RecurringExpense."NextCycleDate" := CalcDate('3M', WorkDate);
                    RecurringExpense."Cycle"::Yearly:
                        RecurringExpense."NextCycleDate" := CalcDate('1Y', WorkDate);
                end;

                RecurringExpense.Modify(true);
            until RecurringExpense.Next() = 0;
    end;
}
