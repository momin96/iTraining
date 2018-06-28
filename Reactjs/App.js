  import React, { Component } from 'react';
  // import logo from './logo.svg';
  import './App.css';

  class App extends Component {


  constructor(props) {
    super(props);
    this.state = {value: ''};
    this.selectedFile = {value: ''};

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);

    // For file upload, TODO: Need to refactor
    this.fileChangedHandler = this.fileChangedHandler.bind(this);
    this.uploadHandler = this.uploadHandler.bind(this);
  }

  state = {selectedFile: null};

  handleChange(event) {
    this.setState({value: event.target.value});
  }

  handleSubmit(event) {
    console.log("submit tapped");
  }

  uploadHandler(event) {
    console.log(this.state.selectedFile)
  }

  fileChangedHandler = (event) => {
    const file = event.target.files[0];
    this.setState({selectedFile: file});
    console.log(file);
    console.log(this.selectedFile);
  }


    render() {
      return (
        <div className="App">
          <header className="App-header">
            {/* <img src={logo} className="App-logo" alt="logo" /> */}
            {/* <h1 className="App-title">Welcome to React</h1> */}
          </header>
        <p> <span className="ItemP"> Name: </span>  <input className="InputBox" type="text" name="name" /> </p>
        <p> <span className="ItemP"> Code: </span>  <input className="InputBox" type="text" name="name" /> </p>
        <p> <span className="ItemP"> Category: </span>  <input className="InputBox" type="text" name="name" /> </p>
        <p> <span className="ItemP"> Description: </span>  <input className="InputBox" type="text" name="name" /> </p>
        <p> <span className="ItemP"> Quantity: </span>  <input className="InputBox" type="text" name="name" /> </p>
        <p> <span className="ItemP"> Misc: </span>  <input className="InputBox" type="text" name="name" /> </p>
        <p> 
          <span className="ItemP"> Pick Image: </span>  <input className="InputBox" type="file" onChange={this.fileChangedHandler} /> 
          <button onClick={this.uploadHandler}>Upload!</button>
        </p>

          {/* <form onSubmit={this.handleSubmit}>    */}
              <input className="SubmitButton" type="submit" value="Submit" />
          {/* </form> */}
        </div>
      );
    }
  }

  export default App;
