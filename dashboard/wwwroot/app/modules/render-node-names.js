import clearNodes from "./clear-nodes.js";

export default function renderNodeNames(metrics) {
    const nodeList = document.getElementById("nodeList");
    clearNodes(nodeList);

    metrics.forEach(m => {
        const node = document.createElement("div");
        node.innerText = `🧱 ${m.node}`;

        nodeList.appendChild(node);
    });
}