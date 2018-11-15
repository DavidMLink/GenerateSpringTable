package com.GROUP.ARTIFACT.controller;

import java.util.List;

import javax.validation.Valid;

import com.GROUP.ARTIFACT.model.TABLENAME;
import com.GROUP.ARTIFACT.service.TABLENAMEService;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TABLENAMEsController {
    private final TABLENAMEService LOWERCASEService;
    
    public TABLENAMEsController(TABLENAMEService LOWERCASEService) {
        this.LOWERCASEService = LOWERCASEService;
    }

    // Start Here

}