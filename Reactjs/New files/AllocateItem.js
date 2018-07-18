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
                    <SuggestionList products={this.state.products} filterText={this.state.filterText} />

                
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
                <button onClick={this.handleAllocatedButton} > Allocate </button>
            <br/>

            <br/>

                
            
            </div>
        );
    }
}

export default AllocateItem;


class SuggestionList extends React.Component {
   
    constructor() {
        super();

        this.state = {
            value: '',
            suggestions: []
        };    
    }

    onChange = (event, { newValue, method }) => {
        console.log("onChange ",newValue, event.currentTarget.children, method);
        if (method === 'click') {
            let c = event.currentTarget.children
            c[0].id
            console.log("Selected ",c[0].id)
        }
        this.setState({
            value: newValue
        });
    };
  
    onSuggestionsFetchRequested = ({ value }) => {

        this.setState({
            suggestions: getSuggestions(value, this.props.products)
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
        placeholder: "Search product here !!",
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
                />
            </div>
        );


        // if (this.props.products && this.props.products.length >= 1 ) {

            
        //     let filterText = this.props.filterText;

        //     const rows = [];

        //     this.props.products.forEach(function(product) {
                
        //         let id = product.id;
        //         let data = product.data;
                
        //         if (data.itemName.indexOf(filterText) === -1 || !filterText) {
        //             return null
        //         }
                
        //         rows.push(
        //              <ProductRow key={data.itemCode} itemName={data.itemName} />//<span> {data.itemName} <br/></span>            
        //         );
        //     }, this);
                
        //     return rows;
        // }

        // return null;
    }
}

function escapeRegexCharacters(str) {
  return str.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
}

function getSuggestions(value, productList) {
    
  const escapedValue = escapeRegexCharacters(value.trim());
  
  if (escapedValue === '') {
    return [];
  }

  const regex = new RegExp('^' + escapedValue, 'i');

  return productList.filter(product => regex.test(product.data.itemName));
}

function getSuggestionValue(suggestion) {
  return suggestion.data.itemName;
}

function renderSuggestion(suggestion) {
  return (
    <span id={suggestion.id}>{suggestion.data.itemName}</span>
  );
}


// class ProductRow extends React.Component {
//     render() {
//         let itemName = this.props.itemName;
//         return (            
//             <p><a href="" onClick={this.suggestionClick}> {itemName} </a></p>
//         )
//     }
// }



function isEmpty(obj) {
    for(var key in obj) {
        if(obj.hasOwnProperty(key))
            return false;
    }
    return true;
}

const theme = {
  container: {
    position: 'relative'
  },
  input: {
    width: 240,
    height: 30,
    padding: '10px 20px',
    fontFamily: 'Helvetica, sans-serif',
    fontWeight: 300,
    fontSize: 16,
    border: '1px solid #aaa',
    borderTopLeftRadius: 4,
    borderTopRightRadius: 4,
    borderBottomLeftRadius: 4,
    borderBottomRightRadius: 4,
  },
  inputFocused: {
    outline: 'none'
  },
  inputOpen: {
    borderBottomLeftRadius: 0,
    borderBottomRightRadius: 0
  },
  suggestionsContainer: {
    display: 'none'
  },
  suggestionsContainerOpen: {
    display: 'block',
    position: 'absolute',
    top: 51,
    width: 280,
    border: '1px solid #aaa',
    backgroundColor: '#fff',
    fontFamily: 'Helvetica, sans-serif',
    fontWeight: 300,
    fontSize: 16,
    borderBottomLeftRadius: 4,
    borderBottomRightRadius: 4,
    zIndex: 2
  },
  suggestionsList: {
    margin: 0,
    padding: 0,
    listStyleType: 'none',
  },
  suggestion: {
    cursor: 'pointer',
    padding: '10px 20px'
  },
  suggestionHighlighted: {
    backgroundColor: '#ddd'
  }
};

//8310034750