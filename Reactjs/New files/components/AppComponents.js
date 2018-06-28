import React from 'react';
import { BrowserRouter, Route, Link } from 'react-router-dom';
/*
* Importing components
*/

import App from '../App';
import AllocateItem from './AllocateItem';

class AppComponents extends React.Component {
    render() {
        return (
              <div className='container'>
				<div className='text-center'>
					<h1> Single page application in ReactJs</h1>
				</div>
				<nav className="navbar navbar-default">
					<div className="container-fluid">
						<ul className="nav navbar-nav">
							<li>
								<Link to='/'>
									<div>Home</div>
								</Link>
							</li>
							<li>
								<Link to='/AllocatedItem'>
									<div>Allocated Item</div>
								</Link>
							</li>
						</ul>
					</div>
				</nav>
				<BrowserRouter>
					<Link to="/">Home</Link>
                    <Link to="/AllocateItem">AllocateItem </Link>

                    <Route exact path="/" component={App} />
                    <Route path="/AllocatedItem" component={AllocateItem} />
				</BrowserRouter>
			</div>

        );
    }
}

export default AppComponent;
