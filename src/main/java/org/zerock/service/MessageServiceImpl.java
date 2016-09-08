package org.zerock.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.MessageVO;
import org.zerock.persistence.MessageDAO;
import org.zerock.persistence.PointDAO;

@Service
public class MessageServiceImpl implements MessageService {

	@Inject
	private MessageDAO messageDAO;

	@Inject
	private PointDAO pointDAO;

//	Transaction처리로 어디선가 오류나면 All or Nothing(완벽히 수행 or 아무것도 수행안됨)처리됨
	@Transactional
	@Override
	public void addMessage(MessageVO vo) throws Exception {

		messageDAO.create(vo);
		pointDAO.updatePoint(vo.getSender(), 10);
	}

//	Transaction처리로 어디선가 오류나면 All or Nothing(완벽히 수행 or 아무것도 수행안됨)처리됨
	 @Transactional
	@Override
	public MessageVO readMessage(String uid, Integer mid) throws Exception {

		messageDAO.updateState(mid);

		pointDAO.updatePoint(uid, 5);

		return messageDAO.readMessage(mid);
	}
}
