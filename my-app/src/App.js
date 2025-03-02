//import logo from './logo.svg';
import './App.css';
import About from './components/About';
import Navbar from './components/Navbar';
import Sidebar from './components/Sidebar';
import TextForm from './components/TextForm';
function App() {
  return (
    <>

<Navbar title="Satvik's Group"/>
<div className="container my 3">
<TextForm heading="Text Area"/>
<About/>
<Sidebar/>
</div>
    </>

  );
}

export default App;
