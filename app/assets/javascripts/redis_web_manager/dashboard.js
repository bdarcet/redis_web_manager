$(document).ready(function () {
    const memory = document.getElementById('memory');
    if (memory) {
        const dataset = memory.dataset['canvas'];
        if (dataset) {
            const data = JSON.parse(dataset);
            if (data && data.length > 0) {
                renderMemory(memory, data);
            }
        }
    }

    const cpu = document.getElementById('cpu');
    if (cpu) {
        const dataset = cpu.dataset['canvas'];
        if (dataset) {
            const data = JSON.parse(dataset);
            if (data && data.length > 0) {
                renderCpu(cpu, data);
            }
        }
    }

    const client = document.getElementById('client');
    if (client) {
        const dataset = client.dataset['canvas'];
        if (dataset) {
            const data = JSON.parse(dataset);
            if (data && data.length > 0) {
                renderClient(client, data);
            }
        }
    }

    function renderMemory(node, data) {
        const labels = data.map(d => parseDate(d['date']));
        const memories = data.map(d => d['memory']);
        const used_memory = memories.map(c => parseFloat(c['used_memory']));
        const used_memory_rss = memories.map(c => parseFloat(c['used_memory_rss']));
        const used_memory_peak = memories.map(c => parseFloat(c['used_memory_peak']));
        const used_memory_overhead = memories.map(c => parseFloat(c['used_memory_overhead']));
        const used_memory_startup = memories.map(c => parseFloat(c['used_memory_startup']));
        const used_memory_dataset = memories.map(c => parseFloat(c['used_memory_dataset']));
        return new Chart(node.getContext('2d'), {
            type: 'line',
            responsive: true,
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'Used memory',
                        data: used_memory,
                        borderWidth: 2,
                        borderColor: '#3e95cd',
                        fill: false
                    },
                    {
                        label: 'Used memory rss',
                        data: used_memory_rss,
                        borderWidth: 2,
                        borderColor: '#8e5ea2',
                        fill: false
                    },
                    {
                        label: 'Used memory peak',
                        data: used_memory_peak,
                        borderWidth: 2,
                        borderColor: '#3cba9f',
                        fill: false
                    },
                    {
                        label: 'Used memory overhead',
                        data: used_memory_overhead,
                        borderWidth: 2,
                        borderColor: '#4bc0c0',
                        fill: false
                    },
                    {
                        label: 'Used memory overhead',
                        data: used_memory_startup,
                        borderWidth: 2,
                        borderColor: '#e8c3b9',
                        fill: false
                    },
                    {
                        label: 'Used memory overhead',
                        data: used_memory_dataset,
                        borderWidth: 2,
                        borderColor: '#8e5ea2',
                        fill: false
                    }
                ]
            },
            options: {
                legend: {
                    position: 'bottom'
                },
                scales: {
                    yAxes: [
                        {
                            ticks: {
                                callback: function (value) {
                                    return humanSize(value);
                                }
                            }
                        }
                    ]
                },
                tooltips: {
                    callbacks: {
                        label: function (props) {
                            return humanSize(props['value']);
                        }
                    }
                }
            }
        });
    }

    function renderCpu(node, data) {
        const labels = data.map(d => parseDate(d['date']));
        const cpus = data.map(d => d['cpu']);
        const used_cpu_sys = cpus.map(c => parseFloat(c['used_cpu_sys']));
        const used_cpu_user = cpus.map(c => parseFloat(c['used_cpu_user']));
        const used_cpu_sys_children = cpus.map(c => parseFloat(c['used_cpu_sys_children']));
        const used_cpu_user_children = cpus.map(c => parseFloat(c['used_cpu_user_children']));
        return new Chart(node.getContext('2d'), {
            type: 'line',
            responsive: true,
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'Used cpu sys',
                        data: used_cpu_sys,
                        borderWidth: 2,
                        borderColor: '#3e95cd',
                        fill: false
                    },
                    {
                        label: 'Used cpu user',
                        data: used_cpu_user,
                        borderWidth: 2,
                        borderColor: '#8e5ea2',
                        fill: false
                    },
                    {
                        label: 'Used cpu sys children',
                        data: used_cpu_sys_children,
                        borderWidth: 2,
                        borderColor: '#3cba9f',
                        fill: false
                    },
                    {
                        label: 'Used cpu user children',
                        data: used_cpu_user_children,
                        borderWidth: 2,
                        borderColor: '#c45850',
                        fill: false
                    }
                ]
            },
            options: {
                legend: {
                    position: 'bottom'
                },
                scales: {
                    yAxes: [
                        {
                            ticks: {
                                callback: function (value) {
                                    return humanSecond(parseInt(value, 10));
                                }
                            }
                        }
                    ]
                },
                tooltips: {
                    callbacks: {
                        label: function (props) {
                            return humanSecond(parseInt(props['value'], 10));
                        }
                    }
                }
            }
        });
    }

    function renderClient(node, data) {
        const labels = data.map(d => parseDate(d['date']));
        const clients = data.map(d => d['client']);
        const connected_clients = clients.map(c => parseInt(c['connected_clients'], 10));
        const blocked_clients = clients.map(c => parseInt(c['blocked_clients'], 10));
        return new Chart(node.getContext('2d'), {
            type: 'line',
            responsive: true,
            data: {
                labels: labels,
                datasets: [
                    {
                        label: 'Connected clients',
                        data: connected_clients,
                        borderWidth: 2,
                        borderColor: '#3e95cd',
                        fill: false
                    },
                    {
                        label: 'Blocked clients',
                        data: blocked_clients,
                        borderWidth: 2,
                        borderColor: '#8e5ea2',
                        fill: false
                    }
                ]
            },
            options: {
                legend: {
                    position: 'bottom'
                }
            }
        });
    }

    function parseDate(value) {
        return new Date(value).toDateString();
    }

    function humanSize(size) {
        if (size < 1024) {
            return size + ' B';
        }
        const i = Math.floor(Math.log(size) / Math.log(1024));
        const num = (size / Math.pow(1024, i));
        const round = Math.round(num);
        const value = round < 10 ? num.toFixed(2) : round < 100 ? num.toFixed(1) : round;
        return `${value} ${'KMGTPEZY'[i - 1]}B`
    }

    function humanSecond(value) {
        //FIXME bug graph
        const date = new Date(null);
        date.setSeconds(value);
        return date.toDateString();
    }
});