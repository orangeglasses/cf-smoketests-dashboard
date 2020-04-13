import generateResultText from "./generate-result-text.js";

const resultContainer = document.getElementById("resultContainer");

export default function createTestResultIndicator(test, indicatorId) {
    const indicator = createIndicator(test, indicatorId);

    if (test.results) {
        const details = createResultDetails(test.results);
        indicator.appendChild(details);
    }

    resultContainer.appendChild(indicator);
}

function createIndicator(test, id) {
    const indicator = document.createElement("div");

    indicator.id = id;
    indicator.classList.add("bd", "default-bg", "padded", "ft-normal", "rounded");

    if (test.result) {
        indicator.classList.add("bd-ok")
    } else {
        indicator.classList.add("bd-fail", "wooping");
    }

    const title = document.createElement("h1");
    title.classList.add("ft-big");
    title.innerText = generateResultText(test.result, test.name);

    indicator.appendChild(title);

    return indicator;
}

function createResultDetails(results) {
    const details = document.createElement("ul");

    results.forEach(r => {
        const d = document.createElement("li");
        d.innerText = generateResultText(r.result, r.name);
        details.appendChild(d);
    });

    return details;
}