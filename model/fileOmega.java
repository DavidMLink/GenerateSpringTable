    // CONSTRUCTORS
    public TABLENAME() {
    }

    // creates object
    public TABLENAME(PARAMETERSTRING) {
        POSITIONCREATE
        this.title = title;
        this.description = desc;
        this.language = lang;
        this.numberOfPages = pages;
    }

    // updates object
    public TABLENAME(PARAMETERSTRING) {
        POSITIONUPDATE
        this.id = id;
        this.title = title;
        this.description = desc;
        this.language = lang;
        this.numberOfPages = pages;
    }
    //END OF CONSTRUCTORS
    
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }
}