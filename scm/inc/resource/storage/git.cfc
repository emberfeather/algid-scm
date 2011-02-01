component {
	public component function init() {
		return this;
	}
	
	public function getRepository( required string path ) {
		// Normalize reference to the repository
		if( right(arguments.path, 5) != '/.git' ) {
			arguments.path &= '/.git';
		}
		
		return createObject('component', 'plugins.scm.inc.resource.storage.git.repository').init(arguments.path);
	}
}
