import trackMetrics from "./modules/track-metrics.js";

const metricsConnection = new signalR.HubConnectionBuilder().withUrl("/db-metrics").build();

trackMetrics(metricsConnection)

metricsConnection.onClosed = e => {
    console.warn('Connection closed');
};

metricsConnection.start().catch(function (err) {
    return console.error(err.toString());
});