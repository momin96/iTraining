import React, { Component } from 'react';
import * as Firebase from 'firebase';
import 'firebase/firestore'


function CustomerList(props) {

    const list = props.customers.map(function(customer) {
        
        let id = customer["id"];
        let data = customer["data"];
        
        let customerName = data["name"];
        return <option key={id} value={data}>{customerName}</option>
    });
    
    return list;
}

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
        return <NoData message="Please select product for more details"/>
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
        return <NoData message="Please select product for more details"/>
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

const ShowCustomerDetails = (props) => {
    console.log("ShowCustomerDetails",props);

    return null
}

const NoData = (props) => {
     return (
        <div>
            {props.message}
        </div>
    )
}

class AllocateItem extends Component {

    componentDidMount() {
       this.productCollectionRef.onSnapshot(response => {

            let newDocsList = response.docs.map( doc => {
                return doc.data()
            })

            this.setState({
                documents: newDocsList                
            })
        });

        this.customerCollectionRef.onSnapshot( response => {
            
            let custList = response.docs.map ( doc =>{
                return  {
                    "id" : doc.id,
                    "data" : doc.data()
                } 
            });

            this.setState({
                customers : custList
            })
        });
    }

    constructor(props) {
        super(props);

        this.state = {
            documents : [],
            selectedDocument : '',
            customers : [],
            selectedCustomer : '',
            shouldShowProductDetails : false
        };

        this.handleProductSelection = this.handleProductSelection.bind(this);
        this.handleCustomerSelection = this.handleCustomerSelection.bind(this);

        if (!Firebase.apps.length) {
            Firebase.initializeApp(config);
        }
            
        this.productCollectionRef = Firebase.firestore().collection('Product');
        this.customerCollectionRef = Firebase.firestore().collection('Customer');

    }

    handleProductSelection = (event) => {
        let code =  event.target.value;
        this.setState({
            selectedDocument : code,
            shouldShowProductDetails : true
        });
    }

    handleCustomerSelection = (event) => {
        let customerDoc = event.target.value;

        this.setState({
            selectedCustomer: customerDoc
        });
    }

    render() {
        return (
            <div className="App">
                
                <div className="LeftPanel"> 
                    <br/>
                    <h2> Product </h2>
                    <br/>

                    <select name="product" onChange={this.handleProductSelection}>  
                            <option value="SelectProduct">Select Product</option>
                            <ItemList documents={this.state.documents} />
                    </select>

                    <p> <ShowProductDetail show={this.state.shouldShowProductDetails} documents={this.state.documents} selectedDoc={this.state.selectedDocument}  />  </p>
                         

                </div>

                <div className="RightPanel"> 
                     
                     <select onChange={this.handleCustomerSelection} >
                        <option value="SelectCustomer">Select Customer</option>
                        <CustomerList customers={this.state.customers} />
                    </select>

                     <p> <ShowCustomerDetails  selectedCustomer={this.state.selectedCustomer} /></p> 
                </div>

            </div>
        );
    }
}

export default AllocateItem;