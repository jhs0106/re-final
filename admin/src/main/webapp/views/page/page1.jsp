<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="main-container">
<%--chat demo start--%>
  <div class="pd-ltr-20 xs-pd-20-10">
    <div class="min-height-200px">
      <div class="bg-white pd-20 card-box mb-30">
        <h4 class="h4 text-blue">Mixed Chart Demo</h4>
        <div id="chart5"></div>
      </div>
    </div>
<%--chart demo end--%>

  </div>
</div>
<script>
  document.addEventListener("DOMContentLoaded", function () {
    var el = document.querySelector("#chart5");
    if (!el) return;

    var options = {
      series: [
        { name: "매출", type: "column", data: [10, 41, 35, 51, 49, 62, 69] },
        { name: "방문자", type: "line", data: [23, 42, 35, 27, 43, 22, 17] }
      ],
      chart: {
        height: 350,
        type: "line"
      },
      stroke: {
        width: [0, 4]
      },
      dataLabels: {
        enabled: true,
        enabledOnSeries: [1]
      },
      labels: ["월", "화", "수", "목", "금", "토", "일"],
      xaxis: {
        type: "category"
      },
      yaxis: [
        {
          title: {
            text: "매출"
          }
        },
        {
          opposite: true,
          title: {
            text: "방문자"
          }
        }
      ]
    };

    var chart = new ApexCharts(el, options);
    chart.render();
  });
</script>