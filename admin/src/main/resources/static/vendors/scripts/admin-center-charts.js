// /vendors/scripts/admin-center-charts.js

window.addEventListener("load", function () {
    if (!window.ApexCharts) {
        console.error("ApexCharts not loaded");
        return;
    }

    var palette = ['#6366f1', '#f97373', '#10b981', '#fbbf24', '#ec4899', '#0ea5e9'];

    // ============== 1) 일별 방문 & 채팅 생성 추이 ==============
    (function renderAdminTrafficChart() {
        var el = document.querySelector("#admin-traffic-chart");
        if (!el) return;

        try {
            var options = {
                series: [
                    {
                        name: "일일 방문자 수",
                        type: "area",
                        data: [120, 145, 132, 158, 176, 210, 195]
                    },
                    {
                        name: "채팅방 생성 수",
                        type: "line",
                        data: [5, 7, 6, 9, 11, 13, 8]
                    }
                ],
                chart: {
                    height: 300,
                    type: "line",
                    toolbar: { show: false },
                    zoom: { enabled: false }
                },
                stroke: {
                    curve: "smooth",
                    width: [3, 3]
                },
                colors: [palette[0], palette[2]],
                fill: {
                    type: ["gradient", "solid"],
                    gradient: {
                        shadeIntensity: 0.9,
                        opacityFrom: 0.55,
                        opacityTo: 0.05,
                        stops: [0, 80, 100]
                    }
                },
                dataLabels: { enabled: false },
                grid: {
                    borderColor: "#e5e7eb",
                    strokeDashArray: 4
                },
                xaxis: {
                    categories: ["월", "화", "수", "목", "금", "토", "일"],
                    axisBorder: { show: false },
                    axisTicks:  { show: false },
                    labels: {
                        style: { colors: "#6b7280", fontSize: "11px" }
                    }
                },
                yaxis: [
                    {
                        title: { text: "방문자 수", style: { color: "#4b5563" } },
                        labels: {
                            style: { colors: "#6b7280", fontSize: "11px" }
                        },
                        min: 0
                    },
                    {
                        opposite: true,
                        title: { text: "채팅방 생성 수", style: { color: "#4b5563" } },
                        labels: {
                            style: { colors: "#6b7280", fontSize: "11px" }
                        },
                        min: 0
                    }
                ],
                legend: {
                    position: "top",
                    horizontalAlign: "left",
                    fontSize: "11px",
                    labels: { colors: "#374151" },
                    markers: { radius: 10 }
                },
                tooltip: {
                    shared: true,
                    intersect: false,
                    y: {
                        formatter: function (val, opts) {
                            var idx = opts.seriesIndex;
                            return idx === 0 ? val + " 명" : val + " 개";
                        }
                    }
                }
            };

            var chart = new ApexCharts(el, options);
            chart.render();
        } catch (e) {
            console.error("admin-traffic-chart error:", e);
        }
    })();


    // ============== 2) 회원 역할 비율 도넛 ==============
    (function renderRolePieChart() {
        var el = document.querySelector("#role-pie-chart");
        if (!el) return;

        try {
            var total = 430 + 610 + 120 + 12;

            var options = {
                series: [430, 610, 120, 12], // GENERAL / 반려인 / 알바 / 관리자 (샘플)
                chart: {
                    height: 180,
                    type: "donut"
                },
                labels: ["일반 사용자", "반려인", "알바생", "관리자"],
                colors: ["#e5e7eb", "#f97373", "#10b981", "#fbbf24"],
                dataLabels: { enabled: false },
                legend: {
                    show: true,
                    position: "bottom",
                    labels: { colors: "#e5e7eb" },
                    fontSize: "11px"
                },
                stroke: { width: 0 },
                plotOptions: {
                    pie: {
                        donut: {
                            size: "70%",
                            labels: {
                                show: true,
                                name: {
                                    show: true,
                                    offsetY: 10,
                                    color: "#e5e7eb",
                                    fontSize: "11px"
                                },
                                value: {
                                    show: true,
                                    offsetY: -10,
                                    color: "#ffffff",
                                    fontSize: "18px",
                                    formatter: function (val) {
                                        return val + "명";
                                    }
                                },
                                total: {
                                    show: true,
                                    label: "총 회원",
                                    color: "#cbd5f5",
                                    fontSize: "11px",
                                    formatter: function () {
                                        return total + "명";
                                    }
                                }
                            }
                        }
                    }
                },
                tooltip: {
                    y: {
                        formatter: function (val) {
                            return val + "명";
                        }
                    }
                }
            };

            var chart = new ApexCharts(el, options);
            chart.render();
        } catch (e) {
            console.error("role-pie-chart error:", e);
        }
    })();


    // ============== 3) 반려동물 타입 분포 막대 ==============
    (function renderPetTypeChart() {
        var el = document.querySelector("#pet-type-chart");
        if (!el) return;

        try {
            var options = {
                series: [{
                    name: "등록 수",
                    data: [480, 210, 42] // 개, 고양이, 기타 (샘플)
                }],
                chart: {
                    type: "bar",
                    height: 180,
                    toolbar: { show: false }
                },
                colors: ["#bfdbfe"],
                plotOptions: {
                    bar: {
                        horizontal: false,
                        columnWidth: "45%",
                        borderRadius: 6
                    }
                },
                dataLabels: { enabled: false },
                grid: {
                    borderColor: "#1d4ed8",
                    strokeDashArray: 4,
                    xaxis: { lines: { show: false } },
                    yaxis: { lines: { show: true } }
                },
                xaxis: {
                    categories: ["개", "고양이", "기타"],
                    axisBorder: { show: false },
                    axisTicks: { show: false },
                    labels: {
                        style: {
                            colors: ["#e5e7eb", "#e5e7eb", "#e5e7eb"],
                            fontSize: "11px"
                        }
                    }
                },
                yaxis: {
                    labels: {
                        style: { colors: "#e5e7eb", fontSize: "11px" }
                    },
                    min: 0
                },
                tooltip: {
                    y: {
                        formatter: function (val) {
                            return val + " 마리";
                        }
                    }
                }
            };

            var chart = new ApexCharts(el, options);
            chart.render();
        } catch (e) {
            console.error("pet-type-chart error:", e);
        }
    })();

});
