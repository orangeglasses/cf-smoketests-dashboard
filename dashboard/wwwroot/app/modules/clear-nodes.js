export default function clearNodes() {
    try {
        const container = document.getElementById("resultContainer");
        while (container.firstChild) {
            container.removeChild(container.lastChild);
        }
    } catch (error) {
        console.error(error);
    }
}