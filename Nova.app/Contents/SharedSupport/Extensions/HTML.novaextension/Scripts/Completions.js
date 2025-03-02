class HTMLCompletionsAssistant {
    constructor() {
        this.linkSelector = new ScopeSelector("tag.attribute.value.link");
    }
    
    provideCompletionItems(editor, context) {
        let selectors = context.selectors;
        
        let matchingSelector = null;
        
        for (let selector of selectors) {
            if (selector.matches(this.linkSelector)) {
                matchingSelector = this.linkSelector;
                break;
            }
        }
        
        if (!matchingSelector) {
            return [];
        }
        
        let line = context.line;
        let substring = null;
        
        // Determine the text before the cursor, but after the quote
        if (matchingSelector == this.linkSelector) {
            let idx = line.lastIndexOf("\"")
            if (idx == -1) {
                idx = line.lastIndexOf("'")
            }
            if (idx != -1) {
                substring = line.substring(idx + 1, line.length);
            }
        }
        
        if (!substring && substring !== "") {
            return [];
        }
        
        let components = nova.path.split(substring);
        let basePath = null;
        
        if (components[0] == "/") {
            // Absolute in workspace
            basePath = nova.workspace.path;
            if (!basePath) {
                basePath = "/";
            }
            components.shift();
        }
        else {
            // Relative to document
            let editorPath = editor.document.path;
            if (editorPath) {
                basePath = nova.path.dirname(editorPath);
            }
        }
        
        let lastComponent = components.pop();
        if (!lastComponent || lastComponent == "/") {
            lastComponent = "";
        }
        else {
            lastComponent = lastComponent.toLowerCase();
        }
        
        let directoryPath = basePath;
        if (components.length > 0) {
            directoryPath = nova.path.join(basePath, nova.path.join(...components));
        }
        
        let contents = null;
        try {
            contents = nova.fs.listdir(directoryPath);
        }
        catch (err) {
            contents = [];
        }
        
        let completions = [];
        
        for (let item of contents) {
            if (item.startsWith(".")) {
                // Ignore dot files
                continue;
            }
            
            let stat = nova.fs.stat(nova.path.join(directoryPath, item));
            let isDirectory = stat.isDirectory();
            
            let lowercaseItem = item.toLowerCase();
            
            if (lastComponent.length == 0 || lowercaseItem.startsWith(lastComponent)) {
                let match = new CompletionItem(item, CompletionItemKind.File);
                
                let insertText = null;
                if (lastComponent.length > 0) {
                    insertText = nova.path.join(nova.path.dirname(substring), item);
                }
                else {
                    insertText = nova.path.join(substring, item);
                }
                
                if (isDirectory) {
                    insertText = insertText + "/";
                }
                
                match.insertText = insertText;
                match.filterText = insertText;
                match.range = new Range(context.position - substring.length, context.position);
                match.path = nova.path.join(directoryPath, item);
                completions.push(match);
            }
        }
        
        return completions;
    }
}

module.exports = new HTMLCompletionsAssistant();
