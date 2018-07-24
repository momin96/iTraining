import * as Firebase from 'firebase';
import React, { Component } from 'react';
import { CloudinaryContext, Transformation, Image } from 'cloudinary-react';
import './App.css';
import 'firebase/firestore'

//npm install firebase@5.0.4 --save
//https://firebase.google.com/support/guides/firebase-web
// npm install --save react-router-dom
// https://hackernoon.com/simple-guide-to-creating-a-single-page-app-with-react-router-6b6f709a2e3f
 

// npm install cloudinary-react --save
// https://cloudinary.com/documentation/react_integration


class App extends Component {

  componentDidMount () {
    if (!Firebase.apps.length) {
          Firebase.initializeApp(config);
    }
    this.productCollectionRef = Firebase.firestore().collection('Product');

     const script = document.createElement("script");

      script.src = "https://widget.cloudinary.com/global/all.js";
      script.type = 'text/javascript';
      document.body.appendChild(script);
  }

  constructor(props) {
    super(props);

    this.state = {
        value: '',
        itemName:'Apple ',
        itemCategory:'Fruit',
        itemDesc:'An Apple a day keeps, doctor away',
        itemQty:'6',
        itemPrice:'12.5',
        itemMisc:'I like Apple, & its product',
        itemCode:''
    };

    this.selectedFile = {value: ''};

    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleClear = this.handleClear.bind(this);

  }

  state = {selectedFile: null};

  handleChange(event) {
    this.setState({value: event.target.value});
  }

  handleClear = (event) => {

    this.setState({
      itemCategory:'',
      itemName:'',
      itemDesc:'',
      itemQty:'',
      itemPrice:'',
      itemMisc:'',
      itemCode:''
    })

  }

  handleSubmit = (event) => {

    var name = this.state.itemName;
    var category = this.state.itemCategory;
    var price = Number(this.state.itemPrice);
    var qty = Number(this.state.itemQty);
    var desc = this.state.itemDesc;
    var misc = this.state.itemMisc;


    if (name && category &&  price && qty ) {


    var code = '';
      if (name.length < 3 ) {
          code = code.concat(name.substring(0,name.length));  
      }
      else {
          code = code.concat(name.substring(0,3));  
      }

      if (category.length < 3 ) {
        code = code.concat(name.substring(0,category.length));  
      }
      else {
        code = code.concat(category.substring(0,3));  
      }

      var ts = Math.round((new Date()).getTime() / 1000);
      code = code.concat(ts);  

      var dict = {
        "itemName" : name,
        "itemDesc" : desc,
        "itemCategory": category,
        "itemPrice" : price,
        "itemQty" : qty,
        "itemMisc" : misc,
        "itemCode" : code
      }

      this.productCollectionRef.add(
        dict
      ).then(function(docRef) {
        console.log("Doc Id "+docRef.id);
      }).catch(function(error) {
        console.log("Error "+error);
      });
    
    }
    else {
        console.log("Please fill in mandatory feilds");
        alert("Please fill in mandatory feilds");
    }
  }

  handleInputChange = (event) => {
    this.setState({
      [event.target.name] : event.target.value
    })
  }

    render() {
      return (
        <div className="App">

        <p> <input className="InputBox" type="text"  name="itemName" placeholder="Enter product name" value={this.state.itemName} onChange={e => this.handleInputChange(e)}/> </p>
        <p> <input className="InputBox" type="text"  name="itemCategory" placeholder="Enter category of product" value={this.state.itemCategory} onChange={e => this.handleInputChange(e)} /> </p>
        <p> <input className="InputBox" type="text"  name="itemDesc"  placeholder="Enter product descrption" value={this.state.itemDesc} onChange={e => this.handleInputChange(e)} /> </p>
        <p> <input className="InputBox" type="text"  name="itemQty" placeholder="Enter quantity"  value={this.state.itemQty} onChange={e => this.handleInputChange(e)}/> </p>
        <p> <input className="InputBox" type="text"  name="itemPrice" placeholder="Enter product's price" value={this.state.itemPrice} onChange={e => this.handleInputChange(e)} /> </p>
        <p> <input className="InputBox" type="text"  name="itemMisc" placeholder="Enter product's related any other info " value={this.state.itemMisc}onChange={e => this.handleInputChange(e)} /> </p>        
        
        <ImageUpload />
        <button className="SubmitButton" onClick={this.handleSubmit}>Submit</button>
        <button className="SubmitButton" onClick={this.handleClear}>Clear </button>


        </div>
      );
    }
  }

  export default App;


class ImageUpload extends React.Component {
  constructor (props) {
    super(props);
    this.state = {
      // onFinish: props.onFinish
    };
    this.onUploadFinish = this.onUploadFinish.bind(this);
  }

  componentDidMount() {
    document.getElementById("upload_widget_opener").addEventListener("click", () => {
      global.window.cloudinary.openUploadWidget({
          name: 'viatech', // cloud_
          upload: 'mfhwgw6g' // _preset
        },
        (error, result) => {
          this.onUploadFinish(error, result)
        }
      );
    }, false);
  }

  onUploadFinish(error, result) {
    console.log("onUploadFinish error= ", error,  "result = ", result)
    if(error) {
      alert("Some error occured ",error);
      return;
    }
    else {
      alert("Image uploaded succesfully");
    }
  }

  render() {
    return (

      <div>
       <button id="upload_widget_opener">Upload Image</button>
   </div>
    );
  }
}