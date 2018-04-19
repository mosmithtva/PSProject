<#
    .SYNOPSIS
	Creates a scaffold function

    .DESCRIPTION
	Creates a basic skeleton function

    .EXAMPLE
	$functions="Get-Thing","Set-Thing"
	
	foreach($item IN $functions)
	{
			New-PSFunction -Name $item -Path C:\PSModules\Public
	}

    .PARAMETER Name
	REQUIRED
	PSCredential

	.PARAMETER Path
	Option path to create the function. Default is PWD

	.OUTPUTS
	Create $Name.ps1 in specified path

    .NOTES

	.LINK
	https://github.com/VNerdIO/New-PSProject
#>
Function New-PSFunction{
	[CmdletBinding()]
	Param([Parameter(Mandatory=$true)]
		  [string]
		  $Name,
		  [string]
		  $Path)
	
	begin{}
	process{
		try{

			if(-not($Path)){ $Path = ".\" }

$FunctionTemplate=@"
<#
    .SYNOPSIS

    .DESCRIPTION

    .EXAMPLE

    .PARAMETER
    
    .OUTPUTS

    .NOTES

    .LINK
#>
Function $Name{
	[CmdletBinding()]
	Param([Parameter(Mandatory=`$true)]
		  `$Name)
	
	begin{}
	process{
		try{}
		catch{
			`$ErrorMessage = `$_.Exception.Message
			`$FailedItem = `$_.Exception.ItemName
			
			Write-Output "`$FailedItem - `$ErrorMessage"
			Write-Output $False
		}
		finally{}
	}
	end{}
}
"@

			$FunctionTemplate | Out-File -Encoding Ascii "$Path\$name.ps1"
		}
		catch{
			$ErrorMessage = $_.Exception.Message
			$FailedItem = $_.Exception.ItemName
			$Line = $_.InvocationInfo.ScriptLineNumber
			$Function = $MyInvocation.MyCommand
			$Message = "[ERROR  in $Function on line $Line] $FailedItem - $ErrorMessage"
		}
		finally{}
	}
	end{}
}
