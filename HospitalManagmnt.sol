/*
Create "Hospital" & "Patient" contracts in single solidity file.
In this program,write logic to  add patient and search for a patient.
*/
pragma solidity ^0.4.4;

contract Hospital {
//uint[] id1;
    Patient[] patients;
    //Patient patient;
    
    function addPatient(uint _id,string _name)  {
        patients.push(new Patient(_id, _name));
        
    }
    function getPatient(uint index)  public returns (uint) {
        return patients[index].getId();
    }
    function checkPatientExists(uint id)  returns (bool) {
        for (uint i=0; i<patients.length; i++) {
            if(patients[i].getId()==id)
            return true;
        }
        return false;
    }
}

contract Patient {
    uint public id;string public name;
    function Patient(uint _id,string _name) {
        id = _id;
        name=_name;
    }
    function getId() returns (uint){
        return id;
    } 
    function getName() returns (string){
        return name;
    } 
}
