Namespace importer
#Import "src/settings"
#Import "src/builder"


Const loadFile:="import_cfg.json"

Function Main()
	Local loader:=New SettingsLoader( loadFile, Defaults() )
	Local settings:=loader.Load()
	Local builder:=New ImportBuilder( settings )
	builder.Build()
End

Function Defaults:Settings()
	Local settings:=New Settings
	settings.outputFile="importfortune.monkey2"
	settings.parseDir="src"
	settings.ignoreStarting="_"
	Return settings
End