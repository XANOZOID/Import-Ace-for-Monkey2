Namespace importer
#Import "<std>"

Using std..

Class SettingsLoader
	
	Method New( file:String, defaultSettings:Settings )
		_file=RealPath(file)
		_defaultSettings=defaultSettings
	End
	
	#Rem monkeydoc loads settings from a file, else generates&returns defaults
	#End
	Method Load:Settings()
		If GetFileType(_file)=FileType.File Then 
			' parse json file here
			Return Null
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