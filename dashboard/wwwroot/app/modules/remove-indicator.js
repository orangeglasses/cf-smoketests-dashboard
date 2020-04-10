export default function removeExistingIndicator(indicatorElement) {
    if (indicatorElement) {
        document.getElementById("resultContainer").removeChild(indicatorElement);
    } else {
        console.warn("Tried to remove an indicator that doesn't exist!");
    }
}