export default function removeExistingIndicator(indicatorElement) {
    if (indicatorElement) {
        document.getElementById("resultContainer").removeChild(indicator);
    } else {
        console.warn("Tried to remove an indicator that doesn't exist!");
    }
}