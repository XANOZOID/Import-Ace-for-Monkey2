Namespace importer
#Import "src/settings"
#Import "src/builder"


#Rem monkeydoc The configuration file . . .
	This file should be setup as a json file with the format:
	@example	
		{
			"output file": "import_wish.monkey2",
			"parse directory": "src",
			"ignore start": "_" // ignores files starting with _
		}
	@end
#End
Const cfgFile:="import_cfg.json"

Function Main()
	Local loader:=New SettingsLoader( cfgFile, Defaults() )
	Local settings:=loader.Load()
	Local builder:=New ImportBuilder( settings )
	builder.Build()
End

Function Defaults:Settings()
	Local settings:=New Settings
	settings.outputFile="import_wish.monkey2"
	settings.parseDir="src"
	settings.ignoreStarting=""
	Return settings
End