package com.GROUP.ARTIFACT.service;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

import com.GROUP.ARTIFACT.model.TABLENAME;
import com.GROUP.ARTIFACT.repository.TABLENAMERepository;

@Service
public class TABLENAMEService {
    // adding the TABLENAME repository as a dependency
    private final TABLENAMERepository LOWERCASERepository;
    
    public TABLENAMEService(TABLENAMERepository LOWERCASERepository) {
        this.LOWERCASERepository = LOWERCASERepository;
    }

    // CRUD METHODS
    
        // CREATE
        public TABLENAME createTABLENAME(TABLENAME b) {
            return LOWERCASERepository.save(b);
        }
        // END OF CREATE

        // READ
        public List<TABLENAME> allTABLENAMEs() {
            return LOWERCASERepository.findAll();
        }

        public TABLENAME findTABLENAME(Long id) {
            Optional<TABLENAME> optionalTABLENAME = LOWERCASERepository.findById(id);
            if(optionalTABLENAME.isPresent()) {
                return optionalTABLENAME.get();
            } else {
                return null;
            }
        }
        // END OF READ

        // UPDATE
        public TABLENAME updateTABLENAME(TABLENAME b){
            return LOWERCASERepository.save(b);
        }
        // END OF UPDATE

        // DELETE
        public void deleteTABLENAME(Long id){
            LOWERCASERepository.deleteById(id);
        }
        // END OF DELETE
        
    // END OF CRUD METHODS
}