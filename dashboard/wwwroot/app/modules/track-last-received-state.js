const diffText = document.getElementById("lastReceivedDiff");
let tracking = false;

export default function trackDataLastReceivedDate(smokeTestConnection) {
    if (tracking) {
        console.log("Already tracking last data received time!");
        return;
    }

    smokeTestConnection.on('updateLastReceived', updateLastReceivedInfo);
    tracking = true;
}

function updateLastReceivedInfo(timeInfo) {
    diffText.innerText = `Last received data ${timeInfo.diffText || '0 seconds'} ago`;

    const status = timeInfo.status;
    diffText.classList.remove("color-warn", "color-critical", "color-ok", "wooping");

    if (status > 50) {
        diffText.classList.add("color-warn");
    } else if (status > 75) {
        diffText.classList.add("color-critical", "wooping");
    } else {
        diffText.classList.add("color-ok");
    }
}