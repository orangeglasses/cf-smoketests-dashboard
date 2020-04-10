import removeExistingIndicator from "./remove-indicator.js";
import createTestResultIndicator from "./create-indicator.js";

let tracking = false;

export default function trackTestResults(smokeTestConnection) {
    if (tracking) {
        console.log("Already tracking test results!");
        return;
    }

    smokeTestConnection.on('updateTestResults', parseResults);
    tracking = true;
}

function parseResults(tests) {
    tests.forEach(test => {
        try {
            const indicatorId = `result_${test.key}`;
            console.log(indicatorId);

            const existingIndicator = document.getElementById(indicatorId);
            if (existingIndicator) {
                removeExistingIndicator(existingIndicator);
            }

            createTestResultIndicator(test, indicatorId);
        } catch (error) {
            console.error(error);
        }
    });
}