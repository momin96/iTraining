import React, { Component } from 'react';
import * as Firebase from 'firebase';
import 'firebase/firestore'


function ItemList(props) { 
    const finalList = props.documents.map(function(doc) {
        var code = doc["itemCode"];
        return <option key={code} value={code} >{code}</option>
    });

    return finalList;
} 

class ShowProductDetail extends React.Component {
    
    componentWillUpdate() {

        if (!this.props.show) {
            return null;
        }

        for (let i = 0 ; i < this.props.documents.length; i++) {
            let doc = this.props.documents[i];
            if (doc["itemCode"] === this.props.selectedDoc ) {
                
                this.iName = doc["itemName"];
                this.code = doc["itemCode"];
                break
            }
        }        
   }
    

    constructor(props) {
        super(props);   

        this.iName = '';
        this.code = '';

    }

    render () {
        return (
            <h2> Name:  {this.code}</h2>
        );
    }
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
        console.log("shouldShowProductDetails ",this.state.shouldShowProductDetails)
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

                    <p> <ShowProductDetail show={this.state.shouldShowProductDetails} documents={this.state.documents} selectedDoc={this.state.selectedDocument}  />  </p>
                         

                </div>

                <div className="RightPanel"> 
                </div>

            </div>
        );
    }
}

export default AllocateItem;