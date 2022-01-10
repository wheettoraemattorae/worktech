package com.groupware.worktech.mail.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupware.worktech.common.PageInfo;
import com.groupware.worktech.member.model.vo.Member;
import com.groupware.worktech.mail.model.dao.MailDAO;
import com.groupware.worktech.mail.model.vo.Mail;
import com.groupware.worktech.mail.model.vo.MailFile;

@Service("mailService")
public class MailServiceImpl implements MailService {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MailDAO mailDAO;
	
	@Override
	public int insertMailFile(List<MailFile> mailFileList) {
		
		return mailDAO.insertMailFile(sqlSession, mailFileList);
	}

	@Override
	public int insertMail(Mail m) {
		return mailDAO.insertMail(sqlSession, m);
	}

	@Override
	public int getTempListCount(String empNo) {
		return mailDAO.getTempListCount(sqlSession, empNo);
	}

	@Override
	public ArrayList<Mail> selectTempList(PageInfo pi, String empNo) {
		return mailDAO.selectTempList(sqlSession, pi, empNo);
	}

	@Override
	public Mail selectTempMail(int id) {
		return mailDAO.selectTempMail(sqlSession, id);
	}

	@Override
	public int updateMail(Mail m) {
		return mailDAO.updateMail(sqlSession, m);
	}

	@Override
	public int deleteMailFile(int mFileNo) {
		return mailDAO.deleteMailFile(sqlSession, mFileNo);
	}

	@Override
	public MailFile selectMailFile(int mFileNo) {
		return mailDAO.selectMailFile(sqlSession, mFileNo);
	}


	@Override
	public int insertTempMail(Mail m) {
		return mailDAO.insertTempMail(sqlSession, m);
	}

	@Override
	public int getsendListCount(String empNo) {
		return mailDAO.getSendListCount(sqlSession, empNo);
	}

	@Override
	public ArrayList<Mail> selectSendList(PageInfo pi, String empNo) {
		return mailDAO.selectSendList(sqlSession, pi, empNo);
	}

	@Override
	public Mail selectMail(Map<String, Object> map) {
		return mailDAO.selectMail(sqlSession, map);
	}
	

	@Override
	public Member getMId(String mId) {
		return mailDAO.getMId(sqlSession, mId);
	}

	@Override
	public int getReceiveListCount(String email) {
		return mailDAO.getReceiveListCount(sqlSession, email);
	}

	@Override
	public ArrayList<Mail> selectReceiveList(PageInfo pi, String email) {
		return mailDAO.selectReceiveList(sqlSession, pi, email);
	}

	@Override
	public int deleteMail(Map<String, Object> map) {
		return mailDAO.deleteMail(sqlSession, map);
	}

	@Override
	public int insertMailSRReceiver(String mId) {
		return mailDAO.insertMailSRReceiver(sqlSession, mId);
	}

	@Override
	public int insertMailSRSender(String empNo) {
		return mailDAO.insertMailSRSender(sqlSession, empNo);
	}

	@Override
	public int getDeleteListCount(String empNo) {
		return mailDAO.getDeleteListCount(sqlSession, empNo);
	}

	@Override
	public ArrayList<Mail> selectDeleteList(PageInfo pi, String empNo) {
		return mailDAO.selectDeleteList(sqlSession, pi, empNo);
	}

	@Override
	public ArrayList<Member> searchEmp(String keyword) {
		return mailDAO.searchEmp(sqlSession, keyword);
	}

	@Override
	public int updateRDate(Map<String, Object> map) {
		return mailDAO.updateRDate(sqlSession, map);
	}

	@Override
	public int updateFavorites(Map<String, Object> map) {
		return mailDAO.updateFavorites(sqlSession, map);
	}

	@Override
	public int getAllListCount(String empNo) {
		return mailDAO.getAllListCount(sqlSession, empNo);
	}

	@Override
	public ArrayList<Mail> selectAllList(PageInfo pi, String empNo) {
		return mailDAO.selectAllList(sqlSession, pi, empNo);
	}

	@Override
	public int selectCountNotRead(String empNo) {
		return mailDAO.selectCountNotRead(sqlSession, empNo);
	}

	@Override
	public int getFavoritesListCount(String empNo) {
		return mailDAO.getFavoritesListCount(sqlSession, empNo);
	}

	@Override
	public ArrayList<Mail> selectFavoritesList(PageInfo pi, String empNo) {
		return mailDAO.selectFavoritesList(sqlSession, pi, empNo);
	}

	@Override
	public int getSearchListCount(Map<String, Object> map) {
		return mailDAO.getSearchListCount(sqlSession, map);
	}

	@Override
	public ArrayList<Mail> searchList(PageInfo pi, Map<String, Object> map) {
		return mailDAO.searchList(sqlSession, pi, map);
	}

	@Override
	public ArrayList<Mail> selectCheckList(String empNo) {
		return mailDAO.selectCheckList(sqlSession, empNo);
	}

	
}
