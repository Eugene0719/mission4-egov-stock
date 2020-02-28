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
	<!-- <script src="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"></script>
	<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script> -->
	<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
	<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.js"></script>
	<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css"></script>
	
	
	<!-- <link rel="stylesheet" href="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.css"/> 
    <script src="https://cdn.datatables.net/t/bs-3.3.6/jqc-1.12.0,dt-1.10.11/datatables.min.js"></script> -->
	
	<style>
	.avgTable{
			display:none;
			padding: 10px 10px 10px 10px;
	}
	
	.dis-none{
			display:none;
			padding: 50px 10px 10px 10px;
	} 
	</style>
	<!-- jQuery -->
    <!-- <script src="https://code.jquery.com/jquery.min.js"></script> -->
    <!-- google charts -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    
    <script type="text/javaScript" language="javascript" defer="defer">
    
        /* 글 수정 화면 function */
        function fn_egov_select(itemId,dealDate) {
        	
        	$("#itemId").val(itemId);
        	$("#dealDate").val(dealDate);
        	console.log(itemId, dealDate);
        	//document.listForm.selectedId.value = itemId;
        	callAjax(itemId, dealDate);
        	callAjaxAvg(itemId, dealDate);
        }
        
        /* 그래프 에이작스 function */
        /* function fn_egov_select(itemId,dealDate) {
        	
        	$("#itemId").val(itemId);
        	$("#dealDate").val(dealDate);
        	console.log(itemId);
        	callAjax(itemId,dealDate);
        	
        	document.listForm.selectedId.value = itemId;
        } */
        
        /* 라디오버튼 실행 */
