package com.groupware.worktech.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.groupware.worktech.board.model.exception.BoardException;
import com.groupware.worktech.board.model.service.BoardService;
import com.groupware.worktech.board.model.vo.Board;
import com.groupware.worktech.board.model.vo.BoardFile;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService bService;
	
	@RequestMapping("commonList.bo")
	public String commonBoardList() {
		
		return "commonBoardList";
	}
	
	@RequestMapping("cinsertView.bo")
	public String generalBoardInsertView() {
		return "commonBoardInsertForm";
	}
	
	@RequestMapping("cinsert.bo")
	public String insertGeneralBoard(@ModelAttribute Board b, @RequestParam("uploadFile") MultipartFile[] uploadFile, HttpServletRequest request) {
		ArrayList<BoardFile> fileList = new ArrayList<BoardFile>();
		
		if(uploadFile != null && !uploadFile[0].isEmpty()) {
			for(int i = 0; i < uploadFile.length; i++) {
				HashMap<String, String> fileInfo = saveFile(uploadFile[i], request);
				
				if(fileInfo.get("renameFileName") != null) {
					BoardFile f = new BoardFile();
					f.setfName(uploadFile[i].getOriginalFilename());
					f.setfRname(fileInfo.get("renameFileName"));
					f.setfURL(fileInfo.get("renamePath"));
					f.setRefBNo(b.getbNo());
					
					fileList.add(f);
				}
			}
		}
		
		b.setFileList(fileList);
		
		int result = bService.insertCommonBoard(b);
		
		if(result > 0) {
			return "redirect:commonList.bo";
		} else {
			throw new BoardException("게시글 등록에 실패하였습니다.");
		}
		
	}

	public HashMap<String, String> saveFile(MultipartFile file, HttpServletRequest request) {
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/buploadFiles";
		
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		String originalFileName = file.getOriginalFilename();
		String renameFileName = randomStr(2) + sdf.format(new Date(System.currentTimeMillis())) + randomStr(3) + "." + originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
		
		String renamePath = folder + "/" + renameFileName;
		
		try {
			file.transferTo(new File(renamePath));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		HashMap<String, String> fileInfo = new HashMap<String, String>();
		fileInfo.put("renameFileName", renameFileName);
		fileInfo.put("renamePath", renamePath);
		return null;
	}
	
	public String randomStr(int length) {
		int leftLimit = 48;
		int rightLimit = 122;
		int targetStringLength = length;
		Random random = new Random();
		
		String generatedString = random.ints(leftLimit, rightLimit + 1)
								 .filter(i -> (i <= 57 || i >= 65) && (i <= 90 || i >= 97))
								 .limit(targetStringLength)
								 .collect(StringBuilder::new,  StringBuilder::appendCodePoint, StringBuilder::append)
								 .toString();
		return generatedString;
	}
}
