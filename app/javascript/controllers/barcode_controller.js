import { Controller } from "@hotwired/stimulus";
import Quagga from "quagga";

// Connects to data-controller="barcode"
export default class extends Controller {
  static targets = ["brand", "brandInput","model", "modelInput","reference",
                    "referenceInput", "barcode", "barcodeInput", "overlay"];
  connect() {

    const barcode = "0793393701806"
    fetch(`/items/create_from_scan?barcode=${barcode}`, {
      method: "post",
    })
      .then((response) => response.json())
      .then((data) => {
        console.log(data);
        console.log('brand', data.items[0].brand);
        const item = data.items[0];
        this.brandInputTarget.value = item.brand;
        this.brandTarget.innerHTML = `<p>${item.brand}</p>`;

        const model = item["title"]
        let words = model.split(" ");
        let firstThreeWords = words.slice(0, 3).join(" ");
        console.log('model', firstThreeWords);
        this.modelInputTarget.value = firstThreeWords;
        this.modelTarget.innerHTML = `<p>${firstThreeWords}</p>`;

        // console.log('reference', data.items[0]);
        // this.referenceInputTarget.value = item.reference;
        // this.referenceTarget.innerHTML = `<p>${item.reference}</p>`;

        console.log('barcode', data.items[0].ean);
        this.barcodeInputTarget.value = item.ean;
        this.barcodeTarget.innerHTML = `<p>${item.ean}</p>`;

      });
      this.startWebcam();
  }

  async startWebcam() {
    try {
      // Specify constraints more clearly for mobile compatibility
      const constraints = {
        video: {
          facingMode: "environment" // Use the back camera on mobile devices
        }
      };

      const stream = await navigator.mediaDevices.getUserMedia(constraints);
      document.querySelector("#barcode-scanner").srcObject = stream;

      this.startQuagga(); // Initialize Quagga after getting the video stream
    } catch (error) {
      console.error("Error accessing webcam:", error);
    }
  }

  startQuagga() {
    Quagga.init(
      {
        inputStream: {
          name: "Live",
          type: "LiveStream",
          target: document.querySelector("#barcode-scanner"),
          constraints: {
            facingMode: "environment", // Ensure the use of the environment-facing camera
          },
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

    let count = 0;
    let oldBarcode;

    Quagga.onDetected(function (data) {
      const barcode = data.codeResult.code;
      if (oldBarcode == barcode) {
        count += 1;
      } else {
        count = 0;
      }

      if (count == 20) {
        console.log("c'est lui", barcode);
        fetch(`/items/create_from_scan?barcode=${barcode}`, {
          method: "post",
        })
          .then((response) => response.json())
          .then((data) => {
            console.log(data);
            console.log('brand', data.items[0].brand);
            const item = data.items[0];
            this.brandInputTarget.value = item.brand;
            this.brandTarget.innerText = item.brand;
            this.modelInputTarget.value = item.model;
            this.modelTarget.innerHTML = item.model

          });
      }

      oldBarcode = data.codeResult.code;
    });
  }
}
