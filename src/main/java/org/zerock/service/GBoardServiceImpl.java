package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.GboardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.SearchCriteria;
import org.zerock.persistence.GBoardDAO;

@Service
public class GBoardServiceImpl implements GBoardService {

  @Inject
  private GBoardDAO gdao;

  
  @Transactional
  @Override
  public void regist(GboardVO gboard) throws Exception {
  
    gdao.create(gboard);
    
    String[] files = gboard.getFiles();
    
    if(files == null) { return; } 
    
    for (String fileName : files) {
      gdao.addAttach(fileName);
    }   
  }
  
  //
//  @Override
//  public void regist(GBoardVO gboard) throws Exception {
//    gdao.create(board);
//  }

//  @Override
//  public GBoardVO read(Integer bno) throws Exception {
//    return gdao.read(bno);
//  }


  @Transactional(isolation=Isolation.READ_COMMITTED)
  @Override
  public GboardVO read(Integer bno) throws Exception {
    gdao.updateViewCnt(bno);
    return gdao.read(bno);
  }

  
//  @Override
//  public void modify(GBoardVO gboard) throws Exception {
//    gdao.update(board);
//  }
  
  @Transactional
  @Override
  public void modify(GboardVO gboard) throws Exception {
    gdao.update(gboard);
    
    Integer bno = gboard.getBno();
    
    gdao.deleteAttach(bno);
    
    String[] files = gboard.getFiles();
    
    if(files == null) { return; } 
    
    for (String fileName : files) {
      gdao.replaceAttach(fileName, bno);
    }
  }
  

//  @Override
//  public void remove(Integer bno) throws Exception {
//    gdao.delete(bno);
//  }
  
  
  @Transactional
  @Override
  public void remove(Integer bno) throws Exception {
    gdao.deleteAttach(bno);
    gdao.delete(bno);
  } 

  @Override
  public List<GboardVO> listAll() throws Exception {
    return gdao.listAll();
  }

  @Override
  public List<GboardVO> listCriteria(Criteria cri) throws Exception {

    return gdao.listCriteria(cri);
  }

  @Override
  public int listCountCriteria(Criteria cri) throws Exception {

    return gdao.countPaging(cri);
  }

  @Override
  public List<GboardVO> listSearchCriteria(SearchCriteria cri) throws Exception {

    return gdao.listSearch(cri);
  }

  @Override
  public int listSearchCount(SearchCriteria cri) throws Exception {

    return gdao.listSearchCount(cri);
  }
  

  @Override
  public List<String> getAttach(Integer bno) throws Exception {
    
    return gdao.getAttach(bno);
  }   

}
