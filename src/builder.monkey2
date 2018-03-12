Namespace importer
#Import "<std>"
#Import "settings"
Using std..

Class ImportBuilder
	Field settings:Settings
	
	Method New( settings:Settings )
		Self.settings=settings
	End
	
	Method Build()
		' open our stream
		_stream=FileStream.Open( settings.outputFile, "w" )
		
		' Add in our little stamp
		_stream.WriteLine( "'Generated with https://github.com/abe-noll/Project-Import-Automation-Mx2" )
		
		'get all paths from our dir
		Local paths:= LoadRDir( settings.parseDir )
		
		
		Local basedir:=CurrentDir()' get a base path to strip from the path
		For Local path:=Eachin paths
			' ignore all non monkey2 files
			If Not path.EndsWith(".monkey2") Continue
			
			' make current file relative
			Local relpath:=path.Replace( basedir, "")
			
			' write to output
			_stream.WriteLine( "#Import ~q"+relpath+"~q")
		
		Next
		
		_stream.Close()
	End
	
Private
	Field _stream:Stream
	
	Method LoadRDir:StringStack( path:String, s:StringStack=New StringStack )
		Local paths:=LoadDir( path )
		For Local _path:=Eachin paths
			' ignore any file that begins with the ignore match
			If _path.StartsWith( settings.ignoreStarting ) Continue
			
			If GetFileType(path)=FileType.Directory
				LoadRDir( path +"/"+ _path, s)
			Else
				s.Push( path )
			End
		Next
		Return s
	End
	
End


