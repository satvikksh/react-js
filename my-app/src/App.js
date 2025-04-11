import React, { useState } from 'react';
import {
  BrowserRouter as Router,
  Routes,
  Route,
} from "react-router-dom";
import About from './components/About';
import Navbar from './components/Navbar';
// import Sidebar from './components/Sidebar';
import TextForm from './components/TextForm';
// import Home from './components/Home'; // Create this component

function App() {
  const [Mode, setMode] = useState('light');
  const toggleMode = () => {
    setMode(prev => prev === 'dark' ? 'light' : 'dark');
    document.body.style.backgroundColor = Mode === 'dark' ? 'white' : 'black';
  };

  return (
    <Router>
      <Navbar title="Satvik's Group" mode={Mode} toggleMode={toggleMode} />
      <div className="container my-3">
        {/* Sidebar (appears on all pages) */}
        {/* <Sidebar /> */}

        {/* Routes define page-specific content */}
        <Routes>
          {/* <Route path="/" element={<Home />} /> Default route */}
          <Route path="/" element={<TextForm />} />
          <Route path="/about" element={<About />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;