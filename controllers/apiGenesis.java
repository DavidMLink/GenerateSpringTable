package com.GROUP.ARTIFACT.controllers;

import java.util.List;

import com.GROUP.ARTIFACT.models.TABLENAME;
import com.GROUP.ARTIFACT.services.TABLENAMEService;

import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TABLENAMECRUD {
    private final TABLENAMEService LOWERCASEService;
    public TABLENAMECRUD(TABLENAMEService LOWERCASEService){
        this.LOWERCASEService = LOWERCASEService;
    }
    
    // CRUD

        // CREATE
            @RequestMapping(value="/api/LOWERCASEs", method=RequestMethod.POST)