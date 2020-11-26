const resultContainer = document.getElementById("resultContainer");

export default function createNode(metric, indicatorId) {
    var node = document.createElement("div");
    node.id = indicatorId;

    var title = document.createElement("h2");
    title.innerText = `🔬 ${metric.node}`;

    var fps = document.createElement("p");
    fps.style.paddingLeft = "37px";
    fps.innerText = `FPS: ${metric.fpsValue}`;

    node.appendChild(title);
    node.appendChild(fps);

    resultContainer.appendChild(node);
}