import React from 'react';
import ReactDOM from 'react-dom';

import './index.css';
// import App from './App';
import registerServiceWorker from './registerServiceWorker';

import Main from "./Main";


// const config = {
//   apiKey: 'AIzaSyD1aopJR6sl8MKJvwn_GXefMI0G71la35s',
//   projectId: 'devdatabasefresh',
// };
 
// firebase.initializeApp(config);
// this.app = firebase.app()

ReactDOM.render(
<Main />,
document.getElementById('root'));
registerServiceWorker();
