component {
	public component function init() {
		variables.executable = 'git';
		variables.timeout = 15;
		
		return this;
	}
	
	public void function checkWorkDirectory(required string workDirectory) {
		if(!directoryExists(arguments.workDirectory)) {
			throw(message='Work directory does not exist', detail='The #arguments.workDirectory# does not exist');
		}
	}
	
	public string function getExecutable() {
		return variables.executable;
	}
	
	public numeric function getTimeout() {
		return variables.timeout;
	}
	
	public void function setExecutable(required string executable) {
		variables.executable = arguments.executable;
	}
	
	public void function setTimeout(required numeric timeout) {
		variables.timeout = arguments.timeout;
	}
	
	public any function _init() {
		return onMissingMethod('init', arguments);
	}
	
	public any function onMissingMethod(required string missingMethodName, required struct missingMethodArguments) {
		if(!arrayLen(arguments.missingMethodArguments)) {
			throw(message='Missing working directory', detail='The first argument must be the path to the git working directory');
		}
		
		checkWorkDirectory(arguments.missingMethodArguments[1]);
		
		local.command = '--git-dir="' & arguments.missingMethodArguments[1] & '/.git" --work-tree="' & arguments.missingMethodArguments[1] & '" ';
		
		local.command &= arguments.missingMethodName;
		
		for(local.i = 2; local.i <= arrayLen(arguments.missingMethodArguments); local.i++) {
			local.command &= ' ' & arguments.missingMethodArguments[local.i];
		}
		
		return __git(local.command);
	}
	
	private string function __git( required string command ) {
		execute name="#variables.executable#" timeout="#variables.timeout#" arguments="#arguments.command#" variable="local.result";
		
		return local.result;
	}
}
