package com.hctt.is208.service;

import com.hctt.is208.entity.JobPost;
import com.hctt.is208.entity.Application;
import com.hctt.is208.repository.ApplicationRepository;
import org.springframework.stereotype.Service;
import java.util.stream.Collectors;
import java.util.List;

@Service
public class ApplicationService {
    private final ApplicationRepository applicationRepository;

    public List<JobPost> getAppliedJobPostsByCandidate(Integer candidateId) {
        List<Application> applications = applicationRepository.findByCandidateId(candidateId);
        return applications.stream()
                .map(Application::getJobPost)
                .collect(Collectors.toList());
    }

    public ApplicationService(ApplicationRepository applicationRepository) {
        this.applicationRepository = applicationRepository;
    }

    public List<Application> getApplicationsByCandidate(Integer candidateId) {
        return applicationRepository.findByCandidateId(candidateId);
    }

    public void cancelApplication(Integer applicationId, Integer candidateId) {
        Application app = applicationRepository.findById(applicationId)
                .orElseThrow(() -> new RuntimeException("Application not found"));
        if (!app.getCandidate().getId().equals(candidateId)) {
            throw new RuntimeException("Not allowed");
        }
        applicationRepository.deleteById(applicationId);
    }

    public List<Application> getApplicationsByJobPost(Integer jobPostId) {
        return applicationRepository.findByJobPostId(jobPostId);
    }

    public Application apply(Application application) {
        return applicationRepository.save(application);
    }
}
