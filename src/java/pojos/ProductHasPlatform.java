package pojos;
// Generated Jun 4, 2018 3:43:42 PM by Hibernate Tools 3.6.0



/**
 * ProductHasPlatform generated by hbm2java
 */
public class ProductHasPlatform  implements java.io.Serializable {


     private Integer idproductHasPlatform;
     private SfPlatform sfPlatform;
     private Product product;

    public ProductHasPlatform() {
    }

    public ProductHasPlatform(SfPlatform sfPlatform, Product product) {
       this.sfPlatform = sfPlatform;
       this.product = product;
    }
   
    public Integer getIdproductHasPlatform() {
        return this.idproductHasPlatform;
    }
    
    public void setIdproductHasPlatform(Integer idproductHasPlatform) {
        this.idproductHasPlatform = idproductHasPlatform;
    }
    public SfPlatform getSfPlatform() {
        return this.sfPlatform;
    }
    
    public void setSfPlatform(SfPlatform sfPlatform) {
        this.sfPlatform = sfPlatform;
    }
    public Product getProduct() {
        return this.product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }




}

