// Commands
nova.commands.register("python.resolveInterpreter", (workspace) => {
    // Paths to search
    let searchPaths = [];
    
    // Virtual environment in the parent directory
    let parentVenvPath = nova.path.dirname(workspace.path);
    try {
        let binPath = nova.path.join(parentVenvPath, "bin");
        let activatePath = nova.path.join(binPath, "activate");
        if (nova.fs.access(activatePath, nova.fs.F_OK)) {
            searchPaths.push(binPath);
        }
    }
    catch (err) {
    }
    
    // Virtual environments in `~/.pyenv/versions/`
    let homeVenvPath = nova.path.expanduser("~/.pyenv/versions/");
    try {
        let contents = nova.fs.listdir(homeVenvPath);
        for (let item of contents) {
            let itemPath = nova.path.join(homeVenvPath, item);
            let binPath = nova.path.join(itemPath, "bin");
            searchPaths.push(binPath);
        }
    }
    catch (err) {
    }
    
    // Standard paths
    searchPaths.push("/opt/homebrew/bin", "/usr/local/bin", "/usr/bin");
    
    // Search for python interpreter executables
    let regex = /^python(?:\d+(?:\.\d+)?)?$/;
    
    let matchingPaths = [];
    for (let searchPath of searchPaths) {
        try {
            let contents = nova.fs.listdir(searchPath);
            for (let item of contents) {
                if (item.match(regex)) {
                    let execPath = nova.path.join(searchPath, item);
                    if (nova.fs.access(execPath, nova.fs.X_OK)) {
                        if (execPath.startsWith(parentVenvPath)) {
                            execPath = nova.path.join("..", execPath.substring(parentVenvPath.length));
                        }
                        else if (execPath.startsWith(homeVenvPath)) {
                            execPath = nova.path.join("~/.pyenv/versions", execPath.substring(homeVenvPath.length));
                        }
                        matchingPaths.push(execPath);
                    }
                }
            }
        }
        catch (err) {
        } 
    }
    
    let versionRegex = /^Python\s(\d+(\.\d+(\.\d+)?)?)/;
    let promises = [];
    
    for (let path of matchingPaths) {
        let promise = new Promise((resolve, reject) => {
            let processPath = path
            if (!nova.path.isAbsolute(processPath)) {
                processPath = nova.path.join(workspace.path, processPath);
            }
            
            let process = new Process(nova.path.expanduser(processPath), {
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
            
            process.onStderr((line) => {
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
    identifier: "python",
    name: "Python"
});

// Debug Sessions
nova.workspace.onDidStartDebugSession((debugSession) => {
    if (debugSession.type == "debugpy") {
        debugSession.onCustomEvent((debugSession, event) => {
            if (event.event == "debugpyAttach") {
                // Attach to a new debug session
                let body = event.body;
                
                let action = new TaskDebugAdapterAction("debugpy");
                action.adapterStart = "attach";
                
                let connect = body.connect;
                if (connect) {
                    action.transport = "socket";
                    action.socketHost = connect.host;
                    action.socketPort = connect.port;
                }
                
                action.debugRequest = "attach";
                action.debugArgs = body;
                
                debugSession.startChildSession(action);
            }
        });
    }
});

