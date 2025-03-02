class PHPTasksAssistant {
    resolveTaskAction(context) {
        let action = context.action;
        let data = context.data;
        let config = context.config;
        
        if (action == Task.Run) {
            let type = data.type;
            
            if (type == "phpDebug") {
                // Xdebug debugging
                let action = new TaskDebugAdapterAction("php");
                
                action.command = nova.path.normalize(nova.path.join(nova.extension.path, "../../NovaDBGpAdapter"));
                
                // Debug Args
                let debugArgs = {};
                
                let port = config.get("php.debug.port", "number");
                if (!port) {
                    port = 9003;
                }
                debugArgs.port = port;
                
                debugArgs.allowRemote = config.get("php.debug.allowRemote", "boolean");
                debugArgs.stopOnEntry = config.get("php.debug.stopOnEntry", "boolean");
                
                debugArgs.serverSourceRoot = config.get("php.debug.serverSourceRoot", "string");
                
                let localSourceRoot = config.get("php.debug.localSourceRoot", "string");
                if (!localSourceRoot) {
                    localSourceRoot = nova.workspace.path;
                }
                else {
                    if (!nova.path.isAbsolute(localSourceRoot)) {
                        // Resolve against workspace
                        localSourceRoot = nova.path.join(nova.workspace.path, localSourceRoot);
                    }
                }
                debugArgs.localSourceRoot = localSourceRoot;
                
                action.debugArgs = debugArgs;
                
                return action;
            }
            else if (type == "phpLocalServerDebug") {
                // Xdebug debugging
                let action = new TaskDebugAdapterAction("php");
                
                action.command = nova.path.normalize(nova.path.join(nova.extension.path, "../../NovaDBGpAdapter"));
                action.env = {"XDEBUG_SESSION": "1"};
                
                // Debug Args
                let debugArgs = {};
                
                let port = config.get("php.debug.port", "number");
                if (!port) {
                    port = 9003;
                }
                debugArgs.port = port;
                
                debugArgs.startServer = true;
                debugArgs.interpreter = nova.workspace.config.get("php.interpreter", "string");
                debugArgs.serverPort = config.get("php.debug.serverPort", "number");
                
                debugArgs.launchBrowser = config.get("php.debug.launchBrowser", "boolean");
                debugArgs.stopOnEntry = config.get("php.debug.stopOnEntry", "boolean");
                
                let localSourceRoot = config.get("php.debug.localSourceRoot", "string");
                if (!localSourceRoot) {
                    localSourceRoot = nova.workspace.path;
                }
                debugArgs.localSourceRoot = localSourceRoot;
                
                action.debugArgs = debugArgs;
                
                return action;
            }
        }
        
        return null;
    }
}

module.exports = new PHPTasksAssistant();
