<#
  .SYNOPSIS
    Generates text based on mustache ({{var}}) formatted template strings and csv-files as input.
  .PARAMETER CsvFile
  	Data input
  .PARAMETER Template
  	Template string formatted as mustache template strings ({{var}})
  .PARAMETER TemplateFile
    File containing template string
#>

param (
	[parameter(Mandatory=$true)]
  [alias('i')]
	[string]$CsvFile,
  [alias('t')]
	[string]$Template,
  [alias('tf')]
  [string]$TemplateFile
)

Function Generate($csv, $templateString) {
  $guid = [Guid]::NewGuid()
  $outFile = "Templator_$($guid).txt"
  $csv | % {
    $member = $_
    Get-Member -InputObject $member -MemberType ([System.Management.Automation.PSMemberTypes]::NoteProperty) `
      | % { $i = 0; $currStr = $templateString } {
        $currStr = $currStr.Replace("{{$($_.Name)}}", $member.($_.Name))
        $i++
      } { $currStr | Out-File $outFile -Append -Encoding utf8 }
  }
  return $outFile
}

if (-not (Test-Path $CsvFile)) {
  Write-Host "Unable to open file $CsvFile!" -Foreground Red
} else {
  $inputFile = Import-Csv $CsvFile
  $templStr = ""
  if ($Template) {
    $templStr = $Template
  } elseif ($TemplateFile) {
    $templStr = [string] (Get-Content $TemplateFile)
  } else {
    Write-Host "No template string/file was provided. Type Get-Help Templator.ps1 for more information."
  }
  $fileName = Generate $inputFile $templStr
  Write-Host "Done. Result in $fileName"
}
