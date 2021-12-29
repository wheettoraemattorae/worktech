package com.groupware.worktech.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.groupware.worktech.board.model.vo.Board;
import com.groupware.worktech.board.model.vo.BoardFile;
import com.groupware.worktech.common.PageInfo;

@Repository("bDAO")
public class BoardDAO {

	public int getListCount(SqlSessionTemplate sqlSession, String bType) {
		return sqlSession.selectOne("boardMapper.getListCount", bType);
	}

	public ArrayList<Board> selectNoticeList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectNoticeList", pi, rowBounds);
	}

	public int insertNotice(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertNotice", b);
	}

	public int insertNoticeFile(SqlSessionTemplate sqlSession, BoardFile boardFile) {
		return sqlSession.insert("boardMapper.insertNoticeFile", boardFile);
	}

	public Board selectNotice(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.selectOne("boardMapper.selectNotice", bNo);
	}

	public int addReadCount(SqlSessionTemplate sqlSession, int bNo) {
		return sqlSession.update("boardMapper.addReadCount", bNo);
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public int insertCommonBoard(SqlSessionTemplate sqlSession, Board b) {
		return sqlSession.insert("boardMapper.insertCommonBoard", b);
	}

	public ArrayList<Board> selectCommonList(SqlSessionTemplate sqlSession, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectCommonList", null, rowBounds);
	}
	
	public ArrayList<Board> selectCommonList(SqlSessionTemplate sqlSession, PageInfo pi, int category) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectCategoryList", category, rowBounds);
	}

	public int getCategoryListCount(SqlSessionTemplate sqlSession, Integer category) {
		return sqlSession.selectOne("boardMapper.getCategoryListCount", category);
	}

	

	
	
}
