// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BlockHealth {
    // Define a structure for storing patient data
    struct Patient {
        uint id;
        string name;
        uint age;
        string medicalHistory;
    }

    // Mapping to store patient records by ID
    mapping(uint => Patient) private patients;

    // Variable to keep track of the next patient ID
    uint private nextPatientId;

    // Event to log patient record creation
    event PatientRecordCreated(uint id, string name, uint age);

    // Function to add a new patient record
    function addPatient(string memory _name, uint _age, string memory _medicalHistory) public returns (uint) {
        uint patientId = nextPatientId++;
        patients[patientId] = Patient(patientId, _name, _age, _medicalHistory);
        emit PatientRecordCreated(patientId, _name, _age);
        return patientId;
    }

    // Function to get patient details by ID
    function getPatient(uint _id) public view returns (string memory, uint, string memory) {
        require(_id < nextPatientId, "Patient does not exist.");
        Patient memory patient = patients[_id];
        return (patient.name, patient.age, patient.medicalHistory);
    }

    // Function to update patient details
    function updatePatient(uint _id, string memory _name, uint _age, string memory _medicalHistory) public {
        require(_id < nextPatientId, "Patient does not exist.");
        Patient storage patient = patients[_id];
        patient.name = _name;
        patient.age = _age;
        patient.medicalHistory = _medicalHistory;
    }
}
