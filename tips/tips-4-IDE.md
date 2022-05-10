# Tips for VS as an IDE

[Thank you for downloading Visual Studio](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/)

未总结网文清单:

1. [Options, Text Editor, C/C++, Formatting](https://docs.microsoft.com/en-us/visualstudio/ide/reference/options-text-editor-c-cpp-formatting)
2. [Personalize the Visual Studio IDE](https://docs.microsoft.com/en-us/visualstudio/ide/personalizing-the-visual-studio-ide)
3. [Code style preferences](https://docs.microsoft.com/en-us/visualstudio/ide/code-styles-and-code-cleanup)
4. [C++ Code Editing and Navigation in Visual Studio](https://devblogs.microsoft.com/cppblog/c-code-editing-and-navigation-in-visual-studio/)
5. [Develop C and C++ applications](https://visualstudio.microsoft.com/vs/features/cplusplus/)
6. [Welcome to Visual Studio 2022](https://myit101.texassoftware.com/welcome-to-visual-studio-2022-by-scott-hanselman-and-friends-visual-studio-2022-launch-event/)
7. [Thank you for downloading Visual Studio](https://visualstudio.microsoft.com/thank-you-downloading-visual-studio/?sku=Community&rel=17#cplusplus)
8. [Visual Studio 2022 is now available](https://visualstudio.microsoft.com/launch/)
9. [What's new in Visual Studio 2022](https://docs.microsoft.com/en-us/visualstudio/ide/whats-new-visual-studio-2022?view=vs-2022)
10. [Bring your C++ codebase to Visual Studio with “Open Folder”](https://devblogs.microsoft.com/cppblog/bring-your-c-codebase-to-visual-studio-with-open-folder/)

***********************************

1. [Properties Window and Property Pages](#properties-window-and-property-pages-of-setup-project)
2. [Optimize Visual Studio startup time](https://docs.microsoft.com/en-us/visualstudio/ide/optimize-visual-studio-startup-time?view=vs-2019)

最近文件列表位于：\
C:\Users\jiche\AppData\Local\Microsoft\VisualStudio\16.0_084dfa93\ApplicationPrivateSettings.xml
```xml
<collection name="CodeContainers.Offline">
            <value name="value">
                [
               
                ]
            </value>
            <value name="machineLocal">True</value>
</collection>
```

## Properties Window and Property Pages of setup project

The architecture is specified in the setup project's properties window which, 
confusingly enough, is not the same as the property pages, which is a pop-up window 
by right clicking the project and selecting the property item.

If you select the setup project in solution explorer and click <Alt + Enter> you sould see the 
properties window with AddRemoveProgramsIcon, Manufacturer and so on. Down that list is 
TargetPlatform where you specify x86 or x64.

I would take me a while to find this. It is on View -> Other Windows -> Properties Window

Please refer to [Can't set 64 bit target for Setup Project in Visual Studio 2017](https://stackoverflow.com/questions/47143721/cant-set-64-bit-target-for-setup-project-in-visual-studio-2017)