/* 		function fn_egov_radio() {
        	
        	//console.log("라디오 아이디 "+ itemId);
			//document.getElementById("test").value = '${itemId}';
			console.log(asdf);
			
			var dayType = $(this).val();
			var itemId = $("#itemId").val();
			var dealDate = $("#testDatepicker").val();
			
				return false;
        	callAjax(itemId,dealDate,dayType);
        	//alert("아이디"+itemId);
        } */
        
        //에이작스로 서치레지데이트값 보내기!!!!!!!!
        function fn_egov_selectList() {
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit();
        }
        function fn_egov_selectList2() {
        	action = "<c:url value='ajax/dataTableList.do'/>";
           	submit();
        }
        
        $(function(){
        $("input:radio[name=calender]").click(function(){
        	var calender = $(this).val();	// 버튼의 값을 가져온다.
        	console.log("디슨느느느는  "+ calender);
        	var itemId = $("#itemId").val();	// itemid 값을 가져온다.
        	console.log("라디오펑션 아이디"+itemId);
        	var dealDate = $("#dealDate").val();
        	
        	callAjax(itemId,dealDate,calender);
        });
        	// 버튼을 클릭 시 call에 담긴 매개변수를 가져온다. 그런데 calender='aaa' 디폴트값이 위의 버튼클릭시 값을 새로 가져와서 
        	// 다른버튼을 클릭 하면 새로운 값이 들어간다.
        	
			
        	 //alert(calender); // 버튼 클릭시 값이 들어가는지 확인
        	   });
        
        
        
        /* pagination 페이지 링크 function */
        function fn_egov_link_page(pageNo){
        	document.listForm.pageIndex.value = pageNo;
        	document.listForm.action = "<c:url value='/egovSampleList.do'/>";
           	document.listForm.submit();
        }
        
        
         $(function() {
    $( "#testDatepicker" ).datepicker({
    	dateFormat: "yymmdd"
       ,defaultDate:'20200131'
    	});
	}); 
        
       //밑에 테이블그리는 함수랑 같음 이렇게 써도 됨
     	/* $(document).ready( function () {
     	$('#myTable').DataTable();
     	
     	}); */
         
     jQuery(function($){
         $("#myTable").DataTable({
        	 language: {
        	        "emptyTable": "데이터가 없어요.",
        	        "lengthMenu": "페이지당 _MENU_ 개씩 보기",
        	        "info": "현재 _START_ - _END_ / _TOTAL_건",
        	        "infoEmpty": "데이터 없음",
        	        "infoFiltered": "( _MAX_건의 데이터에서 필터링됨 )",
        	        "search": "종목코드/명: ",
        	        "zeroRecords": "일치하는 데이터가 없어요.",
        	        "loadingRecords": "로딩중...",
        	        "processing":     "잠시만 기다려 주세요...",
        	        "paginate": {
        	            "next": "다음",
        	            "previous": "이전"
        	        }
        	 },
        	 //serverSide: true,
        	 ajax : {
                 url : "ajax/dataTableList.do?"
                 //dataSrc: 'data'
         },
         columns: [
        	 
 			{ targets: 0, data: "itemId", render: detail },
 			{ targets: 1, data: "itemName", render: detail},  
 			{ targets: 2, data: "priceOpen", render: AddComma},
 			{ targets: 3, data: "priceHigh", render: AddComma},
 			{ targets: 4, data: "priceLow" , render: AddComma},
 			{ targets: 5, data: "priceClose", render: AddComma },
 			{ targets: 6, data: "pd", render: pdc},
 			{ targets: 7, data: "fr", render: frc },
 			{ targets: 8, data: "volume", render: AddComma }
 				], 
         });
     });
     	
   	/* Custom filtering function which will search data in column four between two values */
   	$.fn.dataTable.ext.search.push(
   	    function( settings, data, dataIndex ) {
   	        var min = parseInt( $('#min').val(), 10 );
   	        var max = parseInt( $('#max').val(), 10 );
   	        var age = parseFloat( data[3] ) || 0; // use data for the age column
   	 
   	        if ( ( isNaN( min ) && isNaN( max ) ) ||
   	             ( isNaN( min ) && age <= max ) ||
   	             ( min <= age   && isNaN( max ) ) ||
   	             ( min <= age   && age <= max ) )
   	        {
   	            return true;
   	        }
   	        return false;
   	    }
   	);
   	
   	$(document).ready(function() {
   	    var table = $('#myTable').DataTable();
   	     
   	    // Event listener to the two range filtering inputs to redraw on input
   	    $('#min, #max').keyup( function() {
   	        table.draw();
   	    } );
   	} );
   	
    /* 화폐단위 콤마처리 */  	
  	function AddComma(val){
          var regexp = /\B(?=(\d{3})+(?!\d))/g;
          return val.toString().replace(regexp, ',');
          }

  	/* 전일대비 색깔바꾸기  */
     function pdc(val){
  		
    	 /* 음수부호 없애기 */
    	 var test = val;
			test = Math.abs(val);
    	 if(val > 0){
    		 return '<span style="color:red;">▲'+AddComma(test)+'</span>';
    	 }
    	 if(val < 0){
    		 return '<span style="color:blue;">▼'+AddComma(test)+'</span>';
    	 }
    	 if(val == 0){
    		 return '<span>'+val+'</span>';
    	 }
     }
     
     /* 등락률 색깔바꾸기  */
     function frc(val){
    	 if(val > 0){
    		 return '<span style="color:red;">+'+val+'</span>';
    	 }
    	 if(val < 0){
    		 return '<span style="color:blue;">'+val+'</span>';
    	 }
    	 if(val == 0){
    		 return '<span>'+val+'</span>';
    	 }
     }
     
     function detail(val, type, row) {
    	 
    	 	val = '<span style=\"cursor:pointer;cursor:hand\" onclick="javascript:fn_egov_select(' + "'" + row.itemId + "'" + ', ' + row.dealDate + ', ' + "'" +  row.itemName + "'" + ')">' +val+ '</span>';
         return val;
     }
     
     
	     
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
        	</div>
        	<br>총 <c:out value="${totCnt}"/> 건
        	<!-- List -->
        	<div id="table">
        		<table width="100%" border="0" cellpadding="0" cellspacing="0" summary="카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블">
        			<caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
        			<colgroup>
        				<col width="60"/>
        				<col width="110"/>
        				<col width="100"/>
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
            				<td align="center" class="listtd" ><c:out value="${result.itemId}" /></td>
            				<td align="left" class="listtd" ><a href="javascript:fn_egov_select('<c:out value="${result.itemId}"/>','<c:out value="${result.dealDate}"/>')"><c:out value="${result.itemName}" />&nbsp;</a></td>
            				<td align="center" class="listtd" ><fmt:formatNumber type="number" value="${result.priceOpen}" pattern="#,###"/>&nbsp;</td>
            				<td align="center" class="listtd"><fmt:formatNumber type="number" value="${result.priceHigh}" pattern="#,###"/>&nbsp;</td>
            				<td align="center" class="listtd" ><fmt:formatNumber type="number" value="${result.priceLow}" pattern="#,###"/>&nbsp;</td>
            				<td align="center" class="listtd"><fmt:formatNumber type="number" value="${result.priceClose}" pattern="#,###"/>&nbsp;</td>
            				<c:if test="${result.PD > 0}">
            					<td align="center" class="listtd" style="color:red;"><fmt:formatNumber type="number" value="${result.PD}" pattern="▲#,###"/>&nbsp;</td>
            				</c:if>
            				<c:if test="${result.PD < 0}">
            					<td align="center" class="listtd" style="color:blue;">▼<fmt:formatNumber type="number" value="${result.PD}" pattern="▲#,###; #,###"/>&nbsp;</td>
            				</c:if>
            				<c:if test="${result.PD == 0}">
            					<td align="center" class="listtd"><c:out value="${result.PD}"/>&nbsp;</td>
            				</c:if>
            				<c:if test="${result.FR > 0}">
            					<td align="center" class="listtd" style="color:red;">+<c:out value="${result.FR}"/>&nbsp;</td>
            				</c:if>
            				<c:if test="${result.FR < 0}">
            					<td align="center" class="listtd" style="color:blue;"><c:out value="${result.FR}"/>&nbsp;</td>
            				</c:if>
            				<c:if test="${result.FR == 0}">
            					<td align="center" class="listtd"><c:out value="0"/>&nbsp;</td>
            				</c:if>
            				<td align="center" class="listtd"><fmt:formatNumber type="number" value="${result.volume}" pattern="#,###"/>&nbsp;</td>
            			</tr>
        			</c:forEach>
        		</table>
        	</div>
        	<!-- /List -->
        	<div id="paging">
        		<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_link_page" />
        		<form:hidden path="pageIndex" />
        	</div>
        			<input type="hidden" id="itemId"/>
 					<input type="hidden" id="dealDate"/>
        	<br><br>
        	
        	<!-- ****************** 데이터테이블!! ******************-->
        	<table border="0" cellspacing="5" cellpadding="5">
		        <tbody>
		        
		   <%--  <div id="search">
        		거래일<input name="searchRegDate" cssClass="txt"/>
        		<ul>
        			<li>
	      	            <span class="btn_blue_l">
	      	                <a href="javascript:fn_egov_selectList2();"><spring:message code="button.search" /></a>
	      	                <img src="<c:url value='/images/egovframework/example/btn_bg_r.gif'/>" style="margin-left:6px;" alt=""/>
	      	            </span>
      	            </li>
      	        </ul>
        	</div> --%>
        	
		        	<!-- <tr>
			            <td>날짜 검색 : </td>
			            <td><input type="text" id="min" name="min"> ~ </td>
			            <td><input type="text" id="max" name="max"></td>
			        </tr> -->
		    	</tbody>
		    </table>
        	<table id="myTable" class="display">
			    <thead>
			        <tr>
						<th>종목코드</th>
						<th>종목명</th>
						<th>시가</th>
						<th>고가</th>
						<th>저가</th>
						<th>종가</th>
						<th>전일대비</th>
						<th>등락률</th>
						<th>거래량</th>
			        </tr>
			    </thead>
			    <tbody>
			        
			    </tbody>
			</table>
        	<br><br><br>
        	<!-- *********테이블 투 !!!!!!!! ********* -->
        	<table width="100%" border="0" cellpadding="0" cellspacing="0" id="avgTable" class="avgTable">
        			<caption style="visibility:hidden">카테고리ID, 케테고리명, 사용여부, Description, 등록자 표시하는 테이블</caption>
        			<colgroup>
        				<col width="60"/>
        				<col width="60"/>
        				<col width="60"/>
        				<col width="80"/>
        				<col width="?"/>
        				<col width="60"/>
        			</colgroup>
        			<tr>
        				<!-- <th align="center">No</th> -->
        				<th align="center" rowspan="2"><spring:message code="title.sample.deal_date" /></th>
        				<th align="center" rowspan="2"><spring:message code="title.sample.price_close" /></th>
        				<th align="center" colspan="4"><spring:message code="title.price.avg" /></th>
        				<th align="center" rowspan="2"><spring:message code="title.sample.volume" /></th>
        				<th align="center" colspan="4"><spring:message code="title.volume.avg" /></th>
        			</tr>
        			<tr>
        				<th align="center"><spring:message code="title.price.5" /></th>
        				<th align="center"><spring:message code="title.price.10" /></th>
        				<th align="center"><spring:message code="title.price.20" /></th>
        				<th align="center"><spring:message code="title.price.60" /></th>
        				<th align="center"><spring:message code="title.price.5" /></th>
        				<th align="center"><spring:message code="title.price.20" /></th>
        				<th align="center"><spring:message code="title.price.60" /></th>
        			</tr>
        			<tbody id="dynamicTbody">
        			
        			</tbody>
        		</table>
        	<br><br><br>
        	
 			
 			<div id="Line_Controls_Chart">
		    	<div class="dis-none" id="chartArea">
				    <h4>주식 그래프</h4>
		        	
		 			<input type="hidden" id="itemId"/>
		 			<input type="hidden" id="dealDate"/>
		 			<br><br>
		    		<input type="radio" name="calender" value="aaa" checked/>일
					<input type="radio" name="calender" value="bbb"/>주
				    <input type="radio" name="calender" value="ccc"/>월
	 			</div>
	 			
	      		<!-- 라인 차트 생성할 영역 -->
	          <div id="curve_chart" style="width: 700px; height: 500px;"></div>
	      		<!-- 컨트롤바를 생성할 영역 -->
	          <div id="controlsArea" style="padding:0px 20px 0px 0px;"></div>
	     		<!--  막대그래프를 생성할 영역 -->
	          <div id="chart_div" style="width: 700px; height: 500px;"></div>
	          
	        </div>
        </div>
    </form:form>

  </body>
 
  <script>
  /* $("input:radio[name='calender']").prop('checked', true); // 선택하기
  $("input:radio[name='calender']").prop('checked', false); // 해제하기 */
  
