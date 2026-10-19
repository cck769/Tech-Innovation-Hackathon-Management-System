-- ==========================================
-- TABLE DROPS
-- ==========================================
DROP TABLE participant CASCADE CONSTRAINTS;
DROP TABLE workshop CASCADE CONSTRAINTS;
DROP TABLE workshop_registration CASCADE CONSTRAINTS;
DROP TABLE team CASCADE CONSTRAINTS;
DROP TABLE mentor CASCADE CONSTRAINTS;
DROP TABLE project CASCADE CONSTRAINTS;
DROP TABLE judge CASCADE CONSTRAINTS;
DROP TABLE score CASCADE CONSTRAINTS;
DROP TABLE category CASCADE CONSTRAINTS;
DROP TABLE award CASCADE CONSTRAINTS;
DROP TABLE sponsor CASCADE CONSTRAINTS;

-- ==========================================
-- TABLE CREATIONS
-- ==========================================
CREATE TABLE workshop (
    Workshop_ID INT PRIMARY KEY,
    Workshop_Name VARCHAR2(100),
    Description VARCHAR2(200),
    Date_Time DATE,
    Capacity INT
);

CREATE TABLE mentor (
    Mentor_ID INT PRIMARY KEY, 
    Mentor_Name VARCHAR(100) UNIQUE,
    Email VARCHAR(200) UNIQUE,
    Contact_Number CHAR(10) UNIQUE,
    Expertise VARCHAR2(200)
);

CREATE TABLE category (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR2(100),
    Description VARCHAR2(400)
);

CREATE TABLE team (
    Team_ID INT PRIMARY KEY,
    Team_Name VARCHAR2(100) UNIQUE,
    Team_Ammount INT CHECK (Team_Ammount BETWEEN 3 AND 5),
    Mentor_ID INT,
    FOREIGN KEY(Mentor_ID) REFERENCES mentor(Mentor_ID),
    CHECK (Team_ID BETWEEN 1 AND 8)
);

CREATE TABLE participant (
    Participant_ID INT PRIMARY KEY,
    Participant_Name VARCHAR2(100),
    Participant_IC VARCHAR2(20) UNIQUE,
    Email VARCHAR2(100) UNIQUE,
    Contact_Number VARCHAR2(20) UNIQUE,
    Course VARCHAR2(100),
    University VARCHAR2(100),
    Education_Level VARCHAR(100) CHECK (Education_Level IN ('Undergraduate', 'Postgraduate')),
    Team_ID INT,
    FOREIGN KEY(Team_ID) REFERENCES team(Team_ID)
);

CREATE TABLE project (
    Project_ID INT PRIMARY KEY, 
    Team_ID INT UNIQUE,
    Category_ID INT, 
    Project_Title VARCHAR2(100),
    Description VARCHAR2(400),
    Submission_Link VARCHAR2(200),
    Submission_Dateline DATE,
    FOREIGN KEY(Team_ID) REFERENCES team(Team_ID),
    FOREIGN KEY(Category_ID) REFERENCES category(Category_ID)
);

CREATE TABLE judge (
    Judge_ID INT PRIMARY KEY, 
    Judge_Name VARCHAR2(100) UNIQUE,
    Email VARCHAR2(100) UNIQUE,
    Expertise VARCHAR2(100)
);

CREATE TABLE score (
    Score_ID INT PRIMARY KEY, 
    Judge_ID INT,
    Project_ID INT,
    Score_Value INT,  
    Comments VARCHAR2(400),
    FOREIGN KEY(Judge_ID) REFERENCES judge(Judge_ID),
    FOREIGN KEY(Project_ID) REFERENCES project(Project_ID),
    CHECK (Score_Value BETWEEN 0 AND 100),
    UNIQUE (Judge_ID, Project_ID)
);

CREATE TABLE sponsor (
    Sponsor_ID INT PRIMARY KEY,
    Sponsor_Name VARCHAR2(100),
    Contact_Person VARCHAR2(100),
    Email VARCHAR2(100) UNIQUE
);

CREATE TABLE award (
    Award_ID INT PRIMARY KEY, 
    Award_Title VARCHAR2(100),
    Sponsor_ID INT, 
    Project_ID INT, 
    FOREIGN KEY(Project_ID) REFERENCES project(Project_ID),
    FOREIGN KEY(Sponsor_ID) REFERENCES sponsor(Sponsor_ID)
);

