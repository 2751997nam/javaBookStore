package models.database;

import config.Database;
import static controllers.Controller.number;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpServletRequest;

public class DB {

    protected Connection connection;
    protected String table;
    protected String class_name;
    protected Query query;

    public DB() {
        try {
            this.connection = MySQLConnect.getMySQLConnection();
            this.query = new Query();
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public DB(String table) {
        try {
            this.table = table;
            this.connection = MySQLConnect.getMySQLConnection();
            this.query = new Query();
            this.query.setFrom("From " + table);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e);
        }
    }

    public DB(String table, String class_name) {
        try {
            this.table = table;
            this.connection = MySQLConnect.getMySQLConnection();
            this.query = new Query();
            this.query.setFrom("From " + table);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e);
        }
        this.class_name = "models." + class_name;
    }
    
    public void flush() {
        this.query = new Query();
        this.table = null;
        this.class_name = null;
    }
    
    public DB newQuery(String table) {
        flush();
        this.table = table;
        this.query.setFrom("From " + table);
        
        return this;
    }
    
    public String antiInjection(String sql) {
        sql = sql.replaceAll("\'+|\"+|(--)+", "");
        
        return sql;
    }
    
    public Connection getConnection()
    {
        return this.connection;
    }
    
    public DB newQuery(String table, String class_name) {
        flush();
        this.table = table;
        this.class_name = class_name;
        this.query.setFrom("From " + table);
        
        return this;
    }

    public String getQuery() {
        return this.query.toString();
    }

