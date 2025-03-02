import React from "react";
import PropTypes from "prop-types";
// import "bootstrap/dist/css/bootstrap.min.css";
// import "bootstrap/dist/js/bootstrap.bundle.min";

export default function Sidebar(props) {
  return (
    <div className="d-flex">
      <nav className="bg-body-tertiary" style={{ width: "250px", height: "100vh", position: "fixed" }}>
        <div className="container-fluid p-3">
          <h5 className="navbar-brand">{props.title}</h5>
          <ul className="navbar-nav mb-2 mb-lg-0">
            <li className="nav-item">
              <a className="nav-link active" aria-current="page" href="/">Home</a>
            </li>
            <li className="nav-item">
              <a className="nav-link" href="/">Link</a>
            </li>
            <li className="nav-item dropdown">
              <a className="nav-link dropdown-toggle" href="/" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                Dropdown
              </a>
              <ul className="dropdown-menu">
                <li><a className="dropdown-item" href="/">Action</a></li>
                <li><a className="dropdown-item" href="/">Another action</a></li>
                <li><hr className="dropdown-divider" /></li>
                <li><a className="dropdown-item" href="/">Something else here</a></li>
              </ul>
            </li>
          </ul>
          <form className="mt-3" role="search">
            <input className="form-control mb-2" type="search" placeholder="Search" aria-label="Search" />
            <button className="btn btn-outline-success w-100" type="submit">Search</button>
          </form>
        </div>
      </nav>
    </div>
  );
}

Sidebar.propTypes = {
  title: PropTypes.string,
  abouttext: PropTypes.string,
};
