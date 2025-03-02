class HTMLFilesAssistant {
    provideFilesOutput(files) {
        let strings = [];
        for (let file of files) {
            let string = this.outputForFile(file);
            strings.push(string);
        }
        return strings;
    }
    
    outputForFile(file) {
        // Converts a file object into an HTML tag
        var path = file.path;
        var mimetype = file.mimetype;
        
        // Encode the path
        path = encodeURI(path);
        
        if (!mimetype) {
            return path;
        }
        
        if (mimetype.startsWith('image/')) {
            // Image
            var imageMetadata = file.image;
            if (imageMetadata) {
                var width = imageMetadata.width;
                var height = imageMetadata.height;
                if (width && height) {
                    return '<img src="' + path + '" width="' + width + '" height="' + height + '" />';
                }
            }
            return '<img src="' + path + '" />';
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
            return '<a href="' + path + '">${0:Link}</a>'
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

module.exports = new HTMLFilesAssistant();
