package org.zerock.service;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.GameReplyVO;

public interface GameReplyService {

  public void addReply(GameReplyVO gvo) throws Exception;

  public List<GameReplyVO> listReply(Integer bno) throws Exception;

  public void modifyReply(GameReplyVO gvo) throws Exception;

  public void removeReply(Integer rno) throws Exception;

  public List<GameReplyVO> listReplyPage(Integer bno, Criteria cri) 
      throws Exception;

  public int count(Integer bno) throws Exception;
}
