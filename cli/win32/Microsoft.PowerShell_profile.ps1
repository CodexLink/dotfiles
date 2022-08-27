# pwsh (Powershell) Config for Win32 with Oh-My-Posh as Prompt.
# Updated as of 08/24/2022, Version 0.6.3

# # Aliases
Set-Alias c cat
Set-Alias cbf CreateBlankFile
Set-Alias ccp CopyCurrentPath
Set-Alias cfc ContentFileToClipboard
Set-Alias cfh CompareFileHash
Set-Alias elev Elevate-Command
Set-Alias ex explorer
Set-Alias g git
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

# - Oh-My-Posg chips.omp.json config.
$Env:SEGMENT_DISABLE_BATTERY = $false
$Env:SEGMENT_DISABLE_DTIME = $false
$Env:SEGMENT_DISABLE_PROJECT_PYTHON = $false
$Env:SEGMENT_DISABLE_PROJECT_PYTHON_VENV = $false
$Env:SEGMENT_DISABLE_TRANSIENT = $false
$Env:SEGMENT_PROJECT_PYTHON_ACTIVE_VENV_STR = "Env. Active"
$Env:SEGMENT_DISABLE_TRANSIENT_RECENT_EXEC_TIME = $false
$Env:SEGMENT_DISABLE_WAKATIME = $false
$Env:WAKATIME_API_KEY = "<masked>"

# # Script Variables
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

# # Imports
Import-Module PSReadLine -WarningAction:SilentlyContinue

$PSReadLineOptions = @{
	BellStyle 										= "Audible"
	Colors = @{
		Command            					= '#FFD600'
		Comment											= '#9FFFE0'
		ContinuationPrompt 					= '#80D8FF'
		Default            					= '#FFFFBF'
		Error												= '#FF8A80'
		Emphasis										= '#B9F6CA'
		InlinePrediction						= '#BFCC50'
		Keyword 										= '#B6E3FF'
		ListPrediction							= '#FFD600'
		ListPredictionSelected			= "`e[48;2;142;36;170m"
		Member             					= '#FFDD71'
		Number             					= '#FF8A80'
		Operator           					= '#FFFF8D'
		Parameter          					= '#84FFFF'
		Type               					= '#FFB2FF'
		Selection 									= '#80D8FF'
		String 											= '#B9F6CA'
		Variable           					= '#E7FF8C'
	}
	EditMode											= "Vi"
	HistoryNoDuplicates 					= $true
	HistorySearchCursorMovesToEnd = $true
	PredictionSource 							= "HistoryAndPlugin"
	PredictionViewStyle 					= "ListView"
	ShowToolTips 									= $true
	ViModeIndicator 							= "Script"
}  
Set-PSReadLineOption @PSReadLineOptions
Set-PSReadLineKeyHandler -Chord "Alt+s" -Function SwitchPredictionView
Set-PSReadLineKeyHandler -Chord "Alt+a" -Function PreviousHistory
Set-PSReadLineKeyHandler -Chord "Alt+d" -Function NextHistory
Set-PSReadlineKeyHandler -Key "Tab" -Function AcceptSuggestion
Set-PSReadlineKeyHandler -Key "Alt+f" -Function ForwardWord
Set-PSReadlineKeyHandler -Key "Alt+d" -Function BackwardKillWord


function OpenWTConfig {
	Start-Process nvim -ArgumentList $Global:WinTermConfigFilePath -NoNewWindow -Wait; return
}
# - PSFzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+Alt+f' -PSReadlineChordReverseHistory 'Ctrl+Alt+r' -TabExpansion

# - Other Module Imports

Import-Module CompletionPredictor		# Extension for PSReadLine.
Import-Module PowerColorLS	  			# Better LS Equivalent.
Import-Module z 										# Directory-Jump based on History.

# # Entrypoint
oh-my-posh --config ~/chips.omp.json --init --shell pwsh | Invoke-Expression
