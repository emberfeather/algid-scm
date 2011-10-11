component extends="mxunit.framework.TestCase" {
	public void function setup( string repoName = 'test' ) {
		variables.git = createObject('component', 'plugins.scm.inc.resource.scm.git').init();
		
		variables.workDir = expandPath('/test/repos/' & arguments.repoName);
		
		// Remove the repository
		if(directoryExists(variables.workDir)) {
			directoryDelete(variables.workDir, true);
		}
		
		// Create a new repository
		directoryCreate(variables.workDir);
		
		variables.git._init(variables.workDir);
	}
}
