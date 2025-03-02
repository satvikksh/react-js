(function() {
    class NovaPreviewRuntime {
        constructor() {
            this.messageHandlers = {}
        }
        
        // Funnel point for all API method invocations
        // Ex: window.nova.message.invoke('methodName', arg1, arg2, arg3);
        invoke() {
            if (arguments.length == 0) {
                throw "invoke() must be called with at least one argument (the method name)";
            }
            
            // Method name
            let name = arguments[0];
            if (typeof name != 'string') {
                throw "Method name must be a string";
            }
            
            // Method arguments
            let args = [];
            for (let i = 1; i < arguments.length; i++) {
                let arg = arguments[i];
                args.push(arg);
            }
            
            // Message
            let message = {
                name: name,
                args: args
            };
            
            // Invoke message handler
            window.webkit.messageHandlers.nova.postMessage(message);
        }
        
        // Funnel point for all messages received from the API host app
        // Should not be directly invoked by the API or client
        receive(message) {
            let messageName = message["name"];
            if (typeof messageName != 'string') {
                throw "Message name must be a string";
            }
            
            let args = message["args"];
            let handlerFunc = this.messageHandlers[messageName];
            let result = undefined;
            
            // Invoke the function
            try {
                result = handlerFunc.apply(null, args);
            }
            catch (e) {
                this.invoke('console.exception', e.toString());
                return undefined;
            }
            
            return result;
        }
        
        // Installs a handler for a given message name
        addMessageHandler(messageName, func) {
            if (typeof messageName != 'string') {
                throw "Message name must be a string";
            }
            if (typeof func != 'function') {
                throw "Message handler must be a function";
            }
            this.messageHandlers[messageName] = func;
        }
        
        // Removes a handler for a given message
        removeMessageHandler(messageName) {
            if (typeof messageName != 'string') {
                throw "Message name must be a string";
            }
            delete this.messageHandlers[messageName]
        }
    }
    
    // Create global instance
    let runtime = new NovaPreviewRuntime();
    window.nova = runtime;
    
    // Register methods
    runtime.addMessageHandler('favicon', () => {
        let favicons = [];
        
        let links = document.getElementsByTagName('link');
        for (let link of links) {
            let rel = link.getAttribute('rel');
            if (rel == 'icon') {
                let href = link.getAttribute('href');
                favicons.push({
                    type: "icon",
                    href: href
                });
            }
        }
        
        return favicons;
    });
    
    // Register event handlers
    
    // Invoked on page show
    window.addEventListener('pageshow', () => {
        let result = {};
        
        // Stylesheets
        let styleSheets = document.styleSheets;
        let styleSheetObjs = [];
        for (let i = 0; i < styleSheets.length; i++) {
            let styleSheet = styleSheets[i];
            
            let styleSheetObj = {};
            styleSheetObj.title = styleSheet.title;
            styleSheetObj.href = styleSheet.href;
            styleSheetObj.type = styleSheet.type;
            styleSheetObj.disabled = styleSheet.disabled;
            styleSheetObjs.push(styleSheetObj);
        }
        result.styleSheets = styleSheetObjs;
        
        // Scripts
        let scripts = document.scripts;
        let scriptObjs = [];
        for (let i = 0; i < scripts.length; i++) {
            let script = scripts[i];
            if (!script.src) {
                continue;
            }
            
            let scriptObj = {};
            scriptObj.src = script.src;
            scriptObj.type = script.type;
            scriptObjs.push(scriptObj);
        }
        result.scripts = scriptObjs;
        
        runtime.invoke('pageshow', result);
    })
    
    window.addEventListener('load', (e) => {
        // Enumerate links
        let links = document.querySelectorAll('a');
        for (let link of links) {
            // Mouse Enter event
            link.addEventListener('mouseenter', (le) => {
                let element = le.target;
                
                let elemObj = {};
                elemObj.href = element.href;
                elemObj.target = element.target;
                
                runtime.invoke('linkenter', elemObj);
            });
            
            // Mouse Leave event
            link.addEventListener('mouseleave', (le) => {
                let element = le.target;
                
                let elemObj = {};
                elemObj.href = element.href;
                elemObj.target = element.target;
                
                runtime.invoke('linkleave', elemObj);
            });
        }
    });
})();
