package com.GROUP.ARTIFACT.controllers;

import java.util.List;

import javax.validation.Valid;

import com.GROUP.ARTIFACT.models.TABLENAME;
import com.GROUP.ARTIFACT.services.TABLENAMEService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TABLENAMEController {
    private final TABLENAMEService LOWERCASEService;
    
    public TABLENAMEController(TABLENAMEService LOWERCASEService) {
        this.LOWERCASEService = LOWERCASEService;
    }

    // Start Here

}