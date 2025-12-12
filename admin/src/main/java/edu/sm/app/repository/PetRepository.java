package edu.sm.app.repository;

import edu.sm.app.dto.Pet;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface PetRepository {

    int insert(Pet pet);

    Pet select(@Param("petId") int petId);

    List<Pet> selectAll();

    List<Pet> selectByUserId(@Param("userId") int userId);

    int update(Pet pet);

    int delete(@Param("petId") int petId);

    int countByUserId(@Param("userId") int userId);
    
}
