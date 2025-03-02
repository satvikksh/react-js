// Commands

// Wrap Selection in Tag
nova.commands.register("html.wrapSelectionInTag", (editor) => {
    // Wraps the current editor selection in a new tag, with placeholders
    let selectedRanges = editor.selectedRanges;
    let newSelectedRanges = [];
    let shadowRanges = [];
    let offset = 0;
    editor.edit(function(e) {
        for (let range of selectedRanges) {
            let text = editor.getTextInRange(range);
            let newText = "<$[tag]>" + text + "</$[tag]>";
            
            let start = range.start;
            let end = range.end;
            
            let offsetRange = new Range(start + offset, end + offset);
            e.replace(offsetRange, newText);
            
            let newTextTokenizedLength = text.length + 7;
            
            // First tag placeholder range
            let firstSelectedRange = new Range(start + offset + 1, start + offset + 2);
            newSelectedRanges.push(firstSelectedRange);
            
            // Second tag placeholder range
            let secondSelectedRange = new Range(start + offset + text.length + 5, start + text.length + offset + 6);
            shadowRanges.push(secondSelectedRange);
            
            offset += newTextTokenizedLength - text.length;
        }
    });
    editor.selectedRanges = newSelectedRanges;
    
    editor.startShadowTyping(shadowRanges, Charset.alphanumeric);
});

// Completions
const Completions = require("Completions.js");
nova.assistants.registerCompletionAssistant(['html'], Completions, {
    triggerChars: new Charset("./'\"")
});

// Files
const Files = require("Files.js");
// Note: This API is private, and may disappear at any point. Do not attempt to use it.
nova.assistants.registerFileAssistant("html", Files);

