<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession se = request.getSession();
    String language =  (se.getAttribute("locale") == null) ? "en" : (String) se.getAttribute("locale");
%>
