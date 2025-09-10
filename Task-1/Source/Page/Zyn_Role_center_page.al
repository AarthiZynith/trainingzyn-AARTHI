namespace DefaultPublisher.ALProject5;
using Microsoft.HumanResources.Employee;
page 50120 "Visit Manager Role Center"
{

    PageType = RoleCenter;
    Caption = 'Visit Manager';
    ApplicationArea = All;

    layout
    {
        area(RoleCenter)
        {
            part(Customercuetile; 50127)
            {

            }
            part("Active subscription"; "Subscription Cue Page") { }
            part("SubscriptionNotification";Zyn_NotificationCustomPage){}

        }
    }
    actions
    {
        area(Embedding)
        {
            action(Customers)
            {
                RunObject = Page "Visit Log List";
                ApplicationArea = All;
            }

        }
        area(Sections)
        {
            group("Employee Asset Management")
            {
                action(AssetTypeList)
                {
                    RunObject = page AssetTypeListPage;
                    ApplicationArea = All;
                }
                action(AssetsList)
                {
                    RunObject = page AssetsListPage;
                    ApplicationArea = All;
                }
                action(EmployeeAssetsList)
                {
                    RunObject = Page EmployeeAssetsListPage;
                    ApplicationArea = All;
                }
            }


            group("Expense Management System")
            {
                action(ExpenseList)
                {
                    RunObject = Page ExpenseListPage;
                    ApplicationArea = All;
                }
                action(ExpenseCategoryList)
                {
                    RunObject = page ExpenseCategoryListPage;
                    ApplicationArea = All;
                }
            }
            group("Budget Management System")
            {
                action(BudgetList)
                {
                    RunObject = page BudgetList;
                    ApplicationArea = All;
                }
            }
            group("Income Management System ")
            {
                action(IncomePage)
                {
                    RunObject = page IncomeListPage;
                    ApplicationArea = All;
                }
                action(Income)
                {
                    RunObject = page IncomeCategoryListPage;
                    ApplicationArea = All;
                }
            }
            group("Employee Leave Management")
            {

                Action(EmployeeList)
                {
                    RunObject = page "Employee List";
                    ApplicationArea = All;
                }
                action(EmployeeLeaveRequestList)
                {
                    RunObject = page leaveRequestList;
                    ApplicationArea = All;
                }
                action(EmployeeLeaveCategoryList)
                {
                    RunObject = page leaveCategoryList;
                    ApplicationArea = All;
                }
            }

            group("Subscription Billing Management")
            {
                action(SubscriptionListPage)
                {
                    RunObject = page SubscriptionListPage;
                    ApplicationArea = All;
                }
                action(SubscriptionPlanListPage)
                {
                    ApplicationArea = All;
                    RunObject = page SubscriptionPlanlist;
                }
            }

        }
        
        }
//             cues{
//             modify("MY Cues"){
// addlast{
//              cue("Subscription Reminders")
//             {
//                 ApplicationArea = All;
//                 Caption = 'Subscription Reminders';
//                 Image = Reminder;
//                 DrillDownPageId = 50102; // Opens the list page
//                 DataItem = "Subscription Reminder"; // Table for notifications
//                 DataItemLink = "Date Created = FIELD(CurrentDateTime())"; // Filter for today
//             }
//         }
//         }
//         }
    }




