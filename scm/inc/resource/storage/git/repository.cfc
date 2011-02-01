component extends="plugins.scm.inc.resource.base.repository" {
	public component function init( required string path ) {
		super.init();
		
		variables.repository = createObject('java', 'org.eclipse.jgit.storage.file.FileRepository', '/plugins/scm/inc/lib/org.eclipse.jgit.jar').init(arguments.path);
		
		if( isNull(variables.repository.getBranch()) ) {
			throw('Unable to find repository at #arguments.path#')
		}
		
		return this;
	}
	
	public function getTree( required string tree ) {
		return createObject('component', 'plugins.scm.inc.resource.storage.git.tree').init(variables.repository, arguments.tree);
	}
	
	public function get__repository() {
		return variables.repository;
	}
}
