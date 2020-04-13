export default function generateResultText(isSuccess, testName) {
    return `${isSuccess ? "✔" : "❌"} ${testName}`;
}