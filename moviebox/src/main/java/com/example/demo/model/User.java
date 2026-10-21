package com.example.demo.model;
import jakarta.persistence.*;
import java.time.LocalDateTime;
import jakarta.validation.constraints.*;

@Entity
@Table(name= "users")

public class User {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	@NotBlank(message = "First name is required")
	private String fname;
	
	@NotBlank(message = "Last name is required")
	private String lname;
	
	@Email(message = "Invalid email format")
	@NotBlank(message = "Email is required")
	@Column(unique = true, nullable = false)
	private String email;
	
	@NotBlank(message = "Phone number is required")
	private String num;
	
	@NotBlank(message = "Password is required")
	private String pass;
	
	@NotBlank(message = "Password is required")
	private String confirmPass;
	
	private int role = 1; 
	
	private Boolean terms;
	
	public User() {
	}
	
	public User (String fname, String lname, String email, String num, String pass, String confirmPass, int role) {
		this.fname = fname;
		this.lname = lname;
		this.num = num;
		this.pass = pass;
		this.confirmPass = confirmPass;
		this.role = role;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	
	public void setFname(String fname) {
		this.fname = fname;
	}
	
	public void setLname(String lname) {
		this.lname = lname;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public void setNum(String num) {
		this.num = num;
	}
	
	public void setPass(String pass) {
		this.pass = pass;
	}
	
	public void setConfirmPass(String confirmPass) {
		this.confirmPass = confirmPass;
	}
	
	public void setRole(int role) {
		this.role = role;
	}
	
	
	public Long getID() {
		return id;
	}
	
	public String getFname() {
		return fname;
	}
	
	public String getLname() {
		return lname;
	}
	
	public String getEmail() {
		return email;
	}
	
	public String getNum() {
		return num;
	}
	
	public String getPass() {
		return pass;
	}
	
	public String getConfirmPass() {
		return confirmPass;
	}
	
	public int getRole() {
		return role;
	}

    public Boolean getTerms() {
        return terms;
    }

    public void setTerms(Boolean terms) {
        this.terms = terms;
    }
	
	@Override
	public String toString() {
		return "User{" + 
	"id=" + id +
	", fname='" + fname + '\'' +
	", lname='" + lname + '\'' +
	", email='" + email + '\'' + 
	", num='" + num + '\'' +
	", role=" + role +
	'}';
	}
	
	
	
}
