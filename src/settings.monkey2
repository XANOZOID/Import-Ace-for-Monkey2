Namespace importer
#Import "<std>"
#Import "<json>"

Using json..
Using std..

Class SettingsLoader
	
	Method New( file:String, defaultSettings:Settings )
		_file=RealPath(file)
		_defaultSettings=defaultSettings
	End
	
	#Rem monkeydoc loads settings from a file, else generates&returns defaults
	#End
	Method Load:Settings()
		If GetFileType(file)=FileType.File Then 
			' parse json file here
		Else
			Return GenerateDefaults()
		End
	End

Private
	Field _file:=""
	Field _defaultSettings:Settings
	
	Method GenerateDefaults:Settings()
		' generate json file here
		Return _defaultSettings
	End
	
End

Struct Settings
	
	Field outputFile:=""
	Field parseDir:=""
	Field ignoreStarting:=""
	
End