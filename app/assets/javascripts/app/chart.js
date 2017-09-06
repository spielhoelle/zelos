// google.charts.load('current', {
//   packages: ['corechart', 'bar']
// });
// $(document).on('turbolinks:load', function() {
//   if (document.getElementById('chart_div') !== null || document.getElementById('chart_div') !== undefined) {
//     google.charts.setOnLoadCallback(drawMaterial);
//   }
// })
//
// function drawMaterial() {
//   var settings = {
//     "async": true,
//     "crossDomain": true,
//     "url": window.location.origin + "/admin/entries?format=json",
//     "method": "GET",
//   }
//
//   $.ajax(settings).done(function(response) {
//     var data = google.visualization.arrayToDataTable(response);
//
//     var materialOptions = {
//       chart: {
//         title: 'Recent Invoices'
//       },
//       hAxis: {
//         title: 'EUR',
//         minValue: 0,
//       },
//       vAxis: {
//         title: 'Company'
//       },
//       bars: 'horizontal',
//       legend: { position: 'none' }
//     };
//     var materialChart = new google.charts.Bar(document.getElementById('chart_div'));
//     materialChart.draw(data, materialOptions);
//   });
// }
