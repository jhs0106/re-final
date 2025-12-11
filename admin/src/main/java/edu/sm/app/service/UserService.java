package edu.sm.app.service;

import edu.sm.app.dto.User;
import edu.sm.app.dto.Pet;
import edu.sm.app.repository.UserRepository;
import edu.sm.app.repository.PetRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class UserService {

    private final UserRepository userRepository;
    private final PetRepository petRepository;

    // USER ----------------------------------
    public User getUser(int userId) {
        return userRepository.select(userId);
    }

    public List<User> getAllUsers() {
        return userRepository.selectAll();
    }

    public void registerUser(User user) {
        userRepository.insert(user);
    }

    public void updateUser(User user) {
        userRepository.update(user);
    }

    public void deleteUser(int userId) {
        userRepository.delete(userId);
    }

    // PET -----------------------------------
    public List<Pet> getPetsByUser(int userId) {
        return petRepository.selectByUserId(userId);
    }

    public Pet getPet(int petId) {
        return petRepository.select(petId);
    }

    public void registerPet(Pet pet) {
        petRepository.insert(pet);
    }

    public void updatePet(Pet pet) {
        petRepository.update(pet);
    }

    public void deletePet(int petId) {
        petRepository.delete(petId);
    }

    public List<Pet> getAllPets() {
        return petRepository.selectAll();
    }
}
