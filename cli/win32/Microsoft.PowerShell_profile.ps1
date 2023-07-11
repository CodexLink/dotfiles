# pwsh (Powershell) Config for Win32 with Oh-My-Posh as Prompt.

# # Aliases
Set-Alias b bat
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
Set-Alias pn pnpm
Set-Alias py python
Set-Alias wtc OpenWTConfig

# # Env Variables

# - For Python
$Env:PYTHONIOENCODING = "utf-8"			# Force Encoding to "UTF-8"
$Env:VIRTUAL_ENV_DISABLE_PROMPT = 1

# - Oh-My-Posg chips.omp.json config.
$Env:DISABLE_SEGMENT_BATTERY = $false
$Env:DISABLE_SEGMENT_DTIME = $false
$Env:DISABLE_SEGMENT_PROJECT_NODE = $false
$Env:DISABLE_SEGMENT_PROJECT_PYTHON = $false
$Env:DISABLE_SEGMENT_PROJECT_PYTHON_VENV = $false
$Env:DISABLE_SEGMENT_PRIMARY_EXEC_TIME = $false
$Env:DISABLE_SEGMENT_TRANSIENT = $false
$Env:DISABLE_SEGMENT_TRANSIENT_EXEC_TIME = $false
$Env:DISABLE_SEGMENT_WAKATIME = $false
# $Env:SEGMENT_PROJECT_PYTHON_ACTIVE_VENV_STR = "Env. Active"
$Env:SEGMENT_PROJECT_PYTHON_ACTIVE_VENV_STR = ""
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
	PredictionViewStyle 					= "InlineView"
	ShowToolTips 									= $true
	ViModeIndicator 							= "Script"
}  
Set-PSReadLineOption @PSReadLineOptions
Set-PSReadLineKeyHandler -Chord "Alt+w" -Function SwitchPredictionView
Set-PSReadLineKeyHandler -Chord "Alt+q" -Function PreviousHistory
Set-PSReadLineKeyHandler -Chord "Alt+e" -Function NextHistory
Set-PSReadLineKeyHandler -Chord "Alt+d" -Function ForwardWord
Set-PSReadLineKeyHandler -Chord "Alt+s" -Function BackwardKillWord
Set-PSReadLineKeyHandler -Key "Tab" -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function Complete

function OpenWTConfig {
	Start-Process nvim -ArgumentList $Global:WinTermConfigFilePath -NoNewWindow -Wait; return
}

# - Other Module Imports
Import-Module Terminal-Icons        # For the PowerColorLS Dependency.
Import-Module CompletionPredictor		# Extension for PSReadLine.
Import-Module PowerColorLS	  			# Better LS Equivalent.
Import-Module z 										# Directory-Jump based on History.

# # Entrypoint
oh-my-posh --config ~/chips.omp.json --init --shell pwsh | Invoke-Expression