CREATE TABLE workshop_registration (
    Workshop_ID INT,
    Participant_ID INT, 
    PRIMARY KEY(Workshop_ID, Participant_ID),
    FOREIGN KEY(Workshop_ID) REFERENCES workshop(Workshop_ID),
    FOREIGN KEY(Participant_ID) REFERENCES participant(Participant_ID)
);

-- ==========================================
-- DATA INSERTION
-- ==========================================
INSERT INTO category (Category_ID, Category_Name, Description) VALUES (1, 'Fintech', 'Finance-related innovations');
INSERT INTO category (Category_ID, Category_Name, Description) VALUES (2, 'Artificial Intelligence', 'AI and machine learning projects');
INSERT INTO category (Category_ID, Category_Name, Description) VALUES (3, 'Medical Technology', 'Healthcare and medical apps');
INSERT INTO category (Category_ID, Category_Name, Description) VALUES (4, 'Green Tech', 'Environmental sustainability tech');
INSERT INTO category (Category_ID, Category_Name, Description) VALUES (5, 'Cybersecurity', 'Security and encryption solutions');
INSERT INTO category (Category_ID, Category_Name, Description) VALUES (6, 'EdTech', 'Educational technology tools');
INSERT INTO category (Category_ID, Category_Name, Description) VALUES (7, 'Agritech', 'Agricultural innovation systems');
INSERT INTO category (Category_ID, Category_Name, Description) VALUES (8, 'Smart Cities', 'Urban tech and IoT integration');

INSERT INTO mentor (Mentor_ID, Mentor_Name, Email, Contact_Number, Expertise) VALUES (1, 'Mentor A', 'mentor.a@example.com', '0123456789', 'AI');
INSERT INTO mentor (Mentor_ID, Mentor_Name, Email, Contact_Number, Expertise) VALUES (2, 'Mentor B', 'mentor.b@example.com', '0123456790', 'Cybersecurity');
INSERT INTO mentor (Mentor_ID, Mentor_Name, Email, Contact_Number, Expertise) VALUES (3, 'Mentor C', 'mentor.c@example.com', '0123456791', 'Fintech');
INSERT INTO mentor (Mentor_ID, Mentor_Name, Email, Contact_Number, Expertise) VALUES (4, 'Mentor D', 'mentor.d@example.com', '0123456792', 'EdTech');
INSERT INTO mentor (Mentor_ID, Mentor_Name, Email, Contact_Number, Expertise) VALUES (5, 'Mentor E', 'mentor.e@example.com', '0123456793', 'MedTech');
INSERT INTO mentor (Mentor_ID, Mentor_Name, Email, Contact_Number, Expertise) VALUES (6, 'Mentor F', 'mentor.f@example.com', '0123456794', 'Agritech');
INSERT INTO mentor (Mentor_ID, Mentor_Name, Email, Contact_Number, Expertise) VALUES (7, 'Mentor G', 'mentor.g@example.com', '0123456795', 'Smart Cities');
INSERT INTO mentor (Mentor_ID, Mentor_Name, Email, Contact_Number, Expertise) VALUES (8, 'Mentor H', 'mentor.h@example.com', '0123456796', 'Green Tech');

INSERT INTO team (Team_ID, Team_Name, Team_Ammount, Mentor_ID) VALUES (1, 'Team Alpha', 4, 1);
INSERT INTO team (Team_ID, Team_Name, Team_Ammount, Mentor_ID) VALUES (2, 'Team Beta', 3, 2);
INSERT INTO team (Team_ID, Team_Name, Team_Ammount, Mentor_ID) VALUES (3, 'Team Gamma', 5, 3);
INSERT INTO team (Team_ID, Team_Name, Team_Ammount, Mentor_ID) VALUES (4, 'Team Delta', 3, 4);
INSERT INTO team (Team_ID, Team_Name, Team_Ammount, Mentor_ID) VALUES (5, 'Team Epsilon', 5, 5);
INSERT INTO team (Team_ID, Team_Name, Team_Ammount, Mentor_ID) VALUES (6, 'Team Zeta', 5, 6);
INSERT INTO team (Team_ID, Team_Name, Team_Ammount, Mentor_ID) VALUES (7, 'Team Eta', 4, 7);
INSERT INTO team (Team_ID, Team_Name, Team_Ammount, Mentor_ID) VALUES (8, 'Team Theta', 5, 8);

