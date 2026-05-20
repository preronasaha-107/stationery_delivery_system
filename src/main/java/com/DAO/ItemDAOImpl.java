package com.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.entity.itemdtls;

public class ItemDAOImpl implements ItemDAO {

    private Connection conn;

    public ItemDAOImpl(Connection conn) {

        super();

        this.conn = conn;
    }

    public boolean additems(itemdtls i) {

        boolean f = false;

        try {
            
            String sql =
            "insert into itemdtl(item_name,item_quantity,price,category,item_status,photoname,email) values(?,?,?,?,?,?,?)";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1, i.getItem_name());

            ps.setInt(2, i.getItem_quantity());

            ps.setString(3, i.getPrice());

            ps.setString(4, i.getCategory());

            ps.setString(5, i.getItem_status());

            ps.setString(6, i.getPhotoname());

            ps.setString(7, i.getEmail());

            int ii = ps.executeUpdate();

            if(ii == 1) {

                f = true;
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return f;
    }

    @Override
    public List<itemdtls> getAllItems() {
        return getItemsFromQuery(
                "select * from itemdtl order by item_id desc",
                new SqlParameterSetter() {
                    @Override
                    public void apply(PreparedStatement ps) throws Exception {
                    }
                });
    }

    @Override
    public List<itemdtls> getDistinctCatalogItems() {

        List<itemdtls> list = getItemsFromQuery(
                "select * from itemdtl order by item_id desc",
                new SqlParameterSetter() {
                    @Override
                    public void apply(PreparedStatement ps) throws Exception {
                    }
                });

        return deduplicateByName(list, 0);
    }

    @Override
    public List<itemdtls> getLatestItems(int limit) {
        List<itemdtls> list = getItemsFromQuery(
                "select * from itemdtl order by item_id desc",
                new SqlParameterSetter() {
                    @Override
                    public void apply(PreparedStatement ps) throws Exception {
                    }
                });

        return deduplicateByName(list, limit);
    }

    @Override
    public List<itemdtls> getRecommendedItems(int limit) {
        List<itemdtls> list = getItemsFromQuery(
                "select * from itemdtl where item_status=? and item_quantity > 0 order by item_quantity desc, item_id desc",
                new SqlParameterSetter() {
                    @Override
                    public void apply(PreparedStatement ps) throws Exception {
                        ps.setString(1, "Available");
                    }
                });

        return deduplicateByName(list, limit);
    }

    @Override
    public List<itemdtls> getItemsByStatus(String status) {
        List<itemdtls> list = getItemsFromQuery(
                "select * from itemdtl where item_status=? order by item_id desc",
                new SqlParameterSetter() {
                    @Override
                    public void apply(PreparedStatement ps) throws Exception {
                        ps.setString(1, status);
                    }
                });

        return deduplicateByName(list, 0);
    }

    @Override
    public List<itemdtls> searchItems(String keyword) {

        List<itemdtls> list = new ArrayList<itemdtls>();

        try {
            if(keyword == null) {
                keyword = "";
            }
            keyword = keyword.trim();

            String search = "%" + keyword.toLowerCase() + "%";
            list = getItemsFromQuery(
                    "select * from itemdtl where lower(item_name) like ? or lower(category) like ? or lower(item_status) like ? order by item_id desc",
                    new SqlParameterSetter() {
                        @Override
                        public void apply(PreparedStatement ps) throws Exception {
                            ps.setString(1, search);
                            ps.setString(2, search);
                            ps.setString(3, search);
                        }
                    });

        } catch (Exception e) {

            e.printStackTrace();
        }

        return deduplicateByName(list, 0);
    }

    @Override
    public boolean itemNameExists(String itemName) {
        return itemNameExists(itemName, 0);
    }

    @Override
    public boolean itemNameExists(String itemName, int excludeId) {
        boolean exists = false;

        try {
            String sql =
                    "select 1 from itemdtl where lower(trim(item_name))=? and item_id<>? limit 1";

            PreparedStatement ps =
                    conn.prepareStatement(sql);

            ps.setString(1, normalizeName(itemName));
            ps.setInt(2, excludeId);

            ResultSet rs =
                    ps.executeQuery();

            exists = rs.next();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return exists;
    }

	@Override
	public itemdtls getItemById(int id) {
		    itemdtls i=null;
		    try {
		        String sql="select * from itemdtl where item_id=?";
		        PreparedStatement ps=conn.prepareStatement(sql);
		        ps.setInt(1, id);

		        ResultSet rs=ps.executeQuery();
		        while(rs.next())
		        {   
		        	i=mapItem(rs);
		        }

		    } catch (Exception e) {
		        e.printStackTrace();
		    }
		return i;
	
	}

	@Override
	public boolean updateEditItems(itemdtls i) {

	    boolean f = false;

	    try {

	        String sql =
	        "update itemdtl set item_name=?,item_quantity=?,price=?,category=?,item_status=? where item_id=?";

	        PreparedStatement ps =
	                conn.prepareStatement(sql);

	        ps.setString(1, i.getItem_name());

	        ps.setInt(2, i.getItem_quantity());

	        ps.setString(3, i.getPrice());

	        ps.setString(4, i.getCategory());

	        ps.setString(5, i.getItem_status());

	        ps.setInt(6, i.getItem_id());

	        int row = ps.executeUpdate();

	        if(row == 1){

	            f = true;
	        }

	    } catch (Exception e) {

	        e.printStackTrace();
	    }

	    return f;
	}

	public boolean deleteItems(int id) {
	    boolean f = false;
	    try {
	    	String sql = "delete from itemdtl where item_id=?";
	    	PreparedStatement ps = conn.prepareStatement(sql);
	    	ps.setInt(1, id);
	        
	        
	        int i = ps.executeUpdate();
	        if (i == 1) {
	            f = true;
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return f;
	
	}

    private itemdtls mapItem(ResultSet rs) throws Exception {

        itemdtls i = new itemdtls();

        i.setItem_id(rs.getInt(1));
        i.setItem_name(rs.getString(2));
        i.setItem_quantity(rs.getInt(3));
        i.setPrice(rs.getString(4));
        i.setCategory(rs.getString(5));
        i.setItem_status(rs.getString(6));
        i.setPhotoname(rs.getString(7));
        i.setEmail(rs.getString(8));

        return i;
    }

    private List<itemdtls> getItemsFromQuery(String sql,
            SqlParameterSetter setter) {

        List<itemdtls> list = new ArrayList<itemdtls>();

        try {
            PreparedStatement ps =
                    conn.prepareStatement(sql);

            setter.apply(ps);

            ResultSet rs =
                    ps.executeQuery();

            while(rs.next()) {
                list.add(mapItem(rs));
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return list;
    }

    private List<itemdtls> deduplicateByName(List<itemdtls> items, int limit) {

        Map<String, itemdtls> uniqueItems = new LinkedHashMap<String, itemdtls>();

        for(itemdtls item : items) {
            String key = normalizeName(item.getItem_name());

            if(key.isEmpty()) {
                key = "item-id-" + item.getItem_id();
            }

            if(!uniqueItems.containsKey(key)) {
                uniqueItems.put(key, item);
            }
        }

        List<itemdtls> deduplicatedItems = new ArrayList<itemdtls>(uniqueItems.values());

        if(limit > 0 && deduplicatedItems.size() > limit) {
            return new ArrayList<itemdtls>(deduplicatedItems.subList(0, limit));
        }

        return deduplicatedItems;
    }

    private String normalizeName(String itemName) {
        if(itemName == null) {
            return "";
        }

        return itemName.trim().toLowerCase(Locale.ENGLISH);
    }

    private interface SqlParameterSetter {
        void apply(PreparedStatement ps) throws Exception;
    }

}
