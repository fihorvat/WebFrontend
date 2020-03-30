# set current location
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
Set-Location -Path $dir

# index.html file path
$FilePath = Join-Path -Path $dir -ChildPath "index.html"

# variables
$startTerminator = "*<!--Projects-->"
$endTerminatr = "*<!--!Projects-->"
$append = [bool]$true

# index.html file content
$FileContent = Get-ChildItem $FilePath | Get-Content

# new context variable
$NewFileContent = @()

# go throught whole html file line by line
for ($i = 0; $i -lt $FileContent.Length; $i++) 
{
	# check if current line is StartTerminator
	if ($FileContent[$i] -like $startTerminator) {
			# add start terminator to NewFileContent variable
			$NewFileContent += $FileContent[$i]

			#disable automatic append
			$append = [bool]$false
	}

	# check if current line is EndTerminator
	if($FileContent[$i] -like $endTerminatr)
	{
		# Get all directory names in current directory
		# remove all directories that starts with ! or . or Template
		$directories = Get-ChildItem -Directory -Name | Where-Object { $_ -notlike "!*" } | Where-Object { $_ -notlike "Template" } | Where-Object { $_ -notlike ".*" };

		# insert space before every capital word
		$prettifiedDirNames = $directories | ForEach-Object { $_ -csplit '(?=[A-Z]|-)' -ne '' -join ' ' }

		#start unorder list
		$NewFileContent += "<ul>"
		for($d = 0; $d -lt $directories.Length; $d++) {
				$dirName = $directories[$d];
				$prettifiedDirName = $prettifiedDirNames[$d];
				$NewFileContent += "  <li>";
				$NewFileContent += "    <a href='$dirName\index.html'>$prettifiedDirName</a>";
				$NewFileContent += "  </li>";
		}
		#end unorder list
		$NewFileContent += "</ul>"

		#enable automatic append
		$append = [bool]$true
	}

	#add current line from original file if append is enabled
	if($append -eq  [bool]$true)
	{
		$NewFileContent += $FileContent[$i]
	}
}

# write NewFileContent in source file
$NewFileContent | Out-File $FilePath