-- Team 1
INSERT INTO participant VALUES (1, 'Ali Tan', 991231011234, 'ali.tan@uni1.edu.my', 60123456701, 'Computer Science', 'Monash University', 'Undergraduate', 1);
INSERT INTO participant VALUES (2, 'Sara Lim', 000101029876, 'sara.lim@uni1.edu.my', 60123456702, 'Data Science', 'Monash University', 'Undergraduate', 1);
INSERT INTO participant VALUES (3, 'Aiman Lee', 000215038765, 'aiman.lee@uni1.edu.my', 60123456703, 'IT', 'Monash University', 'Postgraduate', 1);
INSERT INTO participant VALUES (4, 'John Goh', 000317049876, 'john.goh@uni1.edu.my', 60123456704, 'Cybersecurity', 'Monash University', 'Undergraduate', 1);

-- Team 2
INSERT INTO participant VALUES (5, 'Liyana Wong', 000422059123, 'liyana.wong@uni2.edu.my', 60123456705, 'AI', 'Universiti Tunku Abdul Rahma', 'Undergraduate', 2);
INSERT INTO participant VALUES (6, 'Daniel Tan', 000531069876, 'daniel.tan@uni2.edu.my', 60123456706, 'Software Engineering', 'Universiti Tunku Abdul Rahma', 'Undergraduate', 2);
INSERT INTO participant VALUES (7, 'Nur Izzah', 000619078765, 'izzah@uni2.edu.my', 60123456707, 'Data Analytics', 'Universiti Tunku Abdul Rahma', 'Postgraduate', 2);
INSERT INTO participant VALUES (8, 'Raymond Koh', 000701089123, 'raymond.koh@uni2.edu.my', 60123456708, 'Computer Science', 'Universiti Tunku Abdul Rahma', 'Undergraduate', 2);

-- Team 3
INSERT INTO participant VALUES (9, 'Chong Wei', 000803091234, 'chong.wei@uni3.edu.my', 60123456709, 'Health Informatics', 'Sunway University', 'Undergraduate', 3);
INSERT INTO participant VALUES (10, 'Mira Syafiqah', 000912109876, 'mira.syafiqah@uni3.edu.my', 60123456710, 'Biomedical Tech', 'Sunway University', 'Undergraduate', 3);
INSERT INTO participant VALUES (11, 'Vikram Rao', 001021111111, 'vikram.rao@uni3.edu.my', 60123456711, 'Medical Tech', 'Sunway University', 'Postgraduate', 3);
INSERT INTO participant VALUES (12, 'Samantha Ng', 001122121212, 'samantha.ng@uni3.edu.my', 60123456712, 'Bioinformatics', 'Sunway University', 'Undergraduate', 3);

-- Team 4
INSERT INTO participant VALUES (13, 'Azim Firdaus', 001231131313, 'azim.f@uni4.edu.my', 60123456713, 'Green Technology', 'Taylors University', 'Undergraduate', 4);
INSERT INTO participant VALUES (14, 'Eunice Lau', 010101141414, 'eunice.l@uni4.edu.my', 60123456714, 'Sustainability', 'Taylors University', 'Postgraduate', 4);
INSERT INTO participant VALUES (15, 'Faiz Rahman', 010202151515, 'faiz.r@uni4.edu.my', 60123456715, 'Environmental Science', 'Taylors University', 'Undergraduate', 4);
INSERT INTO participant VALUES (16, 'Wei Ming', 010303161616, 'weiming@uni4.edu.my', 60123456716, 'Ecology Tech', 'Taylors University', 'Undergraduate', 4);

