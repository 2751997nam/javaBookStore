<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String language =  (session.getAttribute("locale") == null) ? "en" : (String) session.getAttribute("locale");
%>
