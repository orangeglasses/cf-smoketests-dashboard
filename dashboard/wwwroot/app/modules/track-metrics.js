import renderNodeNames from "./render-node-names.js";
import renderSnapshots from "./render-snapshots.js";
import updateChart from "./update-chart.js";

let tracking = false;
let snapshots = [];

let chart;

export default function trackMetrics(connection) {
    if (tracking) {
        console.log("Already tracking metrics!");
        return;
    }

    connection.on('updateCounters', parseMetrics);
    tracking = true;

    const chartContext = document.getElementById("fpsChart").getContext("2d");

    chart = new Chart(chartContext, {
        type: 'line',
        data: {
            datasets: [
                {
                    label: "speed",
                    borderColor: "maroon",
                    backgroundColor: "crimson",
                    pointRadius: 0,
                    data: [0]
                }
            ]
        },
        options: {
            responsive: true,
        }
    });
}

function parseMetrics(metrics) {
    snapshots.unshift(metrics); // Push in new data
    
    if(snapshots.length > 4) {
        snapshots.pop(); // Drop the oldest item.
    }
    
    renderNodeNames(metrics);
    renderSnapshots(snapshots);

    updateChart(chart, metrics);
}