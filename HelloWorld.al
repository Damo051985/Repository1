// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50100 CustomerListExt extends "Customer List"
{

    actions
    {
        Addfirst(Navigation)
        {
            Action("Check License")
            {
                Caption = 'Check License';
                Trigger OnAction()
                Var
                    CheckLicense: Page CheckLicense;
                    TestPage: Page TestPage;
                    lTestTable: Record "TestTable";
                Begin
                    Message('TestDano1');
                    TestPage.Run;
                    lTestTable.Findset;
                    TaskScheduler.CreateTask(Codeunit::TestCodeunit, Codeunit::TestCodeunit2, True, CompanyName, CurrentDateTime, lTestTable.RecordID);
                End;
            }
        }
    }
    trigger OnOpenPage();
    var
        CheckLicence: Page CheckLicense;
    begin
        //Message('App published: Hello world');
        //CheckLicence.Run;
    end;

}