package pojos;
// Generated Jun 4, 2018 3:43:42 PM by Hibernate Tools 3.6.0


import java.util.HashSet;
import java.util.Set;

/**
 * WishList generated by hbm2java
 */
public class WishList  implements java.io.Serializable {


     private Integer idwishList;
     private User user;
     private Set<WishListHasItem> wishListHasItems = new HashSet<WishListHasItem>(0);

    public WishList() {
    }

	
    public WishList(User user) {
        this.user = user;
    }
    public WishList(User user, Set<WishListHasItem> wishListHasItems) {
       this.user = user;
       this.wishListHasItems = wishListHasItems;
    }
   
    public Integer getIdwishList() {
        return this.idwishList;
    }
    
    public void setIdwishList(Integer idwishList) {
        this.idwishList = idwishList;
    }
    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    public Set<WishListHasItem> getWishListHasItems() {
        return this.wishListHasItems;
    }
    
    public void setWishListHasItems(Set<WishListHasItem> wishListHasItems) {
        this.wishListHasItems = wishListHasItems;
    }




}

