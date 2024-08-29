import { Controller } from "@hotwired/stimulus";
import Quagga from "quagga";

// Connects to data-controller="barcode"
export default class extends Controller {
  static targets = ["brand", "brandInput","model", "modelInput","reference",
                    "referenceInput", "barcode", "barcodeInput", "photo", "photoInput", "overlay"];
  connect() {
    console.log("Hello from our barcode controller");

      this.startWebcam();
  }

  async startWebcam() {
    console.log("Starting webcam");

    try {
      // Specify constraints more clearly for mobile compatibility
      const constraints = {
        video: {
          facingMode: "environment" // Use the back camera on mobile devices
        }
      };

      const stream = await navigator.mediaDevices.getUserMedia(constraints);
      document.querySelector("#barcode-scanner").srcObject = stream;

      console.log("Webcam started");


      this.startQuagga(); // Initialize Quagga after getting the video stream
    } catch (error) {
      console.error("Error accessing webcam:", error);
    }
  }

  startQuagga() {
    console.log("Starting Quagga");
    console.log(this.overlayTarget);
    const overlay = this.overlayTarget;
    const brand = this.brandTarget;
    const brandInput = this.brandInputTarget;
    const model = this.modelTarget;
    const modelInput = this.modelInputTarget;
    const reference = this.referenceTarget;
    const referenceInput = this.referenceInputTarget;
    const barcode = this.barcodeTarget;
    const barcodeInput = this.barcodeInputTarget;
    const photo = this.photoTarget;
    const photoInput = this.photoInputTarget;


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
      let barcodet = data.codeResult.code;
      console.log("Barcode detected:", barcodet);


      if (oldBarcode == barcodet) {
        count += 1;
      } else {
        count = 0;
      }

      if (count == 5) {
        console.log("c'est lui", barcodet);
        fetch(`/items/create_from_scan?barcode=${barcodet}`, {
          method: "post",
        })
          .then((response) => response.json())
          .then((data) => {
            overlay.classList.add("show");

            const item = data.items[0];
            brandInput.value = item.brand;
            brand.innerHTML = `<p> ${item.brand} </p>`;

            const title = item["title"];
            let words = title.split(" ");
            let firstThreeWords = words.slice(0, 3).join(" ");
            modelInput.value = firstThreeWords;
            model.innerHTML = `<p>${firstThreeWords}</p>`;

            // console.log('reference', data.items[0]);
            // this.referenceInputTarget.value = item.reference;
            // this.referenceTarget.innerHTML = `<p>${item.reference}</p>`;
            barcodeInput.value = item.ean;
            barcode.innerHTML = `<p> N° code-barre: ${item.ean} </p>`;

            console.log(item)
            photoInput.value = item.images[0];
            photo.innerHTML = `<img src="${item.images[0]}", alt="shoe", class="product-image-items">`;

          });
      }

      oldBarcode = data.codeResult.code;

    });

  }
}
