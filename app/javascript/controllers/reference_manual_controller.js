import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="reference-manual"
export default class extends Controller {
  static targets = ["input"]
  connect() {
  }

  fetchSneaker(){
    console.log(this.inputTarget.value);
    const apiKey1 = "0fa27d5fa7mshd6714f60ee0eafbp15449bjsn4cb7ff7b7916";
    const apiKey2 = "v1-sneakers.p.rapidapi.com";
    const url = `https://v1-sneakers.p.rapidapi.com/v1/sneakers?styleId=${this.inputTarget.value}&limit=10`;
    const options = {
    method: 'GET',
    headers: {
      'x-rapidapi-key': apiKey1,
      'x-rapidapi-host': apiKey2
      }
    }
    fetch(url, options)
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`);
        }
        return response.json();
      })
      .then(data => {
        console.log(data)
        fetch('/my_stock/items', {  // Updated to match the route
          method: 'POST',
          headers: {
            'Content-Type': 'application/json' // Specify that we're sending JSON
          },
          body: JSON.stringify({ data: data.results[0] }) // Send the data as JSON
        })
        .then(response => response.json())
        .then(result => {
          // console.log('Success:', result);
          // Optional: handle success response
        })
        .catch(error => {
          // console.error('Error in POST request:', error);
        });

      })
      .catch(error => {
        // console.error('Error fetching data:', error);
      });
        // this.displayData(data); // Optional: method to handle/display the data
  }
}
