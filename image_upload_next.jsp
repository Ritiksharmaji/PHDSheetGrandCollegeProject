<%@ include file="javabean.jsp"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>

<%
   File file;
   boolean uploadSuccess = false; // Flag to track upload status
   int maxFileSize = 500 * 1024 * 1024; // 500 MB
   int maxMemSize = 40 * 1024 * 1024;  // 40 MB

   String quer = "";
   String newfilename =null;

   // Get session attributes safely
   int ds = (Integer) session.getAttribute("type");
   String name_prefix = "";
   
   String appno = (String) session.getAttribute("appno");
   String empp = (String) session.getAttribute("emp");
   newfilename = empp;
   String filePath = "D:\\package\\newext\\RSGRANTS";
   int type = ds;

   String sdn = "select * from facultygrants.file_names fn where id=" + type;


   Statement st2 = null;
   ResultSet rs2 = null;
       
   try {
       st2 = conn.createStatement();
       rs2 = st2.executeQuery(sdn);
       if (rs2 != null && rs2.next()) {
        
        name_prefix += "_"+rs2.getString("file_prefix")+"_" + rs2.getInt("file_count");
    } else {
           
       }
   } catch (Exception e) {
       e.printStackTrace();
   } finally {
       if (st2 != null) {
           try {
               st2.close();
               rs2.close();
           } catch (Exception e) {
               e.printStackTrace();
           }
       }
   }



   // Verify the content type
   String contentType = request.getContentType();

   if (contentType != null && contentType.indexOf("multipart/form-data") >= 0) {

       DiskFileItemFactory factory = new DiskFileItemFactory();
       // maximum size stored in memory
       factory.setSizeThreshold(maxMemSize);

       // Location to save data that is larger than maxMemSize.
       factory.setRepository(new File("D:\\package\\newext\\RSGRANTS"));

       // Create a new file upload handler
       ServletFileUpload upload = new ServletFileUpload(factory);

       // maximum file size to be uploaded.
       upload.setSizeMax(maxFileSize);

       try {
           // Parse the request to get file items.
           List<FileItem> fileItems = upload.parseRequest(request);

           // Process the uploaded file items
           Iterator<FileItem> i = fileItems.iterator();

           while (i.hasNext()) {
               FileItem fi = i.next();
               if (!fi.isFormField()) {
                   // Get the uploaded file parameters
                   String fieldName = fi.getFieldName();
                   String fileName = fi.getName();



                   if (fileName != null && !fileName.isEmpty()) {
                       String[] fileNameSplits = fileName.split("\\.");
                       int extensionIndex = fileNameSplits.length - 1;
                       newfilename += name_prefix + "." + fileNameSplits[extensionIndex];
                       File uploadedFile = new File(filePath, newfilename);
                       fi.write(uploadedFile);
                       uploadSuccess = true; // Set flag to true if the file is successfully written
                   } else {
                       throw new Exception("File name is empty or null.");
                   }
               }
           }
       } catch (Exception ex) {
           ex.printStackTrace();
           out.println("File upload failed due to an error: " + ex.getMessage());
       }
   } else {
       out.println("Invalid content type for file upload.");
   }


   if(ds==1)
   {
    quer = " update facultygrants.projectdetails set b_description_img_file='"+newfilename+"' where appno='"+appno+"'";
   }
   
   else if(ds==2)
   {
    quer = " update facultygrants.projectdetails set b_description_img_file='"+newfilename+"' where appno='"+appno+"'";
   }
   else if(ds==3)
   {
    quer = " update facultygrants.projectdetails set b_description_img_file='"+newfilename+"' where appno='"+appno+"'";
   }

   else if(ds==4)
   {
    quer = " update facultygrants.projectdetails set b_review_img_file='"+newfilename+"' where appno='"+appno+"'";
   }

   // Print the upload status
   if (uploadSuccess) {
       out.println("File successfully uplodfdaded.");
       // Update the file count in the database
       String fcoin = "UPDATE facultygrants.file_names SET file_count = file_count + 1 WHERE id=" + type;

       Statement st = null;
       
       try {
           st = conn.createStatement();
           int updateCount = st.executeUpdate(fcoin);
           if (updateCount > 0) {
               
           } else {
               
           }
       } catch (Exception e) {
           e.printStackTrace();
       } finally {
           if (st != null) {
               try {
                   st.close();
               } catch (Exception e) {
                   e.printStackTrace();
               }
           }
       }


       Statement st1 = null;
       
       try {
           st1 = conn.createStatement();
           int updateCount = st1.executeUpdate(quer);
           if (updateCount > 0) {
               
           } else {
               
           }
       } catch (Exception e) {
           e.printStackTrace();
       } finally {
           if (st1 != null) {
               try {
                   st1.close();
               } catch (Exception e) {
                   e.printStackTrace();
               }
           }
       }
       
       
       %>
       <script>
        alert("File Uploaded Successfully");
       </script>
       <%
   } else {
       out.println("File upload failed.");
       %>
       <script>
        alert("Error Occured");
       </script>
       <%
   }

   String dfse = "image_upload_file.jsp?ses="+type;
   response.sendRedirect(dfse);
%>

<%@ include file="dbClose.jsp" %>
