/*
	@Release: pawnCompiler
	@Author: RyDeR`
	@Version: 1.0
	@Last Update: 04/08/2010 - 14:30
	@Bugs: -
	@Functions:
			@Functon: WinExec(path[])
			@Info: Use to execute programs. (like .exe, .bat, etc..)
			@params: 
				- path[] = The path of the program.


			@Function: returnServerPath(strdest[])
			@Info: Stores your server path to a string.
			@params:
				- strdest[] = The string where you're going to store your data in.


			@Function: existFile(path[])
			@Info: Checks if a file exists (in your server folder).
			@params:
				- path[] = The path you want to check if exists.

			@Function: compileScript(directory[], scriptName[])
			@Info: Compiles your scripts.
			@params:
				- directory[] = In which directory your script is. (e.g. filterscripts, gamemodes, scriptfiles..)
				- scriptName[] = The name of the script you want it to compile. (e.g. vehiclespawner (without .pwn extention))

	@Author Notes: -
*/
	

native WinExec(path[]);
native returnServerPath(strdest[]);
native existFile(path[]);


stock compileScript(directory[], scriptName[])
{
	new
		curPath[128],
		string[256]
	;
	returnServerPath(curPath);

	format(string, sizeof(string), "%s/%s.pwn", directory, scriptName);
	if(!existFile(string)) return format(string, sizeof(string), "[pawnCompiler]: Error - Script \"%s\" not found!", scriptName), string;

	format(string, sizeof(string), "%s/pawno/pawncc.exe ./%s/%s.pwn", curPath, directory, scriptName);
	WinExec(string);
	
	return format(string, sizeof(string), "[pawnCompiler]: Info - Script named \"%s\" in \"%s\" directory has been compiled!", scriptName, directory), string;
}