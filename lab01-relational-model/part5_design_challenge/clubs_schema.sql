CREATE TABLE Student (
    StudentID   INT PRIMARY KEY,
    FirstName   VARCHAR(50),
    LastName    VARCHAR(50),
    Email       VARCHAR(100)
);

CREATE TABLE Faculty (
    FacultyID   INT PRIMARY KEY,
    FirstName   VARCHAR(50),
    LastName    VARCHAR(50),
    Department  VARCHAR(100)
);

CREATE TABLE Club (
    ClubID      INT PRIMARY KEY,
    ClubName    VARCHAR(100),
    Description VARCHAR(255),
    Budget      DECIMAL(10,2),
    FacultyID   INT,
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
);

CREATE TABLE Room (
    RoomID      INT PRIMARY KEY,
    Capacity    INT,
    Location    VARCHAR(100)
);

CREATE TABLE Event (
    EventID     INT PRIMARY KEY,
    EventName   VARCHAR(100),
    EventDate   DATE,
    EventTime   TIME,
    ClubID      INT,
    RoomID      INT,
    FOREIGN KEY (ClubID) REFERENCES Club(ClubID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

CREATE TABLE Expense (
    ExpenseID   INT,
    ClubID      INT,
    Amount      DECIMAL(10,2),
    Description VARCHAR(255),
    ExpenseDate DATE,
    PRIMARY KEY (ExpenseID, ClubID),
    FOREIGN KEY (ClubID) REFERENCES Club(ClubID)
);

CREATE TABLE MemberOf (
    StudentID   INT,
    ClubID      INT,
    Role        VARCHAR(50),
    PRIMARY KEY (StudentID, ClubID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (ClubID) REFERENCES Club(ClubID)
);

CREATE TABLE Attends (
    StudentID        INT,
    EventID          INT,
    AttendanceStatus VARCHAR(20),
    PRIMARY KEY (StudentID, EventID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);