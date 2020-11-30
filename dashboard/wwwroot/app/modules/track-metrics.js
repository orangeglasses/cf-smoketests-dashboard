import renderNodeNames from "./render-node-names.js";
import renderSnapshots from "./render-snapshots.js";

let tracking = false;
let snapshots = [];

export default function trackMetrics(connection) {
    if (tracking) {
        console.log("Already tracking metrics!");
        return;
    }

    connection.on('updateCounters', parseMetrics);
    tracking = true;
}

function parseMetrics(metrics) {
    snapshots.unshift(metrics); // Push in new data
    
    if(snapshots.length > 4) {
        snapshots.pop(); // Drop the oldest item.
    }
    
    console.log(snapshots);


    renderNodeNames(metrics);
    renderSnapshots(snapshots);
}