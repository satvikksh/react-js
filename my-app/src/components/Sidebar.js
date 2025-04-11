import React from "react";
import PropTypes from "prop-types";
import { Link } from "react-router-dom";
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
              <Link className="nav-link active" aria-current="page" to="/">Home</Link>
            </li>
            <li className="nav-item">
              <Link className="nav-link" to="/">Link</Link>
            </li>
            <li className="nav-item dropdown">
              <Link className="nav-link dropdown-toggle" to="/" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                Dropdown
              </Link>
              <ul className="dropdown-menu">
                <li><Link className="dropdown-item" to="/">Action</Link></li>
                <li><Link className="dropdown-item" to="/">Another action</Link></li>
                <li><hr className="dropdown-divider" /></li>
                <li><Link className="dropdown-item" to="/">Something else here</Link></li>
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
