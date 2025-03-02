class CSSCompletionsAssistant {
    constructor() {
        this.doubleQuotedPathSelector = new ScopeSelector("style.string.double-quoted.path");
        this.singleQuotedPathSelector = new ScopeSelector("style.string.single-quoted.path");
        this.rightDelimiterSelector = new ScopeSelector("delimiter.right");
    }
    
    provideCompletionItems(editor, context) {
        let text = context.text;
        let selectors = context.selectors;
        
        let matchingSelector = null;
        
        for (let selector of selectors) {
            if (selector.matches(this.doubleQuotedPathSelector) && !selector.matches(this.rightDelimiterSelector)) {
                matchingSelector = this.doubleQuotedPathSelector;
                break;
            }
            else if (selector.matches(this.singleQuotedPathSelector) && !selector.matches(this.rightDelimiterSelector)) {
                matchingSelector = this.singleQuotedPathSelector;
                break;
            }
        }
        
        if (!matchingSelector) {
            return [];
        }
        
        let items = [];
        
        if (matchingSelector == this.doubleQuotedPathSelector || matchingSelector == this.singleQuotedPathSelector) {
            // Offer file completions
            let line = context.line;
            let substring = null;
            
            // Determine the text before the cursor, but after the quote
            if (matchingSelector == this.doubleQuotedPathSelector) {
                let idx = line.lastIndexOf("\"")
                if (idx != -1) {
                    substring = line.substring(idx + 1, line.length);
                }
            }
            else if (matchingSelector == this.singleQuotedPathSelector) {
                let idx = line.lastIndexOf("'")
                if (idx != -1) {
                    substring = line.substring(idx + 1, line.length);
                }
            }
            
            if (substring || substring === "") {
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
                        items.push(match);
                    }
                }
            }
        }
        
        return items;
    }
}

module.exports = new CSSCompletionsAssistant();
