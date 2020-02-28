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
    <script type="text/javaScript" language="javascript" defer="defer"></script>
    
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

/* console.log(${sampleVO.itemId}); */
 
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart); 

function drawChart() {
	var data =
		/* $.ajax({
			  url: "ajax/ListAjax.do",
			  dataType: "json",
			  async: false,
			}).done(function (jsonData) {
			  var data = new google.visualization.DataTable();
			  data.addColumn('string', 'itemId');
			  data.addColumn('number', 'volume');

			  jsonData.forEach(function (row) {
			    data.addRow([
			      row.itemId,
			      row.volume
			    ]);
			  });

			  var chart = new google.visualization.LineChart(document.getElementById('chartDiv'));
			  chart.draw(data, {
			    width: 400,
			    height: 240
			  });
			}).fail(function (jq, text, err) {
			  console.log(text + ' - ' + err);
			}); */
		
		
	$.ajax({
        url: "ajax/ListAjax.do",
        data: {"itemId":"${sampleVO.itemId}"},
        /* type: "post",  */
        dataType: "json",
        async: false,
        success:function(data) {
        	/* alert(data+"에이작승이이이이잉"); */
        	
        	 var data = new google.visualization.DataTable();
        	 	/* data.addColumn('number', 'itemId'),
        	 	data.addColumn('number', 'volume')
        	 
        	 	data.addRows([
        	 		[028300, 80], [5622, 120],
        	 		[8789, 12], [632, 213]
        	 		
        	 		]); */ 
        	 	
        	 	
        	 	data.addColumn('string', '볼륨'),
        	 	data.addColumn('number', 'volume')
        	 
        	 	data.addRows([
        	 		['거래량', ${sampleVO.volume}], 
        	 		['거래량', 120],
        	 		['거래량', 900],
        	 		['거래량', 213]
        	 		
        	 		]);
        	 	
        	 	
			var options = {
				title: '주식차트',
				curveType: 'function',
				legend: { position: 'bottom' }
				};
			var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
			chart.draw(data, options); 
        	 console.log(data);
        },
        
        	
	});
        error: function a(e){
        	console.log(e);
        }};
        
        /* var control = new google.visualization.ControlWrapper({
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
          }); */
	
        
	/* var data = new google.visualization.DataTable(data);*/
	
	/* var options = {
			title: '주식차트',
			curveType: 'function',
			legend: { position: 'bottom' }
			};
	var chart = new google.visualization.DataTable(data); */
	/* var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
			chart.draw(data, options); */
		 
	

   /* $(document).ready(function(){
	//drawChart(); 
	google.charts.load('current', {'packages':['line','controls']});
  	chartDrowFun.chartDrow(); //chartDrow() 실행 
});  */
</script>

</html>