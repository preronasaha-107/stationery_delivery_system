<%@page import="java.io.File"%>
<%@page import="java.util.Locale"%>
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

private String formatPrice(String price) {
    if(price == null || price.trim().isEmpty()) {
        return "0.00";
    }

    try {
        return String.format(Locale.US, "%.2f", Double.parseDouble(price.trim()));
    } catch (Exception e) {
        return price.trim();
    }
}
%>
