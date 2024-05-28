DROP SCHEMA hospital;

CREATE SCHEMA hospital COLLATE = utf8_general_ci;
USE hospital;

CREATE TABLE Hospital_Info (
    HOSPITAL_ID DECIMAL(11,0) PRIMARY KEY,
    HOSPITAL_NAME VARCHAR(60) NOT NULL,
    HOSPITAL_CONTACT DECIMAL(10,0) NOT NULL,
    HOSPITAL_ADDRESS VARCHAR(100) NOT NULL
);

CREATE TABLE Office (
    OFFICE_ID DECIMAL(11,0) PRIMARY KEY,
    OFFICE_PHONE DECIMAL(10,0) NOT NULL,
    OFFICE_BUILDING VARCHAR(50) NOT NULL
);

CREATE TABLE Department (
    DEPT_ID DECIMAL(11,0) PRIMARY KEY,
    HOSPITAL_ID DECIMAL(11,0),
    DEPT_NAME VARCHAR(50) NOT NULL,
    FOREIGN KEY (HOSPITAL_ID) REFERENCES Hospital_Info(HOSPITAL_ID)
);

CREATE TABLE Food_Category (
    FOOD_CATEGORY_ID DECIMAL(11,0) PRIMARY KEY,
    FOOD_DESCRIPTION VARCHAR(100) NOT NULL
);

CREATE TABLE Food_Item (
    FOOD_ITEM_ID DECIMAL(9,0) PRIMARY KEY,
    ITEM_DESCRIPTION VARCHAR(100) NOT NULL,
    FOOD_CATEGORY_ID DECIMAL(11,0),
    FOREIGN KEY (FOOD_CATEGORY_ID) REFERENCES Food_Category(FOOD_CATEGORY_ID)
);

CREATE TABLE Patient_Room (
    ROOM_ID DECIMAL(9,0) PRIMARY KEY,
    ROOM_TYPE VARCHAR(40) NOT NULL
);

CREATE TABLE Patient (
    PATIENT_ID DECIMAL(9,0) PRIMARY KEY,
	HOSPITAL_ID DECIMAL(11,0),
    PATIENT_NAME VARCHAR(50) NOT NULL,
    PATIENT_GENDER CHAR(11) NOT NULL,
    PATIENT_GENETIC_INFO_ID DECIMAL(9,0) NOT NULL,
    PATIENT_BIRTH_DATE DATE NOT NULL,
    REFERRED_BY VARCHAR(50) NOT NULL,
    ADMISSION_DATE DATE,
    DISCHARGE_DATE DATE,
    HEIGHT_ON_ADMISSION VARCHAR(22) NOT NULL,
    WEIGHT_ON_ADMISSION VARCHAR(22) NOT NULL,
    OTHER_DETAILS VARCHAR(100),
    ROOM_ID DECIMAL(9,0) NOT NULL,
    FOREIGN KEY(HOSPITAL_ID) REFERENCES Hospital_Info(HOSPITAL_ID),
    FOREIGN KEY(ROOM_ID) REFERENCES Patient_Room(ROOM_ID)
);

CREATE TABLE Patient_Dietary_Requirements (
    DIETARY_ITEM_ID DECIMAL(9,0) PRIMARY KEY,
    PATIENT_ID DECIMAL(9,0),
    FOOD_ITEM_ID DECIMAL(9,0),
    FOREIGN KEY (PATIENT_ID) REFERENCES Patient(PATIENT_ID),
    FOREIGN KEY (FOOD_ITEM_ID) REFERENCES Food_Item(FOOD_ITEM_ID)
);

CREATE TABLE Patient_History_Information (
    PATIENT_HISTORY_ID DECIMAL(9,0) PRIMARY KEY,
    PATIENT_DISORDER_NAME VARCHAR(50) NOT NULL,
    ASSOCIATED_RISKS VARCHAR(66) NOT NULL,
    COUNTRIES_OF_ORIGIN VARCHAR(58) NOT NULL,
    INFO_PHOTO_FILENAME VARCHAR(50) NOT NULL,
    OTHER_DETAILS VARCHAR(106)
);

