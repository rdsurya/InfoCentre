<%@page import="dbcon.MyConnector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="database.*"%>
<%@page import="Model.*"%>
<%@page import="Controller.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
       
        <%
            String a = request.getParameter("lokasi_sto");
            String b = request.getParameter("core");
            String c = request.getParameter("pjg_kabel");
            String d = request.getParameter("tipe_kabel");
            String e = request.getParameter("jenis_kabel");
            String f = request.getParameter("tanggal");
            String g = request.getParameter("tanggal_baru");

            System.out.println(request.getParameterMap());
            
            Connection connection = null;
            Statement statement = null;
            MyConnector connector = new MyConnector();
            connector.createConnection();
            connection = connector.getConnection();
            statement = connection.createStatement();
            PreparedStatement ps = null; 
            
            int updateQuery = 0;
            if (a != null && b != null && c != null && d != null && e != null && f != null) {
                if (a != "" && b != "" && c != "" && d != "" && e != "" && f != "" ) {
                    try {
                        String query = "UPDATE tb_lokasi SET lokasi_sto=?, core=?, pjg_kabel=?, tipe_kabel=?, jenis_kabel=?, tanggal=? where core = '" + b + "' ";
                        System.out.println(query);
                        ps = connection.prepareStatement(query);
                        ps.setString(1, a);
                        ps.setString(2, b);
                        ps.setString(3, c);
                        ps.setString(4, d);
                        ps.setString(5, e);
                        ps.setString(6, g);
                        System.out.println(ps.toString());
                        updateQuery = ps.executeUpdate();
                        
                        String query2 = "UPDATE tb_data set tanggal=? WHERE tanggal='"+f+"' AND core='"+b+"';";
                        ps = connection.prepareStatement(query2);
                        ps.setString(1, g);
                        System.out.println(ps.toString());
                        updateQuery = ps.executeUpdate();
                        if (updateQuery != 0) {
                            out.println("Updated");
                            response.sendRedirect("dataCore.jsp?core="+b+"&&lokasi_sto="+a+" ");
                        }
                    } catch (Exception ex) {
                        out.println("Koneksi bermasalah " + ex.getMessage());
                    } finally {
                        ps.close();
                        connection.close();
                    }
                }
            }
        %> 
