package edu.sm.app.repository;

import edu.sm.app.dto.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserRepository {

    int insert(User user);

    User select(@Param("userId") int userId);

    User selectByUsername(@Param("username") String username);

    List<User> selectAll();

    int update(User user);

    int updatePassword(@Param("userId") int userId, @Param("newPassword") String newPassword);

    int updateLastLogin(@Param("userId") int userId);

    int delete(@Param("userId") int userId);

    boolean existsByUsername(@Param("username") String username);

    boolean existsByEmail(@Param("email") String email);

    int countByRole(@Param("role") String role);

    User selectByUsernameAll(@Param("username") String username);

    int deletePermanently(@Param("userId") int userId);

}
