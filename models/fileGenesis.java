package com.GROUP.ARTIFACT.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.OneToOne;
import javax.persistence.OneToMany;
import javax.persistence.ManyToOne;
import javax.persistence.ManyToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.Size;
import javax.persistence.JoinColumn;


@Entity
@Table(name="LOWERCASEPLURAL") //You may need to rename me if this is the third table in a MANY TO MANY relationship...
public class TABLENAME {
    //PrimaryKey
    @Id
    //PrimaryKey AutoGeneration
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    