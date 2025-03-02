class CSSFilesAssistant {
    provideFilesOutput(files) {
        let strings = [];
        for (let file of files) {
            let string = this.outputForFile(file);
            strings.push(string);
        }
        return strings;
    }
    
    outputForFile(file) {
        // Converts a file object into a CSS value
        var path = file.path;
        var mimetype = file.mimetype;
        if (!mimetype) {
            return path;
        }
        
        if (mimetype.startsWith('image/')) {
            // Image
            return 'url("' + path + '")';
        }
        else if (mimetype == 'text/css') {
            // CSS
            return '@import("' + path + '");';
        }
        else if (mimetype.startsWith('font/') || mimetype.startsWith('application/x-font-')) {
            // Font
            var name = file['name'];
            
            var string = '@font-face {\n';
            string = string.concat('\tfont-family: "' + name + '";\n');
            string = string.concat('\tsrc: url("' + path + '");\n');
            string = string.concat('}');
            return string;
        }
        else {
            return path;
        }
    }
}

module.exports = new CSSFilesAssistant();
