document.addEventListener('DOMContentLoaded', () => {
    // --- Global State ---
    const state = {
        environments: [],
        testCases: [], // Master list of all possible test cases
        activeTestCases: [], // Test cases relevant to the current environment
        currentEnvId: null,
        commitData: [],
        comparisonSortOrder: 'default', // 'default', 'asc', 'desc'
        historyLimit: '15', // Default limit updated
        charts: {
            history: null,
            overallHistory: null,
            distribution: null,
        }
    };

    // --- DOM Elements ---
    const dom = {
        body: document.body,
        loader: document.getElementById('loader'),
        themeToggle: document.getElementById('theme-toggle'),
        commitLimitSelector: document.getElementById('commit-limit-selector'),
        envTabs: document.getElementById('env-tabs'),
        overview: {
            latestCommitId: document.getElementById('latest-commit-id'),
            previousCommitId: document.getElementById('previous-commit-id'),
            overallChange: document.getElementById('overall-change'),
            improvementsCount: document.getElementById('improvements-count'),
            regressionsCount: document.getElementById('regressions-count'),
            maxImprovementRatio: document.getElementById('max-improvement-ratio'),
            maxImprovementCase: document.getElementById('max-improvement-case'),
            maxRegressionRatio: document.getElementById('max-regression-ratio'),
            maxRegressionCase: document.getElementById('max-regression-case'),
        },
        comparison: {
            commitA: document.getElementById('commitA'),
            commitB: document.getElementById('commitB'),
            tableBody: document.querySelector('#comparison-table tbody'),
            sortHeader: document.getElementById('sort-by-change'),
        },
        history: {
            selector: document.getElementById('test-case-selector'),
            chartCanvas: document.getElementById('history-chart'),
        },
        newCharts: {
            overallHistoryCanvas: document.getElementById('overall-history-chart'),
            distributionCanvas: document.getElementById('change-distribution-chart'),
        }
    };

    // --- Utility Functions ---
    const showLoader = (show) => dom.loader.classList.toggle('hidden', !show);
    const fetchData = async (url) => {
        const response = await fetch(url);
        if (!response.ok) throw new Error(`Failed to fetch ${url}`);
        return response.json();
    };
    const formatPercent = (val) => {
        if (isNaN(val) || !isFinite(val)) return 'N/A';
        const sign = val > 0 ? '+' : '';
        return `${sign}${(val * 100).toFixed(2)}%`;
    };
    const formatDateTime = (isoString) => {
        const date = new Date(isoString);
        return date.toLocaleString('sv-SE'); // YYYY-MM-DD HH:MM:SS
    };
    const getLimitedCommitData = () => {
        const limit = state.historyLimit;
        if (limit === 'all') {
            return state.commitData;
        }
        const numLimit = parseInt(limit, 10);
        return state.commitData.slice(-numLimit);
    };

    // --- Core Logic ---
    async function init() {
        initTheme();
        showLoader(true);
        try {
            // Fetch master list of test cases first
            state.testCases = await fetchData('data/test-cases.json');
            state.environments = await fetchData('data/environments.json');
            
            setupEnvTabs();
            if (state.environments.length > 0) {
                await switchEnvironment(state.environments[0].id);
            }
        } catch (error) {
            console.error("Initialization failed:", error);
            alert("Error loading initial data. Check console for details.");
        } finally {
            showLoader(false);
        }
    }
    
    function initTheme() {
        const savedTheme = localStorage.getItem('theme') || 'light'; // Default to light
        if (savedTheme === 'dark') {
            dom.body.classList.remove('light-theme');
            dom.themeToggle.textContent = '☀️';
        } else {
            dom.body.classList.add('light-theme');
            dom.themeToggle.textContent = '🌙';
        }
    }

    function toggleTheme() {
        if (dom.body.classList.contains('light-theme')) {
            dom.body.classList.remove('light-theme');
            dom.themeToggle.textContent = '☀️';
            localStorage.setItem('theme', 'dark');
        } else {
            dom.body.classList.add('light-theme');
            dom.themeToggle.textContent = '🌙';
            localStorage.setItem('theme', 'light');
        }
        renderAllCharts();
    }

    function setupEnvTabs() {
        dom.envTabs.innerHTML = '';
        state.environments.forEach(env => {
            const tab = document.createElement('button');
            tab.className = 'env-tab';
            tab.textContent = env.name;
            tab.dataset.envId = env.id;
            tab.addEventListener('click', () => switchEnvironment(env.id));
            dom.envTabs.appendChild(tab);
        });
    }

    async function switchEnvironment(envId) {
        if (state.currentEnvId === envId) return;
        showLoader(true);
        state.currentEnvId = envId;

        document.querySelectorAll('.env-tab').forEach(tab => {
            tab.classList.toggle('active', tab.dataset.envId === envId);
        });

        try {
            const commitIndex = await fetchData(`data/${envId}/index.json`);
            const commitPromises = commitIndex.map(file => fetchData(`data/${envId}/${file}`));
            state.commitData = (await Promise.all(commitPromises)).sort((a, b) => new Date(a.timestamp) - new Date(b.timestamp));
            
            // ** NEW LOGIC: Determine active test cases for this environment **
            const activeCasesSet = new Set();
            state.commitData.forEach(commit => {
                Object.keys(commit.results).forEach(testCase => {
                    activeCasesSet.add(testCase);
                });
            });
            // Filter master list to get active cases in correct order
            state.activeTestCases = state.testCases.filter(tc => activeCasesSet.has(tc));

            populateTestCaseSelector(); // Update dropdown with active cases
            populateCommitSelectors();  // Populates with ALL data for this env
            renderAll();                // Renders based on active cases and limited data
        } catch (error) {
            console.error(`Error loading data for environment ${envId}:`, error);
            alert(`Failed to load data for ${envId}.`);
        } finally {
            showLoader(false);
        }
    }
    
    function populateTestCaseSelector() {
        // Now populates from the dynamic activeTestCases list
        dom.history.selector.innerHTML = state.activeTestCases.map(tc => `<option value="${tc}">${tc}</option>`).join('');
    }

    function populateCommitSelectors() {
        const optionsHtml = state.commitData.map((data, index) =>
            `<option value="${index}">${data.commit.substring(0, 7)} (${formatDateTime(data.timestamp)}) - ${data.message}</option>`
        ).reverse().join('');
        dom.comparison.commitA.innerHTML = optionsHtml;
        dom.comparison.commitB.innerHTML = optionsHtml;

        if (state.commitData.length >= 2) {
            dom.comparison.commitA.value = state.commitData.length - 2;
            dom.comparison.commitB.value = state.commitData.length - 1;
        } else if (state.commitData.length === 1) {
            dom.comparison.commitA.value = 0;
            dom.comparison.commitB.value = 0;
        }
    }
    
    // --- Render Functions ---
    function renderAll() {
        renderOverview();
        renderComparison();
        renderAllCharts();
    }

    function renderAllCharts() {
        const isLightTheme = dom.body.classList.contains('light-theme');
        const fontColor = isLightTheme ? '#212121' : '#e0e0e0';
        const gridColor = isLightTheme ? 'rgba(0,0,0,0.1)' : 'rgba(255,255,255,0.1)';

        renderHistory(fontColor, gridColor);
        renderOverallHistory(fontColor, gridColor);
        renderChangeDistribution(fontColor, gridColor);
    }

    function renderOverview() {
        const limitedData = getLimitedCommitData();
        if (limitedData.length < 2) {
            Object.values(dom.overview).forEach(el => el.textContent = 'N/A');
            dom.overview.improvementsCount.textContent = '0 / 0';
            dom.overview.regressionsCount.textContent = '0 / 0';
            return;
        }

        const latest = limitedData[limitedData.length - 1];
        const previous = limitedData[limitedData.length - 2];
        dom.overview.latestCommitId.textContent = latest.commit.substring(0, 7);
        dom.overview.previousCommitId.textContent = previous.commit.substring(0, 7);

        let totalTimeLatest = 0, totalTimePrevious = 0;
        let improvements = 0, regressions = 0;
        let maxImprovement = { ratio: 1, name: 'N/A' };
        let maxRegression = { ratio: 1, name: 'N/A' };
        
        // Use activeTestCases for calculation
        state.activeTestCases.forEach(tc => {
            const timeA = previous.results[tc];
            const timeB = latest.results[tc];
            if (timeA > 0 && timeB > 0) {
                totalTimePrevious += timeA;
                totalTimeLatest += timeB;
                const ratio = timeB / timeA;
                if (ratio < 1) {
                    improvements++;
                    if (ratio < maxImprovement.ratio) maxImprovement = { ratio, name: tc };
                }
                if (ratio > 1) {
                    regressions++;
                    if (ratio > maxRegression.ratio) maxRegression = { ratio, name: tc };
                }
            }
        });
        
        const overallChange = totalTimePrevious > 0 ? (totalTimeLatest - totalTimePrevious) / totalTimePrevious : 0;
        dom.overview.overallChange.textContent = formatPercent(overallChange);
        dom.overview.overallChange.className = `metric ${overallChange > 0 ? 'negative' : 'positive'}`;
        dom.overview.improvementsCount.textContent = `${improvements} / ${state.activeTestCases.length}`;
        dom.overview.regressionsCount.textContent = `${regressions} / ${state.activeTestCases.length}`;

        dom.overview.maxImprovementRatio.textContent = maxImprovement.ratio < 1 ? `x${(1 / maxImprovement.ratio).toFixed(2)}` : 'N/A';
        dom.overview.maxImprovementCase.textContent = maxImprovement.name;
        dom.overview.maxRegressionRatio.textContent = maxRegression.ratio > 1 ? `x${maxRegression.ratio.toFixed(2)}` : 'N/A';
        dom.overview.maxRegressionCase.textContent = maxRegression.name;
    }

    function renderComparison() {
        const indexA = parseInt(dom.comparison.commitA.value, 10);
        const indexB = parseInt(dom.comparison.commitB.value, 10);
        if (isNaN(indexA) || isNaN(indexB)) return;

        const commitA = state.commitData[indexA];
        const commitB = state.commitData[indexB];

        // Use activeTestCases to build the table
        let testCaseComparisons = state.activeTestCases.map(tc => {
            const timeA = commitA.results[tc];
            const timeB = commitB.results[tc];
            const diff = (timeB ?? 0) - (timeA ?? 0);
            const change = (timeA > 0) ? diff / timeA : 0;
            return { tc, timeA, timeB, diff, change };
        });

        if (state.comparisonSortOrder === 'asc') {
            testCaseComparisons.sort((a, b) => a.change - b.change);
        } else if (state.comparisonSortOrder === 'desc') {
            testCaseComparisons.sort((a, b) => b.change - a.change);
        }

        const tableRows = testCaseComparisons.map(({ tc, timeA, timeB, diff, change }) => {
            let changeClass = '';
            if (change < -0.001) changeClass = 'positive';
            if (change > 0.001) changeClass = 'negative';
            return `<tr class="${changeClass}">
                        <td>${tc}</td>
                        <td>${timeA?.toFixed(3) ?? 'N/A'}</td>
                        <td>${timeB?.toFixed(3) ?? 'N/A'}</td>
                        <td>${diff.toFixed(3)}</td>
                        <td class="${changeClass}">${formatPercent(change)}</td>
                    </tr>`;
        }).join('');

        dom.comparison.tableBody.innerHTML = tableRows;
    }
    
    // ... (rest of the JS file is unchanged, including chart rendering, event listeners etc.)
    // Only functions that iterate through test cases needed modification.
    function cycleSortOrder() {
        const orders = ['default', 'desc', 'asc'];
        const current = orders.indexOf(state.comparisonSortOrder);
        state.comparisonSortOrder = orders[(current + 1) % orders.length];
        
        let indicator = '↕';
        if (state.comparisonSortOrder === 'desc') indicator = '↓';
        if (state.comparisonSortOrder === 'asc') indicator = '↑';
        dom.comparison.sortHeader.textContent = `Change ${indicator}`;
        
        renderComparison();
    }

    function createChartConfig(chartData, fontColor, gridColor) {
        return {
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    x: { ticks: { color: fontColor }, grid: { color: gridColor } },
                    y: { ticks: { color: fontColor }, grid: { color: gridColor }, beginAtZero: false }
                },
                plugins: {
                    legend: { labels: { color: fontColor } }
                }
            },
            ...chartData
        };
    }

    function renderHistory(fontColor, gridColor) {
        const selectedTestCase = dom.history.selector.value;
        if (!selectedTestCase) return;
        
        const data = getLimitedCommitData();
        const labels = data.map(d => d.commit.substring(0, 7));
        const dataPoints = data.map(d => d.results[selectedTestCase] ?? null);

        if (state.charts.history) state.charts.history.destroy();
        
        const chartConfig = createChartConfig({
            type: 'line',
            data: {
                labels,
                datasets: [{
                    label: `Runtime (s) for ${selectedTestCase}`,
                    data: dataPoints,
                    borderColor: 'rgba(74, 144, 226, 1)',
                    backgroundColor: 'rgba(74, 144, 226, 0.2)',
                    fill: false,
                    tension: 0.1,
                    spanGaps: true,
                }]
            }
        }, fontColor, gridColor);
        
        state.charts.history = new Chart(dom.history.chartCanvas, chartConfig);
    }

    function renderOverallHistory(fontColor, gridColor) {
        if (state.charts.overallHistory) state.charts.overallHistory.destroy();

        const data = getLimitedCommitData();
        const labels = data.map(d => d.commit.substring(0, 7));
        const dataPoints = data.map(d => {
            return Object.values(d.results).reduce((sum, time) => sum + (time || 0), 0);
        });

        const chartConfig = createChartConfig({
            type: 'line',
            data: {
                labels,
                datasets: [{
                    label: 'Total Runtime of All Test Cases (s)',
                    data: dataPoints,
                    borderColor: 'rgba(214, 113, 13, 1)',
                    backgroundColor: 'rgba(214, 113, 13, 0.2)',
                    fill: false,
                    tension: 0.1,
                }]
            }
        }, fontColor, gridColor);

        state.charts.overallHistory = new Chart(dom.newCharts.overallHistoryCanvas, chartConfig);
    }

    function renderChangeDistribution(fontColor, gridColor) {
        if (state.charts.distribution) state.charts.distribution.destroy();
        
        const data = getLimitedCommitData();
        if (data.length < 2) return;

        const latest = data[data.length - 1];
        const previous = data[data.length - 2];
        const bins = {
            '<-20%': 0, '-20%..-10%': 0, '-10%..-2%': 0, '±2%': 0,
            '+2%..+10%': 0, '+10%..+20%': 0, '>+20%': 0
        };

        // Use activeTestCases for calculation
        state.activeTestCases.forEach(tc => {
            const timeA = previous.results[tc];
            const timeB = latest.results[tc];
            if (timeA > 0 && timeB > 0) {
                const change = (timeB - timeA) / timeA;
                if (change < -0.2) bins['<-20%']++;
                else if (change < -0.1) bins['-20%..-10%']++;
                else if (change < -0.02) bins['-10%..-2%']++;
                else if (change <= 0.02) bins['±2%']++;
                else if (change <= 0.1) bins['+2%..+10%']++;
                else if (change <= 0.2) bins['+10%..+20%']++;
                else bins['>+20%']++;
            }
        });

        const chartConfig = createChartConfig({
            type: 'bar',
            data: {
                labels: Object.keys(bins),
                datasets: [{
                    label: 'Number of Test Cases',
                    data: Object.values(bins),
                    backgroundColor: [
                        '#2e7d32', '#4caf50', '#81c784', '#cccccc',
                        '#ffb74d', '#ff9800', '#f57c00'
                    ]
                }]
            }
        }, fontColor, gridColor);
        
        chartConfig.options.plugins.legend.display = false;
        chartConfig.options.scales.y.beginAtZero = true;
        state.charts.distribution = new Chart(dom.newCharts.distributionCanvas, chartConfig);
    }
    
    // --- Event Listeners ---
    dom.themeToggle.addEventListener('click', toggleTheme);
    dom.commitLimitSelector.addEventListener('change', (e) => {
        state.historyLimit = e.target.value;
        renderAll();
    });
    dom.comparison.commitA.addEventListener('change', renderComparison);
    dom.comparison.commitB.addEventListener('change', renderComparison);
    dom.comparison.sortHeader.addEventListener('click', cycleSortOrder);
    dom.history.selector.addEventListener('change', () => {
        const isLightTheme = dom.body.classList.contains('light-theme');
        const fontColor = isLightTheme ? '#212121' : '#e0e0e0';
        const gridColor = isLightTheme ? 'rgba(0,0,0,0.1)' : 'rgba(255,255,255,0.1)';
        renderHistory(fontColor, gridColor);
    });

    // --- Start the application ---
    init();
});