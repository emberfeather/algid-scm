component {
	public component function init( required string path ) {
		// Normalize reference to the repository
		if( right(arguments.path, 5) != '/.git' ) {
			arguments.path &= '/.git';
		}
		
		variables.repository = createObject('java', 'org.eclipse.jgit.storage.file.FileRepository', '/plugins/scm/inc/lib/org.eclipse.jgit.jar').init(arguments.path);
		variables.git = createObject('java', 'org.eclipse.jgit.api.Git', '/plugins/scm/inc/lib/org.eclipse.jgit.jar').init(repository);
		
		return this;
	}
	
	public function getTree( required string tree ) {
		return createObject('component', 'plugins.scm.inc.resource.storage.git.tree').init(variables.repository, arguments.tree);
	}
	
	public function get__repository() {
		return variables.repository;
	}
	
	public function getAllCommits( string ref = 'HEAD' ) {
		var commit = '';
		var commits = [];
		var id = '';
		var revWalk = createObject('java', 'org.eclipse.jgit.revwalk.RevWalk', '/plugins/scm/inc/lib/org.eclipse.jgit.jar').init(variables.git.getRepository());
		var revSort = createObject('java', 'org.eclipse.jgit.revwalk.RevSort', '/plugins/scm/inc/lib/org.eclipse.jgit.jar');
		
		revWalk.sort(revSort.COMMIT_TIME_DESC, true);
		revWalk.sort(revSort.BOUNDARY, true);
		
		id = repository.resolve(arguments.ref);
		
		if (! isNull(id))
			revWalk.markStart(revWalk.parseCommit(id));
		
		commit = revWalk.next();
		
		// walk to get the commits
		while (not isNull(commit)) {
			arrayAppend(commits, commit);
			
			commit = revWalk.next();
		}
		
		return commits;
	}
}
