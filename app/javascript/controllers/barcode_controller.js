import { Controller } from "@hotwired/stimulus";
import Quagga from "quagga";

// Connects to data-controller="barcode"
export default class extends Controller {
  connect() {
    this.startWebcam();
    Quagga.init(
      {
        inputStream: {
          name: "Live",
          type: "LiveStream",
          target: document.querySelector("#barcode-scanner"),
        },
        decoder: {
          readers: [
            "code_128_reader",
            "ean_reader",
            "ean_8_reader",
            "code_39_reader",
            "code_39_vin_reader",
            "codabar_reader",
            "upc_reader",
            "upc_e_reader",
            "i2of5_reader",
          ],
        },
      },
      function (err) {
        if (err) {
          console.log(err);
          return;
        }
        Quagga.start();
      }
    );

    let count = 0
    let oldBarcode

    Quagga.onDetected(function (data) {
      const barcode = data.codeResult.code
      if (oldBarcode == barcode){
        count += 1;
      } else {
        count = 0
      }

      if (count == 20) {
        console.log("c'est lui", barcode)
          fetch(`/items/create_from_scan?barcode=${barcode}`, {
            method: 'post'
          })
      }

      oldBarcode = data.codeResult.code;
      // document.getElementById("barcode_input").value = data.codeResult.code;
      // document.querySelector("form").submit();
    });


  }


  async startWebcam() {
    try {
      const stream = await navigator.mediaDevices.getUserMedia({ video: true });
      document.querySelector("#barcode-scanner").srcObject = stream;
    } catch (error) {
      console.error("Error accessing webcam:", error);
    }
  }
}