CREATE TABLE Appointment (
    APPOINTMENT_DATE DATE NOT NULL,
    PATIENT_ID DECIMAL(9,0) NOT NULL,
    HEIGHT VARCHAR(20) NOT NULL,
    WEIGHT VARCHAR(20) NOT NULL,
    BODY_LENGTH VARCHAR(20) NOT NULL,
    GENERAL_HEALTH VARCHAR(100) NOT NULL,
    OTHER_DETAILS VARCHAR(100),
    PRIMARY KEY (APPOINTMENT_DATE, PATIENT_ID)
);

CREATE TABLE Medical_Association (
    ASSOC_ID DECIMAL(3,0) PRIMARY KEY,
    ASSOC_NAME VARCHAR(60) NOT NULL
);


CREATE TABLE Hospital_Employee (
    EMP_ID DECIMAL(4,0) PRIMARY KEY,
    DEPT_ID DECIMAL(6,0),
    OFFICE_ID DECIMAL(11,0) ,
    HOSPITAL_ID DECIMAL(11,0),
    EMP_FIRST_NAME VARCHAR(30) NOT NULL,
    EMP_LAST_NAME VARCHAR(30) NOT NULL,
    EMP_PHONE_NUMBER DECIMAL(10,0) NOT NULL,
    EMP_SALARY DECIMAL(6,0) NOT NULL,
    EMP_SOCIAL_SECURITY_NUMBER DECIMAL(9,0) NOT NULL,
    EMP_HIRE_DATE DATE NOT NULL,
    EMP_DEPARTURE_DATE DATE,
    EMP_TYPE VARCHAR(2),
    EMP_ADDRESS VARCHAR(50) NOT NULL,
    EMP_CITY VARCHAR(40) NOT NULL,
    EMP_ZIP_CODE DECIMAL(5,0) NOT NULL,
    EMP_STATE VARCHAR(2) NOT NULL,
    FOREIGN KEY (OFFICE_ID) REFERENCES Office(OFFICE_ID),
    FOREIGN KEY (HOSPITAL_ID) REFERENCES Hospital_Info(HOSPITAL_ID)
);

CREATE TABLE Physician (
    PHYSICIAN_ID DECIMAL(4,0) NOT NULL,
    ASSOC_ID DECIMAL(3,0) NOT NULL,
    PHYSICIAN_FIRST_NAME VARCHAR(30) NOT NULL,
    PHYSICIAN_LAST_NAME VARCHAR(30) NOT NULL,
    HOSPITAL_NAME VARCHAR(60) NOT NULL,
    PHYSICIAN_PHONE_NUMBER DECIMAL(10,0) NOT NULL,
    PRIMARY KEY (PHYSICIAN_ID, ASSOC_ID)
);

CREATE TABLE Medication (
    MED_ID DECIMAL(9,0) PRIMARY KEY,
    MED_TYPE VARCHAR(50) NOT NULL,
    MED_MEASURE VARCHAR(50) NOT NULL
);

CREATE TABLE Illness_Type (
    ILLNESS_TYPE_ID DECIMAL(9,0) PRIMARY KEY,
    ILLNESS_DESCRIPTION VARCHAR(100) NOT NULL,
    ILL_TREATMENT VARCHAR(100) NOT NULL
);

CREATE TABLE Diagnosis (
    PATIENT_ID DECIMAL(9,0),
    ILLNESS_TYPE_ID DECIMAL(9,0),
    ILLNESS_START_DATE DATE,
    ILLNESS_END_DATE DATE,
    PRIMARY KEY (PATIENT_ID, ILLNESS_TYPE_ID),
    FOREIGN KEY (PATIENT_ID) REFERENCES Patient(PATIENT_ID),
    FOREIGN KEY (ILLNESS_TYPE_ID) REFERENCES Illness_Type(ILLNESS_TYPE_ID)
);

