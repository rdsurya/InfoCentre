<%-- 
    Document   : loadCMERectifier
    Created on : Dec 18, 2018, 12:52:45 PM
    Author     : Lenovo
--%>

<%@page import="helper.MySession"%>
<%@page import="helper.BasicJson"%>
<%@page import="org.json.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dbcon.MyConnector"%>
<%
    String node = request.getParameter("node");
    String id = request.getParameter("id");
    String ground = request.getParameter("grounding");
    String witel = "TASIKMALAYA";
    
    String nik = (String) session.getAttribute(MySession.NIK);

    String query = "DELETE FROM cme_grounding WHERE `id`="+id+" AND witel='"+witel+"' AND node='"+node+"' ;";
    MyConnector con = new MyConnector();
    con.createConnection();
    
    con.executeQuery(query);
    
    out.print(new BasicJson().getBasicJson(true, "Grounding "+ground+" node "+node+" telah dihapus.").toString());
    con.activitLog(nik, "cme_battery", "Menghapus data grounding "+ground+" node "+node);
    con.closeConnection();

   
%>
