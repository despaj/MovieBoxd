package com.example.demo.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.example.demo.model.User;
import com.example.demo.repository.UserRepository;

import java.util.List;

@Service
public class UserService {
	@Autowired
	private UserRepository repo;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
    private UserRepository userRepository;
	
	public String saveUser(User user) {
	    if (repo.existsByEmail(user.getEmail())) {
	        return "email_exists";
	    }
	    
	    user.setPass(passwordEncoder.encode(user.getPass())); // encrypt password
	    repo.save(user);
	    return "success";
	}


    // ✅ Add this method
    public long countUsers() {
        return userRepository.count();
    }

	
	public List <User> getAllUsers() {
		return repo.findAll();
	}
	
	public void deleteUser(Long id) {
		repo.deleteById(id);
	}
	
	public User getUserById(Long id) {
		return repo.findById(id).orElse(null);
	}
	
	public User findByEmailAndPassword(String email, String pass) {
		User user = repo.findByEmail(email);
		if (user != null && passwordEncoder.matches(pass, user.getPass())) {
		return user;
		}
		return null;
	}
}

