import React, { Component } from 'react';
import * as Firebase from 'firebase';
import 'firebase/firestore'

const config = {
  apiKey: 'AIzaSyD1aopJR6sl8MKJvwn_GXefMI0G71la35s',
  projectId: 'devdatabasefresh',
};

class AllocateItem extends Component {
    
    constructor(props) {
        super(props);

        this.setState = {
            docsList : []
        }
        // this.docsList = {value : []};

        if (!Firebase.apps.length) {
                Firebase.initializeApp(config);
        }
        this.productCollectionRef = Firebase.firestore().collection('Product');
        
        this.productCollectionRef.onSnapshot(response => {

            const newDocsList = response.docs.map(
                doc => doc.data()
            )

            this.setState.docsList = newDocsList;

            console.log(this.setState.docsList);
        });

    }

    PrepareDoc = (props) => {
        const finalList = props.docsList.map(function(doc) {
            var name = doc["itemName"];
            return <li> {name}</li>
        });

        return <ul> {finalList} </ul>
    }

    render() {
        return (
            <div className="App">
                
                <div className="LeftPanel"> 
                    <br/>
                    <h2> Product </h2>
                    <br/>

                    {/* <PrepareDoc value={this.state.docsList} />  */}

                </div>

                <div className="RightPanel"> 

                </div>

            </div>
        );
    }
}

export default AllocateItem;