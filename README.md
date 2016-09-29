Resets your SharePoint Development Environment

[This StackExchange](https://sharepoint.stackexchange.com/questions/23908/deploying-eventreceiver-project-with-target-of-webapplication-from-vs-fails-when/195200) issue was really starting to annoy me so I had to come up with some way of scripting this.

Use the shortcut to run the script from your start menu on your development machine. Make sure you update the path to the script.

Alternatively, if you are refactoring heavily and anticipate this issue coming up a few times in a row, then in your SharePoint deployment project, open the project properties, navigate to the SharePoint tab, and then set the pre-deployment step to:
`C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -command "& C:\*Your Path*\SPDevEnvReset.ps1"`
