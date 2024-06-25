# PSModules

This repo walk you through the natural evolution from a standalone 'script that just works'
to a module approach that is sustainable.

Why using module?
Let's see what happen when we don't

## ex01 - The Standalone script

You have a PS1 doing stuff.

```PowerShell
& .\ex01\MyScript.ps1
```

## ex02 - Parameterize the script file

You parameterize the file.

```PowerShell
& .\ex02\MyScript_withParams.ps1 -EventDate '09/20/2021' -Subject 'Sampler'
```

## ex03 - Decomposing in Functions to simplify the code

You make several functions to simplify the code.

```PowerShell
& .\ex03\MyScript_withFunctions.ps1 -Subject 'Sampler'
& .\ex03\MyScript_withFunctions.ps1 -EventDate '09/20/2022' -Subject 'Sampler'
& .\ex03\MyScript_withFunctions.ps1 -EventDate '01/03/2022' -Subject 'Sampler'
```

## ex04 - Splitting functions in files

You split the functions in different files for clarity and you dot source them.

```PowerShell
& .\ex04\MyScript_withFunctions.ps1 -Subject 'Sampler'

& .\ex04\MyScript_withFunctions.ps1 -EventDate '09/20/2022' -Subject 'Sampler'

& .\ex04\MyScript_withFunctions.ps1 -EventDate '01/03/2022' -Subject 'Sampler'
```

Ok, then how do you share this? Zip and email? There's better! That's why Modules are for!

## ex05 - The PowerShell module (bare-bones)

Ok, what's a module? let's go back to our script with functions and go the module route.

We have single file script, what happens if I run it:

```PowerShell
& .\ex05-psm1\MyScript_withFunctions.psm1
```

WTH?

Something you import and remove

```PowerShell
Import-Module .\ex05-psm1\MyScript_withFunctions.psm1
```

Oh yeah, something happened. Let's try with my own date...

Where did the parameter go? Oh, it's an argument, fair enough.

```PowerShell
Import-Module .\ex05-psm1\MyScript_withFunctions.psm1 -ArgumentList @('01/03/2022')
```

Wait, what happened... It's not importing the module.

Let's see if the module is "there":

```PowerShell
Get-Module
```

Ok, it's there then let's remove it and re-import with my argument

```PowerShell
Remove-Module MyScript_withFunctions
Import-Module .\ex05-psm1\MyScript_withFunctions.psm1 -ArgumentList @('01/03/2022')
```

Oh that works, but can we just force it instead of re-importing every time?

Let's change the date first to something in the future

```PowerShell
Import-Module .\ex05-psm1\MyScript_withFunctions.psm1 -ArgumentList @('09/20/2022')
```

and with a force now...

```PowerShell
Import-Module .\ex05-psm1\MyScript_withFunctions.psm1 -ArgumentList @('09/20/2022') -Force
```

Works. And Can I re-use those functions?

```PowerShell
Get-MyDemoMessage -EventDate '09/20/2021' -Presenter 'Gael' -Subject 'Sampler'
Get-MyDemoMessage -EventDate '09/20/2021' -Presenter 'Gael' -Subject 'Sampler' | Show-MyDemoEventMessage
```

What if I want the users to only "see" one function?

Let's add:

```PowerShell
Export-ModuleMember -Function Show-MyDemoEventMessage
```

And now the Get-MyDemoMessage function is hidden to the user!
-- # revert

## ex07 - Module and manifest with unique component per file

Ok, but how to properly create a module with functions in separate files, while making it easy to share?

```PowerShell
New-ModuleManifest -Path .\ex07-module-psd1\MyModule\MyModule.psd1 -Author 'Gael Colas' -Rootmodule MyModule.psm1
```

## ex08 - Module Delivery basics

Now that we have a module, how can we share it?

## ex09 - Sampler

Add functions

change build.yaml
    - remove DscResources & en-US
    - Remove DscResource.Common

