# pwsh (Powershell) Config for Win32 with Oh-My-Posh as Prompt.
# Updated as of 08/12/2022

# # Aliases
Set-Alias ccp CopyCurrentPath
Set-Alias elev Elevate-Command
Set-Alias ex explorer
Set-Alias g GithubAlias-Processor
Set-Alias ld lazydocker
Set-Alias lg lazygit
Set-Alias ls PowerColorLS
Set-Alias mk mkdir
Set-Alias n nvim
Set-Alias p ping
Set-Alias py python
Set-Alias ipy ipython
Set-Alias wtc OpenWTConfig

# # Env Variables
# - For Python
$Env:PYTHONIOENCODING = "utf-8"			# Force Encoding to "UTF-8"
$Env:VIRTUAL_ENV_DISABLE_PROMPT = 1 # Hide Duplicated Virtual Env on Prompt.
$Env:WAKATIME_API_KEY = "38d0c4b9-5ec4-481c-b61d-be48c3cd2bda"

# # Script Variables
# ! Please ignore this and its implemented functionality if you don't use powershell.
$Global:WinTermConfigFilePath = "$env:UserProfile\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

# # Functions
function CopyCurrentPath {
	return (pwd).Path | Set-Clipboard
}
# ! Some parts of this function were not yet tested.
function Elevate-Command {
	Param(
		[Parameter(Mandatory=$true, Position=0)][String] $exec,
		[Parameter(Mandatory=$false, Position=1)][AllowEmptyString()][String] $args
	)

	$defaultFilePath = "pwsh"

	if ((-not $PSBoundParameters.ContainsKey('args')) -and ($PSBoundParameters.ContainsKey('exec'))) {
		Start-Process -FilePath $exec -Verb RunAs
	}

	elseif (($PSBoundParameters.ContainsKey('args')) -and ($PSBoundParameters.ContainsKey('exec'))) {
		Start-Process -FilePath $exec -ArgumentList $args -Verb RunAs
	}

	elseif (($PSBoundParameters.ContainsKey('args')) -and (-not $PSBoundParameters.ContainsKey('exec'))) {
		Start-Process $defaultFilePath -ArgumentList $args -Verb RunAs
	}
	else {
    $Global:LASTEXITCODE = 1; return Write-Error -Message "This command does not accept empty arguments (of both 'exec' and 'args'). Please try again." -Category InvalidArgument -ErrorAction Stop }

	return
}
# # Functions
#
# - Beyond Custom Aliases to Function Call
# Solution Reference: https://stackoverflow.com/questions/26290052/create-an-alias-to-a-command-that-has-spaces-in-it
# Enum Reference: https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_enum?view=powershell-7.2
function GithubAlias-Processor {
	Param(
		[Parameter(Mandatory=$true, Position=0)][String] $gAliasAction,
		[Parameter(Mandatory=$false, Position=1)][AllowEmptyString()][String] $gAliasArgs
	)
	# Enum-Like String Decl.
	# Array Variable Reference: https://docs.microsoft.com/en-us/powershell/scripting/learn/deep-dives/everything-about-arrays?view=powershell-7.2
	$GIT_ADD = "a", "add"
	$GIT_CLONE = "cl", "clone"
	$GIT_CHECKOUT = "ch", "checkout"
	$GIT_COMMIT = "co", "commit"
	$GIT_PUSH = "pu", "push"
	$GIT_RESTORE = "re", "restore"
	$GIT_STATUS = "st", "status"

	# Override by processing the value to match from the enum-like string commands.
	$gAliasAction = $gAliasAction.ToLower()

	if ($gAliasAction -eq $GIT_ADD[0]) 					{ $gResolveCommand = $GIT_ADD[1] 			}
	elseif ($gAliasAction -eq $GIT_CLONE[0]) 		{ $gResolveCommand = $GIT_CLONE[1] 		}
	elseif ($gAliasAction -eq $GIT_CHECKOUT[0]) { $gResolveCommand = $GIT_CHECKOUT[1] }
	elseif ($gAliasAction -eq $GIT_COMMIT[0]) 	{ $gResolveCommand = $GIT_COMMIT[1] 	}
	elseif ($gAliasAction -eq $GIT_PUSH[0])   	{ $gResolveCommand = $GIT_PUSH[1] 		}
	elseif ($gAliasAction -eq $GIT_RESTORE[0]) 	{ $gResolveCommand = $GIT_RESTORE[1] 	}
	elseif ($gAliasAction -eq $GIT_STATUS[0]) 	{ $gResolveCommand = $GIT_STATUS[1] 	}
	else { $Global:LASTEXITCODE = 1; return Write-Error -Message "Specified alias action were either 'NotYetImplemented' or is not available. Please try again." -Category InvalidArgument -ErrorAction Stop }

	Start-Process -FilePath git.exe -ArgumentList $gResolveCommand, $gAliasArgs -NoNewWindow -Wait; return;
}

# # Imports
# Reference for supressing warnings on Import-Module: https://stackoverflow.com/questions/30709884/how-to-ignore-warning-errors
Import-Module PSReadLine -WarningAction:SilentlyContinue

# - Set PSReadLine Properties
# Docs: https://docs.microsoft.com/en-us/powershell/module/psreadline/set-psreadlineoption?view=powershell-7.2
# Multiple Options to Single Object Invocation to Single Command Reference: https://docs.microsoft.com/en-us/powershell/module/psreadline/set-psreadlineoption?view=powershell-7.2#example-3-set-multiple-options
$PSReadLineOptions = @{
	BellStyle = "Audible"
	ContinuationPrompt = "❯"
	HistoryNoDuplicates = $true
	HistorySearchCursorMovesToEnd = $true
	PredictionSource = "HistoryAndPlugin"
	PredictionViewStyle = "ListView"
	ShowToolTips = $true
	ViModeIndicator = "Cursor"
}  
Set-PSReadLineOption @PSReadLineOptions

function OpenWTConfig {
	Start-Process nvim -ArgumentList $Global:WinTermConfigFilePath -NoNewWindow -Wait; return
}
# - PSFzf
# Has to lowercase the letter for some reason as it doesn't work on capital letters.
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+Alt+f' -PSReadlineChordReverseHistory 'Ctrl+Alt+r' -TabExpansion

# - Other Module Imports
Import-Module z 							# Directory-Jump based on History
Import-Module PowerColorLS	  # Better LS Equivalent

# # Entrypoint
# ! This requires the hunk theme. Please check OMP repository and their theme section.
oh-my-posh --config ~/chips.omp.json --init --shell pwsh | Invoke-Expression
Enable-PoshTransientPrompt

