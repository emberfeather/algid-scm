component {
	public component function init( required any repository, required string tree ) {
		variables.repository = arguments.repository;
		variables.tree = variables.repository.mapTree(arguments.tree);
		
		if( isNull(variables.tree) ) {
			throw('Unable to find the #arguments.tree# tree')
		}
		
		return this;
	}
	
	public function getItem( required string path ) {
		return createObject('component', 'plugins.scm.inc.resource.storage.git.item').init(variables.tree, arguments.path);
	}
}
