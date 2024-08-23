// document.addEventListener('DOMContentLoaded', function() {
//   const tabs = document.querySelectorAll('.tab-page-index');
//   const sections = document.querySelectorAll('.card-section-page-index');

//   tabs.forEach(tab => {
//     tab.addEventListener('click', function() {
//       // Remove active class from all tabs
//       tabs.forEach(t => t.classList.remove('active'));

//       // Add active class to clicked tab
//       this.classList.add('active');

//       // Hide all sections
//       sections.forEach(section => section.classList.remove('active'));

//       // Show the target section
//       const target = this.getAttribute('data-target');
//       document.getElementById(target).classList.add('active');
//     });
//   });

//   // Trigger a click on the active tab to show the corresponding section
//   document.querySelector('.tab-page-index.active').click();
// });