-- Team 5
INSERT INTO participant VALUES (17, 'Lina Hassan', 010404171717, 'lina.h@uni5.edu.my', 60123456717, 'Cybersecurity', 'Monash University', 'Undergraduate', 5);
INSERT INTO participant VALUES (18, 'Kelvin Yong', 010505181818, 'kelvin.y@uni5.edu.my', 60123456718, 'Network Security', 'Monash University', 'Postgraduate', 5);
INSERT INTO participant VALUES (19, 'Nadira Jamal', 010606191919, 'nadira.j@uni5.edu.my', 60123456719, 'Cryptography', 'Monash University', 'Undergraduate', 5);
INSERT INTO participant VALUES (20, 'Prakash Iyer', 010707202020, 'prakash.iyer@uni5.edu.my', 60123456720, 'Ethical Hacking', 'Monash University', 'Undergraduate', 5);

-- Team 6
INSERT INTO participant VALUES (21, 'Syazwan Iskandar', 010808212121, 'syazwan.i@uni3.edu.my', 60123456721, 'Educational Tech', 'Sunway University', 'Undergraduate', 6);
INSERT INTO participant VALUES (22, 'Chen Mei', 010909222222, 'chen.mei@uni3.edu.my', 60123456722, 'Instructional Design', 'Sunway University', 'Postgraduate', 6);
INSERT INTO participant VALUES (23, 'Nina Fazira', 011010232323, 'nina.f@uni3.edu.my', 60123456723, 'e-Learning Dev', 'Sunway University', 'Undergraduate', 6);
INSERT INTO participant VALUES (24, 'Jeremy Teo', 011111242424, 'jeremy.teo@uni3.edu.my', 60123456724, 'EdTech Systems', 'Sunway University', 'Undergraduate', 6);
INSERT INTO participant VALUES (25, 'Kenny Lu', 015111242435, 'kenny.lu@uni3.edu.my', 60123496655, 'EdTech Systems', 'Sunway University', 'Undergraduate', 6);

-- Team 7
INSERT INTO participant VALUES (26, 'Aqil Mokhtar', 011212252525, 'aqil.m@uni4.edu.my', 60123456725, 'Agriculture Systems', 'Sunway University', 'Undergraduate', 7);
INSERT INTO participant VALUES (27, 'Farah Zainal', 011313262626, 'farah.z@uni4.edu.my', 60123456726, 'Smart Farming', 'Sunway University', 'Postgraduate', 7);
INSERT INTO participant VALUES (28, 'Daryl Liew', 011414272727, 'daryl.liew@uni4.edu.my', 60123456727, 'Plant Monitoring', 'Sunway University', 'Undergraduate', 7);
INSERT INTO participant VALUES (29, 'Rafi Ahmad', 011515282828, 'rafi.a@uni4.edu.my', 60123456728, 'AgriTech Software', 'Sunway University', 'Undergraduate', 7);

-- Team 8
INSERT INTO participant VALUES (30, 'Fatin Wahida', 011616292929, 'fatin.w@uni5.edu.my', 60123456729, 'Urban Planning', 'Asia Pacific University', 'Undergraduate', 8);
INSERT INTO participant VALUES (31, 'Gabriel Tan', 011717303030, 'gabriel.tan@uni5.edu.my', 60123456730, 'IoT Systems', 'Asia Pacific University', 'Postgraduate', 8);
INSERT INTO participant VALUES (32, 'Zulaikha Arif', 011818313131, 'zulaikha.a@uni5.edu.my', 60123456731, 'Smart Infrastructure', 'Asia Pacific University', 'Undergraduate', 8);
INSERT INTO participant VALUES (33, 'Louis Ho', 011919323232, 'louis.ho@uni5.edu.my', 60123456732, 'City Planning Systems', 'Asia Pacific University', 'Undergraduate', 8);
INSERT INTO participant VALUES (34, 'Woof Kong', 011517282829, 'woof.k@uni4.edu.my', 60123458729, 'AgriTech Software', 'Asia Pacific University', 'Undergraduate', 8);

