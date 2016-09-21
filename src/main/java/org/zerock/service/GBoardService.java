package org.zerock.service;

import java.util.List;

import org.zerock.domain.GboardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchCriteria;

public interface GBoardService {

  public void regist(GboardVO gboard) throws Exception;

  public GboardVO read(Integer bno) throws Exception;

  public void modify(GboardVO gboard) throws Exception;

  public void remove(Integer bno) throws Exception;

  public List<GboardVO> listAll() throws Exception;

  public List<GboardVO> listCriteria(Criteria cri) throws Exception;

  public int listCountCriteria(Criteria cri) throws Exception;

  public List<GboardVO> listSearchCriteria(SearchCriteria cri) 
      throws Exception;

  public int listSearchCount(SearchCriteria cri) throws Exception;
  
  
  public List<String> getAttach(Integer bno)throws Exception;
  

}
