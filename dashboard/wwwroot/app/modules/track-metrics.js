import clearNodes from "./clear-nodes.js";
import createNode from "./create-node.js";

let tracking = false;

export default function trackMetrics(smokeTestConnection) {
    if (tracking) {
        console.log("Already tracking metrics!");
        return;
    }

    smokeTestConnection.on('updateCounters', parseMetrics);
    tracking = true;
}

function parseMetrics(metrics) {
    clearNodes();

    metrics.forEach(m => {
        try {
            const nodeId = `node_${m.node}`;
            createNode(m, nodeId);
        } catch (error) {
            console.error(error);
        }
    });
}