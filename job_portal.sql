
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    login_name VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,    
    role ENUM('candidate', 'recruiter') NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE candidates (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    dob DATE,
    address TEXT,
    cv_file_path VARCHAR(255),
    FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE recruiters (
    id INT PRIMARY KEY,
    company_name VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255),
    FOREIGN KEY (id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE job_posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    recruiter_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255),
    salary VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    deadline DATE,
    FOREIGN KEY (recruiter_id) REFERENCES recruiters(id) ON DELETE CASCADE
);

CREATE TABLE applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    job_post_id INT NOT NULL,
    applied_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('applied', 'reviewed', 'accepted', 'rejected') DEFAULT 'applied',
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE,
    FOREIGN KEY (job_post_id) REFERENCES job_posts(id) ON DELETE CASCADE,
    UNIQUE(candidate_id, job_post_id) 
);

