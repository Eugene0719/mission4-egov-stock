/*
 * Copyright 2008-2009 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package egovframework.example.sample.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.example.sample.service.EgovSampleService;
import egovframework.example.sample.service.SampleDefaultVO;
import egovframework.example.sample.service.SampleVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : EgovSampleController.java
 * @Description : EgovSample Controller Class
 * @Modification Information
 * @
 * @  수정일      수정자              수정내용
 * @ ---------   ---------   -------------------------------
 * @ 2009.03.16           최초생성
 *
 * @author 개발프레임웍크 실행환경 개발팀
 * @since 2009. 03.16
 * @version 1.0
 * @see
 *
 *  Copyright (C) by MOPAS All right reserved.
 */

@Controller
public class EgovSampleController {

	/** EgovSampleService */
	@Resource(name = "sampleService")
	private EgovSampleService sampleService;

	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;

	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 SampleDefaultVO
	 * @param model
	 * @return "egovSampleList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/egovSampleList.do")
	public String selectSampleList(@ModelAttribute("searchVO") SampleDefaultVO searchVO,  ModelMap model, SampleVO sampleVO) throws Exception {

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<SampleVO> sampleList = sampleService.selectSampleList(searchVO);
		//List<SampleVO> sampleavg = sampleService.selectSampleAvg(searchVO);
		
		//List<?> sampleList2 = sampleService.selectSampleList2(searchVO);
		/*model.addAttribute("data", selectSample(sampleVO, searchVO));*/
		
		model.addAttribute("resultList", sampleList);
		//model.addAttribute("resultAvg", sampleavg);
		
		//model.addAttribute("resultList2", sampleList2);
		//System.out.println("리절트리스트 아이디 "+ sampleList.get(1).getItemId());
		
		//System.out.println("종목명 검색"+ searchVO.getSearchCode());
		int totCnt = sampleService.selectSampleListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("totCnt", totCnt);

		return "sample/egovSampleList";
	}

	/**
	 * 글 등록 화면을 조회한다.
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	/*@RequestMapping(value = "/addSample.do", method = RequestMethod.GET)
	public String addSampleView(@ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		model.addAttribute("sampleVO", new SampleVO());
		return "sample/egovSampleRegister";
	}*/

	/**
	 * 글을 등록한다.
	 * @param sampleVO - 등록할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	/*@RequestMapping(value = "/addSample.do", method = RequestMethod.POST)
	public String addSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

		// Server-Side Validation
		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "sample/egovSampleRegister";
		}

		sampleService.insertSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}*/

	/**
	 * 글 수정화면을 조회한다.
	 * @param id - 수정할 글 id
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param model
	 * @return "egovSampleRegister"
	 * @exception Exception
	 */
	@RequestMapping("ajax/dataTableList.do")
	@ResponseBody
	public Map<String,Object>  dataTableList(@ModelAttribute("searchVO") SampleDefaultVO searchVO,  ModelMap model, SampleVO sampleVO) throws Exception {
		/*SampleVO sampleVO = new SampleVO();
		sampleVO.setItemId(itemId);*/
		// 변수명은 CoC 에 따라 sampleVO
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		List<SampleVO> dataTableList = sampleService.dataTableList(searchVO);
		//model.addAttribute("resultAvg", sampleavg);
		
		System.out.println("데이터테이블"+dataTableList);
		rtnMap.put("data", dataTableList);
		
		//model.addAttribute(selectSample(sampleVO, searchVO));
		return rtnMap;
	}
	
	
	@RequestMapping("ajax/egovSampleAvg.do")
	@ResponseBody
	public Map<String,Object>  updateSampleView1( String itemId, SampleDefaultVO searchVO, Model model, SampleVO sampleVO) throws Exception {
		
		System.out.println("평균파미아이디"+itemId);
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		
		//그냥 list함수에서는 페이징 들어가있어서 쿼리 새로 만들어줌
		List<SampleVO> sampleavg = sampleService.selectSampleAvg(sampleVO);
		
		System.out.println("평균~~~"+sampleavg);
		rtnMap.put("data", sampleavg);
		
		return rtnMap;
	}
	
	/*@RequestMapping("/updateSampleView.do")
	public String updateSampleView(@RequestParam("selectedId") String itemId, String dealDate, @ModelAttribute("searchVO") SampleDefaultVO searchVO, Model model) throws Exception {
		SampleVO sampleVO = new SampleVO();
		sampleVO.setItemId(itemId);
		sampleVO.setDealDate(dealDate);
		// 변수명은 CoC 에 따라 sampleVO
	
		System.out.println("목록"+itemId);
		System.out.println("날짜"+searchVO.getSearchRegDate());
		model.addAttribute("data", selectSample(sampleVO, searchVO));
		//********list로 받기
		return "sample/egovSampleRegister";
	}*/
	
	@RequestMapping("ajax/ListAjax.do")
	@ResponseBody
	public Map<String,Object> ListAjax(@RequestParam("calender") String calender, String itemId, SampleDefaultVO searchVO, SampleVO sampleVO)throws Exception {
		//@RequestParam("calender") String calender,
		/*SampleVO sampleVO1 = new SampleVO();
		sampleVO1.setItemId(itemId);*/

		//sampleVO.setCalender(calender);
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		List<SampleVO> list = sampleService.printChart(sampleVO);
		
		
		System.out.println("vvvvvvvv!"+sampleVO.getCalender());
		System.out.println("에이작쓰!"+list);
		rtnMap.put("data", list);
		
		System.out.println("뀨????"+rtnMap);
/*//		
//		
//		rtnMap.put("data", list);
//		System.out.println("히든아이디"+itemId);
//		System.out.println("아이템아이디"+sampleVO.getItemId());
//		System.out.println("에이작쓰!"+list);
 * 
*/		return rtnMap;
	}

	/**
	 * 글을 조회한다.
	 * @param sampleVO - 조회할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return @ModelAttribute("sampleVO") - 조회한 정보
	 * @exception Exception
	 */
	public SampleVO selectSample(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO) throws Exception {
		return sampleService.selectSample(sampleVO);
	}

	/**
	 * 글을 수정한다.
	 * @param sampleVO - 수정할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	/*@RequestMapping("/updateSample.do")
	public String updateSample(@ModelAttribute("searchVO") SampleDefaultVO searchVO, SampleVO sampleVO, BindingResult bindingResult, Model model, SessionStatus status)
			throws Exception {

		beanValidator.validate(sampleVO, bindingResult);

		if (bindingResult.hasErrors()) {
			model.addAttribute("sampleVO", sampleVO);
			return "sample/egovSampleRegister";
		}

		sampleService.updateSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}*/

	/**
	 * 글을 삭제한다.
	 * @param sampleVO - 삭제할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return "forward:/egovSampleList.do"
	 * @exception Exception
	 */
	/*@RequestMapping("/deleteSample.do")
	public String deleteSample(SampleVO sampleVO, @ModelAttribute("searchVO") SampleDefaultVO searchVO, SessionStatus status) throws Exception {
		sampleService.deleteSample(sampleVO);
		status.setComplete();
		return "forward:/egovSampleList.do";
	}*/

}
