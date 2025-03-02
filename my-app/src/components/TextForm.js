import React, {useState} from 'react'

export default function TextForm(props) {
    
const handleUpClick =() =>{
    // console.log("Uppercase was clicked" + text);
    let newText = text.toUpperCase();
    setText(newText)
}
const handleDownClick =() =>{
  // console.log("Lowercase was clicked" + text);
  let newText = text.toLowerCase();
  setText(newText)
}
// const handleColorChange =() =>{
//     console.log("Color was changed" + text);
//     let newText = '';
//     setText(newText)
// }

const handleOnChange =(event) =>{
    console.log("On Click");
    setText(event.target.value);
}

 const [text, setText] = useState('Enter Text Here')


  return (
    <>
    <div>
        <h1>{props.heading}</h1>
    <div className="mb-3">
      <textarea type="text" id="mybox" className="form-control" value={text} onChange={handleOnChange} rows="10"/>
    </div>
    
    <button type="submit" className="btn btn-primary mx-3" onClick={handleUpClick}>Upper case</button>
    <button type="submit" className="btn btn-primary mx-3" onClick={handleDownClick}>Lower Case</button>
    
    {/* <button type="submit" className="btn btn-primary mx-3" onClick={handleColorChange}>Clear</button> */}
   
    </div>
    <div className="container">
        <h1>your text</h1>
        <p>{text.split(" ").length} words and {text.length} Character</p>
<p>{0.008 * text.split(" ").length} Read in Minutes</p>
<h3>Preview</h3>
<p>{text}</p>
    </div>
    </>
  )
}
