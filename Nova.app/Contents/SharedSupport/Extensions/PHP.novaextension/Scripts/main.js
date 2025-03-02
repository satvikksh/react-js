// Commands
nova.commands.register("php.resolveInterpreter", (workspace) => {
    // Paths to search
    let searchPaths = [];
    
    // Standard paths
    searchPaths.push("/opt/homebrew/bin", "/usr/local/bin", "/usr/bin");
    
    // Search for python interpreter executables
    let regex = /^php(?:\d+(?:\.\d+)?)?$/;
    
    let matchingPaths = [];
    for (let searchPath of searchPaths) {
        try {
            let contents = nova.fs.listdir(searchPath);
            for (let item of contents) {
                if (item.match(regex)) {
                    let execPath = nova.path.join(searchPath, item);
                    if (nova.fs.access(execPath, nova.fs.X_OK)) {
                        matchingPaths.push(execPath);
                    }
                }
            }
        }
        catch (err) {
        } 
    }
    
    let versionRegex = /^PHP\s(\d+(\.\d+(\.\d+)?)?)/;
    let promises = [];
    
    for (let path of matchingPaths) {
        let promise = new Promise((resolve, reject) => {
            let process = new Process(path, {
                args: ["--version"]
            });
            
            let version = null;
            
            process.onStdout((line) => {
                if (!version) {
                    let match = line.match(versionRegex);
                    if (match) {
                        version = match[1];
                    }
                }
            });
            
            let timeoutID = setTimeout(() => {
                // Ensure the process terminates in a timely fashion
                // If for some reason the process hangs for a long time
                // (or does not actually respond well to --version)
                // we should terminate the process and ignore.
                reject("The process did not respond in a timely manner.");
                process.terminate();
            }, 3000);
            
            process.onDidExit((code) => {
                clearTimeout(timeoutID);
                
                let displayName;
                if (version) {
                    displayName = `${path} (${version})`;
                }
                else {
                    displayName = path;
                }
                let item = [path, displayName];
                resolve(item);
            });
            
            try {
                process.start();
            }
            catch (err) {
                reject(err);
            }
        });
        promises.push(promise);
    }
    
    return Promise.allSettled(promises).then((iterable) => {
        let results = [];
        iterable.forEach(x => {
            if (x.status == 'fulfilled') {
                results.push(x.value);
            }
        });
        return results;
    });
});

// Tasks
const Tasks = require("Tasks.js");
nova.assistants.registerTaskAssistant(Tasks, {
    identifier: "php",
    name: "PHP"
});

// Issues
class NovaPHPValidator {
    provideIssues(editor) {
        let range = new Range(0, editor.document.length);
        let string = editor.getTextInRange(range);
        
        return new Promise((resolve, reject) => {
            let interpreter = nova.workspace.config.get("php.interpreter");
            if (!interpreter) {
                interpreter = "php";
            }
            
            try {
                let p = new Process(interpreter, {
                    args: ["-l", "-d", "display_errors=1"],
                    shell: nova.environment.SHELL
                });
                
                let parser = new IssueParser("php-linter");
                
                p.onStdout((line) => {
                    parser.pushLine(line);
                });
                
                p.onStderr((line) => {
                    parser.pushLine(line);
                });
                
                p.onDidExit((code) => {
                    let issues = parser.issues;
                    resolve(issues);
                });
                
                p.start();
                
                let writer = p.stdin.getWriter();
                writer.write(string);
                writer.close();
            }
            catch (err) {
                console.error("Could not start PHP interpreter: " + err);
                reject("Could not start PHP interpreter: " + err);
            }
        });
    }
}

assistant = null;

function registerAssistant() {
    if (assistant) {
        unregisterAssistant();
    }
    
    let event = nova.workspace.config.get("php.validate");
    if (!event) {
        return;
    }
    
    let options = {
        event: event
    };
    assistant = nova.assistants.registerIssueAssistant("php", new NovaPHPValidator(), options);
}

function unregisterAssistant() {
    if (assistant) {
        assistant.dispose()
        assistant = null;
    }
}

nova.workspace.config.onDidChange("php.validate", (newValue, oldValue) => {
    registerAssistant();
});

nova.workspace.config.onDidChange("php.interpreter", (newValue, oldValue) => {
    registerAssistant();
});

registerAssistant();

