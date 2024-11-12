//
//  Jobs.swift
//  Group-02 Project
//
//  Created by Chandan  on 11/25/23.
//

import Foundation

// Struct to represent a job
struct Job {
    var title: String
    var description: String
    var salary: Double
    var requirements:[String]
}








// Struct to represent a type of employment
struct Employment {
    var type: String
    var jobs: [Job]
}

let staffJobsNWMSU: [Job] = [
    Job(title: "Administrative Assistant", description: "Supports daily office operations", salary: 50000.0, requirements: ["High school diploma", "Organizational skills"]),
    Job(title: "IT Specialist", description: "Manages university IT systems", salary: 60000.0, requirements: ["Bachelor's degree in Computer Science", "Experience in IT support"]),
    Job(title: "Accountant", description: "Handles university finances", salary: 55000.0, requirements: ["Bachelor's degree in Accounting", "CPA certification"]),
    // Add more staff jobs as needed
    // ...
    Job(title: "Event Coordinator", description: "Plans and coordinates university events", salary: 65000.0, requirements: ["Bachelor's degree in Event Management", "Event planning experience"]),
    Job(title: "HR Specialist", description: "Manages human resources functions", salary: 70000.0, requirements: ["Bachelor's degree in Human Resources", "HR certification"]),
]

let graduateJobsNWMSU: [Job] = [
    Job(title: "Research Assistant", description: "Assists faculty in research projects", salary: 55000.0, requirements: ["Enrolled in a graduate program", "Research experience"]),
    Job(title: "Teaching Assistant", description: "Supports professors in classroom activities", salary: 65000.0, requirements: ["Master's degree", "Teaching experience"]),
    Job(title: "Lab Technician", description: "Works in university laboratories", salary: 60000.0, requirements: ["Bachelor's degree in Biology", "Lab experience"]),
    // Add more graduate jobs as needed
    // ...
    Job(title: "Data Analyst", description: "Analyzes university data sets", salary: 70000.0, requirements: ["Master's degree in Data Science", "Statistical analysis skills"]),
    Job(title: "Graduate Counselor", description: "Provides counseling services to students", salary: 75000.0, requirements: ["Master's degree in Counseling", "Counseling license"]),
]

let offCampusJobsNWMSU: [Job] = [
    Job(title: "Marketing Coordinator", description: "Promotes university events off-campus", salary: 45000.0, requirements: ["Bachelor's degree in Marketing", "Communication skills"]),
    Job(title: "Community Outreach Specialist", description: "Engages with local communities", salary: 55000.0, requirements: ["Community relations experience", "Outgoing personality"]),
    Job(title: "Social Media Manager", description: "Manages university social media accounts", salary: 50000.0, requirements: ["Bachelor's degree in Marketing", "Social media management experience"]),
    // Add more off-campus jobs as needed
    // ...
    Job(title: "Grant Writer", description: "Writes proposals for research grants", salary: 60000.0, requirements: ["Bachelor's degree in English", "Grant writing experience"]),
    Job(title: "Public Relations Specialist", description: "Handles university public relations", salary: 65000.0, requirements: ["Bachelor's degree in Public Relations", "PR experience"]),
]

let studentJobsNWMSU: [Job] = [
    Job(title: "Student Ambassador", description: "Represents the university to visitors", salary: 40000.0, requirements: ["Enthusiastic personality", "Excellent communication skills"]),
    Job(title: "Library Assistant", description: "Assists with library tasks", salary: 50000.0, requirements: ["Enrolled in a bachelor's program", "Attention to detail"]),
    Job(title: "Tutor", description: "Provides tutoring services to fellow students", salary: 45000.0, requirements: ["Strong academic performance", "Communication skills"]),
    // Add more student jobs as needed
    // ...
    Job(title: "Student Researcher", description: "Assists faculty in research projects", salary: 55000.0, requirements: ["Enrolled in a research program", "Research experience"]),
    Job(title: "Fitness Center Assistant", description: "Works in the university fitness center", salary: 60000.0, requirements: ["Fitness certification", "Customer service skills"]),
]

// Sample employment data for Northwest Missouri State University
let staffEmployment = Employment(type: "Staff Employment", jobs: staffJobsNWMSU)
let graduateEmployment = Employment(type: "Graduate Employment", jobs: graduateJobsNWMSU)
let offCampusEmployment = Employment(type: "Off Campus Employment", jobs: offCampusJobsNWMSU)
let studentEmployment = Employment(type: "Student Employment", jobs: studentJobsNWMSU)




// Array to store all employments for Northwest Missouri State University
let allEmployments: [Employment] = [staffEmployment, graduateEmployment, offCampusEmployment, studentEmployment]

