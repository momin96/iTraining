import React, { Component } from "react";
 
import {
  Route,
  NavLink,
  HashRouter
} from "react-router-dom";

import App from "./App";
import UpdateItem from "./UpdateItem";
import AllocateItem from "./AllocateItem";

class Main extends Component {
  render() {
    return (
      <HashRouter>
        <div>
          <ul className="header">

            <li><NavLink to="/">Add new Item</NavLink></li>
            <li><NavLink to="/UpdateItem">Update Item</NavLink></li>
            <li><NavLink to="/AllocateItem">Allocate Items</NavLink></li> 

          </ul>
          <div className="content">
             <Route exact path="/" component={App}/>
              <Route path="/UpdateItem" component={UpdateItem}/>
             <Route path="/AllocateItem" component={AllocateItem}/> 
          </div>
        </div>
        </HashRouter>
    );
  }
}
 
export default Main;