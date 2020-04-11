export default function removeExistingIndicators() {
    const container = document.getElementById("resultContainer");
    while (container.firstChild) {
        container.removeChild(myNode.lastChild);
    }
}