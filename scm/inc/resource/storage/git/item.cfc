component {
	public component function init( required any tree, required string path ) {
		variables.tree = arguments.tree;
		variables.item = variables.tree.findBlobMember(arguments.path);
		
		if( isNull(variables.item) ) {
			throw('The #arguments.path# item was not found in the repository');
		}
		
		return this;
	}
	
	public string function getFullName() {
		return variables.item.getFullName();
	}
	
	public string function getName() {
		return variables.item.getName();
	}
	
	public string function getParent() {
		return createObject('component', 'plugins.scm.inc.resource.storage.git.tree').init(variables.tree.getRepository(), variables.item.getParent());
	}
	
	public any function read() {
		return createObject('java', 'java.lang.String').init(variables.item.openReader().getBytes());
	}
}
