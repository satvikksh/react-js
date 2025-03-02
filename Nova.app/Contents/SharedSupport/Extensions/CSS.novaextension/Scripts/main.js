// Colors
const Colors = require("Colors.js");
nova.assistants.registerColorAssistant(["css", "scss", "sass", "less", "html", "php"], Colors);

// Completions
const Completions = require("Completions.js");
nova.assistants.registerCompletionAssistant(["css", "scss", "sass", "less"], Completions, {
    triggerChars: new Charset(" (./'\"")
});

// Files
const Files = require("Files.js");
// Note: This API is private, and may disappear at any point. Do not attempt to use it.
nova.assistants.registerFileAssistant(["css", "scss", "sass", "less"], Files);
