Namespace importer
#Import "<std>"

Using std..

Class SettingsLoader
	
	Method New( file:String, defaultSettings:Settings )
		_file= AppDir() +"/"+ file
		_defaultSettings=defaultSettings
	End
	
	#Rem monkeydoc loads settings from a file, else generates&returns defaults
	#End
	Method Load:Settings()
		Local settings:=New Settings
		If GetFileType(_file)=FileType.File Then 
			settings.From( New JsonObject(JsonValue.Load( _file ).ToObject()) )
		End
		
		Return GenerateDefaults( settings )
	End

Private
	Field _file:=""
	Field _defaultSettings:Settings
	
	#Rem monkeydoc Merges settings together, and fills in defaults
	#End
	Method GenerateDefaults:Settings( settings:Settings )
		' merge loaded settings with the defaults
		settings.Merge( _defaultSettings )
		
		' save file if dirty(values aren't set)
		If settings.dirty Then 
			Local json:JsonObject=settings
			json.Save( _file )
		End
		
		Return Realify(settings)
	End
	
	Method Realify:Settings( settings:Settings )
		settings.outputFile=AppDir() + settings.outputFile
		settings.parseDir=AppDir() + settings.parseDir
		Return settings
	End
	
End

Struct Settings
	
	Field outputFile:=""
	Field parseDir:=""
	Field ignoreStarting:=""
	Field dirty:=False
	
	Method From( obj:JsonObject )
		outputFile=obj.GetString( "output file" )
		parseDir=obj.GetString( "parse directory" )
		ignoreStarting=obj.GetString( "ignore start" )		
	End
	
	Method To:JsonObject()
		Local obj:=New JsonObject
		obj.SetString( "output file", outputFile )
		obj.SetString( "parse directory", parseDir )
		obj.SetString( "ignore start", ignoreStarting )
		Return obj
	End
	
	Method To:String()
		Local rep:="{"
		rep += outputFile + ", "
		rep += parseDir + ", "
		rep += ignoreStarting + "}"
		Return rep 
	End
	
	#Rem monkeydoc Whatever values this settings doesn't have, it tries to copy
	#End
	Method Merge( other:Settings )
		If outputFile="" Then 
			dirty=outputFile<>other.outputFile
			outputFile=other.outputFile
		End
		If parseDir="" Then 
			dirty=parseDir<>other.parseDir Or dirty
			parseDir=other.parseDir
		End
		If ignoreStarting="" Then 
			dirty=ignoreStarting<>other.ignoreStarting Or dirty
			ignoreStarting=other.ignoreStarting
		End
	End
	
End