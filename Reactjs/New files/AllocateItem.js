import React, { Component } from 'react';
import * as Firebase from 'firebase';
import Autosuggest from 'react-autosuggest';
import 'firebase/firestore'

/*      
    Keys 
    
        "itemName" : name,
        "itemDescription" : desc,
        "itemCatagory": category,
        "itemUnitPrice" : price,
        "itemQuantity" : qty,
        "itemMisc" : misc,
        "itemCode" : code,
        "itemThumbnailURL" : imageURL
*/   

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

    constructor(props) {
        super(props);

        this.state = {
            products : [],
            selectedProduct : {},
            customers : [],
            selectedCustomer : {},
            shouldClear : false
        };

        this.handleAllocateAction = this.handleAllocateAction.bind(this);
        this.handleSuggestionSelection = this.handleSuggestionSelection.bind(this);
        this.onSuccessAllocation = this.onSuccessAllocation.bind(this)
        this.handleCancelAction = this.handleCancelAction.bind(this);

        if (!Firebase.apps.length) {
            Firebase.initializeApp(config);
        }
            
        this.productCollectionRef = Firebase.firestore().collection('Product');
        this.customerCollectionRef = Firebase.firestore().collection('Customer');

    }

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

    handleAllocateAction = (event) => {
                
        if (isEmpty(this.state.selectedCustomer) || 
            isEmpty(this.state.selectedProduct)) {
                alert("Please select both product & customer");
        }
        else {

            let productData = this.state.selectedProduct.data
            let productId = this.state.selectedProduct.id

            let customerId = this.state.selectedCustomer.id

            if (isEmpty(productData) === false) {

                let fbRef = this.customerCollectionRef.doc(customerId).collection("AllocatedItem").doc(productId);
                
                fbRef.set(
                     productData
                ).then((succ) => {
                    console.log("Success ",succ);
                    alert(productData.itemName + " Allocated to " + this.state.selectedCustomer.data.name);
                    this.onSuccessAllocation(this)
                }).catch((fail) => {
                    console.log("Fail ",fail);
                });
            }
        }
    }

    handleCancelAction = (event) => {
        console.log("handleCancelAction ",event)

    }

    onSuccessAllocation = (event) => {
        console.log("onSuccessAllocation ",event)
        suggestionWithValue('');
    }

    handleSuggestionSelection = (suggestion) => {

        if (suggestion.data.itemName) {
            // Suggestion object is product object
            this.setState({
                selectedProduct : suggestion
            })
        }
        else if (suggestion.data.name) {
            // Suggestion object is customer object
            this.setState({
                selectedCustomer : suggestion
            })
        }
    }

    render() {
        return (
            <div className="App">
                
                <div className="LeftPanel"> 
                    <h2> Product </h2>
                    <br/>

                    <Suggestion 
                    products={this.state.products} 
                    onSuggestionSelection={this.handleSuggestionSelection} 
                    placeholder="Search Product or Product Category Here !!" 
                    ref="pRef"
                    />

                </div>

                <div className="RightPanel"> 
                    <h2> Customer </h2>
                    <br/>
                     
                    <Suggestion 
                    customers={this.state.customers} 
                    onSuggestionSelection={this.handleSuggestionSelection} 
                    placeholder="Search Customer Here !!" 
                    refs="cRef"
                    />
                </div>

                    <DisplayDetail 
                    product={this.state.selectedProduct} 
                    customer={this.state.selectedCustomer}  
                    onAllocateClick={this.handleAllocateAction}
                    onCancelClick={this.handleCancelAction} 
                    /> 
                
                <br/>
            
            </div>
        );
    }
}

export default AllocateItem;

class DisplayDetail extends React.Component {

    render() {

        if ( isEmpty(this.props.product) === false && isEmpty(this.props.customer) === false) {
            return (
                <div> Should allocate <i>{this.props.product.data.itemName} </i> to <i>{this.props.customer.data.name} </i> ?  
                    <br/>
                    <br/>
                    <button onClick={this.props.onAllocateClick} > Allocate </button>
                    <button onClick={this.props.onCancelClick} > Cancel </button>
                </div> 
            );
        }
        return null;
    }
}


class Suggestion extends React.Component {
   
    constructor() {
        super();

        this.state = {
            value: '',
            suggestions: []
        };

        suggestionWithValue = suggestionWithValue.bind(this)
        
        console.log("constructor",this)
    }

    handleSuggestionSelection = (event, { suggestion, suggestionValue, suggestionIndex, sectionIndex, method }) => {
        this.props.onSuggestionSelection(suggestion);
    }

    onChange = (event, { newValue, method }) => {

        this.setState({
            value: newValue
        });

        console.log("onChange",this.state.value)

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
                    ref="autosuggest"
                />
            </div>
        );
    }
}

function suggestionWithValue(newValue) {
    
    console.log(this.state.value)

    // this.refs.autosuggest.props.inputProps.value = '';
    // this.refs.autosuggest.input.value = '';
    // this.refs.autosuggest.input.focus();

    this.setState({
        value: newValue
    })

        console.log(this.state.value)

    console.log(this.props)

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

//npm i react-autosuggest