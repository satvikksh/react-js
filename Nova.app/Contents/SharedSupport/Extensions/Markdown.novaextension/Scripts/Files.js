class MarkdownFilesAssistant {
    provideFilesOutput(files) {
        let strings = [];
        for (let file of files) {
            let string = this.outputForFile(file);
            strings.push(string);
        }
        return strings;
    }
    
    outputForFile(file) {
        // Converts a file object into a Markdown anchor or HTML tag
        var path = file.path;
        var name = file.name;
        
        var mimetype = file.mimetype;
        if (!mimetype) {
            return path;
        }
        
        if (mimetype.startsWith('image/')) {
            // Image
            return '![' + name + '](' + path + ')';
        }
        else if (mimetype.startsWith('video/')) {
            // Video
            return '<video src="' + path + '" controls></video>';
        }
        else if (mimetype.startsWith('audio/')) {
            // Audio
            return '<audio src="' + path + '" controls></audio>';
        }
        else if (mimetype == 'text/html') {
            // HTML
            return '[' + name + '](' + path + ')'
        }
        else if (mimetype == 'text/css') {
            // CSS
            return '<link rel="stylesheet" type="' + mimetype + '" href="' + path + '" />';
        }
        else if (mimetype == 'text/javascript' || mimetype == 'text/emcascript') {
            // Script
            return '<script type="' + mimetype + '" src="' + path + '"></script>';
        }
        else {
            return path;
        }
    }
}

module.exports = new MarkdownFilesAssistant();
