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
            documents : []
        };

        this.handleOptionSelect = this.handleOptionSelect.bind(this);
        
        if (!Firebase.apps.length) {
            Firebase.initializeApp(config);
        }
            
        this.productCollectionRef = Firebase.firestore().collection('Product');
    }

    handleOptionSelect = (event) => {
        console.log(event.target.value);

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

                         

                </div>

                <div className="RightPanel"> 

                </div>

            </div>
        );
    }
}

export default AllocateItem;