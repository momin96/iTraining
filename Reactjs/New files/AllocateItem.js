import React, { Component } from 'react';
import * as Firebase from 'firebase';
import 'firebase/firestore'


function ItemList(props) { 
    const finalList = props.documents.map(function(doc) {
        let code = doc["itemCode"];
        return <option key={code} value={code} >{code}</option>
    });

    return finalList;
} 

// class ShowProductDetail extends React.Component {
    
//     componentWillUpdate() {

//         if (!this.props.show) {
//             return null;
//         }

//         for (let i = 0 ; i < this.props.documents.length; i++) {
//             let doc = this.props.documents[i];
//             if (doc["itemCode"] === this.props.selectedDoc ) {
                
//                 this.iName = doc["itemName"];
//                 this.code = doc["itemCode"];
//                 break
//             }
//         }        
//    }
    

//     constructor(props) {
//         super(props);   

//         this.iName = '';
//         this.code = '';

//     }

//     render () {
//         return (
//             <span> Name:  {this.code}</span>
//         );
//     }
// }

const ShowProductDetail = (props) => {
    if (!props.show) {
        return <SelectItem/>
    }

    let name = '';
    let code = '';
    let desc = '';
    let price = '';
    let qty = '';

    for (let i = 0 ; i < props.documents.length; i++) {
        let doc = props.documents[i];
        if (doc["itemCode"] === props.selectedDoc ) {
            
            name = doc["itemName"];
            code = doc["itemCode"];
            desc = doc["itemDesc"];
            price = doc["itemPrice"];
            qty = doc["itemQty"];

            break
        }
    } 
    if (code === '') {
       return <SelectItem/>
    }
    else {
        return (
            <div > 
                <span> Name:  {name}</span> 
                <br/>
                <span> Code:  {code}</span> 
                <br/>
                <span> Description:  {desc}</span> 
                <br/>
                <span> Price:  {price}</span> 
                <br/>
                <span> Quantity:  {qty}</span> 
            </div>
        )
    }
}

const SelectItem = (props) => {
     return (
        <div>
            Please select item, for more details
        </div>
    )
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

                    <p> <ShowProductDetail show={this.state.shouldShowProductDetails} documents={this.state.documents} selectedDoc={this.state.selectedDocument}  />  </p>
                         

                </div>

                <div className="RightPanel"> 
                </div>

            </div>
        );
    }
}

export default AllocateItem;