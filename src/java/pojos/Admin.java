package pojos;
// Generated Jun 4, 2018 3:43:42 PM by Hibernate Tools 3.6.0


import java.util.HashSet;
import java.util.Set;

/**
 * Admin generated by hbm2java
 */
public class Admin  implements java.io.Serializable {


     private Integer idadmin;
     private String fname;
     private String lname;
     private String mobile;
     private String email;
     private String password;
     private String status;
     private Set<Product> products = new HashSet<Product>(0);
     private Set<Messages> messageses = new HashSet<Messages>(0);

    public Admin() {
    }

    public Admin(String fname, String lname, String mobile, String email, String password, String status, Set<Product> products, Set<Messages> messageses) {
       this.fname = fname;
       this.lname = lname;
       this.mobile = mobile;
       this.email = email;
       this.password = password;
       this.status = status;
       this.products = products;
       this.messageses = messageses;
    }
   
    public Integer getIdadmin() {
        return this.idadmin;
    }
    
    public void setIdadmin(Integer idadmin) {
        this.idadmin = idadmin;
    }
    public String getFname() {
        return this.fname;
    }
    
    public void setFname(String fname) {
        this.fname = fname;
    }
    public String getLname() {
        return this.lname;
    }
    
    public void setLname(String lname) {
        this.lname = lname;
    }
    public String getMobile() {
        return this.mobile;
    }
    
    public void setMobile(String mobile) {
        this.mobile = mobile;
    }
    public String getEmail() {
        return this.email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    public String getPassword() {
        return this.password;
    }
    
    public void setPassword(String password) {
        this.password = password;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public Set<Product> getProducts() {
        return this.products;
    }
    
    public void setProducts(Set<Product> products) {
        this.products = products;
    }
    public Set<Messages> getMessageses() {
        return this.messageses;
    }
    
    public void setMessageses(Set<Messages> messageses) {
        this.messageses = messageses;
    }




}


