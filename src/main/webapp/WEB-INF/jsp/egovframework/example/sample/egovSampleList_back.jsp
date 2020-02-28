<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="ui"     uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
  /**
  * @Class Name : egovSampleList.jsp
  * @Description : Sample List 화면
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
    <title><spring:message code="title.sample.stock" /></title>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/sample.css'/>"/>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>
	<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
	
	<!-- jQuery -->
    <!-- <script src="https://code.jquery.com/jquery.min.js"></script> -->
    <!-- google charts -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    
    <script type="text/javaScript" language="javascript" defer="defer">
        <!--
        /* 글 수정 화면 function */
        function fn_egov_select(itemId,dealDate) {
        	var userId = $("#userId").val();
        	alert("아이디"+itemId);
        	alert("날짜"+dealDate);
        	callAjax(itemId,dealDate);
        	console.log("아이디",itemId);
        	document.listForm.selectedId.value = itemId;
            /* document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit(); */
        }
        
        /* 글 등록 화면 function */
        function fn_egov_addView() {
           	document.listForm.action = "<c:url value='/addSample.do'/>";
           	document.listForm.submit();
        }
        
        /* 글 목록 화면 function */
        function fn_egov_selectList() {
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit();
        }
        
        /* pagination 페이지 링크 function */
        function fn_egov_link_page(pageNo){
        	document.listForm.pageIndex.value = pageNo;
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit();
        }
        
        /*콤마처리*/
        function inputNumberWithComma(str) {
            str = String(str);
            return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, "$1,");
        }
        //-->
        
        $(function() {
    $( "#testDatepicker" ).datepicker({
    	dateFormat: "yymmdd"
            ,defaultDate:'20200131'
            
    });
});
    </script>
</head>

