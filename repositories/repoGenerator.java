package com.GROUP.ARTIFACT.repositories;

import java.util.List;
import java.util.Optional;

import com.GROUP.ARTIFACT.models.TABLENAME;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TABLENAMERepository extends CrudRepository<TABLENAME, Long>{

    // CRUD METHODS

        // CREATE

        // END OF CREATE

        // READ
        
        List<TABLENAME> findAll();
        
        // List<TABLENAME> findByDescriptionContaining(String search);
        
        // Long countByTitleContaining(String search);
        
        // END OF READ

        // UPDATE

        // END OF UPDATE

        // DELETE

        // Long deleteByTitleStartingWith(String search);

        // this method deletes a TABLENAME by id
        List<TABLENAME> deleteById(long id);

        // END OF DELETE

    // END OF CRUD METHODS

}