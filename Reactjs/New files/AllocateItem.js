import React, { Component } from 'react';
import * as Firebase from 'firebase';
import 'firebase/firestore'


function CustomerList(props) {

    const list = props.customers.map(function(customer) {
        
        let id = customer["id"];
        let data = customer["data"];
        
        let customerName = data["name"];
        return <option key={id} value={id}>{customerName}</option>
    });
    
    return list;
}

function ItemList(props) { 
    const finalList = props.products.map(function(doc) {
        
        let id = doc.id;
        let name = doc.data.itemName;

        return <option key={id} value={id} >{name}</option>
    });

    return finalList;
} 

const ShowProductDetail = (props) => {
    if (!props.selectedProduct || props.selectedProduct === "SelectProduct") {
        return <NoData message="Please select product for more details"/>
    }

    let name = '';
    let code = '';
    let desc = '';
    let price = '';
    let qty = '';

    for (let i = 0 ; i < props.products.length; i++) {
        let product = props.products[i];

        if (product.id === props.selectedProduct ) {
            
            name = product.data["itemName"];
            code = product.data["itemCode"];
            desc = product.data["itemDesc"];
            price = product.data["itemPrice"];
            qty = product.data["itemQty"];

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

    if (!props.selectedCustomer || props.selectedCustomer === 'SelectCustomer') {
        return <NoData message="Please select customer for more details"/>
    }

    let name = ''
    let location = ''

    for (let i = 0; i < props.customers.length ; i++) {
        let cust = props.customers[i];
        if (cust.id === props.selectedCustomer) {
            name = cust.data.name;
            location = cust.data.location;

            break;
        }  
    }

     return (
            <div > 
                <span> Name:  {name}</span> 
                <br/>
                <span> Location:  {location}</span> 
            </div>
        )
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

            let products = response.docs.map( doc => {

                return {
                    "id" : doc.id,   
                    "data" : doc.data()
                }
            })

            this.setState({
                products: products                
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
            products : [],
            selectedProduct : '',
            customers : [],
            selectedCustomer : '',
        };

        this.handleProductSelection = this.handleProductSelection.bind(this);
        this.handleCustomerSelection = this.handleCustomerSelection.bind(this);
        this.handleAllocatedButton = this.handleAllocatedButton.bind(this);

        if (!Firebase.apps.length) {
            Firebase.initializeApp(config);
        }
            
        this.productCollectionRef = Firebase.firestore().collection('Product');
        this.customerCollectionRef = Firebase.firestore().collection('Customer');

    }

    handleProductSelection = (event) => {
        let product =  event.target.value;
        this.setState({
            selectedProduct : product,
        });
    }

    handleCustomerSelection = (event) => {
        let customerDoc = event.target.value;
                
        this.setState({
            selectedCustomer: customerDoc
        });
    }

    handleAllocatedButton = (event) => {
        if (!this.state.selectedCustomer || 
            !this.state.selectedProduct ||
            this.state.selectedProduct === "SelectProduct" ||
            this.state.selectedCustomer === "SelectCustomer") {
                alert("Please select both product & customer");
        }
        else {

            let productData = {};
            for (let i = 0; i < this.state.products.length; i++) {
                let product = this.state.products[i];
                    if (product.id === this.state.selectedProduct) {
                        productData = product.data;
                        break
                    }
            }

            if (isEmpty(productData) === false) {
                let fbRef = this.customerCollectionRef.doc(this.state.selectedCustomer).collection("AllocatedItem").doc(this.state.selectedProduct);
                
                fbRef.set(
                     productData
                ).then((succ) => {
                    console.log("Success ",succ);
                }).catch((fail) => {
                    console.log("Success ",fail);
                });
            }
        }
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
                            <ItemList products={this.state.products} />
                    </select>
                    <br />
                    <br />
                    <ShowProductDetail products={this.state.products} selectedProduct={this.state.selectedProduct}  />
                </div>

                <div className="RightPanel"> 
                    <br/>
                    <h2> Customer </h2>
                    <br/>
                     <select onChange={this.handleCustomerSelection} >
                        <option value="SelectCustomer">Select Customer</option>
                        <CustomerList customers={this.state.customers} />
                    </select>
                    
                    <br />
                    <br />
                    <ShowCustomerDetails  selectedCustomer={this.state.selectedCustomer} customers={this.state.customers}/>
                </div>
                <button onClick={this.handleAllocatedButton} className=""> Allocate </button>
            </div>
        );
    }
}

export default AllocateItem;


function isEmpty(obj) {
    for(var key in obj) {
        if(obj.hasOwnProperty(key))
            return false;
    }
    return true;
}