import { Controller } from "@hotwired/stimulus"
import ApexCharts from 'apexcharts'

// Connects to data-controller="graph"
export default class extends Controller {
  connect() {
    console.log("chart");

    var options = {
      colors: ["#F2BE8A"],
      series: [{
        name: 'Inflation',
        data: [2.3, 3.1, 4.0, 10.1, 4.0, 3.6, 3.2]
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
        width: 1, // Largeur de la bordure
        colors: ['#ffffff'] // Couleur de la bordure (blanc)
      },

      dataLabels: {
        enabled: true,
        formatter: function (val) {
          return val + "%";
        },
        offsetY: -20,
        style: {
          fontSize: '14px',
          colors: ["#fff"]
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
        labels: {
          style: {
            fontSize: '16px',
            fontWeight: 'bold',
            fontFamily: 'Popins, sans-serif',
            colors: ['#cb692f','#cb692f','#cb692f','#cb692f','#cb692f','#cb692f','#cb692f']
          }
        }
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
            return val + "%";
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
        strokeDashArray: 5,
      },

      title: {
        floating: false,
        offsetY: 0,
        align: 'center',
        style: {
          color: '#444'
        }
      },

      legend: {
        show: true,
        position: 'bottom',
        horizontalAlign: 'center',
        itemMargin: {
          horizontal: 13,
          vertical: 0
        },
      }
    };

    var chart = new ApexCharts(this.element, options);
    chart.render();

  }
}
