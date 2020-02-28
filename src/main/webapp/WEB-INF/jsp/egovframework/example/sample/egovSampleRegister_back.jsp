<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<%
  /**
  * @Class Name : egovSampleRegister.jsp
  * @Description : Sample Register 화면
  * @Modification Information
  *
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2009.02.01            최초 생성
  *
  * author 실행환경 개발팀
  * since 2009.02.01
  *
  * Copyright (C) 2009 by MOPAS  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <c:set var="registerFlag" value="${empty sampleVO.itemId ? 'create' : 'modify'}"/>
    <title>Sample <c:if test="${registerFlag == 'create'}"><spring:message code="button.create" /></c:if>
                  <c:if test="${registerFlag == 'modify'}"><spring:message code="button.modify" /></c:if>
    </title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    
    <!--For Commons Validator Client Side-->
    <%-- <script type="text/javascript" src="<c:url value='/cmmn/validator.do'/>"></script> --%>
    <validator:javascript formName="sampleVO" staticJavascript="false" xhtml="true" cdata="false"/>
    
    <script type="text/javaScript" language="javascript" defer="defer">
        
    </script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery.min.js"></script>
    <!-- google charts -->
       <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">
<%-- <form:input type="hidden" path="itemId" maxlength="30" cssClass="txt"/> --%>
<input type="hidden" name="itemId" />
<h1>샘플레지스터</h1>
${sampleVO}

<!--Div that will hold the pie chart-->
    <div id="curve_chart"></div>
    
<div id="Line_Controls_Chart">
      <!-- 라인 차트 생성할 영역 -->
          <div id="curve_chart" style="padding:0px 20px 0px 0px;"></div>
      <!-- 컨트롤바를 생성할 영역 -->
          <div id="controlsArea" style="padding:0px 20px 0px 0px;"></div>
        </div>
</body>

<script>
 
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

 
function drawChart() {
	/* console.log(${sampleVO.itemId});
	return false; */
	/* var itemId = "0"+${sampleVO.itemId}; */
	var data = 
	$.ajax({
        url: "ajax/ListAjax.do",
        data: {'itemId':${sampleVO.itemId}},
        /* data: {
        	  "cols": [
        	        {"itemId":itemId, "volume":volume}
        	      ],
        	  "rows": [
        	        {"c":{"v":"${sampleVO.itemId}", "f":"${sampleVO.volume}"}
        	        {"c":[{"v":"Onions","f":null},{"v":1,"f":null}]},
        	        {"c":[{"v":"Olives","f":null},{"v":1,"f":null}]},
        	        {"c":[{"v":"Zucchini","f":null},{"v":1,"f":null}]},
        	        {"c":[{"v":"Pepperoni","f":null},{"v":2,"f":null}]}
        	      ]
        	}, */
        type: "post",
        dataType: "json",
        async: false,
        success:function(data) {
        	alert(data+"에이작승이이이이잉");
        },
        error: function(error){
        	alert(JSON.stringify(error)+"에러");
        	alert(${sampleVO.itemId});
        }}).responseText;
	/* var data = google.visualization.arrayToDataTable([
	['date', '가격변동', '거래량'],
	['2019-01-19', 50, 120],
	['2019-01-20', 34, 90],
	['2019-01-21', 90, 45],
	['2019-01-22', 56, 45],
	['2019-01-23', 120, 24],
	
	]); */
	
	// Create our data table out of JSON data loaded from server.
     var data = new google.visualization.DataTable(data);
	/*
 // Instantiate and draw our chart, passing in some options.
    var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
    chart.draw(data, {width: 400, height: 240});
  } */
	
	 var options = {
			title: '주식차트',
			curveType: 'function',
			legend: { position: 'bottom' }
			};
			var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
			chart.draw(data, options);
			} 


 
  /* var chartDrowFun = {
 
    chartDrow : function(){
        var chartData = '';
 
        //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
        var chartDateformat     = 'yyyy년MM월dd일';
        //라인차트의 라인 수
        var chartLineCount    = 200;
        //컨트롤러 바 차트의 라인 수
        var controlLineCount    = 10;
 
 
        function drawDashboard() {
 
          var data = new google.visualization.DataTable();
          //그래프에 표시할 컬럼 추가
          data.addColumn('datetime' , '날짜');
          data.addColumn('number'   , '가격변동');
          data.addColumn('number'   , '거래량');
          data.addColumn('number'   , '전체');
 
          //그래프에 표시할 데이터
          var dataRow = [];
 
          for(var i = 0; i <= 29; i++){ //랜덤 데이터 생성
            var total   = Math.floor(Math.random() * 300) + 1;
            var man     = Math.floor(Math.random() * total) + 1;
            var woman   = total - man;
 
            dataRow = [new Date('2017', '09', i , '10'), man, woman , total];
            data.addRow(dataRow);
          }
 
 
            var chart = new google.visualization.ChartWrapper({
              chartType   : 'LineChart',
              containerId : 'lineChartArea', //라인 차트 생성할 영역
              options     : {
                              isStacked   : 'percent',
                              focusTarget : 'category',
                              height          : 500,
                              width              : '100%',
                              legend          : { position: "top", textStyle: {fontSize: 13}},
                              pointSize        : 5,
                              tooltip          : {textStyle : {fontSize:12}, showColorCode : true,trigger: 'both'},
                              hAxis              : {format: chartDateformat, gridlines:{count:chartLineCount,units: {
                                                                  years : {format: ['yyyy년']},
                                                                  months: {format: ['MM월']},
                                                                  days  : {format: ['dd일']},
                                                                  hours : {format: ['HH시']}}
                                                                },textStyle: {fontSize:12}},
                vAxis              : {minValue: 100,viewWindow:{min:0},gridlines:{count:-1},textStyle:{fontSize:12}},
                animation        : {startup: true,duration: 1000,easing: 'in' },
                annotations    : {pattern: chartDateformat,
                                textStyle: {
                                fontSize: 15,
                                bold: true,
                                italic: true,
                                color: '#871b47',
                                auraColor: '#d799ae',
                                opacity: 0.8,
                                pattern: chartDateformat
                              }
                            }
              }
            });
 
            var control = new google.visualization.ControlWrapper({
              controlType: 'ChartRangeFilter',
              containerId: 'controlsArea',  //control bar를 생성할 영역
              options: {
                  ui:{
                        chartType: 'LineChart',
                        chartOptions: {
                        chartArea: {'width': '60%','height' : 80},
                          hAxis: {'baselineColor': 'none', format: chartDateformat, textStyle: {fontSize:12},
                            gridlines:{count:controlLineCount,units: {
                                  years : {format: ['yyyy년']},
                                  months: {format: ['MM월']},
                                  days  : {format: ['dd일']},
                                  hours : {format: ['HH시']}}
                            }}
                        }
                  },
                    filterColumnIndex: 0
                }
            });
 
            var date_formatter = new google.visualization.DateFormat({ pattern: chartDateformat});
            date_formatter.format(data, 0);
 
            var dashboard = new google.visualization.Dashboard(document.getElementById('Line_Controls_Chart'));
            window.addEventListener('resize', function() { dashboard.draw(data); }, false); //화면 크기에 따라 그래프 크기 변경
            dashboard.bind([control], [chart]);
            dashboard.draw(data);
 
        }
          google.charts.setOnLoadCallback(drawDashboard);
 
      }
    }
 
$(document).ready(function(){
  google.charts.load('current', {'packages':['line','controls']});
  chartDrowFun.chartDrow(); //chartDrow() 실행
}); */
  </script>

</html>