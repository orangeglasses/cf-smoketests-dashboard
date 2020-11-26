import trackMetrics from "./modules/track-metrics.js";

const smokeConnection = new signalR.HubConnectionBuilder().withUrl("/metrics").build();

trackMetrics(smokeConnection)

smokeConnection.onClosed = e => {
    console.warn('Connection closed');
};

smokeConnection.start().catch(function (err) {
    return console.error(err.toString());
});