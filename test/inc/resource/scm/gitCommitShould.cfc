component extends="test.inc.resource.scm.gitBase" {
	public void function setup() {
		super.setup('commit');
	}
	
	public void function testCommit_newFile() {
		fileWrite(variables.workDir & '/readme.md', 'Readme.');
		
		variables.git.add(variables.workDir, 'readme.md');
		
		assertTrue(find('create mode', variables.git.commit(variables.workDir, '-m "Testing commits"')));
	}
	
	public void function testCommit_existingFile() {
		fileWrite(variables.workDir & '/readme.md', 'Readme.');
		
		variables.git.add(variables.workDir, 'readme.md');
		
		assertTrue(find('create mode', variables.git.commit(variables.workDir, '-m "Testing commits"')));
		
		fileWrite(variables.workDir & '/readme.md', 'Readme too.');
		
		variables.git.add(variables.workDir, 'readme.md');
		
		assertTrue(find('files changed', variables.git.commit(variables.workDir, '-m "Testing commits"')));
	}
}
