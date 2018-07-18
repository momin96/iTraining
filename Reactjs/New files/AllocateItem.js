import React, { Component } from 'react';
import * as Firebase from 'firebase';
import Autosuggest from 'react-autosuggest';
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
            filterText : ''
        };

        this.handleProductSelection = this.handleProductSelection.bind(this);
        this.handleCustomerSelection = this.handleCustomerSelection.bind(this);
        this.handleAllocatedButton = this.handleAllocatedButton.bind(this);
        this.handleSearch = this.handleSearch.bind(this);
        this.handleSuggestionSelection = this.handleSuggestionSelection.bind(this);

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
                    alert(productData.itemName+" Allocated to "+this.state.selectedCustomer);
                }).catch((fail) => {
                    console.log("Success ",fail);
                });
            }
        }
    }

    handleSearch = (event) => {
        this.setState({
            filterText : event.target.value
        })
    }

    handleSuggestionSelection = (suggestion) => {
        console.log("Parent : ",suggestion);
        let id = suggestion.id
        if (suggestion.data.itemName) {
            // Suggestion object is product object

        }
        else if (suggestion.data.name) {
            // Suggestion object is customer object
            
        }
    }

    render() {
        return (
            <div className="App">
                
                <div className="LeftPanel"> 
                    <br/>
                    <h2> Product </h2>
                    <br/>

                    {/* <select name="product" onChange={this.handleProductSelection}>  
                            <option value="SelectProduct">Select Product</option>
                            <ItemList products={this.state.products} />
                    </select>
                    <br />
                    <br />
                    <ShowProductDetail products={this.state.products} selectedProduct={this.state.selectedProduct}  /> */}


                    {/* <input type="text" className="searchBox" placeholder="Search product here !!" onChange={this.handleSearch}/>
                    <br/> */}
                    <Suggestion products={this.state.products} onSuggestionSelection={this.handleSuggestionSelection} placeholder="Search Product Here !!" />

                
                </div>

                <div className="RightPanel"> 
                    <br/>
                    <h2> Customer </h2>
                    <br/>
                     
                    <Suggestion customers={this.state.customers} onSuggestionSelection={this.handleSuggestionSelection} placeholder="Search Customer Here !!" />

                     
                     {/* <select onChange={this.handleCustomerSelection} >
                        <option value="SelectCustomer">Select Customer</option>
                        <CustomerList customers={this.state.customers} />
                    </select>
                    
                    <br />
                    <br />
                    <ShowCustomerDetails  selectedCustomer={this.state.selectedCustomer} customers={this.state.customers}/> */}
                </div>
                <button onClick={this.handleAllocatedButton} > Allocate </button>
            <br/>

            <br/>

                
            
            </div>
        );
    }
}

export default AllocateItem;


class Suggestion extends React.Component {
   
    constructor() {
        super();

        this.state = {
            value: '',
            suggestions: []
        };    
    }

    handleSuggestionSelection = (event, { suggestion, suggestionValue, suggestionIndex, sectionIndex, method }) => {
        // console.log("id  ", suggestion.id);
        // console.log("value ", suggestionValue);
        this.props.onSuggestionSelection(suggestion);
    }

    onChange = (event, { newValue, method }) => {

        this.setState({
            value: newValue
        });
    };
  
    onSuggestionsFetchRequested = ({ value }) => {
        let list = [];

        if (this.props.products) {
            list = this.props.products;
        }
        else if (this.props.customers) {
            list = this.props.customers;
        } 

        this.setState({
            suggestions: getSuggestions(value, list)
        });
    };

    onSuggestionsClearRequested = () => {

        this.setState({
            suggestions: []
        });
    };

    render () {

        const { value, suggestions } = this.state;
        const inputProps = {
        placeholder: this.props.placeholder,
        value,
        onChange: this.onChange
        };


        return (
            <div className="container">
                <Autosuggest 
                    suggestions={suggestions}
                    onSuggestionsFetchRequested={this.onSuggestionsFetchRequested}
                    onSuggestionsClearRequested={this.onSuggestionsClearRequested}
                    getSuggestionValue={getSuggestionValue}
                    renderSuggestion={renderSuggestion}
                    inputProps={inputProps}
                    onSuggestionSelected={this.handleSuggestionSelection}
                />
            </div>
        );
    }
}

function escapeRegexCharacters(str) {
  return str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

function getSuggestions(value, list) {
    
  const escapedValue = escapeRegexCharacters(value.trim());
  
  if (escapedValue === '') {
    return [];
  }

  const regex = new RegExp('^' + escapedValue, 'i');

    let name = list.filter(element => regex.test(element.data.itemName ? element.data.itemName : element.data.name));

    if (name.length === 0) {
        name = list.filter(element => regex.test(element.data.itemCategory));
    }
    return name;
}

function getSuggestionValue(suggestion) {
  
    if (suggestion.data.itemName){
        return suggestion.data.itemName
    }

    return suggestion.data.name
}

function renderSuggestion(suggestion) {

    return (
    <span id={suggestion.id}>{suggestion.data.itemName ? suggestion.data.itemName : suggestion.data.name}</span>
  );
}


function isEmpty(obj) {
    for(var key in obj) {
        if(obj.hasOwnProperty(key))
            return false;
    }
    return true;
}

//8310034750

//npm i react-autosuggest