INSERT INTO project VALUES (1, 1, 1, 'Smart Finance', 'A fintech tool for students.', 'https://submission.com/smartfinance', TO_DATE('2025-07-07 15:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO project VALUES (2, 2, 2, 'AutoLearn AI', 'AI-driven personalized learning.', 'https://submission.com/autolearn', TO_DATE('2025-07-07 15:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO project VALUES (3, 3, 3, 'MediScan', 'Medical scan analysis platform.', 'https://submission.com/mediscan', TO_DATE('2025-07-07 15:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO project VALUES (4, 4, 4, 'EcoMeter', 'IoT for carbon tracking.', 'https://submission.com/ecometer', TO_DATE('2025-07-07 15:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO project VALUES (5, 5, 5, 'SecureNet', 'Real-time threat detection.', 'https://submission.com/securenet', TO_DATE('2025-07-07 15:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO project VALUES (6, 6, 6, 'EduBuddy', 'Peer-matching education platform.', 'https://submission.com/edubuddy', TO_DATE('2025-07-07 15:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO project VALUES (7, 7, 7, 'AgriBot', 'Automated crop health monitoring.', 'https://submission.com/agribot', TO_DATE('2025-07-07 15:00', 'YYYY-MM-DD HH24:MI'));
INSERT INTO project VALUES (8, 8, 8, 'CityFlow', 'Smart traffic management system.', 'https://submission.com/cityflow', TO_DATE('2025-07-07 15:00', 'YYYY-MM-DD HH24:MI'));

INSERT INTO judge VALUES (1, 'Judge A', 'judge.a@example.com', 'AI');
INSERT INTO judge VALUES (2, 'Judge B', 'judge.b@example.com', 'Fintech');
INSERT INTO judge VALUES (3, 'Judge C', 'judge.c@example.com', 'Cybersecurity');
INSERT INTO judge VALUES (4, 'Judge D', 'judge.d@example.com', 'Medical Tech');
INSERT INTO judge VALUES (5, 'Judge E', 'judge.e@example.com', 'Smart Cities');
INSERT INTO judge VALUES (6, 'Judge F', 'judge.f@example.com', 'EdTech');
INSERT INTO judge VALUES (7, 'Judge G', 'judge.g@example.com', 'Green Tech');
INSERT INTO judge VALUES (8, 'Judge H', 'judge.h@example.com', 'Agritech');

INSERT INTO score VALUES (1, 1, 1, 65, 'Great concept.');
INSERT INTO score VALUES (2, 2, 1, 53, 'Needs better UI.');
INSERT INTO score VALUES (3, 3, 2, 86, 'Impressive logic.');
INSERT INTO score VALUES (4, 4, 3, 75, 'Well researched.');
INSERT INTO score VALUES (5, 5, 4, 88, 'Creative use of tech.');
INSERT INTO score VALUES (6, 6, 5, 82, 'Very practical.');
INSERT INTO score VALUES (7, 7, 6, 71, 'Good team synergy.');
INSERT INTO score VALUES (8, 8, 7, 69, 'Unique implementation.');
INSERT INTO score VALUES (9, 1, 2, NULL, 'Potential to scale.');
INSERT INTO score VALUES (10, 2, 3, 48, 'Documentation incomplete.');
INSERT INTO score VALUES (11, 3, 4, 91, 'Clean code.');
INSERT INTO score VALUES (12, 4, 5, 97, 'Useful in real life.');
INSERT INTO score VALUES (13, 5, 6, 45, 'Missing some modules.');
INSERT INTO score VALUES (14, 6, 7, 85, 'Very organized.');
INSERT INTO score VALUES (15, 7, 8, 89, 'Presentation was excellent.');

INSERT INTO workshop VALUES (1, 'Design Thinking', 'Learn creative design.', TO_DATE('2025-07-05 10:00', 'YYYY-MM-DD HH24:MI'), 25);
INSERT INTO workshop VALUES (2, 'Intro to AI', 'AI for beginners.', TO_DATE('2025-07-05 14:00', 'YYYY-MM-DD HH24:MI'), 30);
INSERT INTO workshop VALUES (3, 'Pitching Skills', 'How to pitch ideas.', TO_DATE('2025-07-06 09:00', 'YYYY-MM-DD HH24:MI'), 20);
INSERT INTO workshop VALUES (4, 'Cyber Awareness', 'Online safety basics.', TO_DATE('2025-07-06 11:00', 'YYYY-MM-DD HH24:MI'), 20);
INSERT INTO workshop VALUES (5, 'Green Tech 101', 'Sustainable tech.', TO_DATE('2025-07-06 14:00', 'YYYY-MM-DD HH24:MI'), 15);
INSERT INTO workshop VALUES (6, 'IoT & Smart Cities', 'Future of urban tech.', TO_DATE('2025-07-07 10:00', 'YYYY-MM-DD HH24:MI'), 20);
INSERT INTO workshop VALUES (7, 'HealthTech UX', 'User-first health solutions.', TO_DATE('2025-07-07 13:00', 'YYYY-MM-DD HH24:MI'), 18);
INSERT INTO workshop VALUES (8, 'Networking Skills', 'Make professional connections.', TO_DATE('2025-07-07 15:00', 'YYYY-MM-DD HH24:MI'), 25);

INSERT INTO workshop_registration VALUES (1, 1);
INSERT INTO workshop_registration VALUES (1, 2);
INSERT INTO workshop_registration VALUES (1, 5);
INSERT INTO workshop_registration VALUES (1, 28);
INSERT INTO workshop_registration VALUES (1, 32);
INSERT INTO workshop_registration VALUES (2, 1);
INSERT INTO workshop_registration VALUES (2, 2);
INSERT INTO workshop_registration VALUES (3, 3);
INSERT INTO workshop_registration VALUES (3, 4);
INSERT INTO workshop_registration VALUES (3, 5);
INSERT INTO workshop_registration VALUES (3, 8);
INSERT INTO workshop_registration VALUES (4, 5);
INSERT INTO workshop_registration VALUES (5, 6);
INSERT INTO workshop_registration VALUES (6, 7);
INSERT INTO workshop_registration VALUES (6, 8);
INSERT INTO workshop_registration VALUES (7, 10);
INSERT INTO workshop_registration VALUES (7, 9);
INSERT INTO workshop_registration VALUES (7, 11);
INSERT INTO workshop_registration VALUES (7, 22);
INSERT INTO workshop_registration VALUES (7, 32);
INSERT INTO workshop_registration VALUES (7, 17);
INSERT INTO workshop_registration VALUES (7, 20);
INSERT INTO workshop_registration VALUES (7, 25);
INSERT INTO workshop_registration VALUES (7, 15);
INSERT INTO workshop_registration VALUES (7, 6);
INSERT INTO workshop_registration VALUES (7, 8);
INSERT INTO workshop_registration VALUES (7, 1);
INSERT INTO workshop_registration VALUES (7, 2);
INSERT INTO workshop_registration VALUES (7, 3);
INSERT INTO workshop_registration VALUES (7, 4);
INSERT INTO workshop_registration VALUES (7, 24);
INSERT INTO workshop_registration VALUES (7, 28);
INSERT INTO workshop_registration VALUES (8, 11);
INSERT INTO workshop_registration VALUES (8, 12);
INSERT INTO workshop_registration VALUES (8, 13);
INSERT INTO workshop_registration VALUES (8, 14);

INSERT INTO sponsor VALUES (1, 'Sunway Group', 'Jane Tan', 'jane@sunway.com');
INSERT INTO sponsor VALUES (2, 'Petronas', 'Ahmad Yusof', 'ahmad@petronas.com');
INSERT INTO sponsor VALUES (3, 'Microsoft Malaysia', 'Siti Noor', 'siti@microsoft.my');
INSERT INTO sponsor VALUES (4, 'Telekom Malaysia', 'Azman Omar', 'azman@tm.com.my');
INSERT INTO sponsor VALUES (5, 'AirAsia Digital', 'Rina Lee', 'rina@airasia.com');
INSERT INTO sponsor VALUES (6, 'Grab Malaysia', 'Kelvin Chong', 'kelvin@grab.my');
INSERT INTO sponsor VALUES (7, 'Time Internet', 'Syafiq Rahim', 'syafiq@time.my');
INSERT INTO sponsor VALUES (8, 'Google Cloud MY', 'Nadia Lim', 'nadia@google.com');

INSERT INTO award VALUES (1, 'Best Innovation', 1, 1);
INSERT INTO award VALUES (2, 'Best Pitch', 2, 2);
INSERT INTO award VALUES (3, 'Tech for Good', 3, 3);
INSERT INTO award VALUES (4, 'Green Impact Award', 4, 4);
INSERT INTO award VALUES (5, 'AI Excellence', 5, 2);
INSERT INTO award VALUES (6, 'Health Solution Award', 6, 3);
INSERT INTO award VALUES (7, 'Future City Award', 7, 8);
INSERT INTO award VALUES (8, 'People’s Choice', 8, 1);