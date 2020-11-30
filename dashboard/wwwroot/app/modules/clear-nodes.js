export default function clearNodes(containerElement) {
    try {
        while (containerElement.firstChild) {
            containerElement.removeChild(containerElement.lastChild);
        }
    } catch (error) {
        console.error(error);
    }
}