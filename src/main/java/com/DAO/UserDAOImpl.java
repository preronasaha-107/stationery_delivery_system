package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.entity.User;

public class UserDAOImpl implements UserDAO {
    private Connection conn;

    public UserDAOImpl(Connection conn) {
        super();
        this.conn = conn;
    }

    public boolean userRegister(User us) {
        boolean f = false;
        try {
            if(userExists(us.getEmail())) {
                return false;
            }
            String sql = "insert into user(name,email,phno,password) values(?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, us.getName());
            ps.setString(2, us.getEmail());
            ps.setString(3, us.getPhno());
            ps.setString(4, us.getPassword());
            int i=ps.executeUpdate();
            if(i==1)
            {
                f=true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

	@Override
	public User login(String email, String password) {
		User us=null;
		   

		    try {
		        String sql="select * from user where lower(trim(email))=? and password=? limit 1";
		        PreparedStatement ps=conn.prepareStatement(sql);
		        ps.setString(1, email == null ? "" : email.trim().toLowerCase());
		        ps.setString(2, password);

		        ResultSet rs=ps.executeQuery();
		        while(rs.next())
		        {
		            us=new User();
		            us.setId(rs.getInt(1));
		            us.setName(rs.getString("name"));
		            us.setEmail(rs.getString("email"));
		            us.setPhno(rs.getString("phno"));
		            us.setPassword(rs.getString("password"));
		            us.setAddress(getOptionalString(rs, "address"));
		            us.setLandmark(getOptionalString(rs, "landmark"));
		            us.setCity(getOptionalString(rs, "city"));
		            us.setState(getOptionalString(rs, "state"));
		            us.setPincode(getOptionalString(rs, "pincode"));
		        }
		    
		    } catch (Exception e) {
		        e.printStackTrace();
		    }

		  return us;
		}

	@Override
	public boolean userExists(String email) {
		boolean exists = false;

		try {
			String sql = "select 1 from user where lower(trim(email))=? limit 1";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, email == null ? "" : email.trim().toLowerCase());

			ResultSet rs = ps.executeQuery();
			exists = rs.next();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return exists;
	}

	private String getOptionalString(ResultSet rs, String columnName) {
		try {
			return rs.getString(columnName);
		} catch (Exception e) {
			return null;
		}
	}
		
	}
    
