<%@page import="java.io.File"%>
<%@page import="com.entity.itemdtls"%>
<%!
private String resolveImagePath(javax.servlet.ServletContext app, String fileName) {
    if(fileName == null || fileName.trim().isEmpty()) {
        return "img/j.jpg";
    }

    String[] folders = {"recent", "new", "out", "img"};

    for(String folder : folders) {
        String relativePath = folder + "/" + fileName;
        String absolutePath = app.getRealPath("/" + relativePath);

        if(absolutePath != null && new File(absolutePath).exists()) {
            return relativePath;
        }
    }

    return "img/j.jpg";
}

private boolean isItemAvailable(itemdtls item) {
    return item != null
            && item.getItem_quantity() > 0
            && "Available".equalsIgnoreCase(item.getItem_status());
}
%>
