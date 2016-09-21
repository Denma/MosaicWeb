package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.GboardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchCriteria;

public interface GBoardDAO {

  public void create(GboardVO vo) throws Exception;

  public GboardVO read(Integer bno) throws Exception;

  public void update(GboardVO vo) throws Exception;

  public void delete(Integer bno) throws Exception;

  public List<GboardVO> listAll() throws Exception;

  public List<GboardVO> listPage(int page) throws Exception;

  public List<GboardVO> listCriteria(Criteria cri) throws Exception;

  public int countPaging(Criteria cri) throws Exception;
  
  //use for dynamic sql
  
  public List<GboardVO> listSearch(SearchCriteria cri)throws Exception;
  
  public int listSearchCount(SearchCriteria cri)throws Exception;
  
  
  public void updateReplyCnt(Integer bno, int amount)throws Exception;
  
  
  public void updateViewCnt(Integer bno)throws Exception;
  
  public void addAttach(String fullName)throws Exception;
  
  public List<String> getAttach(Integer bno)throws Exception;  
   
  public void deleteAttach(Integer bno)throws Exception;
  
  public void replaceAttach(String fullName, Integer bno)throws Exception;
  
}
