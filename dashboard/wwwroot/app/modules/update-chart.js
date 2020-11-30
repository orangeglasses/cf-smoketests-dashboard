
export default function updateChart(chart, metric) {
    const total = getMetricTotal(metric);
    chart.data.datasets[0].data.unshift(total);
    chart.data.labels.unshift(".");
    
    if(chart.data.datasets[0].data.length > 70) {
        chart.data.datasets[0].data.pop();
    }
    
    chart.update();
}

function getMetricTotal(metric) {
    let total = 0;
    metric.forEach(n => total+=n.fpsValue);

    return total;
}