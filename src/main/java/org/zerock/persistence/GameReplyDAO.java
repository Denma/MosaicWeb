package org.zerock.persistence;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.GameReplyVO;

public interface GameReplyDAO {

  public List<GameReplyVO> list(Integer bno) throws Exception;

  public void create(GameReplyVO gvo) throws Exception;

  public void update(GameReplyVO gvo) throws Exception;

  public void delete(Integer rno) throws Exception;

  public List<GameReplyVO> listPage(Integer bno, Criteria cri) throws Exception;

  public int count(Integer bno) throws Exception;

  public int getBno(Integer rno) throws Exception;

}
