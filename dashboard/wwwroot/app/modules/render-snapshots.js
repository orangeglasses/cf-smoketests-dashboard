import clearNodes from "./clear-nodes.js";

export default function renderSnapshots(snapshots) {
    snapshots.forEach((s,i) => {
        renderSingleSnapshot(s,i);
    });
}

function renderSingleSnapshot(snapShot, index) {
    const column = document.getElementById(`nodeSnapshot${index}`);
    clearNodes(column);

    snapShot.forEach(n => {
        const node = document.createElement("div");
        node.classList.add("single-node-stat");

        const name = document.createElement("div");
        name.innerText = `🧱 ${n.node}`;
        node.appendChild(name);

        const fps = document.createElement("div");
        fps.innerText = `${n.fpsValue} 🎦`;
        node.appendChild(fps);

        column.appendChild(node);
    });
}