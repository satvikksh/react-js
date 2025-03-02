var starfield = new WebGLBackground({
    // Canvas and button are mandatory options
    canvas: document.querySelector("#starfield"),
    button: document.querySelector("#get-started-button"),
    
    // Starfield background color. Defaults to #080f24.
    backgroundColor: "#080f24",
    
    // Whether the starfield should constantly be centered on the button element. Default is true.
    followButton: true,
    
    // Controls the number of stars. Default is 1500.
    starCount: 1500,
    
    // The range of page scroll values (in pixels) at which the stars should be completely visible and completely hidden.
    // The stars will have full opacity before the first scroll threshold, interpolate opacity between first and second threshold, 
    // then be completely hidden after the second treshold.
    // Default is [window.innerHeight, window.innerHeight * 2].
    starsScrollRange: [500, 1500],
    
    // Same as above, but for the nebula clouds.
    // Suggestion: we think it looks better if the stars fade out just a little after the clouds.
    cloudsScrollRange: [500, 1250],
    
    // Intensity of the starfield in idle mode ('intensity' affects speed, length and thickness of stars).
    // Defaults to 0. (We suggest leaving this to zero).
    idleIntensity: 0,
    
    // Intensity of the starfield when pressing down a mouse button.
    // Defaults to 1. Put the same value as idle here to disable the acceleration on click.
    clickIntensity: 1.5,
    
    // Intensity of the starfield when the mouse cursor is hovering the specified button element.
    // Defaults to 1.5.
    buttonIntensity: 0
});