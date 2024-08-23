import { Controller } from "@hotwired/stimulus"
import ApexCharts from 'apexcharts'

// Connects to data-controller="pie"
export default class extends Controller {
  connect() {
    console.log("pieeee");

    var options = {
      series: [44, 55, 13], // Les valeurs des segments (réduites à 3)
      chart: {
          width: 380,
          type: 'donut',
      },
      colors: ['#f6b765', '#d76531', '#000000'], // Les couleurs personnalisées pour 3 segments
      labels: ['En stock', 'Stock moyen', 'Stock faible'], // Les légendes pour chaque segment
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
                  width: 360
              },
              legend: {
                  show: true, // Assurez-vous que la légende est activée sur les petits écrans
                  fontSize: '12px', // Taille de la police pour les petits écrans
                  itemMargin: {
                      horizontal: 10, // Espacement horizontal entre les éléments
                      vertical: 5 // Espacement vertical entre les éléments
                  },
                  markers: {
                      width: 12, // Largeur des marqueurs dans la légende
                      height: 12, // Hauteur des marqueurs dans la légende
                      strokeColor: '#fff', // Couleur de la bordure des marqueurs
                      strokeWidth: 2 // Épaisseur de la bordure des marqueurs
                  }
              }
          }
      }],
      legend: {
          show: true, // Assurez-vous que la légende est activée
          position: 'right', // Position de la légende
          offsetY: 0,
          height: 230,
          fontSize: '14px', // Taille de la police pour la légende
          itemMargin: {
              horizontal: 10, // Espacement horizontal entre les éléments
              vertical: 5 // Espacement vertical entre les éléments
          },
          markers: {
              width: 12, // Largeur des marqueurs dans la légende
              height: 12, // Hauteur des marqueurs dans la légende
              strokeColor: '#fff', // Couleur de la bordure des marqueurs
              strokeWidth: 3 // Épaisseur de la bordure des marqueurs
          }
      }
    };

    var chart = new ApexCharts(this.element, options);
    chart.render();
  }

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
