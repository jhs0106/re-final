package edu.sm.app.repository;

import edu.sm.app.dto.WalkPhotoDto;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface WalkPhotoMapper {

    void insert(WalkPhotoDto photo);

    List<WalkPhotoDto> findByWalkId(@Param("walkingRecodeId") long walkingRecodeId);
}
