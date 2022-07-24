# Win32 CLI Configuration with OHM (Oh-My-Poosh)
# Updated as of 07/17/2022

# For Python
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1 # Hide Duplicated Virtual Env on Prompt.
$env:PYTHONIOENCODING="utf-8"				# Force Encoding to "UTF-8"

# Custom Made Function, Critical
function CopyCurrentPath {
	(pwd).Path | Set-Clipboard
}

# ! Some parts of this function were not yet tested.
function ElevateCommandAsAdmin {
	Param(
		[Parameter(Mandatory=$false, Position=0)][String] $exec = "",
		[Parameter(Mandatory=$false, Position=1)][String] $args = ""
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
		Write-Error -Message "This command does not accept empty arguments (of both 'exec' and 'args'). Please try again." -Category InvalidArgument
	}
}

# Aliases
Set-Alias ccp CopyCurrentPath
Set-Alias elev ElevateCommandAsAdmin
Set-Alias ex explorer
Set-Alias g git
Set-Alias ld lazydocker
Set-Alias lg lazygit
Set-Alias mk mkdir
Set-Alias n nvim
Set-Alias p ping
Set-Alias py python
Set-Alias ipy ipython

# Import PSReadLine and its Side Components
Import-Module PSReadLine
Import-Module PSFzf

# Set PSReadLine Properties
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Has to lowercase the letter for some reason as it doesn't work on capital letters.
# ! Maybe it was used by the 'Windows Terminal'.
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+Alt+f' -PSReadlineChordReverseHistory 'Ctrl+Alt+r'

# Other Module Imports
Import-Module z 							# Directory Jump based on History
Import-Module posh-git				# Git Support on OHM Interface
Import-Module Terminal-Icons	# Add Icons to Terminal. This is dependent to the font you have.

# Entrypoint
# ! This requires the hunk theme. Please check OMP repository and their theme section.
oh-my-posh --init --shell pwsh --config ~/hunk.omp.json | Invoke-Expression