CREATE TABLE Prescription (
    PRESCRIPTION_ID DECIMAL(11,0) PRIMARY KEY,
    PATIENT_ID DECIMAL(9,0),
    MED_ID DECIMAL(9,0),
    FOREIGN KEY (PATIENT_ID) REFERENCES Patient(PATIENT_ID),
    FOREIGN KEY (MED_ID) REFERENCES Medication(MED_ID)
);
 
# Independent Tables
# Hospital Info:

INSERT INTO Hospital_Info (HOSPITAL_ID, HOSPITAL_NAME, HOSPITAL_CONTACT, HOSPITAL_ADDRESS)
VALUES
    (1001, 'St. Mary\'s Hospital', 1234567890, '123 Main Street, Cityville, State'),
    (1002, 'City General Hospital', 2345678901, '456 Elm Street, Townsville, State'),
    (1003, 'Memorial Hospital', 3456789012, '789 Oak Street, Villagetown, State'),
    (1004, 'Unity Hospital', 4567890123, '987 Maple Avenue, Hamletville, State'),
    (1005, 'Sunset Community Hospital', 5678901234, '321 Pine Street, Suburbia, State'),
    (1006, 'Golden Gate Medical Center', 6789012345, '654 Cedar Street, Metropolis, State'),
    (1007, 'Riverfront Regional Hospital', 7890123456, '876 Birch Street, Riverside, State'),
    (1008, 'Pinecrest Health Center', 8901234567, '543 Spruce Street, Hillside, State'),
    (1009, 'Valley View Medical Clinic', 9012345678, '210 Oakwood Drive, Mountainville, State'),
    (1010, 'Harborview Hospital', 1234567890, '789 Beach Avenue, Oceantown, State');


# Office:

INSERT INTO Office (OFFICE_ID, OFFICE_PHONE, OFFICE_BUILDING)
VALUES
    (1101, 1234567890, 'Smith Building'),
    (1102, 2345678901, 'Jones Tower'),
    (1103, 3456789012, 'Johnson Center'),
    (1104, 4567890123, 'Williams Hall'),
    (1105, 5678901234, 'Brown Office Park'),
    (1106, 6789012345, 'Miller Plaza'),
    (1107, 7890123456, 'Davis Building'),
    (1108, 8901234567, 'Wilson Complex'),
    (1109, 9012345678, 'Taylor Tower'),
    (1110, 9876543210, 'Clark Hall');


# Food_Category:

INSERT INTO Food_Category (FOOD_CATEGORY_ID, FOOD_DESCRIPTION)
VALUES
    (2200000001, 'Fruits'),
    (2200000002, 'Meats'),
    (2200000003, 'Vegetables'),
    (2200000004, 'Grains'),
    (2200000005, 'Dairy Products'),
    (2200000006, 'Seafood'),
    (2200000007, 'Sweets'),
    (2200000008, 'Beverages'),
    (2200000009, 'Snacks'),
    (2200000019, 'Condiments');



# Patient_Room:

INSERT INTO Patient_Room (ROOM_ID, ROOM_TYPE) VALUES
(101, 'Single'),
(102, 'Double'),
(103, 'Single'),
(104, 'Double'),
(105, 'Single'),
(106, 'Double'),
(107, 'Single'),
(108, 'Double'),
(109, 'Single'),
(110, 'Double');



# Medical_Association:

INSERT INTO Medical_Association (ASSOC_ID, ASSOC_NAME)
VALUES
    (101, 'American Medical Association'),
    (102, 'American Medical Association British Medical Association'),
    (103, 'American Medical Association Canadian Medical Association'),
    (104, 'American Medical Association Australian Medical Association'),
    (105, 'American Medical Association German Medical Association'),
    (106, 'American Medical Association French Medical Association'),
    (107, 'American Medical Association Italian Medical Association'),
    (108, 'American Medical Association Spanish Medical Association'),
    (109, 'American Medical Association Japanese Medical Association'),
    (110, 'American Medical Association Brazilian Medical Association');


