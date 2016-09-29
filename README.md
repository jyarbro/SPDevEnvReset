Resets your SharePoint Development Environment

[This StackExchange](https://sharepoint.stackexchange.com/questions/23908/deploying-eventreceiver-project-with-target-of-webapplication-from-vs-fails-when/195200) issue was really starting to annoy me so I had to come up with some way of scripting this.

In your SharePoint deployment project, open the project properties, navigate to the SharePoint tab, and then set the pre-deployment step to:
`C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -command "& C:\SPDevEnvReset.ps1"`

Where I have used C:\ as the location for the script, you must update the path to your chosen location.
