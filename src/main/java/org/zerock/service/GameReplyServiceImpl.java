package org.zerock.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.Criteria;
import org.zerock.domain.GameReplyVO;
import org.zerock.domain.ReplyVO;
import org.zerock.persistence.BoardDAO;
import org.zerock.persistence.GBoardDAO;
import org.zerock.persistence.GameReplyDAO;
import org.zerock.persistence.ReplyDAO;

@Service
public class GameReplyServiceImpl implements GameReplyService {

  @Inject
  private GameReplyDAO greplyDAO;
  
  @Inject
  private GBoardDAO gboardDAO;

  @Transactional
  @Override
  public void addReply(GameReplyVO gvo) throws Exception {

    greplyDAO.create(gvo);
    gboardDAO.updateReplyCnt(gvo.getBno(), 1);
  }
  
  @Transactional
  @Override
  public void removeReply(Integer rno) throws Exception {

    int bno = greplyDAO.getBno(rno);
    greplyDAO.delete(rno);
    gboardDAO.updateReplyCnt(bno, -1);
  }   



  @Override
  public List<GameReplyVO> listReply(Integer bno) throws Exception {

    return greplyDAO.list(bno);
  }

  @Override
  public void modifyReply(GameReplyVO gvo) throws Exception {

    greplyDAO.update(gvo);
  }



  @Override
  public List<GameReplyVO> listReplyPage(Integer bno, Criteria cri) 
      throws Exception {

    return greplyDAO.listPage(bno, cri);
  }

  @Override
  public int count(Integer bno) throws Exception {

    return greplyDAO.count(bno);
  }

}
