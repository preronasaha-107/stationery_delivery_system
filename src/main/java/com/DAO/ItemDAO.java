
package com.DAO;

import java.util.List;

import com.entity.itemdtls;

public interface ItemDAO {

    public boolean additems(itemdtls i);

    public List<itemdtls> getAllItems();
    public List<itemdtls> searchItems(String keyword);
    
    public itemdtls getItemById(int id);
  
    
    public boolean updateEditItems(itemdtls i);
    public boolean deleteItems(int i);
    
    
    
}
