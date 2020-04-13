import trackDataLastReceivedDate from "./modules/track-last-received-state.js";
import trackTestResults from "./modules/track-testresults.js";

const smokeConnection = new signalR.HubConnectionBuilder().withUrl("/smoke").build();

trackDataLastReceivedDate(smokeConnection);
trackTestResults(smokeConnection)

smokeConnection.onClosed = e => {
    console.warn('Connection closed');
};

smokeConnection.start().catch(function (err) {
    return console.error(err.toString());
});