package org.zerock.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageMaker;
import org.zerock.domain.GameReplyVO;
import org.zerock.service.GameReplyService;
import org.zerock.service.ReplyService;

@RestController
@RequestMapping("/greplies")
public class GameReplyController {
   
   static Logger logger = LoggerFactory.getLogger(GameReplyController.class);
   
   @Inject
   private GameReplyService gservice;

   @RequestMapping(value = "", method = RequestMethod.POST)
   public ResponseEntity<String> register(@RequestBody GameReplyVO gvo) { //UnMarshalling
      logger.info("$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$");
      logger.info(gvo.toString());
      logger.info("$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$#$");
      
      ResponseEntity<String> entity = null;
      try {
         gservice.addReply(gvo);
         entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);   //200
      } catch (Exception e) {
         e.printStackTrace();
         entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);   //400
      }
      
      return entity;   //Marshalling
   }

   @RequestMapping(value = "/all/{bno}", method = RequestMethod.GET)
   public ResponseEntity<List<GameReplyVO>> list(@PathVariable("bno") Integer bno) {

      ResponseEntity<List<GameReplyVO>> entity = null;
      try {
         entity = new ResponseEntity<>(gservice.listReply(bno), HttpStatus.OK);

      } catch (Exception e) {
         e.printStackTrace();
         entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
      }

      return entity;
   }

   @RequestMapping(value = "/{rno}", method = { RequestMethod.PUT, RequestMethod.PATCH })
   public ResponseEntity<String> update(@PathVariable("rno") Integer rno, @RequestBody GameReplyVO gvo) {

      ResponseEntity<String> entity = null;
      try {
         gvo.setRno(rno);
         gservice.modifyReply(gvo);

         entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
      } catch (Exception e) {
         e.printStackTrace();
         entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
      }
      return entity;
   }

   @RequestMapping(value = "/{rno}", method = RequestMethod.DELETE)
   public ResponseEntity<String> remove(@PathVariable("rno") Integer rno) {

      ResponseEntity<String> entity = null;
      try {
         gservice.removeReply(rno);
         entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
      } catch (Exception e) {
         e.printStackTrace();
         entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
      }
      return entity;
   }

   @RequestMapping(value = "/{bno}/{page}", method = RequestMethod.GET)
   public ResponseEntity<Map<String, Object>> listPage(@PathVariable("bno") Integer bno,
         @PathVariable("page") Integer page) {

      ResponseEntity<Map<String, Object>> entity = null;

      try {
         Criteria cri = new Criteria();
         cri.setPage(page);

         PageMaker pageMaker = new PageMaker();
         pageMaker.setCri(cri);

         Map<String, Object> map = new HashMap<String, Object>();
         List<GameReplyVO> list = gservice.listReplyPage(bno, cri);

         map.put("list", list);

         int replyCount = gservice.count(bno);
         pageMaker.setTotalCount(replyCount);

         map.put("pageMaker", pageMaker);

         entity = new ResponseEntity<Map<String, Object>>(map, HttpStatus.OK);

      } catch (Exception e) {
         e.printStackTrace();
         entity = new ResponseEntity<Map<String, Object>>(HttpStatus.BAD_REQUEST);
      }
      return entity;
   }

}