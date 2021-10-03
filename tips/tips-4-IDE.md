# Tips for VS as an IDE

1. [Properties Window and Property Pages](#properties-window-and-property-pages-of-setup-project)
2. [Optimize Visual Studio startup time](https://docs.microsoft.com/en-us/visualstudio/ide/optimize-visual-studio-startup-time?view=vs-2019)
3. 


## Properties Window and Property Pages of setup project

The architecture is specified in the setup project's properties window which, 
confusingly enough, is not the same as the property pages, which is a pop-up window 
by right clicking the project and selecting the property item.

If you select the setup project in solution explorer and click <Alt + Enter> you sould see the 
properties window with AddRemoveProgramsIcon, Manufacturer and so on. Down that list is 
TargetPlatform where you specify x86 or x64.

I would take me a while to find this. It is on View -> Other Windows -> Properties Window

Please refer to [Can't set 64 bit target for Setup Project in Visual Studio 2017](https://stackoverflow.com/questions/47143721/cant-set-64-bit-target-for-setup-project-in-visual-studio-2017)




