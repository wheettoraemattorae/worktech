package com.groupware.worktech.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupware.worktech.member.model.dao.MemberDAO;
import com.groupware.worktech.member.model.vo.Member;

@Service("mService")
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDAO mDAO;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public Member memberLogin(Member m) {
		return mDAO.memberLogin(sqlSession, m);
	}

}