    // thực hiện câu truy vấn select, trả về List các model
    public List execute(String query) {
        List result = new ArrayList();
        try {
            System.out.println(query);
            Statement statement = this.connection.createStatement();

            ResultSet rs = statement.executeQuery(query);
            while (rs.next()) {
                HashMap<String, String> cols = new HashMap();
                int length = rs.getMetaData().getColumnCount();
                for (int i = 1; i <= length; i++) {
                    cols.put(rs.getMetaData().getColumnName(i), rs.getString(i));
                }
                result.add(Class.forName(this.class_name).getConstructor(HashMap.class).newInstance(cols));
            }
            this.connection.close();
        } catch (InstantiationException | IllegalAccessException
                | IllegalArgumentException | InvocationTargetException
                | ClassNotFoundException | NoSuchMethodException | SQLException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    //thực hiện câu truy vấn select, kết quả trả về List HashMap<String, String>
    public List excuteWithoutClass(String query) {
        List result = new ArrayList();
        try {
            System.out.println(query);
            Statement statement = this.connection.createStatement();

            ResultSet rs = statement.executeQuery(query);
            while (rs.next()) {
                HashMap<String, String> map = new HashMap();
                int length = rs.getMetaData().getColumnCount();
                for (int i = 1; i <= length; i++) {
                    map.put(rs.getMetaData().getColumnName(i), rs.getString(i));
                }

                result.add(map);
            }
            this.connection.close();
        } catch (IllegalArgumentException | SQLException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return result;
    }

    //kiểm tra câu truy vấn select có trả về kết quả gì không
    public boolean checkQuery(String query) {
        try {
            System.out.println(query);
            Statement statement = this.connection.createStatement();
            ResultSet rs = statement.executeQuery(query);
            if (rs.next()) {
                this.connection.close();
                return true;
            }
            this.connection.close();
        } catch (SQLException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
            System.out.println(ex);
        }

        return false;
    }

    //kiểm tra câu truy vấn select có trả về kết quả gì không
    public boolean checkQuery() {
        return this.checkQuery(this.query.toString());
    }

    // chạy các câu truy vấn insert, update, delete
    public void executeQuery(String sql) {
        try {
            Statement statement = this.connection.createStatement();
            System.out.println(sql);
            statement.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // chạy các câu truy vấn insert, update, delete
    public void execute() {
        this.executeQuery(this.query.toString());
    }

    public void newQuery() {
        this.query = new Query();
    }

    // trả về tất cả bản ghi trong 1 bảng
    public List all() {
        return execute("Select * from " + this.table);
    }

    //insert 1 số trường trong 1 bảng
    public DB insert(Map<String, String> map) {
        this.query.setCommand("INSERT INTO");
        this.query.setFrom(this.table);
        this.query.setColumns("(");
        this.query.setColumnValues(" Values ( ");
        Iterator<Map.Entry<String, String>> iter = map.entrySet().iterator();
        map.entrySet().forEach((entry) -> {
            String key = this.query.getColumns() + antiInjection(entry.getKey());
            String value = this.query.getColumnValues() + "\'" + antiInjection(entry.getValue()) + "\'";
            iter.next();
            if (iter.hasNext()) {
                this.query.setColumns(key + ", ");
                this.query.setColumnValues(value + ", ");
            } else {
                this.query.setColumns(key + " )");
                this.query.setColumnValues(value + ")");
            }
        });
        this.execute();

        return this;
    }

    public DB update(Map<String, String> map) {
        this.query.setCommand("Update");
        this.query.setFrom(this.table);
        String sql = "SET ";
        ArrayList<String> sets = new ArrayList();
        map.entrySet().forEach((entry) -> {
            sets.add(antiInjection(entry.getKey()) + " = " + "\'" + antiInjection(entry.getValue()) + "\'");
        });

        for (String set : sets) {
            sql += set + ", ";
        }
        sql += "updated_at = CURRENT_TIMESTAMP";
        this.query.setUpdate(sql);
        this.execute();
        
        return this;
    }

    public void update(Object obj) {
        this.query.setCommand("Update");
        this.query.setFrom(this.table);
        String sql = "SET ";

        this.execute();
    }

    public DB delete() {
        this.query.setCommand("Delete");

        return this;
    }

    public DB select(String select) {
        this.query.setCommand("SELECT " + antiInjection(select));

        return this;
    }

    public DB insert() {
        this.query.setCommand("INSERT INTO ");

        return this;
    }

    public DB update() {
        this.query.setCommand("UPDATE ");

        return this;
    }

    // chọn bảng cho câu truy vấn
    public DB table(String table) {
        this.query.setFrom(antiInjection(table));

        return this;
    }

    public DB where(String[] wheres) {
        String allWhere = "WHERE ";
        int length = wheres.length;
        for (String where : wheres) {
            allWhere += antiInjection(where);
            if (where.compareTo(wheres[length - 1]) != 0) {
                allWhere += " AND ";
            }
        }
        this.query.setWhere(allWhere);

        return this;
    }

    public DB whereNotString(String key, String operator, String value) {
        String where = this.query.getWhere() + " AND ";
        if (this.query.getWhere().isEmpty()) {
            where = "WHERE ";
        }
        where += antiInjection(key) + " " + antiInjection(operator) + " ";
        where += antiInjection(value);
        this.query.setWhere(where);

        return this;
    }

    public DB where(String key, String operator, String value) {
        String where = this.query.getWhere() + " AND ";
        if (this.query.getWhere().isEmpty()) {
            where = "WHERE ";
        }
        where += antiInjection(key) + " " + antiInjection(operator);
        where += " \'" + antiInjection(value) + "\' ";

        this.query.setWhere(where);

        return this;
    }

    public DB whereIn(String column, String where) {
        String whereIn = "Where " + antiInjection(column) + " IN (" + antiInjection(where) + ")";
        this.query.setWhere(whereIn);

        return this;
    }

    public DB groupBy(String groupBy) {
        this.query.setGroupBy("GROUP BY " + antiInjection(groupBy));

        return this;
    }

    public DB orderBy(String order) {
        this.query.setOrderBy("Order By " + antiInjection(order));
        return this;
    }

    public DB having(String having) {
        this.query.setHaving("HAVING " + antiInjection(having));
        return this;
    }

    //thực hiện câu truy vấn select
    public List get() {
        if (this.class_name != null) {
            return execute(this.query.toString());
        } else {
            return excuteWithoutClass(this.query.toString());
        }
    }

    // phân trang
    public DB paginate(HttpServletRequest request, int limit) {
        int current = 1, page_number = 0;
        if (request.getParameter("page") != null) {
            current = Integer.parseInt(request.getParameter("page"));
        }
        Query sql = this.query;
        String command = this.query.getCommand();
        sql.setCommand("SELECT count(*) as paginate");
        try {
            System.out.println(query);
            Statement statement = this.connection.createStatement();

            ResultSet rs = statement.executeQuery(sql.toString());
            while (rs.next()) {
                page_number = rs.getInt("paginate");
            }
        } catch (IllegalArgumentException | SQLException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }
        this.query.setCommand(command);
        number = page_number % limit == 0 ? page_number / limit : page_number / limit + 1;

        this.query.setLimit(limit);
        this.query.setPaginate("Offset " + limit * (current - 1));

        return this;
    }
    
    public DB paginate(HttpServletRequest request)
    {
        this.paginate(request, Integer.parseInt(new Database().get("paginate")));
        
        return this;
    }

    // tìm tổng số trong trong phân trang
    public int getPageNumber(int limit, int offset) {
        int page_number = 0;
        try {
            String sql = "SELECT (CASE\n"
                    + "WHEN COUNT(*) % " + limit + " = 0\n"
                    + "THEN COUNT(*) DIV " + limit + "\n"
                    + "ELSE COUNT(*) DIV " + limit + " + 1\n"
                    + "END) as total\n"
                    + "FROM " + this.table;

            Statement statement = this.connection.createStatement();

            ResultSet rs = statement.executeQuery(sql);

            while (rs.next()) {
                page_number = rs.getInt("total");
            }

        } catch (SQLException ex) {
            Logger.getLogger(DB.class.getName()).log(Level.SEVERE, null, ex);
        }

        return page_number;
    }

    // tìm 1 model theo id
    public Object find(int id) {
        Object obj = new Object();

        obj = this.where(new String[]{"id = " + id}).execute(this.query.toString()).get(0);

        return obj;
    }

    // lấy số lượng bản ghi tối đa trong câu truy vấn
    public DB limit(int limit) {
        this.query.setLimit(limit);

        return this;
    }

    public String getClassName(String column) {
        return "models." + column.toUpperCase().charAt(0) + column.substring(1, column.length() - 3);
    }

    public DB join(String table, String col1, String opt, String col2) {
        String sql = "Inner Join " + antiInjection(table) + " ON " + antiInjection(col1) + " " + antiInjection(opt) + " " + antiInjection(col2) + "\n";
        this.query.setJoin(sql);

        return this;
    }

    public DB join(String table, String col1, String col2) {
        String sql = "Inner Join " + antiInjection(table) + " ON " + antiInjection(col1) + " = " + antiInjection(col2) + "\n";
        this.query.setJoin(sql);

        return this;
    }
}