# Medication:

INSERT INTO Medication (MED_ID, MED_TYPE, MED_MEASURE)
VALUES
    (201, 'Aspirin', 'mg'),
    (202, 'Paracetamol', 'mg'),
    (203, 'Ibuprofen', 'mg'),
    (204, 'Amoxicillin', 'mg'),
    (205, 'Loratadine', 'mg'),
    (206, 'Omeprazole', 'mg'),
    (207, 'Ventolin', 'mcg'),
    (208, 'Atorvastatin', 'mg'),
    (209, 'Metformin', 'mg'),
    (210, 'Ciprofloxacin', 'mg');


# Ilness_type:

INSERT INTO Illness_Type (ILLNESS_TYPE_ID, ILLNESS_DESCRIPTION, ILL_TREATMENT)
VALUES
    (200000001, 'Common Cold', 'Rest and fluids'),
    (200000002, 'Influenza', 'Antiviral medication'),
    (200000003, 'Allergic Rhinitis', 'Antihistamines'),
    (200000004, 'Bronchitis', 'Antibiotics, rest'),
    (200000005, 'Pneumonia', 'Antibiotics, oxygen therapy'),
    (200000006, 'Asthma', 'Bronchodilators, corticosteroids'),
    (200000007, 'Hypertension', 'Medication, lifestyle changes'),
    (200000008, 'Diabetes Mellitus', 'Insulin, oral medications'),
    (200000009, 'Gastroenteritis', 'Fluid replacement, rest'),
    (200000010, 'Migraine', 'Pain relievers, rest');

# Dependent Tables (Level 1)

# Department:


INSERT INTO Department (DEPT_ID, HOSPITAL_ID, DEPT_NAME)
VALUES
    (1011, 1001, 'Cardiology'),
    (1022, 1002, 'Orthopedics'),
    (1033, 1003, 'Pediatrics'),
    (1044, 1004, 'Neurology'),
    (1055, 1005, 'Oncology'),
    (1066, 1006, 'Gynecology'),
    (1077, 1007, 'Dermatology'),
    (1088, 1008, 'Endocrinology'),
    (1099, 1009, 'Radiology'),
    (1100, 1010, 'Emergency Medicine');

# Food_Item:

INSERT INTO Food_Item (FOOD_ITEM_ID, ITEM_DESCRIPTION, FOOD_CATEGORY_ID)
VALUES
    (110000001, 'Apple', 2200000001),
    (110000002, 'Banana', 2200000002),
    (110000003, 'Orange', 2200000003),
    (110000004, 'Chicken Breast', 2200000004),
    (110000005, 'Salmon', 2200000005),
    (110000006, 'Broccoli', 2200000006),
    (110000007, 'Spinach', 2200000007),
    (110000008, 'Rice', 2200000008),
    (110000009, 'Pasta', 2200000009),
    (110000010, 'Bread', 2200000019);

# Hospital_Employee:

