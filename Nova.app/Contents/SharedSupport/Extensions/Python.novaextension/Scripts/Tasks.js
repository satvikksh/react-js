class PythonTasksAssistant {
    resolveTaskAction(context) {
        let action = context.action;
        let data = context.data;
        let config = context.config;
        
        if (action == Task.Run) {
            let type = data.type;
            
            if (type == "pythonDebug") {
                // Local debugging
                let interpreter = nova.workspace.config.get("python.interpreter", "string");
                if (!interpreter) {
                    throw new Error("No Python interpreter has been set for the project.");
                }
                
                // Resolve ~ in the interpreter path if needed
                interpreter = nova.path.expanduser(interpreter);
                
                // Resolve a relative interpreter path, if needed
                if (!nova.path.isAbsolute(interpreter)) {
                    interpreter = nova.path.join(nova.workspace.path, interpreter);
                }
                
                let script = config.get("python.debug.script", "string");
                let module = config.get("python.debug.module", "string");
                if (!script && !module) {
                    throw new Error("No Python script or module has been set for the task.");
                }
                
                let action = new TaskDebugAdapterAction("debugpy");
                
                action.command = interpreter;
                
                let args = [];
                args.push("-m");
                args.push("debugpy.adapter");
                action.args = args;
                
                // Debug Args
                let debugArgs = {};
                
                if (script) {
                    debugArgs.program = script;
                }
                else if (module) {
                    debugArgs.module = module;
                }
                
                let customArgs = config.get("python.debug.customArgs", "array");
                if (customArgs) {
                    debugArgs.args = customArgs;
                }
                
                let workingDirectory = config.get("python.debug.workingDirectory", "string");
                if (workingDirectory) {
                    if (nova.path.isAbsolute(workingDirectory)) {
                        debugArgs.cwd = nova.path.normalize(workingDirectory);
                    }
                    else {
                        debugArgs.cwd = nova.path.normalize(nova.path.join(nova.workspace.path, workingDirectory));
                    }
                }
                else {
                    debugArgs.cwd = nova.workspace.path;
                }
                
                if (config.get("python.debug.django", "boolean")) {
                    debugArgs.django = true;
                }
                if (config.get("python.debug.jinja", "boolean")) {
                    debugArgs.jinja = true;
                }
                if (config.get("python.debug.pyramid", "boolean")) {
                    debugArgs.pyramid = true;
                }
                
                if (config.get("python.debug.debugExternal", "boolean")) {
                    debugArgs.justMyCode = false;
                }
                
                action.debugArgs = debugArgs;
                
                return action;
            }
            else if (type == "pythonRemoteDebug") {
                // Remote debugging
                let host = config.get("python.debug.host", "string");
                if (!host) {
                    throw new Error("No remote debugging host has been set for the task.");
                }
                
                let port = config.get("python.debug.port", "number");
                if (!port) {
                    throw new Error("No remote debugging port has been set for the task.");
                }
                
                let action = new TaskDebugAdapterAction("debugpy");
                
                action.adapterStart = "attach";
                
                action.transport = "socket";
                action.socketHost = host;
                action.socketPort = port;
                
                // Debug Args
                action.debugRequest = "attach";
                
                let debugArgs = {};
                
                let pathMappings = config.get("python.debug.pathMappings");
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
                
                if (config.get("python.debug.django", "boolean")) {
                    debugArgs.django = true;
                }
                if (config.get("python.debug.jinja", "boolean")) {
                    debugArgs.jinja = true;
                }
                
                if (config.get("python.debug.debugExternal", "boolean")) {
                    debugArgs.justMyCode = false;
                }
                
                action.debugArgs = debugArgs;
                
                return action;
            }
        }
        
        return null;
    }
}

module.exports = new PythonTasksAssistant();
