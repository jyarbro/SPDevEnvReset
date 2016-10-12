Resets your SharePoint Development Environment

[This StackExchange](https://sharepoint.stackexchange.com/questions/23908/deploying-eventreceiver-project-with-target-of-webapplication-from-vs-fails-when/195200) issue was really starting to annoy me so I had to come up with some way of scripting this.

Use the shortcut to run the script from your start menu on your development machine. Make sure you update the path to the script.

If you are working with timer jobs, I suggest that beyond this script, you also reset the timer job after every deployment. To do this, go into your SharePoint deployment project, open the project properties, navigate to the SharePoint tab, and then set the post-deployment step to:

`net stop sptimerv4`

`net start sptimerv4`
