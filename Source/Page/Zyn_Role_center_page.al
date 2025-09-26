namespace DefaultPublisher.ALProject5;
using Microsoft.HumanResources.Employee;
page 50120 Zyn_VisitManagerRoleCenter
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
            part("Active subscription"; Zyn_SubscriptionCuePage)
            {

            }
            part("SubscriptionNotification"; Zyn_NotificationCustomPage)
            {

            }

        }
    }
    actions
    {
        area(Embedding)
        {
            action(Customers)
            {
                RunObject = Page Zyn_VisitLogList;
                ApplicationArea = All;
            }

        }
        area(Sections)
        {
            group("Employee Asset Management")
            {
                action(AssetTypeList)
                {
                    RunObject = page Zyn_AssetTypeList;
                    ApplicationArea = All;
                }
                action(AssetsList)
                {
                    RunObject = page Zyn_AssetsList;
                    ApplicationArea = All;
                }
                action(EmployeeAssetsList)
                {
                    RunObject = Page Zyn_EmployeeAssetsList;
                    ApplicationArea = All;
                }
            }


            group("Expense Management System")
            {
                action(ExpenseList)
                {
                    RunObject = Page Zyn_ExpenseList;
                    ApplicationArea = All;
                }
                action(ExpenseCategoryList)
                {
                    RunObject = page Zyn_ExpenseCategoryList;
                    ApplicationArea = All;
                }
            }
            group("Budget Management System")
            {
                action(BudgetList)
                {
                    RunObject = page Zyn_BudgetList;
                    ApplicationArea = All;
                }
            }
            group("Income Management System ")
            {
                action(IncomePage)
                {
                    RunObject = page Zyn_IncomeList;
                    ApplicationArea = All;
                }
                action(Income)
                {
                    RunObject = page Zyn_IncomeCategoryList;
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
                    RunObject = page Zyn_leaveRequestList;
                    ApplicationArea = All;
                }
                action(EmployeeLeaveCategoryList)
                {
                    RunObject = page Zyn_leaveCategoryList;
                    ApplicationArea = All;
                }
            }

            group("Subscription Billing Management")
            {
                action(SubscriptionListPage)
                {
                    RunObject = page Zyn_SubscriptionList;
                    ApplicationArea = All;
                }
                action(SubscriptionPlanListPage)
                {
                    ApplicationArea = All;
                    RunObject = page Zyn_SubscriptionPlanlist;
                }
            }

        }

    }

}