INSERT INTO Hospital_Employee (EMP_ID, DEPT_ID, OFFICE_ID, HOSPITAL_ID, EMP_FIRST_NAME, EMP_LAST_NAME, EMP_PHONE_NUMBER, EMP_SALARY, EMP_SOCIAL_SECURITY_NUMBER, EMP_HIRE_DATE, EMP_DEPARTURE_DATE, EMP_TYPE, EMP_ADDRESS, EMP_CITY, EMP_ZIP_CODE, EMP_STATE)
VALUES
    (1111, 1011, 1101, 1001, 'John', 'Doe', 1234567890, 50000, 123456789, '2023-01-01', NULL, 'FT', '123 Main St', 'Anytown', 12345, 'NY'),
    (2222, 1022, 1102, 1002, 'Jane', 'Smith', 2345678901, 55000, 234567890, '2023-02-15', NULL, 'FT', '456 Elm St', 'Othertown', 23456, 'CA'),
    (3333, 1033, 1103, 1003, 'Michael', 'Johnson', 3456789012, 60000, 345678901, '2023-03-30', NULL, 'FT', '789 Oak St', 'Anotherplace', 34567, 'TX'),
    (4444, 1044, 1104, 1004, 'Emily', 'Williams', 4567890123, 58000, 456789012, '2023-04-10', NULL, 'FT', '321 Pine St', 'Newcity', 45678, 'FL'),
    (5555, 1055, 1105, 1005, 'Daniel', 'Brown', 5678901234, 62000, 567890123, '2023-05-20', NULL, 'FT', '987 Cedar St', 'Oldtown', 56789, 'WA'),
    (6666, 1066, 1106, 1006, 'Olivia', 'Jones', 6789012345, 54000, 678901234, '2023-06-25', NULL, 'PT', '654 Birch St', 'Nearbytown', 67890, 'IL'),
    (7777, 1077, 1107, 1007, 'Ethan', 'Davis', 7890123456, 53000, 789012345, '2023-07-15', NULL, 'PT', '123 Maple St', 'Farawaytown', 78901, 'MI'),
    (8888, 1088, 1108, 1008, 'Sophia', 'Miller', 8901234567, 58000, 890123456, '2023-08-05', NULL, 'FT', '456 Walnut St', 'Distanttown', 89012, 'OH'),
    (9999, 1099, 1109, 1009, 'Noah', 'Wilson', 9012345678, 59000, 901234567, '2023-09-10', NULL, 'FT', '789 Cherry St', 'Nearbycity', 90123, 'AZ'),
    (1000, 1100, 1110, 1010, 'Isabella', 'Taylor', 123456789, 60000, 12345678, '2023-10-20', NULL, 'FT', '987 Willow St', 'Farawaycity', 1234, 'NC');

# Physician:

INSERT INTO Physician (PHYSICIAN_ID, ASSOC_ID, PHYSICIAN_FIRST_NAME, PHYSICIAN_LAST_NAME, HOSPITAL_NAME, PHYSICIAN_PHONE_NUMBER)
VALUES
    (1001, 101, 'John', 'Smith', 'General Hospital', 1234567890),
    (1002, 102, 'Emily', 'Johnson', 'Mercy Hospital', 2345678901),
    (1003, 103, 'Michael', 'Williams', 'Memorial Hospital', 3456789012),
    (1004, 104, 'Sophia', 'Brown', 'St. Luke''s', 4567890123),
    (1005, 105, 'Daniel', 'Jones', 'Community Hospital', 5678901234),
    (1006, 106, 'Olivia', 'Garcia', 'University Hospital', 6789012345),
    (1007, 107, 'Ethan', 'Martinez', 'Children''s Hospital', 7890123456),
    (1008, 108, 'Isabella', 'Hernandez', 'Veterans Hospital', 8901234567),
    (1009, 109, 'Noah', 'Miller', 'Baptist Hospital', 9012345678),
    (1010, 110, 'Emma', 'Davis', 'Regional Hospital', 123456789);

# Dependent Tables (Level 2)
# Patient:


