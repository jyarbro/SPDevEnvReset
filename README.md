#Reset your SP Development Environment, preserve sanity!

##How?
1. **Read the source** for the PS1 script. I could be a very terrible person trying to hax your boxen.
2. Download the PS1 script and drop it somewhere. Anywhere. I have mine off the C root because I am a terrible person.
3. Run the PS1 script in powershell. It will spawn an elevated shell if you did not already run it as such, and UAC will ask you for permission to do that.
4. Tell the script which level of reset you want to do. Refer to the source to see what each level consists of.

###Optional steps
You can use the shortcut (.lnk) I provided and update the path to wherever you put the script. You can place this shortcut in your start menu to make it really easy to run.

If you are working with timer jobs, I suggest that beyond this script, you also reset the timer job after every deployment. To do this, go into your SharePoint deployment project, open the project properties, navigate to the SharePoint tab, and then set the post-deployment step to:

`net stop sptimerv4`

`net start sptimerv4`

##Why did you make this?
[This StackExchange](https://sharepoint.stackexchange.com/a/195200/41382) issue was really starting to annoy me so I had to come up with some way of scripting this.

There are still times that my SharePoint environment gets confused and I need to manually retract the solution in Visual Studio prior to running the reset script. At least twice a week I'm happy I have this script around. It gets that crazy when you're developing timer jobs!

##What do I need to run this?
I am using this on a SharePoint 2016 environment with Visual Studio 2015. I see absolutely no reason why this exact script should not work on other versions of those, going back at least to SP 2010.

You will need at least PowerShell 4 as the self-elevating commands require that.

##I'm still having problems deploying!
This isn't a silver bullet. You'll still need to earn your paycheck, unfortunately. I wish PowerShell was powerful enough to replace me sometimes.

If you're having issues related to that StackExchange link above, make sure all your Elements.xml files have the right namespace. If you're having other issues, I cannot recommend [SharePoint.StackExchange.com](https://sharepoint.stackexchange.com) enough. Start a new thread, and start a discussion here on my repository with your specific issue so I can see if I can integrate the solution into this script.
