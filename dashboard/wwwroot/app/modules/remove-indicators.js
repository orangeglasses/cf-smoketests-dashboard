export default function removeExistingIndicators() {
    try {
        const container = document.getElementById("resultContainer");
        while (container.firstChild) {
            container.removeChild(container.lastChild);
        }
    } catch (error) {
        console.error(error);
    }
}