INSERT INTO Patient (PATIENT_ID, HOSPITAL_ID, PATIENT_NAME, PATIENT_GENDER, PATIENT_GENETIC_INFO_ID, PATIENT_BIRTH_DATE, REFERRED_BY, ADMISSION_DATE, DISCHARGE_DATE, HEIGHT_ON_ADMISSION, WEIGHT_ON_ADMISSION, OTHER_DETAILS, ROOM_ID) VALUES
(100000001, 1001, 'John Smith', 'Male', 200000001, '1985-07-15', 'Dr. Johnson', '2023-04-10', '2023-04-15', '6 ft 1 in', '180 lbs', 'None', 101),
(100000002, 1002, 'Emily Johnson', 'Female', 200000002, '1990-03-25', 'Dr. Williams', '2023-04-12', '2023-04-20', '5 ft 6 in', '150 lbs', 'Allergic to penicillin', 102),
(100000003, 1003, 'Michael Brown', 'Male', 200000003, '1978-11-08', 'Dr. Davis', '2023-04-15', NULL, '5 ft 9 in', '170 lbs', 'High cholesterol', 103),
(100000004, 1004, 'Sophia Garcia', 'Female', 200000004, '1989-09-30', 'Dr. Martinez', '2023-04-20', '2023-04-25', '5 ft 4 in', '130 lbs', 'None', 104),
(100000005, 1005, 'Daniel Lee', 'Male', 200000005, '1976-05-18', 'Dr. Brown', '2023-04-25', NULL, '6 ft 0 in', '160 lbs', 'Type 2 diabetes', 105),
(100000006, 1006, 'Olivia Taylor', 'Female', 200000006, '1995-12-12', 'Dr. Wilson', '2023-04-28', '2023-05-05', '5 ft 5 in', '140 lbs', 'Asthma', 106),
(100000007, 1007, 'Ethan Martinez', 'Male', 200000007, '1983-08-22', 'Dr. Moore', '2023-05-01', '2023-05-08', '5 ft 10 in', '175 lbs', 'None', 107),
(100000008, 1008, 'Isabella Hernandez', 'Female', 200000008, '1998-04-04', 'Dr. Anderson', '2023-05-05', NULL, '5 ft 7 in', '150 lbs', 'None', 108),
(100000009, 1009, 'Noah Miller', 'Male', 200000009, '1980-10-20', 'Dr. Taylor', '2023-05-10', '2023-05-18', '6 ft 2 in', '190 lbs', 'High blood pressure', 109),
(100000010, 1010, 'Emma Davis', 'Female', 200000010, '1992-07-17', 'Dr. Hernandez', '2023-05-15', NULL, '5 ft 8 in', '160 lbs', 'None', 110);


# Patient_History_Information:

INSERT INTO Patient_History_Information (PATIENT_HISTORY_ID, PATIENT_DISORDER_NAME, ASSOCIATED_RISKS, COUNTRIES_OF_ORIGIN, INFO_PHOTO_FILENAME, OTHER_DETAILS)
VALUES
    (101111, 'Depression', 'Heart defects', 'Tanzania', 'https://loremflickr.com/600/400/people/', 'Anxiety'),
    (200000, 'Hypertension', 'Heart Disease', 'UK', 'https://loremflickr.com/320/240', 'Fatigue'),
    (200111, 'Hypertension', 'Stroke', 'UK', 'https://loremflickr.com/320/240', 'Fatigue'),
    (200222, 'Diabetes', 'Heart Disease', 'UK', 'https://loremflickr.com/320/240', 'Fatigue'),
    (200333, 'Allergies', 'Heart Disease', 'Canada', 'https://loremflickr.com/320/240', 'Fatigue'),
    (200444, 'Diabetes', 'Heart Disease', 'USA', 'https://loremflickr.com/320/240', 'Nausea'),
    (200555, 'Diabetes', 'Stroke', 'USA', 'https://loremflickr.com/320/240', 'Headache'),
    (200666, 'Hypertension', 'Stroke', 'USA', 'https://loremflickr.com/320/240', 'Fatigue');

# Appointment:

INSERT INTO Appointment (APPOINTMENT_DATE, PATIENT_ID, HEIGHT, WEIGHT, BODY_LENGTH, GENERAL_HEALTH, OTHER_DETAILS) VALUES 
('2023-04-10', 100000001, '6 ft 1 in', '180 lbs', '30 in', 'Good', NULL),
('2023-04-12', 100000002, '5 ft 6 in', '150 lbs', '28 in', 'Stable', NULL),
('2023-04-15', 100000003, '5 ft 9 in', '170 lbs', '29 in', 'Normal', NULL),
('2023-04-20', 100000004, '5 ft 4 in', '130 lbs', '27 in', 'Fair', NULL),
('2023-04-25', 100000005, '6 ft 0 in', '160 lbs', '30 in', 'Good', NULL),
('2023-04-28', 100000006, '5 ft 5 in', '140 lbs', '28 in', 'Stable', NULL),
('2023-05-01', 100000007, '5 ft 10 in', '175 lbs', '29 in', 'Normal', NULL),
('2023-05-05', 100000008, '5 ft 7 in', '150 lbs', '28 in', 'Fair', NULL),
('2023-05-10', 100000009, '6 ft 2 in', '190 lbs', '31 in', 'Good', NULL),
('2023-05-15', 100000010, '5 ft 8 in', '160 lbs', '29 in', 'Stable', NULL);