<body style="text-align:center; margin:0 auto; display:inline; padding-top:100px;">

    <form:form commandName="searchVO" id="listForm" name="listForm" method="post">
        <input type="hidden" name="selectedId" />
        <div id="content_pop">
        	<!-- 타이틀 -->
        	<div id="title">
        		<ul>
        			<li><img src="<c:url value='/images/egovframework/example/title_dot.gif'/>" alt=""/><spring:message code="title.sample.stock" /></li>
        		</ul>
        	</div>
        	
        	<!-- // 타이틀 -->
        	<div id="search">
        		거래일<form:input path="searchRegDate" cssClass="txt" id="testDatepicker"/>
        		종목코드/명<form:input path="searchCode" cssClass="txt"/>
        		<ul>
        			<li>
	      	            <span class="btn_blue_l">
	      	                <a href="javascript:fn_egov_selectList();"><spring:message code="button.search" /></a>
	      	                <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
	      	            </span>
      	            </li>
      	        </ul>
        		<!--  <input type="text" id="testDatepicker"> -->
        		
        		
        		<%-- <ul>
        			<li>
        			    <label for="searchCondition" style="visibility:hidden;"><spring:message code="search.choose" /></label>
        				<form:select path="searchCondition" cssClass="use">
        					<form:option value="1" label="Name" />
        					<form:option value="0" label="ID" />
        				</form:select>
        			</li>
        			<li><label for="searchKeyword" style="visibility:hidden;display:none;"><spring:message code="search.keyword" /></label>
                        <form:input path="searchKeyword" cssClass="txt"/>
                    </li>
        			<li>
        	            <span class="btn_blue_l">
        	                <a href="javascript:fn_egov_selectList();"><spring:message code="button.search" /></a>
        	                <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
        	            </span>
        	        </li>
                </ul> --%>
        	</div>
        	<br>총 <c:out value="${totCnt}"/> 건
        	<!-- List -->
        	<div id="table">
        		<table width="100%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
        			<caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
        			<colgroup>
        				<col width="40"/>
        				<col width="100"/>
        				<col width="150"/>
        				<col width="80"/>
        				<col width="?"/>
        				<col width="60"/>
        			</colgroup>
        			<tr>
        				<!-- <th align="center">No</th> -->
        				<th align="center"><spring:message code="title.sample.item_id" /></th>
        				<th align="center"><spring:message code="title.sample.item_name" /></th>
        				<th align="center"><spring:message code="title.sample.price_open" /></th>
        				<th align="center"><spring:message code="title.sample.price_high" /></th>
        				<th align="center"><spring:message code="title.sample.price_low" /></th>
        				<th align="center"><spring:message code="title.sample.price_close" /></th>
        				<th align="center"><spring:message code="title.sample.price_yester" /></th>
        				<th align="center"><spring:message code="title.sample.price_updown" /></th>
        				<th align="center"><spring:message code="title.sample.volume" /></th>
        			</tr>
        			<c:forEach var="result" items="${resultList}" varStatus="status">
            			<tr>
            				<%-- <td align="center" class="listtd"><c:out value="${paginationInfo.totalRecordCount+1 - ((searchVO.pageIndex-1) * searchVO.pageSize + status.count)}"/></td> --%>
            				<td align="center" class="listtd" ><a href="javascript:fn_egov_select('<c:out value="${result.itemId}"/>','<c:out value="${result.dealDate}"/>')" id="userId"><c:out value="${result.itemId}" /></a></td>
            				<td align="left" class="listtd"><c:out value="${result.itemName}" />&nbsp;</td>
            				<td align="center" class="listtd" ><c:out value="${result.priceOpen}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.priceHigh}"/>&nbsp;</td>
            				<td align="center" class="listtd" ><c:out value="${result.priceLow}"/>&nbsp;</td>
            				<td align="center" class="listtd"><c:out value="${result.priceClose}"/>&nbsp;</td>
            				<c:if test="${result.PD > 0}">
            					<td align="center" class="listtd" style="color:red;">▲<c:out value="${result.PD}"/>&nbsp;</td>
            				</c:if>
            				<c:if test="${result.PD < 0}">
            					<td align="center" class="listtd" style="color:blue;">▼<c:out value="${result.PD}"/>&nbsp;</td>
            				</c:if>
            				<c:if test="${result.PD == 0}">
            					<td align="center" class="listtd"><c:out value="${result.PD}"/>&nbsp;</td>
            				</c:if>
            				<c:if test="${result.FR > 0}">
            					<td align="center" class="listtd" style="color:red;"><c:out value="${result.FR}"/>&nbsp;</td>
            				</c:if>
            				<c:if test="${result.FR < 0}">
            					<td align="center" class="listtd" style="color:blue;"><c:out value="${result.FR}"/>&nbsp;</td>
            				</c:if>
            				<c:if test="${result.FR == 0}">
            					<td align="center" class="listtd"><c:out value="0"/>&nbsp;</td>
            				</c:if>
            				<td align="center" class="listtd"><c:out value="${result.volume}"/>&nbsp;</td>
            			</tr>
        			</c:forEach>
        		</table>
        	</div>
        	<!-- /List -->
        	<div id="paging">
        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        		<form:hidden path="pageIndex" />
        	</div>
        	
        	<h4>주식 그래프</h4>
 
	    	<div id="Line_Controls_Chart">
	      <!-- 라인 차트 생성할 영역 -->
	          <div id="lineChartArea" style="padding:0px 20px 0px 0px;"></div>
	      <!-- 컨트롤바를 생성할 영역 -->
	          <div id="controlsArea" style="padding:0px 20px 0px 0px;"></div>
	      <!-- 막대그래프를 생성할 영역 -->
	          <div id="chart_div" style="width: 900px; height: 500px;"></div>
	          
	        </div>
        </div>
    </form:form>
 
  </body>
 
  <script>
  function callAjax(itemId,dealDate){
	  $.ajax({
          url: "ajax/ListAjax.do",
          data: {"itemId":itemId, "dealDate":dealDate},
          /* data: {"itemId":'${data.itemId}', "dealDate":'${data.dealDate}'}, */
          /* type: "post",  */
          dataType: "json",
          async: false,
          success:function(data) {
          	alert(data+"에이작승이이이이잉");
          	/* alert(id); */
          	initChart(data);
          	
          },
          error: function a(e){
          	console.log(e);
      }});
  }
  
  
  function initChart(obj){
	  
	  console.log("obj ==> ", obj);
	  /* obj.data[0].volume */
	  var chartDrowFun = {
			  
			    chartDrow : function(){
			        var chartData = '';
			 
			        //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
			        var chartDateformat     = 'yyyy년MM월dd일';
			        //라인차트의 라인 수
			        var chartLineCount    = 10;
			        //컨트롤러 바 차트의 라인 수
			        var controlLineCount    = 10;
			 
			 
			        function drawDashboard() {
			        	
			                
			          var data = new google.visualization.DataTable();
			          //그래프에 표시할 컬럼 추가
			          data.addColumn('datetime' , '날짜');
			          data.addColumn('number'   , '종가'); 
			           /* data.addColumn('number'   , '거래량'); */
			          data.addColumn('number'   , '가격이동평균5');
			          data.addColumn('number'   , '가격이동평균10');
			          data.addColumn('number'   , '가격이동평균20');
			          data.addColumn('number'   , '가격이동평균60');
			          data.addColumn('number'   , '가격이동평균120');
			          /*data.addColumn('number'   , '거래량이동평균60');  */
			          /* data.addColumn('number'   , '전체'); */
			 		
			          //그래프에 표시할 데이터
			          var dataRow = [];
			 	
			          //랜덤 데이터 생성
			        for(var i = 0; i <= 60; i++){
			            var priceClose     = obj.data[i].priceClose;
			            var priceAvg5     = obj.data[i].priceAvg5;
			            var priceAvg10     = obj.data[i].priceAvg10;
			            var priceAvg20     = obj.data[i].priceAvg20;
			            var priceAvg60     = obj.data[i].priceAvg60;
			            var priceAvg120     = obj.data[i].priceAvg120;
			            var year	= obj.data[i].year;
			            var month	= obj.data[i].month;
			            var day		= obj.data[i].day;
			 
			            /* dataRow = [date, man, woman ];
			            data.addRow(dataRow); */
			            
			            dataRow = [new Date(year, month, day),priceClose,priceAvg5,priceAvg10,priceAvg20,priceAvg60,priceAvg120];
			            data.addRow(dataRow);
			        	  }
			         
			console.log(data);
			
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
			            
			            //막대
			            
			            function drawVisualization() {
			            	  // Some raw data (not necessarily accurate)
			            	  var data = google.visualization.arrayToDataTable([
			            	    ['Month', 'Bolivia', 'Ecuador', 'Madagascar', 'Papua New Guinea', 'Rwanda', 'Average'],
			            	    ['2004/05',  165,      938,         522,             998,           450,      614.6],
			            	    ['2005/06',  135,      1120,        599,             1268,          288,      682],
			            	    ['2006/07',  157,      1167,        587,             807,           397,      623],
			            	    ['2007/08',  139,      1110,        615,             968,           215,      609.4],
			            	    ['2008/09',  136,      691,         629,             1026,          366,      569.6]
			            	  ]);

			            	  var options = {
			            	    title : 'Monthly Coffee Production by Country',
			            	    vAxis: {title: 'Cups'},
			            	    hAxis: {title: 'Month'},
			            	    seriesType: 'bars',
			            	    series: {5: {type: 'line'}}        
			            	    };

			            	  var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
			            	  
			            	  chart.draw(data, options);
			            
			            
				            
				            
			        }
			          google.charts.setOnLoadCallback(drawDashboard);
			          google.charts.setOnLoadCallback(drawVisualization);
			 
			      }
			    
	  
	    google.charts.load('current', {'packages':['line','controls', 'corechart']});
 	    chartDrowFun.chartDrow(); //chartDrow() 실행
  }
	  
  
  
  
var id = '';
id = '${itemId}';


$(document).ready(function(){
	if(id){
		callAjax();	
	}
});

/* //막대
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawVisualization);

function drawVisualization() {
  // Some raw data (not necessarily accurate)
  var data = google.visualization.arrayToDataTable([
    ['Month', 'Bolivia', 'Ecuador', 'Madagascar', 'Papua New Guinea', 'Rwanda', 'Average'],
    ['2004/05',  165,      938,         522,             998,           450,      614.6],
    ['2005/06',  135,      1120,        599,             1268,          288,      682],
    ['2006/07',  157,      1167,        587,             807,           397,      623],
    ['2007/08',  139,      1110,        615,             968,           215,      609.4],
    ['2008/09',  136,      691,         629,             1026,          366,      569.6]
  ]);

  var options = {
    title : 'Monthly Coffee Production by Country',
    vAxis: {title: 'Cups'},
    hAxis: {title: 'Month'},
    seriesType: 'bars',
    series: {5: {type: 'line'}}        };

  var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
  
  chart.draw(data, options);
} */

  </script>
  
  function drawVisualization(){
		  var salesArray = [];
          
          for(var i = 100; i <= 10; i++){
	            var volume     = obj.data[i].volume;
	            var volumeAvg5     = obj.data[i].volumeAvg5;
	            var volumeAvg20     = obj.data[i].volumeAvg20;
	            var volumeAvg60     = obj.data[i].volumeAvg60;
	            var volumeAvg120     = obj.data[i].volumeAvg120;
	            var year	= obj.data[i].year;
	            var month	= obj.data[i].month;
	            var day		= obj.data[i].day;
          
          salesArray.push(['Year', '거래량', '거래량이동평균5', '거래량이동평균20', '거래량이동평균60', '거래량이동평균120']);
          salesArray.push([
	              new Date(year, month, day),volume,volumeAvg5,volumeAvg20,volumeAvg60,volumeAvg120]);
          	//data.addRow(salesArray);
          }
          
          var data = google.visualization.arrayToDataTable(salesArray);
      	  
      	  var options = {
      	    title : '주식',
      	    /* vAxis: {title: 'Cups'},
      	    hAxis: {title: 'Month'}, */
      	    hAxis              : {format: chartDateformat, gridlines:{count:chartLineCount,units: {
                  years : {format: ['yyyy년']},
                  months: {format: ['MM월']},
                  days  : {format: ['dd일']},
                  hours : {format: ['HH시']}}
                },textStyle: {fontSize:12}},
              vAxis              : {minValue: 100,viewWindow:{min:0},gridlines:{count:-1},textStyle:{fontSize:12}},
      	    seriesType: 'bars',
      	    series: {0: {type: 'line'}}        
      	    };

      	  var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
      	  
      	  //chart.draw(data, options);
      	  chart.draw(data, options);
		  
	  }
	  
	  google.charts.setOnLoadCallback(drawVisualization);
</html>
