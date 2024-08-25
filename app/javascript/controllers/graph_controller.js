import { Controller } from "@hotwired/stimulus"
import ApexCharts from 'apexcharts'

// Connects to data-controller="graph"
export default class extends Controller {
  connect() {
    console.log("chart");

    var options = {
      colors: ["#fef4df", "#F2BE8A"],
      series: [{
        name: 'Inflation',
        data: [250, 400, 600, 900, 850, 1060, 950]
      }],
      chart: {
        height: 350,
        type: 'bar',
      },

      plotOptions: {
        bar: {
          borderRadius: 16,
          distributed: true,
          dataLabels: {
            position: 'top',
          },
        }
      },

      // Ajouter une bordure blanche autour des barres
      stroke: {
        show: true,
        width: 2, // Largeur de la bordure
        colors: ["#ffffff"],
      },

      dataLabels: {
        enabled: true,
        formatter: function (val) {
          return val + "€";
        },
        offsetY: -20,
        style: {
          fontSize: '12px',
          colors: ["#656363"]
        }
      },

      xaxis: {
        categories: ["L", "M", "M", "J", "V", "S", "D"],
        position: 'bottom',
        axisBorder: {
          show: false
        },
        axisTicks: {
          show: false
        },
        crosshairs: {
          fill: {
            type: 'gradient',
            gradient: {
              colorFrom: '#D8E3F0',
              colorTo: '#BED1E6',
              stops: [0, 100],
              opacityFrom: 0.4,
              opacityTo: 0.5,
            }
          }
        },
        tooltip: {
          enabled: true,
        },
      },

      yaxis: {
        axisBorder: {
          show: false
        },
        axisTicks: {
          show: false,
        },
        labels: {
          show: false,
          formatter: function (val) {
            return val + "€";
          },
          style: {
            fontSize: 5555,
            colors: ['#fff']
          }
        },
      },

      grid: {
        show: true,
        borderColor: '#CB680C',
        strokeDashArray: 4,
      },

      title: {
        floating: false,
        offsetY: 0,
        align: 'center',
        style: {
          color: '#444'
        }
      },

    };

    var chart = new ApexCharts(this.element, options);
    chart.render();

  }
}
