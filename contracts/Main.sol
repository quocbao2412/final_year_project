pragma solidity ^0.4.17;

contract Main{

    struct Student{
        string username;
        string name;
        string cardID;
        string cardInfo;
        string branch;
        address[3] verifier;
        uint count;
    }

    mapping(address => Student) students;
    mapping(address => bool) studentCheck;
    event Check(address indexed _from, address indexed _to, string cardID, uint count, address[3] verify);

    address[] public studentacc;

    mapping(string => bool) certificateHash;

    function setStudent(string memory usn, string memory n, string memory id, string memory info, string memory coll) public returns (bool){
        
        if(studentCheck[msg.sender] == true) return false;

        Student storage student = students[msg.sender];
        student.username = usn;
        student.name = n;
        student.cardID = id;
        student.cardInfo = info;
        student.branch = coll;
        student.count = 0;
        studentacc.push(msg.sender);
        studentCheck[msg.sender] = true;
        certificateHash[cer] = true;

        return true;
    }

    function getStudent(address ins) view public returns (string memory, string memory, string memory, string memory, string memory,string memory, uint){
        return (students[ins].username, students.[ins].name, students[ins].cardID, students[ins].cardInfo, students[ins].branch, students[ins].count);
    }
    
    function getVerifiedBy(address ins) view public returns (uint, address,address,address){
        return (students[ins].count, students[ins].verifier[0],students[ins].verifier[1],students[ins].verifier[2]);
    }

    function getStudentAddress() view public returns (address[] memory){
        return studentacc;
    }

    function destroyed (address addr) public{
        delete students[addr];
    }

    function verify(address studentAdd, string memory certHash) payable public returns (string memory){
        
        if(studentCheck[msg.sender]==false){
            emit Check(msg.sender, studentAdd,"Invalid Address", students[studentAdd].count, students[studentAdd.verifier]);
            return "Invalid Address";
        }

        if(students[studentAdd].count==3){
            emit Check(msg.sender, studentAdd, "Verified Certificate",students[studentAdd].count,students[studentAdd].verifier);
            return "Verified Certificate";
        }

        if(cerificateHash[certHash]==false){
            emit Check(msg.sender, studAdd, "Invalid Certificate Hash",students[studAdd].count, students[studAdd].verifier);
            return "Invalid Certificate Hash";
        }

        for (uint i=0; i<3; i++){
            if(msg.sender == students[studAdd].verifier[i]){
                emit Check(msg.sender,studAdd, "Certificated Can be verified only Once...",students[studAdd].count, students[studAdd].verifier);
                return "Certificated can be verified only Once";
            }
        }

        students[studAdd].verifier[students[studAdd].count++] = msg.sender;
        emit Check(msg.sender, studAdd, "Verifier Address added to array[]" ,students[studAdd].count, students[studAdd].verifier);
        return "Verifier Address added to array[]";
    }

}