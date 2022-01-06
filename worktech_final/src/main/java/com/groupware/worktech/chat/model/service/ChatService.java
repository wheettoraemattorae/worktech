package com.groupware.worktech.chat.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupware.worktech.admin.model.vo.Department;
import com.groupware.worktech.chat.model.dao.ChatDAO;
import com.groupware.worktech.chat.model.vo.ChatMessage;
import com.groupware.worktech.chat.model.vo.ChatRoom;
import com.groupware.worktech.member.model.vo.Member;

@Service("cService")
public class ChatService {
	
	@Autowired
	private ChatDAO cDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<ChatRoom> selectChatList(String mNo) {
		return cDAO.selectChatList(sqlSession, mNo);
	}

	public ArrayList<Department> getChatDepartmentList() {
		return cDAO.getChatDepartmentList(sqlSession);
	}

	public ArrayList<Member> selectDeptMember(HashMap<String, String> map) {
		return cDAO.selectDeptMember(sqlSession, map);
	}

	public ArrayList<String> selectMemberName(ArrayList<String> mNoes) {
		return cDAO.selectMemberName(sqlSession, mNoes);
	}

	public int insertGroupChatroom(HashMap<String, String> map) {
		return cDAO.insertGroupChatroom(sqlSession, map);
	}

	public int insertGroupChatList(ArrayList<String> mNoes) {
		int result = 0;
		
		for(String mNo : mNoes) {
			result += cDAO.insertGroupChatList(sqlSession, mNo);
		}
		
		return result;
	}

	public ChatRoom selectCreateChatRoom() {
		return cDAO.selectCreateChatRoom(sqlSession);
	}

	public ArrayList<ChatMessage> selectMessageList(int chatRoomNo) {
		return cDAO.selectMessageList(sqlSession, chatRoomNo);
	}

	public int getNotReadCount(HashMap<String, String> map) {
		return cDAO.getNotReadCount(sqlSession, map);
	}
}
