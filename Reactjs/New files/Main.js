import React, { Component } from "react";
 
class Main extends Component {
  render() {
    return (
        <div>
          <h1>Simple SPA</h1>
          <ul className="header">
            <li><a href="/App">Add new Item</a></li>
            <li><a href="/UpdateItem">Update Item </a></li>
            <li><a href="/AllocateItem">Allocate Items </a></li>
          </ul>
          <div className="content">
             
          </div>
        </div>
    );
  }
}
 
export default Main;