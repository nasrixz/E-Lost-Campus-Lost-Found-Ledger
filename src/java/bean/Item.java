package bean;

public class Item {

    private int itemId;
    private String itemName;
    private String category;
    private String reportType;
    private String dateLostFound;
    private String description;
    private String building;
    private String specificLoc;
    private String photo;
    private String status;
    private int userId;

    public Item() {
    }

    public int getItemId() {
        return itemId;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getReportType() {
        return reportType;
    }

    public void setReportType(String reportType) {
        this.reportType = reportType;
    }

    public String getDateLostFound() {
        return dateLostFound;
    }

    public void setDateLostFound(String dateLostFound) {
        this.dateLostFound = dateLostFound;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getBuilding() {
        return building;
    }

    public void setBuilding(String building) {
        this.building = building;
    }

    public String getSpecificLoc() {
        return specificLoc;
    }

    public void setSpecificLoc(String specificLoc) {
        this.specificLoc = specificLoc;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}