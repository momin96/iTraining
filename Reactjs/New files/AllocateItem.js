import React, { Component } from 'react';
import * as Firebase from 'firebase';
import 'firebase/firestore'

const config = {
  apiKey: 'AIzaSyD1aopJR6sl8MKJvwn_GXefMI0G71la35s',
  projectId: 'devdatabasefresh',
};

function ItemList(props) { 
    const finalList = props.documents.map(function(doc) {
        var code = doc["itemCode"];
        return <option key={code} value={code} >{code}</option>
    });

    return finalList;
} 

function ShowProductDetail(props) {
    if (!props.show) {
        return null;
    }

    let selectDoc = {}

    let name = '';
    let code = '';
    let desc = '';
    let price = '';
    let qty = ''; 


    for (let i = 0 ;i < props.documents.length;i++) {
        let doc = props.documents[i];
         if (doc["itemCode"] === props.selectedDoc ) {
           selectDoc = doc

            code = doc["itemCode"];
            name = doc["itemName"];
            desc = doc["itemDesc"];
            price = doc["itemPrice"];
            qty = doc["itemQty"];
            
           break
        }
    }

   console.log("selectDoc",selectDoc);

    return (
        <h2> showing detail </h2>
    );
}

class AllocateItem extends Component {

    componentDidMount() {
       this.productCollectionRef.onSnapshot(response => {

            let newDocsList = response.docs.map(
                doc => doc.data()
            )
            newDocsList[0] = "Select code";
            this.setState({
                documents: newDocsList                
            })
        });
    }

    constructor(props) {
        super(props);

        this.state = {
            documents : [],
            selectedDocument : '',
            customer : [],
            selectedCustomer : '',
            shouldShowProductDetails : false
        };

        this.handleOptionSelect = this.handleOptionSelect.bind(this);
        
        if (!Firebase.apps.length) {
            Firebase.initializeApp(config);
        }
            
        this.productCollectionRef = Firebase.firestore().collection('Product');
    }

    handleOptionSelect = (event) => {
        let code =  event.target.value;
        this.setState({
            selectedDocument : code,
            shouldShowProductDetails : true
        });
    }

    render() {
        return (
            <div className="App">
                
                <div className="LeftPanel"> 
                    <br/>
                    <h2> Product </h2>
                    <br/>

                    <select onChange={this.handleOptionSelect}>  
                            <ItemList documents={this.state.documents} />
                    </select>

                    <p> <ShowProductDetail show={this.state.shouldShowProductDetails} documents={this.state.documents} selectedDoc= {this.state.selectedDocument}  />  </p>
                         

                </div>

                <div className="RightPanel"> 

                </div>

            </div>
        );
    }
}

export default AllocateItem;