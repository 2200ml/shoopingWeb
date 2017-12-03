package com.oohooh.shopping.handler;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oohooh.shopping.entities.Account;
import com.oohooh.shopping.entities.Clothes;
import com.oohooh.shopping.entities.Picture;
import com.oohooh.shopping.service.ClothesService;
import com.oohooh.shopping.service.UploadService;
import com.oohooh.shopping.utils.JsonMsg;
import com.oohooh.shopping.utils.ShoppingWebUtil;

@Controller
public class UploadHandler {

	@Autowired
	private UploadService uploadService;
	
	@Autowired
	private ClothesService clothesService;
	
	@ModelAttribute
	public void getClothes(@RequestParam(value="clothesId", required=false) String clothesIdStr, Map<String, Object> map) {
		int clothesId = -1;
		try {
			clothesId = Integer.parseInt(clothesIdStr);
		} catch (Exception e) {}
		
		if(clothesId > 0) {
			Clothes clothes = uploadService.getById(clothesId);
			map.put("clothes", clothes);
		}
	}
	
	@ResponseBody
	@RequestMapping("deleteClothes")
	public JsonMsg deleteClothes(HttpServletRequest request, @RequestParam("clothesName") String clothesName, 
			@RequestParam("clothesId") Integer clothesId) {
		String picPath = "D:\\uploadFiles\\pic\\";
		Clothes clothes = clothesService.getClothesById(clothesId);
		String oldPic1Name = clothes.getPicture().getPic1();
		String oldFolderName = oldPic1Name.substring(0, oldPic1Name.lastIndexOf("\\"));
		File oldFileFolder = new File(picPath + oldFolderName);
		
		if(oldFileFolder.exists()) {
			ShoppingWebUtil.deleteFile(oldFileFolder);
		}
		
		clothesService.delete(clothesId);
		return JsonMsg.success();
	}
	
	@ResponseBody
	@RequestMapping("/clothesUpdate/{clothesId}")
	public JsonMsg clothesUpdate(HttpServletRequest request, @RequestParam("clothesName") String clothesName, Clothes clothes, 
			@RequestParam(name="files[]", required=false) MultipartFile[] files) throws IOException {
		
		String picPath = "D:\\uploadFiles\\pic\\";
		
		if(files != null && files.length > 0) {
			
			String firstOriginalFilename = files[0].getOriginalFilename();
			
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HHmmss");
			
			String folderName = simpleDateFormat.format(new Date()) +
					 "-" +firstOriginalFilename.substring(0, firstOriginalFilename.lastIndexOf("."));
			
			File fileFolder = new File(picPath + folderName); 
			fileFolder.mkdirs();
			
			String oldPic1Name = clothes.getPicture().getPic1();
			
			String oldFolderName = oldPic1Name.substring(0, oldPic1Name.lastIndexOf("\\"));
			
			File oldFileFolder = new File(picPath + oldFolderName);
			
			if(oldFileFolder.exists()) {
//				FileUtils.forceDelete(oldFileFolder); �ϥ�FileUtils API�R���ɮת���k
				ShoppingWebUtil.deleteFile(oldFileFolder);
			}
			
			List<String> picList = new ArrayList<>();
			
			for(MultipartFile file : files){
				String originalFilename = file.getOriginalFilename();
				System.out.println("originalFilename: " + originalFilename);
				
				String newFileName = folderName + "\\" + originalFilename;
				File newFile = new File(picPath + newFileName);
				file.transferTo(newFile);
				System.out.println(newFileName);
				picList.add(newFileName);
			}
			
			Picture pic = clothes.getPicture();
			
			if(picList.size() == 1) {
				pic.setPic1(picList.get(0));
				pic.setPic2(null);
				pic.setPic3(null);
				pic.setPic4(null);
			}else if(picList.size() == 2) {
				pic.setPic1(picList.get(0));
				pic.setPic2(picList.get(1));
				pic.setPic3(null);
				pic.setPic4(null);
			}else if(picList.size() == 3) {
				pic.setPic1(picList.get(0));
				pic.setPic2(picList.get(1));
				pic.setPic3(picList.get(2));
				pic.setPic4(null);
			}else if(picList.size() == 4) {
				pic.setPic1(picList.get(0));
				pic.setPic2(picList.get(1));
				pic.setPic3(picList.get(2));
				pic.setPic4(picList.get(3));
			}
			
		}
		
		uploadService.saveAndUpdate(clothes);
		return JsonMsg.success();
		
	}
	
	@RequestMapping("/uploadItem/{clothesId}")
	public String updateClothesPage(@PathVariable("clothesId") String clothesIdStr , Map<String, Object> map) {
		int clothesId = -1;
		try {
			clothesId = Integer.parseInt(clothesIdStr);
		} catch (Exception e) {}
		
		map.put("clothesId", clothesId);
		return "WEB-INF/views/uploadItem";
	}
	
	@ResponseBody
	@RequestMapping("/uploadClothes")
	public JsonMsg uploadClothes(HttpServletRequest request, @RequestParam("clothesName") String clothesName, Clothes clothes,
			@RequestParam(name="files[]", required=true) MultipartFile[] files) throws IOException {
		String picPath = "D:\\uploadFiles\\pic\\";
		
		if(files != null && files.length > 0) {
			
			String firstOriginalFilename = files[0].getOriginalFilename();
			
			SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HHmmss");
			
			String folderName = simpleDateFormat.format(new Date()) +
					"-" + firstOriginalFilename.substring(0, firstOriginalFilename.lastIndexOf("."));
			
			File fileFolder = new File(picPath + folderName); 
			if(!fileFolder.exists()) {
				fileFolder.mkdirs();
			}
			
			List<String> picList = new ArrayList<>();
			
			for(MultipartFile file : files){
				String originalFilename = file.getOriginalFilename();
				String newFileName = folderName + "\\" + originalFilename;
				File newFile = new File(picPath + newFileName);
				//file.transferTo() ���ɮצs��i��Ƨ�����k
				file.transferTo(newFile);
				picList.add(newFileName);
			}
			
			Picture pic = new Picture();
			
			//�קK�ū��w���`�A���U�ر��p�]��
			if(picList.size() == 1) {
				pic.setPic1(picList.get(0));
			}else if(picList.size() == 2) {
				pic.setPic1(picList.get(0));
				pic.setPic2(picList.get(1));
			}else if(picList.size() == 3) {
				pic.setPic1(picList.get(0));
				pic.setPic2(picList.get(1));
				pic.setPic3(picList.get(2));
			}else if(picList.size() == 4) {
				pic.setPic1(picList.get(0));
				pic.setPic2(picList.get(1));
				pic.setPic3(picList.get(2));
				pic.setPic4(picList.get(3));
			}
			
			clothes.setPicture(pic);
		}
		
		uploadService.saveAndUpdate(clothes);
		return JsonMsg.success();
		
	}
	
	@RequestMapping("/uploadItem")
	public String toUploadItemPage() {
		return "WEB-INF/views/uploadItem";
	}
	
}