# Diagnosis:

INSERT INTO Diagnosis (PATIENT_ID, ILLNESS_TYPE_ID, ILLNESS_START_DATE, ILLNESS_END_DATE) VALUES 
(100000001, 200000001, '2023-01-10', '2023-01-20'),
(100000002, 200000002, '2023-02-15', '2023-02-25'),
(100000003, 200000003, '2023-03-20', '2023-03-30'),
(100000004, 200000004, '2023-04-25', '2023-05-05'),
(100000005, 200000005, '2023-05-01', '2023-05-10'),
(100000006, 200000006, '2023-06-05', '2023-06-15'),
(100000007, 200000007, '2023-07-10', '2023-07-20'),
(100000008, 200000008, '2023-08-15', '2023-08-25'),
(100000009, 200000009, '2023-09-20', '2023-09-30'),
(100000010, 200000010, '2023-10-25', '2023-11-05');


# Prescription:

INSERT INTO Prescription (PRESCRIPTION_ID, PATIENT_ID, MED_ID) VALUES
(1001, 100000001, 201),
(1002, 100000002, 202),
(1003, 100000003, 203),
(1004, 100000004, 204),
(1005, 100000005, 205),
(1006, 100000006, 206),
(1007, 100000007, 207),
(1008, 100000008, 208),
(1009, 100000009, 209),
(1010, 100000010, 210);



# Data Mining

SELECT 
    Hospital_Info.HOSPITAL_NAME,
    Hospital_Info.HOSPITAL_ADDRESS,
    Hospital_Info.HOSPITAL_CONTACT,
    Department.DEPT_NAME
FROM 
    Hospital_Info
JOIN 
    Department ON Hospital_Info.HOSPITAL_ID = Department.HOSPITAL_ID;



SELECT 
    Patient.PATIENT_NAME,
    Patient.ADMISSION_DATE,
    Patient.DISCHARGE_DATE,
    Patient_Room.ROOM_TYPE,
    Hospital_Info.HOSPITAL_NAME
FROM 
    Patient
JOIN 
    Patient_Room ON Patient.ROOM_ID = Patient_Room.ROOM_ID
JOIN 
    Hospital_Info ON Patient.HOSPITAL_ID = Hospital_Info.HOSPITAL_ID;



SELECT 
    Hospital_Employee.EMP_FIRST_NAME,
    Hospital_Employee.EMP_LAST_NAME,
    Department.DEPT_NAME,
    Office.OFFICE_BUILDING,
    Hospital_Info.HOSPITAL_NAME
FROM 
    Hospital_Employee
JOIN 
    Department ON Hospital_Employee.DEPT_ID = Department.DEPT_ID
JOIN 
    Office ON Hospital_Employee.OFFICE_ID = Office.OFFICE_ID
JOIN 
    Hospital_Info ON Hospital_Employee.HOSPITAL_ID = Hospital_Info.HOSPITAL_ID;



SELECT 
    Patient.PATIENT_NAME,
    Medication.MED_TYPE,
    Medication.MED_MEASURE,
    COUNT(Prescription.PRESCRIPTION_ID) as Total_Prescriptions
FROM 
    Prescription
JOIN 
    Patient ON Prescription.PATIENT_ID = Patient.PATIENT_ID
JOIN 
    Medication ON Prescription.MED_ID = Medication.MED_ID
GROUP BY 
    Prescription.MED_ID, Prescription.PATIENT_ID;
