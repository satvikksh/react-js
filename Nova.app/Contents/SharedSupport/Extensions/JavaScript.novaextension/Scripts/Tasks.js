class JavaScriptTasksAssistant {
    resolveTaskAction(context) {
        let action = context.action;
        let data = context.data;
        let config = context.config;
        
        if (action == Task.Run && data.type == "chromeDebug") {
            // Chrome Debug
            let action = new TaskDebugAdapterAction("chrome");
            
            action.command = nova.path.normalize(nova.path.join(nova.extension.path, "../../NovaChromeDebugAdapter"))
            
            // Debug Args
            let request = config.get("request", "string");
            if (!request) {
                request = "launch";
            }
            action.debugRequest = request;
            
            let debugArgs = {};
            
            let sourceURL = config.get("sourceURL", "string");
            if (!sourceURL) {
                sourceURL = nova.workspace.previewURL;
            }
            debugArgs.sourceURL = sourceURL;
            
            let sourceRoot = config.get("sourceRoot", "string");
            if (sourceRoot) {
                if (!nova.path.isAbsolute(sourceRoot)) {
                    sourceRoot = nova.path.join(nova.workspace.path, sourceRoot);
                }
            }
            else {
                sourceRoot = nova.workspace.previewRootPath;
            }
            debugArgs.sourceRoot = sourceRoot;
            
            let launchPath = config.get("launchPath", "string");
            if (launchPath && !nova.path.isAbsolute(launchPath)) {
                launchPath = nova.path.join(nova.workspace.path, launchPath);
            }
            debugArgs.launchPath = launchPath;
            
            debugArgs.launchArgs = config.get("launchArgs", "array");
            
            debugArgs.port = config.get("port", "number");
            
            debugArgs.stopOnEntry = config.get("stopOnEntry", "boolean");
            
            action.debugArgs = debugArgs;
            
            return action;
        }
        else if (action == Task.Run && data.type == "denoDebug") {
            // Deno Debug
            let action = new TaskDebugAdapterAction("deno");
            
            action.command = nova.path.normalize(nova.path.join(nova.extension.path, "../../NovaChromeDebugAdapter"))
            
            // Debug Args
            let request = config.get("request", "string");
            if (!request) {
                request = "launch";
            }
            action.debugRequest = request;
            
            let debugArgs = {};
            
            debugArgs.type = "deno"
            
            debugArgs.scriptPath = config.get("scriptPath", "string");
            debugArgs.cwd = nova.workspace.path;
            
            let sourceRoot = config.get("sourceRoot", "string");
            if (sourceRoot) {
                if (!nova.path.isAbsolute(sourceRoot)) {
                    sourceRoot = nova.path.join(nova.workspace.path, sourceRoot);
                }
            }
            else {
                sourceRoot = nova.workspace.path;
            }
            debugArgs.sourceRoot = sourceRoot;
            
            debugArgs.runtimeExecutable = config.get("runtimeExecutable", "string");
            debugArgs.runtimeArgs = config.get("runtimeArgs", "array");
            
            debugArgs.launchArgs = config.get("launchArgs", "array");
            
            debugArgs.port = config.get("port", "number");
            
            debugArgs.stopOnEntry = config.get("stopOnEntry", "boolean");
            
            let pathMappings = config.get("pathMappings");
            if (pathMappings) {
                // Ensure the local part of path mappings are absolute
                let basePath = nova.workspace.path;
                let absolutePathMappings = pathMappings.map(mapping => {
                    let local = mapping.localRoot;
                    let remote = mapping.remoteRoot;
                    if (!nova.path.isAbsolute(local)) {
                        local = nova.path.join(basePath, local);
                    }
                    return {"localRoot": local, "remoteRoot": remote};
                });
                debugArgs.pathMappings = absolutePathMappings;
            }
            
            action.debugArgs = debugArgs;
            
            return action;
        }
        else if (action == Task.Run && data.type == "nodeDebug") {
            // Node.js Debug
            let action = new TaskDebugAdapterAction("node");
            
            action.command = nova.path.normalize(nova.path.join(nova.extension.path, "../../NovaChromeDebugAdapter"))
            
            // Debug Args
            let request = config.get("request", "string");
            if (!request) {
                request = "launch";
            }
            action.debugRequest = request;
            
            let debugArgs = {};
            
            debugArgs.type = "node"
            
            debugArgs.scriptPath = config.get("scriptPath", "string");
            debugArgs.cwd = nova.workspace.path;
            
            let sourceRoot = config.get("sourceRoot", "string");
            if (sourceRoot) {
                if (!nova.path.isAbsolute(sourceRoot)) {
                    sourceRoot = nova.path.join(nova.workspace.path, sourceRoot);
                }
            }
            else {
                sourceRoot = nova.workspace.path;
            }
            debugArgs.sourceRoot = sourceRoot;
            
            debugArgs.runtimeExecutable = config.get("runtimeExecutable", "string");
            debugArgs.runtimeArgs = config.get("runtimeArgs", "array");
            
            debugArgs.launchArgs = config.get("launchArgs", "array");
            
            debugArgs.port = config.get("port", "number");
            
            debugArgs.stopOnEntry = config.get("stopOnEntry", "boolean");
            
            let pathMappings = config.get("pathMappings");
            if (pathMappings) {
                // Ensure the local part of path mappings are absolute
                let basePath = nova.workspace.path;
                let absolutePathMappings = pathMappings.map(mapping => {
                    let local = mapping.localRoot;
                    let remote = mapping.remoteRoot;
                    if (!nova.path.isAbsolute(local)) {
                        local = nova.path.join(basePath, local);
                    }
                    return {"localRoot": local, "remoteRoot": remote};
                });
                debugArgs.pathMappings = absolutePathMappings;
            }
            
            action.debugArgs = debugArgs;
            
            return action;
        }
        else {
            return null;
        }
    }
}

module.exports = new JavaScriptTasksAssistant();
