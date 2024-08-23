import { Controller } from "@hotwired/stimulus"
import ApexCharts from 'apexcharts'


// Connects to data-controller="pie"
export default class extends Controller {
  connect() {
    console.log("pieeee");

    var options = {
      series: [44, 55, 13, 33], // Les valeurs initiales des segments
      chart: {
          width: 380,
          type: 'donut',
      },
      colors: ['#f6b765', '#d76531', '#000000', '#fef5dd'], // Les couleurs personnalisées
      dataLabels: {
          enabled: false
      },
      stroke: {
          width: 4, // Espacement entre les segments
          colors: ['#fff'] // Couleur de l'espace entre les segments (blanc par défaut)
      },
      responsive: [{
          breakpoint: 480,
          options: {
              chart: {
                  width: 200
              },
              legend: {
                  show: false
              }
          }
      }],
      legend: {
          position: 'right',
          offsetY: 0,
          height: 230,
      }
    };
    var chart = new ApexCharts(this.element, options);
    chart.render();
    // document.querySelector("#randomize").addEventListener("click", function() {
    //   chart.updateSeries(this.randomize());
    // });

    // document.querySelector("#add").addEventListener("click", function() {
    //     chart.updateSeries(this.appendData());
    // });

    // document.querySelector("#remove").addEventListener("click", function() {
    //     chart.updateSeries(this.removeData());
    // });

    // document.querySelector("#reset").addEventListener("click", function() {
    //     chart.updateSeries(this.reset());
    // });

  };

  appendData() {
    var chart = new ApexCharts(document.querySelector("#chart"), options);
    var arr = chart.w.globals.series.slice();
    arr.push(Math.floor(Math.random() * (100 - 1 + 1)) + 1);
    return arr;
  }

  removeData() {
    var chart = new ApexCharts(document.querySelector("#chart"), options);
    var arr = chart.w.globals.series.slice();
    arr.pop();
    return arr;
  }

  randomize() {
    var chart = new ApexCharts(document.querySelector("#chart"), options);
    return chart.w.globals.series.map(function() {
        return Math.floor(Math.random() * (100 - 1 + 1)) + 1;
    });
  }

  reset() {
      return options.series;
  }
}
