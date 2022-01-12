package com.groupware.worktech.commut.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.groupware.worktech.commut.model.dao.CommutDAO;
import com.groupware.worktech.commut.model.vo.QRCode;

@Service("coService")
public class CommutService {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private CommutDAO coDAO;

	public int insertQRCode(QRCode qr) {
		return coDAO.insertQRCode(qr, sqlSession);
		
	}

	public QRCode selectQr(QRCode qr) {
		return coDAO.selectQRCode(qr, sqlSession);
	}

	public QRCode getinfo(String getmNo) {
		return coDAO.selectQStatus(getmNo, sqlSession);
		}

}
