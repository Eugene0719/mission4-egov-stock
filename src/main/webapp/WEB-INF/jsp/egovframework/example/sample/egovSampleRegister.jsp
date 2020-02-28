<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c"         uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"      uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="spring"    uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>주식차트</title>
 
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery.min.js"></script>
    <!-- google charts -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  </head>
  <body>
 
    <h4>주식 그래프</h4>
 
    <div id="Line_Controls_Chart">
      <!-- 라인 차트 생성할 영역 -->
      	라인차트
          <div id="lineChartArea" style="padding:0px 20px 0px 0px;"></div>
      <!-- 컨트롤바를 생성할 영역 -->
          <div id="controlsArea" style="padding:0px 20px 0px 0px;"></div>
          <div id="bar_chart_div" style="padding:0px 20px 0px 0px;"></div>
          
        </div>
 
  </body>
 
  <script>
 
  function callAjax(){
	  $.ajax({
          url: "ajax/ListAjax.do",
          data: {"itemId":'${data.itemId}', "dealDate":'${data.dealDate}'},
          /* type: "post",  */
          dataType: "json",
          async: false,
          success:function(data) {
          	alert(data+"에이작승이이이이잉");
          	alert(id);
          	initChart(data);
          	
          },
          error: function a(e){
          	console.log(e);
      }});
  }
  
//막대그래프
  /* function drawChart(){
   var data = google.visualization.arrayToDataTable([
  	['동물종류', '동물수'],
  	['고양이', 1],
  	['개', 2],
  	['토끼', 3],
  	['말', 4]
  ]);
  
  var chart = new google.visualiztion.BarChart(
  		document.getElementById('chart_div')
  		);
  chart.draw(data); 
  }
	
  google.charts.load('current', {'packages':['corechart']});
  google.charts.setOnLoadCallback(drawChart); */
  
  
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
			            var year	= obj.data[i].year;
			            var month	= obj.data[i].month;
			            var day		= obj.data[i].day;
			 
			            /* dataRow = [date, man, woman ];
			            data.addRow(dataRow); */
			            
			            dataRow = [new Date(year, month, day),priceClose,priceAvg5,priceAvg10,priceAvg20,priceAvg60];
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
			                vAxis              : {minValue: 100,viewWindow:{min:60000},gridlines:{count:-1},textStyle:{fontSize:12}},
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
			            
			            /* var barChart = new google.visualization.BarChart({
				              chartType   : 'corechart',
				              containerId : 'chart_div', //라인 차트 생성할 영역
				              
				            }); */
				            
				            
			        }
			          google.charts.setOnLoadCallback(drawDashboard);
			 
			      }
			    }
	  	
	    google.charts.load('current', {'packages':['line','controls']});
 	    chartDrowFun.chartDrow(); //chartDrow() 실행
  }
  
  
  
var id = '';
id = '${data.itemId}';


$(document).ready(function(){
	if(id){
		callAjax();	
	}
});








//막대그래프 
google.charts.load('current', {'packages':['bar','corechart']});
 
    function schedulerSuccessAndFailChart() {
        var data = google.visualization.arrayToDataTable([
               ["Title","성공", {role:'annotation'}, "실패", {role:'annotation'}],
                        [""
                ,413, 413 //성공데이터
                ,24, 24] //실패데이터
       ]);
 
       var barChartOption = {
               bars: 'vertical',
               height :260,
               width :'100%',
               legend: { position: "top" },
               isStacked: false,
               tooltip:{textStyle : {fontSize:12}, showColorCode : true},
               animation: { //차트가 뿌려질때 실행될 애니메이션 효과
                 startup: true,
                 duration: 1000,
                 easing: 'linear' },
               annotations: {
                   textStyle: {
                     fontSize: 15,
                     bold: true,
                     italic: true,
                     color: '#871b47',
                     auraColor: '#d799ae',
                     opacity: 0.8
                   }
              }
        };
 
       var chart = new google.visualization.BarChart(document.getElementById('bar_chart_div'));
 
       chart.draw(data, barChartOption);
       //반응형 그래프 출력 - 반응형 그래프를 원하지 않을 시 제거하거나 주석처리 하세요.
       window.addEventListener('resize', function() { chart.draw(data, barChartOption); }, false);
    }
 
    google.charts.setOnLoadCallback(schedulerSuccessAndFailChart);

  </script>

</html>