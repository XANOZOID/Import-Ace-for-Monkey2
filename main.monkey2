#Import "<std>"
Using std..

Const writefile:="imports.monkey2"
Const importDir:="src"
Const ignoreMatch:="_"
Global cdir:String
Global stream:FileStream

Function Main()
	stream=FileStream.Open( writefile, "w" )
	
	'all files of the current dir 
	cdir=CurrentDir() + importDir
	Local paths:= LoadRDir( cdir )
	cdir=CurrentDir()
	
	For Local path:=Eachin paths
		If Not path.EndsWith(".monkey2") Continue
		Local relpath:=path.Replace( cdir, "")
		stream.WriteLine( "#Import ~q"+relpath+"~q")
	Next
	
	stream.Close()
End

Function LoadRDir:StringStack( path:String, s:StringStack=New StringStack )
	Local paths:=LoadDir( path )
	For Local _path:=Eachin paths
		' ignore any file that begins with the ignore match
		If _path.StartsWith(ignoreMatch) Continue
		If GetFileType(path)=FileType.Directory
			LoadRDir( path +"/"+ _path, s)
		Else
			s.Push( path )
		End
	Next
	Return s
End