function callAjaxAvg(itemId,dealDate) {
	  
	  $("#itemId").val(itemId);
	  $("#dealDate").val(dealDate);
	  
	  $.ajax({
          url: "ajax/egovSampleAvg.do",
          data: {"itemId":itemId, "dealDate":dealDate},
          /* type: "post",  */
          dataType: "json",
          async: false,
          success:function(data) {
          	/* alert(data+"에이작승이이이이잉");
          	console.log(data);
          	alert(itemId); */
          	initAvg(data);
          	$("#avgTable").removeClass("avgTable");
          	
          },
          error: function a(e){
        	  alert("에러"+e);
          	console.log(e);
      }});
  }
  
		function AddComma(num){
			var regexp = /\B(?=(\d{3})+(?!\d))/g;
			return num.toString().replace(regexp, ',');
		}

function initAvg(obj){
	
	console.log("obj ==> ", obj);
	
	var html = ''; 
  	
  	for(var i = 0; i <obj['data'].length; i++){ 
  		
  		var priceClose = AddComma(obj.data[i].priceClose);
  		var priceAvg5 = AddComma(obj.data[i].priceAvg5);
  		var priceAvg10 = AddComma(obj.data[i].priceAvg10);
  		var priceAvg20 = AddComma(obj.data[i].priceAvg20);
  		var priceAvg60 = AddComma(obj.data[i].priceAvg60);
  		var volume = AddComma(obj.data[i].volume);
  		var volumeAvg5 = AddComma(obj.data[i].volumeAvg5);
  		var volumeAvg20 = AddComma(obj.data[i].volumeAvg20);
  		var volumeAvg60 = AddComma(obj.data[i].volumeAvg60);
  		
  		
  		html += '<tr>'; 
  		html += '<td class="listtd">'+obj.data[i].dealDate+'</td>'; 
  		html += '<td class="listtd">'+priceClose+'</td>'; 
  		html += '<td class="listtd">'+priceAvg5+'</td>'; 
  		html += '<td class="listtd">'+priceAvg10+'</td>'; 
  		html += '<td class="listtd">'+priceAvg20+'</td>'; 
  		html += '<td class="listtd">'+priceAvg60+'</td>'; 
  		html += '<td class="listtd">'+volume+'</td>'; 
  		html += '<td class="listtd">'+volumeAvg5+'</td>'; 
  		html += '<td class="listtd">'+volumeAvg20+'</td>'; 
  		html += '<td class="listtd">'+volumeAvg60+'</td>'; 
  		html += '</tr>'; 
  		}
  	
  	$("#dynamicTbody").empty(); 
  	$("#dynamicTbody").append(html);
	
}
  
   function callAjax(itemId,dealDate,calender) {
	  
	  if(calender == undefined){
			 var calender = 'aaa';
		  }
	  
	  console.log(itemId, dealDate, calender);
	  $("#itemId").val(itemId);
	  
	  var _dealDate = $("#dealDate").val();
	  var _itemId = $("#itemId").val();
	  //console.log("rrrrrrrr" +_itemId);
	  //console.log("calenderAjax   "+calender);
	  
	  $.ajax({
          url: "ajax/ListAjax.do",
          data: {"itemId":itemId, "dealDate":dealDate,  "calender":calender},
          //data: {"itemId":'${data.itemId}', "dealDate":'${data.dealDate}'},
          //type: "post",
          dataType: "json",
          async: false,
          success:function(data) {
          	//alert(data+"에이작승이이이이잉");
          	//alert(id);
          	initChart(data);
          	console.log("석세쓰 "+calender);
          	// 컨트롤 갔다가 매퍼로
          	$("#chartArea").removeClass("dis-none");
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
			        //var chartData = '';
			        //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
			        //var chartDateformat     = 'yyyyMM';
			        //라인차트의 라인 수
			       // var chartLineCount    = 10;
			        //컨트롤러 바 차트의 라인 수
			        //var controlLineCount    = 10; 
			 
			 
			        function drawChart() {
			          var data = new google.visualization.DataTable();
			          //그래프에 표시할 컬럼 추가
			          data.addColumn('string' , '날짜');
			          data.addColumn('number'   , '종가'); 
			          data.addColumn('number'   , '가격이동평균5');
			          data.addColumn('number'   , '가격이동평균10');
			          data.addColumn('number'   , '가격이동평균20');
			          data.addColumn('number'   , '가격이동평균60');
			          data.addColumn('number'   , '가격이동평균120');
			 		
			          //그래프에 표시할 데이터   
			          var dataRow = [];
			 	
			          //랜덤 데이터 생성
			        //for(var i = 0; i <obj.data.length; i++){
			        for(var i = 0; i <obj['data'].length; i++){
			        	var dealDate		= obj.data[i].dealDate;
			            var priceClose     = obj.data[i].priceClose;
			            var priceAvg5     = obj.data[i].priceAvg5;
			            var priceAvg10     = obj.data[i].priceAvg10;
			            var priceAvg20     = obj.data[i].priceAvg20;
			            var priceAvg60     = obj.data[i].priceAvg60;
			            var priceAvg120     = obj.data[i].priceAvg120;
			            /* var year	= obj.data[i].year;
			            var month	= obj.data[i].month;
			            var day		= obj.data[i].day; */
			           
			            dataRow = [dealDate,priceClose,priceAvg5,priceAvg10,priceAvg20,priceAvg60,priceAvg120];
			            //dataRow = [new Date(year, month, day),priceClose,priceAvg5,priceAvg10,priceAvg20,priceAvg60,priceAvg120];
			            data.addRow(dataRow);
			        	  }
			
			          
			        	var options = {
			                title: '종가 차트',
			               // curveType: 'function',
			                legend: { position: 'right' },
			                //chartArea: {'width': 500,'height' : '100%'},
			                /* hAxis              : {format: chartDateformat, gridlines:{count:chartLineCount,units: {
			                    years : {format: ['yyyy년']},
			                    months: {format: ['MM월']},
			                    days  : {format: ['dd일']},
			                    hours : {format: ['HH시']}}
			                  },textStyle: {fontSize:12}},
			                vAxis              : {minValue: 100,viewWindow:{min:0},gridlines:{count:-1},textStyle:{fontSize:12}} */
			              };
			        	
			        	 //var date_formatter = new google.visualization.DateFormat({ pattern: chartDateformat});
				           // date_formatter.format(data, 0); 

			              var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));
			            /* var chart = new google.visualization.ChartWrapper({
			              chartType   : 'LineChart',
			              containerId : 'lineChartArea', //라인 차트 생성할 영역
			              options     : {
			            	  			  title : '라인그래프',
			                              isStacked   : 'percent',
			                              focusTarget : 'category',
			                              height          : 500,
			                              width              : 800,//'120%',
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
			                        chartArea: {'width': 500,'height' : 80},
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
			            });  */
			 
			             //var date_formatter = new google.visualization.DateFormat({ pattern: chartDateformat});
			            //date_formatter.format(data, 0);
			 			
			             /*var dashboard = new google.visualization.Dashboard(document.getElementById('Line_Controls_Chart'));
			            window.addEventListener('resize', function() { dashboard.draw(data); }, false); //화면 크기에 따라 그래프 크기 변경
			            dashboard.bind([control], [chart]);
			            dashboard.draw(data);  */
			              chart.draw(data, options);
			        }
			        	google.charts.setOnLoadCallback(drawChart);
			        	//google.charts.setOnLoadCallback(drawDashboard);
			          
			    }
	  }
	  
	  google.charts.load('current', {'packages':['corechart']});
	  //google.charts.load('current', {'packages':['line','controls']});
 	  chartDrowFun.chartDrow(); //chartDrow() 실행
 	  
 	 
 	 var chartDrowFun1 = {
			  
			    chartDrow1 : function(){
			    	/* var chartData = '';
					 
			        //날짜형식 변경하고 싶으시면 이 부분 수정하세요.
			        var chartDateformat     = 'yyyy년MM월dd일';
			        //라인차트의 라인 수
			        var chartLineCount    = 10; */
			 
			        
			        function drawVisualization(){
			        	var data = new google.visualization.DataTable();
				          //그래프에 표시할 컬럼 추가
				          data.addColumn('string' , '날짜');
				          data.addColumn('number'   , '거래량이동평균60');
				          data.addColumn('number'   , '거래량');
				 		
				          //그래프에 표시할 데이터
				          var dataRow = [];
				 	
				          //랜덤 데이터 생성
				        for(var i = 0; i <obj.data.length; i++){
				        	var dealDate	= obj.data[i].dealDate;
				            var volumeAvg60     = obj.data[i].volumeAvg60;
				            var volume     = obj.data[i].volume;
				            /* var year	= obj.data[i].year;
				            var month	= obj.data[i].month;
				            var day		= obj.data[i].day; */
				            
				            
				            dataRow = [dealDate,volumeAvg60,volume];
				            data.addRow(dataRow);
				        	  }
			        	  
			        	  var options = {
			        	    title : '거래량 차트',
			        	    /* vAxis: {title: 'Cups'},
			        	    hAxis: {title: 'Month'}, */
			        	  /*  hAxis              : {format: chartDateformat, gridlines:{count:chartLineCount,units: {
			                    years : {format: ['yyyy년']},
			                    months: {format: ['MM월']},
			                    days  : {format: ['dd일']},
			                    hours : {format: ['HH시']}}
			                  },textStyle: {fontSize:12}},
			                vAxis              : {minValue: 100,viewWindow:{min:0},gridlines:{count:-1},textStyle:{fontSize:12}}, */
			        	    seriesType: 'bars',
			        	    series: {0: {type: 'line'}}
			        	    };
							
			            /*  var date_formatter = new google.visualization.DateFormat({ pattern: chartDateformat});
			            date_formatter.format(data, 0);  */
			            
			        	  var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
			        	  
			        	  chart.draw(data, options);
			  	  }
			  	  
			  	  google.charts.setOnLoadCallback(drawVisualization);
			    }
	  }
 	  google.charts.load('current', {'packages':['corechart']});
	  chartDrowFun1.chartDrow1(); //chartDrow() 실행
  }
  
  
  
var id = '';
id = '${itemId}';

$(document).ready(function(){
	if(id){
		callAjax();	
	}
});

  </script>
</html>
