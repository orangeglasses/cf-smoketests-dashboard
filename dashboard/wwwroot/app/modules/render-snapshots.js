import clearNodes from "./clear-nodes.js";

export default function renderSnapshots(snapshots) {
    snapshots.forEach((s,i) => {
        renderSingleSnapshot(s,i);
    });
}

function renderSingleSnapshot(snapShot, index) {
    const column = document.getElementById(`nodeSnapshot${index}`);
    clearNodes(column);
    
    var total = 0;
    snapShot.forEach(n => {
        const node = createRow(n.node, n.fpsValue);
        total = total + n.fpsValue;

        column.appendChild(node);
    });
    
    const snapshotTotal = createRow("", total);
    column.appendChild(snapshotTotal);
}

function createRow(title, value) {
    const node = document.createElement("div");
    node.classList.add("single-node-stat");

    const name = document.createElement("div");
    name.innerText = `${title}`;
    node.appendChild(name);

    const fps = document.createElement("div");
    fps.innerText = `${value}`;
    node.appendChild(fps);

    return node;
}