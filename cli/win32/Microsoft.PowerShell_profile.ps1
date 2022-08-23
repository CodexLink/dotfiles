# pwsh (Powershell) Config for Win32 with Oh-My-Posh as Prompt.
# Updated as of 08/24/2022, Version 0.6.3

# # Aliases
Set-Alias cbf CreateBlankFile
Set-Alias ccp CopyCurrentPath
Set-Alias cfc ContentFileToClipboard
Set-Alias cfh CompareFileHash
Set-Alias elev Elevate-Command
Set-Alias ex explorer
Set-Alias g GithubAlias-Processor
Set-Alias ipy ipython
Set-Alias ld lazydocker
Set-Alias lg lazygit
Set-Alias ls PowerColorLS
Set-Alias mk mkdir
Set-Alias n nvim
Set-Alias p ping
Set-Alias py python
Set-Alias wtc OpenWTConfig

# # Env Variables

# - For Python
$Env:PYTHONIOENCODING = "utf-8"			# Force Encoding to "UTF-8"

# Prefixes with 'SEGMENT_' were explicitly stated for example usages.
$Env:SEGMENT_DISABLE_DTIME = $false
$Env:SEGMENT_DISABLE_PROJECT_PL = $false
$Env:SEGMENT_PROJECT_PL_DISABLE_VENV = $false
$Env:SEGMENT_PROJECT_PL_VENV_STR = ""
$Env:SEGMENT_DISABLE_TRANSIENT_RECENT_EXEC_TIME = $false
$Env:SEGMENT_DISABLE_WAKATIME = $true		# Practice uncommenting Env Vars as they don't disappear when you commented them. Use this switch instead.

$Env:WAKATIME_API_KEY = "<masked>"

# # Script Variables
# ! Please ignore this and its implemented functionality if you don't use powershell.
$Global:WinTermConfigFilePath = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

# # Functions
function ContentFileToClipboard {
	Param(
		[Parameter(Mandatory=$true, Position=0)][String] $file
	)
	return Get-Content $file | Set-Clipboard
}

function CreateBlankFile {
	Param(
		[Parameter(Mandatory=$true, Position=0)][String] $newFile
	)
	return New-Item $newFile -Type File
}

function CompareFileHash {
	Param(
		[Parameter(Mandatory=$true, Position=0)][String] $fileToCompare,
		[Parameter(Mandatory=$true, Position=1)][String] $fileToAgainst
	)
	$_compareFileIsValid = Test-Path -Path $fileToCompare -PathType Leaf
	$_againstFileIsValid = Test-Path -Path $fileToAgainst -PathType Leaf

	if (-not ($_compareFileIsValid -and $_againstFileIsValid)) {
		$Global:LASTEXITCODE = 1; return Write-Error -Message "Supplied reference/s to the file was either invalid or was not a file. Please check your arguments and try again. | Is Valid, Compare: $_compareFileIsValid, Against: $_againstFileIsValid" -CategoryReason InvalidType;
	}

	$_DEFAULT_ALGORITHM = "SHA256"
	$_hashCompareFile = (Get-FileHash -Path $fileToCompare -Algorithm $_DEFAULT_ALGORITHM).Hash
	$_hashAgainstFile = (Get-FileHash -Path $fileToAgainst -Algorithm $_DEFAULT_ALGORITHM).Hash

	return ($_hashCompareFile -and $_hashAgainstFile) ? (Write-Host -Message "Both files '$fileToCompare' (Compare) and '$fileToAgainst' (Against) were both HASH-ACCURATE, which means, they are the same.`nCompare File: $_hashCompareFile`nAgainst File: $_hashAgainstFile" -ForegroundColor Green) : (Write-Error -Message "Both files '$fileToCompare' (Compare) and '$fileToAgainst' (Against) were both NOT HASH-ACCURATE.`nCompare File: $_hashCompareFile`nAgainst File: $_hashAgainstFile")
}

function CopyCurrentPath {
	Param(
		[Parameter(Mandatory=$false, Position=0)][String] $toFile
	)
	return ($toFile ? "$pwd" + ("\$toFile" -Replace ".\\") : (pwd).Path) | Set-Clipboard
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
		[Parameter(Mandatory=$false, Position=1)][AllowEmptyString()][String] $args
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
	else { 
		Write-Warning -Message "Specified alias action $gAliasAction does not exists from the shortcut implementation or is not available. Proceeding either way ..."
	}

	Start-Process -FilePath git.exe -ArgumentList $gResolveCommand, $args -NoNewWindow -Wait; return;
}

# # Imports
# Reference for supressing warnings on Import-Module: https://stackoverflow.com/questions/30709884/how-to-ignore-warning-errors
Import-Module PSReadLine -WarningAction:SilentlyContinue

# - Set PSReadLine Properties
# Docs: https://docs.microsoft.com/en-us/powershell/module/psreadline/set-psreadlineoption?view=powershell-7.2
# Multiple Options to Single Object Invocation to Single Command Reference: https://docs.microsoft.com/en-us/powershell/module/psreadline/set-psreadlineoption?view=powershell-7.2#example-3-set-multiple-options
$PSReadLineOptions = @{
	BellStyle = "Audible"
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
