package edu.sm.app.customer;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

@Mapper
public interface CustomerInquiryRepository {

    List<CustomerInquiry> findAll();

    CustomerInquiry findById(@Param("id") long id);

    void insert(CustomerInquiry inquiry);

    int updateAnswer(@Param("id") long id,
                     @Param("responder") String responder,
                     @Param("answer") String answer,
                     @Param("answeredAt") LocalDateTime answeredAt);
}
