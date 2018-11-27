package pojos;
// Generated Jun 4, 2018 3:43:42 PM by Hibernate Tools 3.6.0


import java.util.HashSet;
import java.util.Set;

/**
 * SellerHasPackage generated by hbm2java
 */
public class SellerHasPackage  implements java.io.Serializable {


     private Integer sellerHasPackageId;
     private SellerPackage sellerPackage;
     private Seller seller;
     private Integer remainingAddTime;
     private String status;
     private Set<InvoicePackage> invoicePackages = new HashSet<InvoicePackage>(0);

    public SellerHasPackage() {
    }

	
    public SellerHasPackage(SellerPackage sellerPackage, Seller seller) {
        this.sellerPackage = sellerPackage;
        this.seller = seller;
    }
    public SellerHasPackage(SellerPackage sellerPackage, Seller seller, Integer remainingAddTime, String status, Set<InvoicePackage> invoicePackages) {
       this.sellerPackage = sellerPackage;
       this.seller = seller;
       this.remainingAddTime = remainingAddTime;
       this.status = status;
       this.invoicePackages = invoicePackages;
    }
   
    public Integer getSellerHasPackageId() {
        return this.sellerHasPackageId;
    }
    
    public void setSellerHasPackageId(Integer sellerHasPackageId) {
        this.sellerHasPackageId = sellerHasPackageId;
    }
    public SellerPackage getSellerPackage() {
        return this.sellerPackage;
    }
    
    public void setSellerPackage(SellerPackage sellerPackage) {
        this.sellerPackage = sellerPackage;
    }
    public Seller getSeller() {
        return this.seller;
    }
    
    public void setSeller(Seller seller) {
        this.seller = seller;
    }
    public Integer getRemainingAddTime() {
        return this.remainingAddTime;
    }
    
    public void setRemainingAddTime(Integer remainingAddTime) {
        this.remainingAddTime = remainingAddTime;
    }
    public String getStatus() {
        return this.status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    public Set<InvoicePackage> getInvoicePackages() {
        return this.invoicePackages;
    }
    
    public void setInvoicePackages(Set<InvoicePackage> invoicePackages) {
        this.invoicePackages = invoicePackages;
    }




}

