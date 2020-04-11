import removeExistingIndicators from "./remove-indicators.js";
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
    removeExistingIndicators();

    tests.forEach(test => {
        try {
            const indicatorId = `result_${test.key}`;
            createTestResultIndicator(test, indicatorId);
        } catch (error) {
            console.error(error);
        }
    });
}