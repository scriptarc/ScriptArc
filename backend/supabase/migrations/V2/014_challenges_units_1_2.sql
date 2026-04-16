-- ============================================================
-- ScriptArc – Challenge Seed Script
-- Units 1 & 2 – All MCQs and Coding Questions
-- Strategy: DELETE existing challenges per lesson, then INSERT fresh.
-- This avoids duplicates while cleanly re-seeding all content.
-- ============================================================

-- Course UUID (constant)
-- d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c

-- ------------------------------------------------------------
-- UNIT 1 LESSON IDs
-- L01: a7b1c2d3-e4f5-4a01-8b6c-d7e8f9a0b1c2
-- L02: b8c2d3e4-f5a6-4b02-9c7d-e8f9a0b1c2d3
-- L03: c9d3e4f5-a6b7-4c03-8d8e-f9a0b1c2d3e4
-- L04: d0e4f5a6-b7c8-4d04-9e9f-a0b1c2d3e4f5
-- L05: e1f5a6b7-c8d9-4e05-8faf-b1c2d3e4f5a6
-- L06: f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7
-- L07: a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8
-- L08: b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9
-- L09: c5d9e0f1-a2b3-4c09-8d3e-f5a6b7c8d9e0
-- L10: d6e0f1a2-b3c4-4d10-9e4f-a6b7c8d9e0f1
-- L11: e7f1a2b3-c4d5-4e11-8f5a-b7c8d9e0f1a2
-- ------------------------------------------------------------
-- UNIT 2 LESSON IDs
-- L01: f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3
-- L02: a9b3c4d5-e6f7-4a13-8b7c-d9e0f1a2b3c4
-- L03: b0c4d5e6-f7a8-4b14-9c8d-e0f1a2b3c4d5
-- L04: c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6
-- L05: d2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7
-- L06: e3f7a8b9-c0d1-4e17-8fba-b3c4d5e6f7a8
-- L07: f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9
-- L08: a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0
-- L09: b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1
-- L10: c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2
-- ------------------------------------------------------------

-- Step 1: Wipe existing challenges for all Unit 1 & 2 lessons
DELETE FROM public.challenges WHERE lesson_id IN (
  -- Unit 1
  'a7b1c2d3-e4f5-4a01-8b6c-d7e8f9a0b1c2',
  'b8c2d3e4-f5a6-4b02-9c7d-e8f9a0b1c2d3',
  'c9d3e4f5-a6b7-4c03-8d8e-f9a0b1c2d3e4',
  'd0e4f5a6-b7c8-4d04-9e9f-a0b1c2d3e4f5',
  'e1f5a6b7-c8d9-4e05-8faf-b1c2d3e4f5a6',
  'f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7',
  'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8',
  'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9',
  'c5d9e0f1-a2b3-4c09-8d3e-f5a6b7c8d9e0',
  'd6e0f1a2-b3c4-4d10-9e4f-a6b7c8d9e0f1',
  'e7f1a2b3-c4d5-4e11-8f5a-b7c8d9e0f1a2',
  -- Unit 2
  'f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3',
  'a9b3c4d5-e6f7-4a13-8b7c-d9e0f1a2b3c4',
  'b0c4d5e6-f7a8-4b14-9c8d-e0f1a2b3c4d5',
  'c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6',
  'd2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7',
  'e3f7a8b9-c0d1-4e17-8fba-b3c4d5e6f7a8',
  'f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9',
  'a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0',
  'b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1',
  'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2'
);

-- ============================================================
-- UNIT 1 – LECTURE 1: Introduction to Data Science (4 MCQs)
-- ============================================================
INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints) VALUES
('5d85a4cd-5b99-5ca7-a989-094141afd0a5', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a7b1c2d3-e4f5-4a01-8b6c-d7e8f9a0b1c2', 'mcq',
 'What best summarizes Data Science?',
 'Which of the following best summarizes Data Science as explained in the lecture?',
 84,
 '["Storing structured data in databases","Gathering data, analyzing patterns, and making informed decisions or predictions","Writing code for artificial intelligence systems","Managing business transactions digitally"]'::jsonb,
 1, 2, 'easy',
 '["The lecture defines data science as gathering data, analyzing it, finding patterns, and using it for decision-making or future prediction."]'::jsonb),

('9da7d998-1876-5362-ab1c-c08f8fbac2b1', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a7b1c2d3-e4f5-4a01-8b6c-d7e8f9a0b1c2', 'mcq',
 'Machine Learning in Robotic Manufacturing',
 'In the robotic manufacturing example, machine learning is mainly used to:',
 235,
 '["Replace all sensors in the system","Increase robot arm size","Find the best path and improve speed and precision","Eliminate energy consumption completely"]'::jsonb,
 2, 2, 'easy',
 '["Machine learning helps optimize robotic assembly tasks by finding the best path and improving speed and precision."]'::jsonb),

('204d616f-7b57-530a-9de8-1473b4e4e830', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a7b1c2d3-e4f5-4a01-8b6c-d7e8f9a0b1c2', 'mcq',
 'Data Science Lifecycle Order',
 'Which of the following is the correct order in the Data Science lifecycle?',
 368,
 '["Data Modeling → Data Collection → Deployment → Cleaning","Problem Statement → Data Collection → Data Cleaning → Analysis → Modeling → Deployment","Data Cleaning → Problem Statement → Modeling → Deployment","Data Collection → Modeling → Cleaning → Deployment"]'::jsonb,
 1, 2, 'easy',
 '["The lecture clearly explains the 6 steps: Problem → Collection → Cleaning → Analysis → Modeling → Optimization & Deployment."]'::jsonb),

('9870d61e-a701-5cf1-a615-415910b1dc8d', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a7b1c2d3-e4f5-4a01-8b6c-d7e8f9a0b1c2', 'mcq',
 'Big Data Compared to Crude Oil',
 'Why is Big Data compared to crude oil in the lecture?',
 718,
 '["Because it is expensive","Because it needs refining to extract useful insights","Because it is only used in industries","Because it replaces data science"]'::jsonb,
 1, 2, 'easy',
 '["Big Data represents raw data (like crude oil). Data Science extracts meaningful information (like refined petroleum products)."]'::jsonb);

-- ============================================================
-- UNIT 1 – LECTURE 2: Facets of Data (6 MCQs)
-- ============================================================
INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints) VALUES
('f31c39f5-a1c6-58a2-9360-9c3961a3310f', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b8c2d3e4-f5a6-4b02-9c7d-e8f9a0b1c2d3', 'mcq',
 'Structured vs Unstructured Data',
 'Which statement correctly differentiates structured and unstructured data?',
 94,
 '["Structured data has no format, while unstructured data follows rows and columns","Structured data is organized in rows and columns, while unstructured data does not follow a predefined format","Both structured and unstructured data follow strict DBMS rules","Unstructured data is easier to retrieve than structured data"]'::jsonb,
 1, 2, 'easy',
 '["Structured data is organized (like Excel or DBMS tables). Unstructured data does not follow rows/columns and is harder to retrieve."]'::jsonb),

('28499ce0-9856-5e28-8522-d83c08ed5384', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b8c2d3e4-f5a6-4b02-9c7d-e8f9a0b1c2d3', 'mcq',
 'Key Process in NLP',
 'Which of the following is a key process in Natural Language Processing (NLP)?',
 247,
 '["Data normalization in SQL","Entity recognition and sentiment analysis","Sensor calibration","Row-column indexing"]'::jsonb,
 1, 2, 'easy',
 '["NLP involves tasks such as entity recognition, summarization, text completion, and sentiment analysis."]'::jsonb),

('10ddb834-b1a6-506b-a810-49766427a1e2', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b8c2d3e4-f5a6-4b02-9c7d-e8f9a0b1c2d3', 'mcq',
 'Machine-Generated Data Example',
 'Which of the following is an example of machine-generated data?',
 301,
 '["Manually typed Excel sheet","Web server logs and sensor data","Printed newspaper article","Handwritten survey responses"]'::jsonb,
 1, 2, 'easy',
 '["Machine-generated data is automatically created by systems without human intervention, such as server logs, call detail records, and sensor data."]'::jsonb),

('3adcd7e8-16cc-58d7-9d98-947bfa1950b0', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b8c2d3e4-f5a6-4b02-9c7d-e8f9a0b1c2d3', 'mcq',
 'Graph-Based Data: Nodes and Edges',
 'In graph-based data, what do nodes and edges represent?',
 380,
 '["Rows and columns","Characters and words","Objects and relationships between them","Images and pixels"]'::jsonb,
 2, 2, 'easy',
 '["Graph-based data represents objects as nodes and relationships/interactions between them as edges (e.g., social networks)."]'::jsonb),

('a42d9bd5-2f0e-5097-ac53-ff294ed6df11', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b8c2d3e4-f5a6-4b02-9c7d-e8f9a0b1c2d3', 'mcq',
 'Audio, Video, Image Data Challenges',
 'Why do audio, video, and image data pose challenges to data scientists?',
 490,
 '["They cannot be stored digitally","They are easy only for machines to interpret","Machines require advanced techniques to interpret visual and audio content","They follow strict row-column formats"]'::jsonb,
 2, 2, 'easy',
 '["Humans can easily interpret images and audio, but machines require specialized data science techniques for object recognition and analysis."]'::jsonb),

('b9c26fba-ec99-5062-95c9-655e9e9c1349', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b8c2d3e4-f5a6-4b02-9c7d-e8f9a0b1c2d3', 'mcq',
 'Streaming Data Characteristic',
 'What is a key characteristic of streaming data?',
 581,
 '["It is stored permanently before processing","It is generated continuously and processed in real-time","It exists only in structured databases","It cannot be analyzed"]'::jsonb,
 1, 2, 'easy',
 '["Streaming data is generated continuously (e.g., stock markets, Twitter feeds) and requires real-time analysis."]'::jsonb);

-- ============================================================
-- UNIT 1 – LECTURE 3: Data Science Process (6 MCQs)
-- ============================================================
INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints) VALUES
('e1c9e8e4-3b74-5c83-8f68-a470c28a2365', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c9d3e4f5-a6b7-4c03-8d8e-f9a0b1c2d3e4', 'mcq',
 'Purpose of Setting Research Goal',
 'What is the primary purpose of setting the research goal in a data science project?',
 74,
 '["To start building machine learning models immediately","To define objectives, required resources, timeline, and expected outcomes","To clean and transform data","To visualize data patterns"]'::jsonb,
 1, 2, 'easy',
 '["The first step involves preparing a project charter including objectives, benefits to the company, required inputs, resources, schedule, and outcomes."]'::jsonb),

('c89f6f1e-71a8-545d-8001-ce689687d5c1', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c9d3e4f5-a6b7-4c03-8d8e-f9a0b1c2d3e4', 'mcq',
 'Data Warehouse vs Data Lake',
 'What is the key difference between a Data Warehouse and a Data Lake?',
 212,
 '["Data warehouse stores raw data, while data lake stores processed data","Data lake stores only structured data","Data warehouse stores processed and organized data, while data lake stores raw and unstructured data","Both store only Excel sheets"]'::jsonb,
 2, 2, 'easy',
 '["In a data warehouse, data is cleaned and organized before storage. In a data lake, raw and unstructured data is stored and processed later when needed."]'::jsonb),

('bd0d6966-1794-5153-a54d-b3648abe65ac', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c9d3e4f5-a6b7-4c03-8d8e-f9a0b1c2d3e4', 'mcq',
 'Data Preparation Activities',
 'Which of the following activities belongs to Data Preparation?',
 311,
 '["Presenting results to stakeholders","Removing missing values, combining datasets, and transforming variables","Deploying automation tools","Running model diagnostics"]'::jsonb,
 1, 2, 'easy',
 '["Data preparation includes data cleaning (removing errors, outliers), combining datasets, and transforming data into a suitable format."]'::jsonb),

('25203069-b838-5e99-a2b6-aaec164d261d', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c9d3e4f5-a6b7-4c03-8d8e-f9a0b1c2d3e4', 'mcq',
 'Goal of Exploratory Data Analysis',
 'What is the main goal of Exploratory Data Analysis (EDA)?',
 381,
 '["To deploy the final model","To build machine learning algorithms","To understand data distribution, relationships, and detect outliers","To automate business processes"]'::jsonb,
 2, 2, 'easy',
 '["EDA helps build deeper understanding of data using descriptive statistics, visualization, and identifying relationships or anomalies."]'::jsonb),

('5895124d-68b8-5af5-b0bf-937377abcc30', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c9d3e4f5-a6b7-4c03-8d8e-f9a0b1c2d3e4', 'mcq',
 'High R² Value Issue',
 'If an R² value is extremely high, what potential issue should be checked?',
 535,
 '["Underfitting","Data cleaning error","Overfitting","Missing value error"]'::jsonb,
 2, 2, 'easy',
 '["A very high R² value may indicate overfitting, meaning the model fits training data too closely and may not generalize well."]'::jsonb),

('4b945aaf-4cef-57a9-8870-1f220b16f1f9', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c9d3e4f5-a6b7-4c03-8d8e-f9a0b1c2d3e4', 'mcq',
 'Importance of Automation in Data Science',
 'Why is automation important in the final stage of the data science process?',
 575,
 '["To reduce the need for research goals","To avoid using models in real-time","To reuse and apply insights efficiently across business operations","To delete historical data"]'::jsonb,
 2, 2, 'easy',
 '["Automation allows businesses to repeatedly apply insights from one project to other operations, improving efficiency and scalability."]'::jsonb);

-- ============================================================
-- UNIT 1 – LECTURE 4: Introduction to NumPy (5 MCQs)
-- ============================================================
INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints) VALUES
('ea49b30d-7856-53d3-9552-7c4e6c719e86', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd0e4f5a6-b7c8-4d04-9e9f-a0b1c2d3e4f5', 'mcq',
 'What is NumPy?',
 'Which of the following correctly describes NumPy?',
 57,
 '["A database management system","A numerical Python library for array processing and scientific computing","A web development framework","A visualization tool only"]'::jsonb,
 1, 2, 'easy',
 '["NumPy (Numerical Python) is an open-source library designed for array processing and scientific computing, including linear algebra and Fourier transforms."]'::jsonb),

('d4990647-f96c-54b8-a760-c0469d09e24f', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd0e4f5a6-b7c8-4d04-9e9f-a0b1c2d3e4f5', 'mcq',
 'NumPy Arrays vs Python Lists',
 'Why are NumPy arrays preferred over Python lists in data science?',
 164,
 '["They consume more memory","They are slower but easier to write","They are significantly faster and optimized for numerical computation","They cannot handle multi-dimensional data"]'::jsonb,
 2, 2, 'easy',
 '["NumPy arrays are optimized for performance and can be up to 50× faster than Python lists, making them suitable for large-scale numerical computation."]'::jsonb),

('1810e8c8-59ed-5701-aafb-ed8f1b7255c9', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd0e4f5a6-b7c8-4d04-9e9f-a0b1c2d3e4f5', 'mcq',
 'Installing NumPy',
 'Which command is used to install NumPy using Python''s package manager?',
 209,
 '["install numpy","python get numpy","pip install numpy","import numpy install"]'::jsonb,
 2, 2, 'easy',
 '["NumPy is installed using pip (Python Package Manager) with the command: pip install numpy."]'::jsonb),

('7a6bee2f-c76c-56e7-8db9-6727910703de', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd0e4f5a6-b7c8-4d04-9e9f-a0b1c2d3e4f5', 'mcq',
 'NumPy Capabilities',
 'Which of the following is NOT a capability of NumPy mentioned in the lecture?',
 235,
 '["Linear algebra operations","Random number generation","Web server hosting","Fourier transform"]'::jsonb,
 2, 2, 'easy',
 '["NumPy supports linear algebra, Fourier transforms, random number generation, and array reshaping – but not web server hosting."]'::jsonb),

('b02cb67c-9d75-57c2-925a-3fcb007fc604', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd0e4f5a6-b7c8-4d04-9e9f-a0b1c2d3e4f5', 'mcq',
 'NumPy Applications',
 'NumPy is widely used in which of the following fields?',
 254,
 '["Machine Learning and Scientific Computing","Social Media Marketing","Video Editing Software","Hardware Manufacturing"]'::jsonb,
 0, 2, 'easy',
 '["NumPy is fundamental in machine learning, data science, image processing, signal processing, and scientific computing."]'::jsonb);

-- ============================================================
-- UNIT 1 – LECTURE 5: Creating Arrays and their Attributes (4 MCQs + 1 Coding)
-- ============================================================
INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints) VALUES
('79e9cbe3-c718-5d13-a314-a8b78ef79aed', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e1f5a6b7-c8d9-4e05-8faf-b1c2d3e4f5a6', 'mcq',
 'NumPy Array Definition',
 'Which statement about a NumPy array is correct?',
 52,
 '["It starts indexing from 1","It is an unordered collection of elements","It is an ordered collection of elements with zero-based indexing","It cannot store numerical data"]'::jsonb,
 2, 2, 'easy',
 '["A NumPy array is an ordered collection of data elements and follows zero-based indexing similar to Python lists."]'::jsonb),

('8f931e87-97df-5066-b29b-8d74b3c1b243', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e1f5a6b7-c8d9-4e05-8faf-b1c2d3e4f5a6', 'mcq',
 'np.arange() vs np.array()',
 'What is the difference between np.arange() and np.array()?',
 228,
 '["np.arange() creates arrays from an existing list, while np.array() generates ranges","np.arange() generates sequential values, while np.array() creates arrays from provided data","Both perform exactly the same function","np.array() only creates 1D arrays"]'::jsonb,
 1, 2, 'easy',
 '["np.arange() generates a sequence of numbers (e.g., 0-19), while np.array() creates arrays from explicitly provided values."]'::jsonb),

('955957c5-eaa6-5850-b95d-fd377aec594d', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e1f5a6b7-c8d9-4e05-8faf-b1c2d3e4f5a6', 'mcq',
 'Array Attribute: ndim',
 'Which NumPy attribute returns the number of dimensions of an array?',
 294,
 '["size","shape","ndim","dtype"]'::jsonb,
 2, 2, 'easy',
 '["ndim returns the number of dimensions (1D, 2D, 3D, etc.) of the array."]'::jsonb),

('8d1c2d27-f57b-55d2-bfec-382e4cd1fba8', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e1f5a6b7-c8d9-4e05-8faf-b1c2d3e4f5a6', 'mcq',
 'int32 Item Size',
 'If an array is defined with data type int32, what will be its item size?',
 410,
 '["2 bytes","4 bytes","8 bytes","16 bytes"]'::jsonb,
 1, 2, 'easy',
 '["int32 occupies 4 bytes per element, while default int64 typically occupies 8 bytes."]'::jsonb);

-- Lecture 5 Coding Challenge
INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, initial_code, language_id, star_value, difficulty, hints, solution) VALUES
('b26d129e-00a4-5128-b5bc-c7f479ba9783', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e1f5a6b7-c8d9-4e05-8faf-b1c2d3e4f5a6', 'coding',
 'NumPy Basics: Create & Reshape Array',
 E'Write a NumPy program to:\n1. Create a 1D array containing numbers from 10 to 19\n2. Convert it into a 2D array with 2 rows\n3. Print the array',
 228,
 E'import numpy as np\n\n# 1D array from 10 to 19\narr1 = np._______\n\n# Convert to 2D array with 2 rows\narr2 = arr1._______\n\nprint(arr2)',
 71, 4, 'medium',
 '["Use np.arange() for creating the sequence","Use .reshape() to change dimensions"]',
 E'import numpy as np\n\n# 1D array from 10 to 19\narr1 = np.arange(10, 20)\n\n# Convert to 2D array with 2 rows\narr2 = arr1.reshape(2, 5)\n\nprint(arr2)');

-- ============================================================
-- UNIT 1 – LECTURE 6: Array Attributes Demonstration (6 MCQs + 1 Coding)
-- ============================================================
INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints) VALUES
('65cff913-e0d7-5fa5-933c-8ef95f7ff61b', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7', 'mcq',
 'Attribute: ndim',
 'Which NumPy attribute is used to find the number of dimensions of an array?',
 3,
 '["size","shape","ndim","dtype"]'::jsonb,
 2, 2, 'easy',
 '["ndim returns the number of dimensions of a NumPy array."]'::jsonb),

('e2f09458-6080-568c-b6f9-eb70098a4278', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7', 'mcq',
 'Attribute: size',
 'Which attribute returns the total number of elements in a NumPy array?',
 40,
 '["shape","size","dtype","ndim"]'::jsonb,
 1, 2, 'easy',
 '["size gives the total number of elements present in the array."]'::jsonb),

('8f1dd4a3-2c98-5c2c-a592-310a4ead2ce9', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7', 'mcq',
 'Attribute: shape',
 'What does the shape attribute return in a NumPy array?',
 60,
 '["Total elements","Number of dimensions","Structure of rows and columns","Data type of elements"]'::jsonb,
 2, 2, 'easy',
 '["shape returns the dimensions of the array (rows, columns, etc.)."]'::jsonb),

('8cc67859-22d2-549d-bff0-bae8eb855841', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7', 'mcq',
 'Default Integer dtype in NumPy',
 'What is the default integer data type returned by NumPy when dtype is not specified?',
 75,
 '["int32","int16","int64","float64"]'::jsonb,
 2, 2, 'easy',
 '["If dtype is not specified, NumPy usually uses int64 by default."]'::jsonb),

('32771743-cd7b-50c7-9f93-88a4480ae249', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7', 'mcq',
 'Attribute: itemsize',
 'What does the itemsize attribute represent in a NumPy array?',
 96,
 '["Total memory of the array","Size of each element in bytes","Number of elements in array","Number of rows"]'::jsonb,
 1, 2, 'easy',
 '["itemsize returns the memory size of each element in bytes."]'::jsonb),

('de902d66-ca45-5629-bba4-7772d10f5f7a', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7', 'mcq',
 'int64 Element Size',
 'If an array uses int64, what will be the size of each element?',
 96,
 '["2 bytes","4 bytes","8 bytes","16 bytes"]'::jsonb,
 2, 2, 'easy',
 '["int64 → 64 bits = 8 bytes"]'::jsonb);

-- Lecture 6 Coding Challenge (Fill in the Blanks)
INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, initial_code, language_id, star_value, difficulty, hints, solution) VALUES
('cf242955-3976-5443-818e-ca698a501c70', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7', 'coding',
 'Array Attributes: ndim, size, shape',
 E'Complete the code to find dimension, size, and shape of a NumPy array.\n\nBlanks:\n1. _____ (for ndim)\n2. _____ (for size)\n3. _____ (for shape)',
 96,
 E'import numpy as np\n\narr = np.array([10,20,30])\n\nprint("Dimension:", arr._____)\nprint("Total Elements:", arr._____)\nprint("Shape:", arr._____)',
 71, 4, 'medium',
 '["Use .ndim for dimensions","Use .size for total elements","Use .shape for structure"]',
 E'import numpy as np\n\narr = np.array([10,20,30])\n\nprint("Dimension:", arr.ndim)\nprint("Total Elements:", arr.size)\nprint("Shape:", arr.shape)');

-- ============================================================
-- UNIT 1 — LECTURE 7: Basic Array Operations (7 MCQs + 1 Coding)
-- ============================================================
INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints) VALUES
('3cb6379d-2ef4-57ae-9047-1aee245d8361', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'mcq',
 'np.concatenate() Function',
 'Which NumPy function is used to join two arrays along a specified axis?',
 56,
 '["np.join()","np.concatenate()","np.append()","np.combine()"]'::jsonb,
 1, 2, 'easy',
 '["np.concatenate() joins arrays along a specified axis."]'::jsonb),
('f1c14723-3a76-5837-ab31-0c3e10a83514', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'mcq',
 'axis=0 in np.concatenate()',
 'What happens when axis = 0 is used in np.concatenate()?',
 104,
 '["Horizontal stacking","Vertical stacking","Diagonal stacking","Array splitting"]'::jsonb,
 1, 2, 'easy',
 '["axis = 0 joins arrays vertically (row-wise)."]'::jsonb),
('372b17b5-3963-5dae-860d-bfebeb729b7e', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'mcq',
 'Horizontal Stacking: np.hstack()',
 'Which NumPy function is specifically used for horizontal stacking of arrays?',
 149,
 '["np.vstack()","np.concatenate()","np.hstack()","np.split()"]'::jsonb,
 2, 2, 'easy',
 '["np.hstack() joins arrays horizontally (column-wise)."]'::jsonb),
('b35602e1-239c-522f-a8d0-145373b9fba0', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'mcq',
 'Limitation of np.split()',
 'What is the limitation of the np.split() function?',
 227,
 '["It works only on 2D arrays","It can split arrays only into equal parts","It cannot split arrays","It only works on strings"]'::jsonb,
 1, 2, 'easy',
 '["np.split() can divide arrays only into equal-sized subarrays."]'::jsonb),
('3ecc46d9-95c4-5cc0-9a55-45aaa811cda0', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'mcq',
 'np.array_split() Function',
 'Which NumPy function allows splitting arrays even if they cannot be divided equally?',
 314,
 '["np.divide()","np.array_split()","np.break()","np.cut()"]'::jsonb,
 1, 2, 'easy',
 '["np.array_split() can divide arrays even when equal division is not possible."]'::jsonb),
('cb858dde-fe14-57f1-9601-af0378f0d377', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'mcq',
 'np.where() Function',
 'Which function is used to find the index of elements satisfying a condition in NumPy?',
 490,
 '["np.search()","np.where()","np.find()","np.locate()"]'::jsonb,
 1, 2, 'easy',
 '["np.where() returns the indices of elements that satisfy a condition."]'::jsonb),
('d0edc51c-565b-5f11-919e-d957615c42a2', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'mcq',
 'np.sort() Default Behavior',
 'What does np.sort() do by default?',
 613,
 '["Sorts columns","Sorts rows","Sorts diagonally","Randomizes the array"]'::jsonb,
 1, 2, 'easy',
 '["By default, np.sort() sorts along the last axis (row-wise for 2D arrays)."]'::jsonb);

INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, initial_code, language_id, star_value, difficulty, hints, solution) VALUES
('b17cfa8f-54d1-57f5-8a9f-40b82bd49331', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'coding',
 'Join Two Arrays Horizontally',
 E'Complete the code to join two arrays horizontally using NumPy.\n\nBlank:\n1. _____ (the function to use)',
 149,
 E'import numpy as np\n\narr1 = np.array([[1,2,3]])\narr2 = np.array([[4,5,6]])\n\nresult = np._____(arr1, arr2)\n\nprint(result)',
 71, 4, 'medium',
 '["Use np.hstack() for horizontal stacking"]',
 E'import numpy as np\n\narr1 = np.array([[1,2,3]])\narr2 = np.array([[4,5,6]])\n\nresult = np.hstack((arr1, arr2))\n\nprint(result)');

-- ============================================================
-- UNIT 1 — LECTURE 8: Joining, Splitting, Searching, Sorting (7 MCQs + 1 Coding)
-- ============================================================
INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints) VALUES
('258f76d1-7839-5cf5-89eb-3b545772d09d', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq',
 'Array Indexing Purpose',
 'What is array indexing in NumPy used for?',
 44,
 '["Sorting array elements","Accessing elements using their position","Deleting elements from arrays","Creating arrays"]'::jsonb,
 1, 2, 'easy',
 '["Indexing allows us to access elements in an array using their position."]'::jsonb),
('097194c5-8698-585b-9e69-3a43679f45c3', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq',
 'Index Start Value',
 'At what index does NumPy array indexing start?',
 75,
 '["-1","1","0","2"]'::jsonb,
 2, 2, 'easy',
 '["Array indexing in Python starts from 0."]'::jsonb),
('838043ad-ee9a-5ce4-8649-1dfafd4651b3', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq',
 'Negative Index -1',
 'What does the negative index -1 represent in an array?',
 164,
 '["First element","Last element","Middle element","Second element"]'::jsonb,
 1, 2, 'easy',
 '["Negative indexing counts from the end of the array, so -1 refers to the last element."]'::jsonb),
('d849d44b-c2b5-57b0-958f-ca98f1098d02', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq',
 '2D Array Indexing: array[1, :]',
 'In a 2D NumPy array, what does array[1, :] represent?',
 239,
 '["First column","Second row","Second column","Entire array"]'::jsonb,
 1, 2, 'easy',
 '["array[1, :] selects row index 1 (second row) and all columns."]'::jsonb),
('e02ca36a-aa76-56db-9ed5-318b4af82a67', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq',
 'Slicing Stop Index',
 'In array slicing syntax array[start:stop:step], what does the stop index represent?',
 381,
 '["Inclusive value","Exclusive value","Always zero","Optional only for strings"]'::jsonb,
 1, 2, 'easy',
 '["The stop index is exclusive, meaning that element is not included."]'::jsonb),
('456f7c43-d499-5731-a9e6-418e77693694', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq',
 'Partial Slicing: array[3:]',
 'What does the slicing expression array[3:] return?',
 530,
 '["Elements from index 0 to 3","Elements from index 3 to the end","Only element at index 3","Reverse array"]'::jsonb,
 1, 2, 'easy',
 '["array[3:] returns all elements starting from index 3 to the end."]'::jsonb),
('62ac1e8b-12ae-5066-9d04-03509832b1d1', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq',
 'Iterating Arrays',
 'Which loop is commonly used to iterate through elements of a NumPy array?',
 712,
 '["while loop","for loop","do-while loop","switch loop"]'::jsonb,
 1, 2, 'easy',
 '["A for loop is typically used to iterate through array elements."]'::jsonb);

INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, initial_code, language_id, star_value, difficulty, hints, solution) VALUES
('f630b6df-60aa-59f1-b551-bb024cc256b8', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'coding',
 'Array Slicing: Print Elements Index 2 to 5',
 E'Complete the code to print elements from index 2 to index 5 using slicing.\n\nBlanks:\n1. _____ (start index)\n2. _____ (stop index)',
 381,
 E'import numpy as np\n\narr = np.array([1,3,5,7,9,11])\n\nresult = arr[_____:_____]\n\nprint(result)',
 71, 4, 'medium',
 '["Remember the stop index is exclusive","To include index 5, the stop must be 6"]',
 E'import numpy as np\n\narr = np.array([1,3,5,7,9,11])\n\nresult = arr[2:6]\n\nprint(result)');

-- ============================================================
-- UNIT 1 — LECTURE 9: Array Indexing, Slicing, and Iterating (8 MCQs + 1 Coding)
-- ============================================================
INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints) VALUES
('49690772-27ee-5277-9b68-b84f9e58a53c', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c5d9e0f1-a2b3-4c09-8d3e-f5a6b7c8d9e0', 'mcq',
 'NumPy Zero-Based Indexing',
 'In NumPy arrays, indexing starts from which value?',
 61,
 '["1","-1","0","Depends on array size"]'::jsonb,
 2, 2, 'easy',
 '["NumPy arrays follow zero-based indexing, meaning the first element has index 0."]'::jsonb),
('0932d50e-e8ef-5798-ad5d-b589be208eff', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c5d9e0f1-a2b3-4c09-8d3e-f5a6b7c8d9e0', 'mcq',
 'Negative Indexing Representation',
 'Which of the following represents negative indexing in Python arrays?',
 82,
 '["0,1,2,3","1,2,3,4","-1,-2,-3,-4","A,B,C,D"]'::jsonb,
 2, 2, 'easy',
 '["Negative indexing accesses elements from the end of the array, where -1 refers to the last element."]'::jsonb),
('d1ab15ce-9adc-5ca9-9c80-2ec5fc212f23', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c5d9e0f1-a2b3-4c09-8d3e-f5a6b7c8d9e0', 'mcq',
 'Fancy Indexing Output',
 'Given the array arr = [1,3,5,7,9], what will be the output of arr[[0,2,4]]?',
 131,
 '["1,3,5","1,5,9","3,7,9","5,7,9"]'::jsonb,
 1, 2, 'easy',
 '["Index 0,2,4 correspond to values 1,5,9."]'::jsonb),
('d7b6adef-0a60-51b2-b417-f250bf0a7d67', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c5d9e0f1-a2b3-4c09-8d3e-f5a6b7c8d9e0', 'mcq',
 'Colon in array[1, :]',
 'In the command array[1, :], what does : represent?',
 197,
 '["Select all rows","Select all columns","Skip values","Reverse array"]'::jsonb,
 1, 2, 'easy',
 '[": selects all columns of the specified row."]'::jsonb),
('9bc0fd8c-50c0-5767-9577-b147dfeaaf8a', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c5d9e0f1-a2b3-4c09-8d3e-f5a6b7c8d9e0', 'mcq',
 '3D Array First Index',
 'In 3D array indexing, the first index represents:',
 278,
 '["Column","Slice","Row","Dimension size"]'::jsonb,
 1, 2, 'easy',
 '["For 3D arrays: array[slice, row, column]"]'::jsonb),
('9ee5e676-8abd-5a6f-883f-c17c72d0f5b0', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c5d9e0f1-a2b3-4c09-8d3e-f5a6b7c8d9e0', 'mcq',
 'What Array Slicing Does',
 'What does array slicing allow you to do?',
 387,
 '["Delete array elements","Access part of an array","Reverse arrays","Merge arrays"]'::jsonb,
 1, 2, 'easy',
 '["Slicing extracts a subset of elements from an array."]'::jsonb),
('b45572c8-1305-553a-aa50-6a916362f050', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c5d9e0f1-a2b3-4c09-8d3e-f5a6b7c8d9e0', 'mcq',
 'Slicing Stop Index Meaning',
 'In Python slicing syntax array[start : stop : step], what does stop represent?',
 425,
 '["Included index","Exclusive index","Last element always","Step size"]'::jsonb,
 1, 2, 'easy',
 '["The stop index is exclusive, meaning that element is not included."]'::jsonb),
('f144cbef-ef09-556b-9bd2-302a1e6233db', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c5d9e0f1-a2b3-4c09-8d3e-f5a6b7c8d9e0', 'mcq',
 'Common Loop for Iteration',
 'Which loop is commonly used to iterate through array elements?',
 712,
 '["while loop","for loop","do-while loop","switch loop"]'::jsonb,
 1, 2, 'easy',
 '["for x in array: is the standard method to iterate through NumPy arrays."]'::jsonb);

INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, initial_code, language_id, star_value, difficulty, hints, solution) VALUES
('ea4e3a7f-9464-5778-9ed6-2caa99edcbd1', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c5d9e0f1-a2b3-4c09-8d3e-f5a6b7c8d9e0', 'coding',
 'Print Element at Index 2',
 E'Complete the code to print the element at index 2 of a NumPy array.\n\nBlank:\n1. _____ (the index number)',
 153,
 E'import numpy as np\n\narr = np.array([10,20,30,40,50])\n\nprint(arr[_____])',
 71, 4, 'medium',
 '["Arrays use zero-based indexing: index 2 is the third element"]',
 E'import numpy as np\n\narr = np.array([10,20,30,40,50])\n\nprint(arr[2])');

-- ============================================================
-- UNIT 1 — LECTURE 10: Copying Arrays, Shape Manipulation, Identity Functions (7 MCQs + 1 Coding)
-- ============================================================
INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints) VALUES
('f4ab168e-18da-5db8-b663-3479550a3163', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd6e0f1a2-b3c4-4d10-9e4f-a6b7c8d9e0f1', 'mcq',
 'array.copy() Method',
 'What does the array.copy() method do in NumPy?',
 54,
 '["Deletes the original array","Creates a reference to the same array","Creates a new independent copy of the array","Sorts the array"]'::jsonb,
 2, 2, 'easy',
 '["copy() creates a new array independent of the original, so changes in the copy do not affect the original array."]'::jsonb),
('9a6b707b-f1f3-5cda-b639-fde6b593b32a', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd6e0f1a2-b3c4-4d10-9e4f-a6b7c8d9e0f1', 'mcq',
 'reshape() Function',
 'Which NumPy function is used to change the shape of an array without changing its data?',
 127,
 '["reshape()","resize()","split()","concatenate()"]'::jsonb,
 0, 2, 'easy',
 '["reshape() changes the dimensions of the array while keeping the same data."]'::jsonb),
('e3bbae8b-7dde-59e4-9478-6e4901282000', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd6e0f1a2-b3c4-4d10-9e4f-a6b7c8d9e0f1', 'mcq',
 'reshape(-1) Behavior',
 'What does reshape(-1) do in NumPy?',
 173,
 '["Deletes the array","Flattens the array into one dimension","Converts array into matrix","Splits the array"]'::jsonb,
 1, 2, 'easy',
 '["reshape(-1) converts a multi-dimensional array into a 1D array."]'::jsonb),
('d3d55d7b-7d75-5f84-a8dd-edfab7b0f753', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd6e0f1a2-b3c4-4d10-9e4f-a6b7c8d9e0f1', 'mcq',
 'np.identity() Function',
 'Which function creates an identity matrix in NumPy?',
 210,
 '["np.matrix()","np.identity()","np.diagonal()","np.ones()"]'::jsonb,
 1, 2, 'easy',
 '["np.identity() creates a square matrix with 1s on the diagonal and 0s elsewhere."]'::jsonb),
('71952860-2bdb-5492-99c7-6a2b27b1e181', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd6e0f1a2-b3c4-4d10-9e4f-a6b7c8d9e0f1', 'mcq',
 'Default dtype of np.identity()',
 'What is the default data type of values created using np.identity()?',
 285,
 '["Integer","Float","Boolean","String"]'::jsonb,
 1, 2, 'easy',
 '["If dtype is not specified, NumPy uses float values by default."]'::jsonb),
('b631265a-35f8-5d74-9f3b-5fe72c4cfbb4', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd6e0f1a2-b3c4-4d10-9e4f-a6b7c8d9e0f1', 'mcq',
 'np.eye() Parameter k',
 'What is the purpose of the k parameter in the np.eye() function?',
 325,
 '["Controls array size","Sets the diagonal offset","Defines array datatype","Sorts diagonal values"]'::jsonb,
 1, 2, 'easy',
 '["k shifts the diagonal position above or below the main diagonal."]'::jsonb),
('c34b9b55-f066-54e5-b9f5-159b0e72baab', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd6e0f1a2-b3c4-4d10-9e4f-a6b7c8d9e0f1', 'mcq',
 'np.identity() vs np.eye()',
 'What is the key difference between np.identity() and np.eye()?',
 452,
 '["np.eye() only creates square matrices","np.identity() supports rectangular matrices","np.eye() can create rectangular matrices and diagonal offsets","Both are identical"]'::jsonb,
 2, 2, 'easy',
 '["np.eye() is more flexible, allowing rectangular matrices and diagonal offsets."]'::jsonb);

INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, initial_code, language_id, star_value, difficulty, hints, solution) VALUES
('21dda2f4-907b-5d45-b72c-8e819b6759e4', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd6e0f1a2-b3c4-4d10-9e4f-a6b7c8d9e0f1', 'coding',
 'Reshape 1D Array into 3×4 Matrix',
 E'Complete the code to reshape a 1D array into a 3x4 matrix.\n\nBlanks:\n1. _____ (function name)\n2. _____ (rows)\n3. _____ (columns)',
 210,
 E'import numpy as np\n\narr = np.array(range(1,13))\n\nnew_arr = arr._____(_____,_____)\n\nprint(new_arr)',
 71, 4, 'medium',
 '["Use .reshape() to change array dimensions","A 3x4 matrix has 3 rows and 4 columns"]',
 E'import numpy as np\n\narr = np.array(range(1,13))\n\nnew_arr = arr.reshape(3,4)\n\nprint(new_arr)');

-- ============================================================
-- UNIT 1 — LECTURE 11: Exploring Data using Series and DataFrames (8 MCQs + 1 Coding)
-- ============================================================
INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints) VALUES
('b0838bce-7d20-5eb2-a799-3bc341bba4f4', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e7f1a2b3-c4d5-4e11-8f5a-b7c8d9e0f1a2', 'mcq',
 'Pandas Series Definition',
 'What is a Pandas Series?',
 46,
 '["A two-dimensional table","A one-dimensional labeled array","A matrix with rows and columns","A NumPy sorting function"]'::jsonb,
 1, 2, 'easy',
 '["A Pandas Series is a 1-dimensional labeled array capable of holding different data types."]'::jsonb),
('9c0e01dd-fdf1-59c7-9674-3ed262059986', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e7f1a2b3-c4d5-4e11-8f5a-b7c8d9e0f1a2', 'mcq',
 'Series and DataFrame Operations',
 'Which of the following operations can be performed on both Series and DataFrames?',
 83,
 '["Vectorized operations","Indexing","Aggregation functions","All of the above"]'::jsonb,
 3, 2, 'easy',
 '["Both Series and DataFrames support indexing, vectorized operations, aggregation, and missing value handling."]'::jsonb),
('41819093-ddd3-5932-9fdc-09820796e2ed', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e7f1a2b3-c4d5-4e11-8f5a-b7c8d9e0f1a2', 'mcq',
 'Creating a Pandas Series',
 'Which command is used to create a Series from a list in Pandas?',
 122,
 '["pd.array()","pd.Series()","pd.DataFrame()","pd.list()"]'::jsonb,
 1, 2, 'easy',
 '["pd.Series() creates a Series from lists, dictionaries, or arrays."]'::jsonb),

('f9d02868-6443-5e16-b5cb-d1de8f23b8b1', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e7f1a2b3-c4d5-4e11-8f5a-b7c8d9e0f1a2', 'mcq',
 'Vectorized Operations Requirement',
 'What must be true for vectorized operations between two Series?',
 246,
 '["Same data values","Same array size","Same datatype","Same column name"]'::jsonb,
 1, 2, 'easy',
 '["Vectorized operations require Series of the same size for element-wise calculations."]'::jsonb),

('87059218-138b-584b-8134-ee164f027f3f', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e7f1a2b3-c4d5-4e11-8f5a-b7c8d9e0f1a2', 'mcq',
 'isna() for Missing Values',
 'Which Pandas function is used to check missing values in a Series?',
 372,
 '["checknull()","isna()","findnull()","missing()"]'::jsonb,
 1, 2, 'easy',
 '["isna() returns True for missing values and False otherwise."]'::jsonb),

('4730eda0-204e-52e8-b94c-93f8d08e80b6', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e7f1a2b3-c4d5-4e11-8f5a-b7c8d9e0f1a2', 'mcq',
 'fillna() to Replace Missing Values',
 'Which function is used to replace missing values in a Series?',
 498,
 '["replace()","fillna()","update()","addna()"]'::jsonb,
 1, 2, 'easy',
 '["fillna() replaces missing values with specified values."]'::jsonb),

('c1fbb69f-3557-5e9e-ae22-2701040b3fe4', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e7f1a2b3-c4d5-4e11-8f5a-b7c8d9e0f1a2', 'mcq',
 'df.loc[] Label-Based Indexing',
 'What does df.loc[] represent in a DataFrame?',
 702,
 '["Position-based indexing","Label-based indexing","Sorting function","Aggregation method"]'::jsonb,
 1, 2, 'easy',
 '["loc[] accesses rows and columns using labels."]'::jsonb),

('cd85271f-d89b-57e5-9492-d8ed6da95829', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e7f1a2b3-c4d5-4e11-8f5a-b7c8d9e0f1a2', 'mcq',
 'df.iloc[] Position-Based Indexing',
 'Which DataFrame function is used for position-based indexing?',
 747,
 '["df.loc[]","df.iloc[]","df.index()","df.access()"]'::jsonb,
 1, 2, 'easy',
 '["iloc[] is used for integer-position based indexing."]'::jsonb);

INSERT INTO public.challenges (id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, initial_code, language_id, star_value, difficulty, hints, solution) VALUES
('1c95227a-410e-52a2-9f8b-317844712553', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e7f1a2b3-c4d5-4e11-8f5a-b7c8d9e0f1a2', 'coding',
 'Create Pandas Series and Print First Element',
 E'Complete the code to create a Pandas Series and print the first element.\n\nBlanks:\n1. _____ (function name)\n2. _____ (index)',
 122,
 E'import pandas as pd\ndata = [10,20,30,40]\ns = pd._____(data)\nprint(s[_____])',
 71, 4, 'medium',
 '["Use pd.Series() to create a Series","Array indexing starts from 0"]',
 E'import pandas as pd\ndata = [10,20,30,40]\ns = pd.Series(data)\nprint(s[0])');

-- UNIT 2 LECTURE 1: Handling Large Volumes of Data (4 MCQs)
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('b9cbdf9c-ce94-5ad0-9d25-d51c7fe18e74','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3','mcq','Primary Challenge of Large Data',E'What is the primary challenge when dealing with large volumes of data in data science?',57,'["Lack of programming languages","Difficulty in visualizing data","Limited memory and computational resources","Lack of internet connectivity"]'::jsonb,2,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('20208e52-ab57-5801-81a7-d05efd254442','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3','mcq','RAM Overflow and Memory Swapping',E'What happens when the computer tries to load more data into RAM than its capacity?',144,'["The computer deletes the data","The operating system swaps data from RAM to disk","The CPU stops functioning","The algorithm automatically compresses the data"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('15e75991-e873-5d3d-82eb-e39ad582f1d1','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3','mcq','System Bottleneck Behavior',E'In a bottleneck situation, what typically happens in a computing system?',229,'["All components work equally fast","Some components remain idle while one component slows the process","The algorithm stops immediately","The RAM increases automatically"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('21ef3e2e-7670-5046-9fe7-bcc8d9a241d1','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3','mcq','Hard Drive vs RAM Speed',E'Why is reading data directly from a hard drive slower compared to RAM?',304,'["Hard drives store less data","Hard drives have slower data access speeds than RAM","RAM is used only for graphics","Hard drives cannot store large files"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);

-- UNIT 2 LECTURE 2: General Techniques for Large Data (6 MCQs)
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('5a2b9551-2360-5d12-b7f7-0409e02a5509','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','a9b3c4d5-e6f7-4a13-8b7c-d9e0f1a2b3c4','mcq','General Techniques Overview',E'Which of the following is NOT mentioned as a general technique for handling large volumes of data?',55,'["Choosing the right algorithm","Choosing the right data structure","Choosing the right tool","Increasing internet bandwidth"]'::jsonb,3,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('d00d8676-d346-5961-a8bc-b02653b9a952','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','a9b3c4d5-e6f7-4a13-8b7c-d9e0f1a2b3c4','mcq','Mini-Batch Learning',E'In online learning algorithms, what does mini-batch learning mean?',144,'["Feeding the entire dataset at once","Feeding the algorithm with small portions of data based on hardware capacity","Feeding the algorithm with one observation per year","Storing all data permanently in memory"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('916ecc70-bacd-59f6-9808-8ab9ca163e74','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','a9b3c4d5-e6f7-4a13-8b7c-d9e0f1a2b3c4','mcq','MapReduce Shuffle Phase',E'In the MapReduce model, which phase groups similar keys together before aggregation?',232,'["Map phase","Shuffle and sort phase","Reduce phase","Storage phase"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('4476d2c5-5deb-5b99-b571-98d2d76ea3f9','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','a9b3c4d5-e6f7-4a13-8b7c-d9e0f1a2b3c4','mcq','Hash Tables for Fast Retrieval',E'Which data structure allows fast data retrieval using key-value pairs?',318,'["Tree","Hash function (hash table)","Sparse matrix","Linked list"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('28434eab-e88c-528a-868a-b9ecee09aa17','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','a9b3c4d5-e6f7-4a13-8b7c-d9e0f1a2b3c4','mcq','Sparse Matrix Definition',E'What is a sparse matrix?',398,'["A matrix with equal numbers of zeros and ones","A matrix with mostly zero values and few non-zero elements","A matrix containing only floating point values","A matrix used only in machine learning"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('baf4f8c8-89c5-5352-ac42-2af41c8a9989','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','a9b3c4d5-e6f7-4a13-8b7c-d9e0f1a2b3c4','mcq','Role of Numba in Python',E'What is the role of Numba in Python?',517,'["It compresses large datasets","It converts Python code to machine code during runtime (Just-In-Time compilation)","It visualizes data using graphs","It stores data in a database"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);

-- UNIT 2 LECTURE 3: General Tips for Large Data (3 MCQs)
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('32f65b8c-ec2d-524e-9d75-16269df044f2','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','b0c4d5e6-f7a8-4b14-9c8d-e0f1a2b3c4d5','mcq','Do Not Reinvent the Wheel',E'What does the phrase "Do not reinvent the wheel" mean in data science?',59,'["Build all tools from scratch","Use existing tools and libraries developed by others","Avoid using programming languages","Only use manual calculations"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('4b5c4729-ebde-5542-8270-aff9a0b3e1d5','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','b0c4d5e6-f7a8-4b14-9c8d-e0f1a2b3c4d5','mcq','Efficient Hardware Usage with Parallelism',E'How can hardware be used efficiently when handling large datasets?',103,'["Run tasks sequentially and wait for each step to finish","Run different processes in parallel whenever possible","Always store data on disk before processing","Turn off the CPU during execution"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('995e0ad0-e44b-59d1-a99a-dd147597cc32','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','b0c4d5e6-f7a8-4b14-9c8d-e0f1a2b3c4d5','mcq','Reducing Computing Needs',E'Why is reducing computing needs important when working with large data?',146,'["It increases memory consumption","It reduces system performance","It allows large datasets to be processed efficiently using fewer resources","It eliminates the need for algorithms"]'::jsonb,2,2,'easy','["Refer to the lecture concepts."]'::jsonb);

-- UNIT 2 LECTURE 4: Data Wrangling (8 MCQs)
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('d95da584-dd5d-5116-ba4e-4396f482df9a','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6','mcq','Data Wrangling Definition',E'What is Data Wrangling?',55,'["Storing raw data without modification","Transforming raw data into a usable format for analysis","Deleting unnecessary data permanently","Visualizing data using graphs"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('a9b36dc8-eaa0-56c4-b118-9e9b367d020b','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6','mcq','Data Wrangling Real-World Applications',E'Which of the following is a real-world application of data wrangling mentioned in the lecture?',143,'["Video editing","Fraud detection and customer behavior analysis","Game development","Hardware manufacturing"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('cbfa0268-6f7b-597a-8ee7-b498cc94c013','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6','mcq','Data Discovery Step Objective',E'What is the main objective of the Data Discovery step in data wrangling?',260,'["Remove duplicate data","Understand the structure and content of the dataset","Publish the dataset","Normalize the dataset"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('9809b147-5437-57f0-9774-1d3fd86507b4','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6','mcq','Data Organization Stage',E'What happens during the Data Organization stage?',336,'["Data is deleted","Data is visualized using charts","Data is restructured into a suitable format for analysis","Data is encrypted"]'::jsonb,2,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('18203bb4-ff4a-5e1d-8bb5-8b5b81eb102c','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6','mcq','Data Cleaning Operations',E'Which operation is commonly used in the Data Cleaning step?',413,'["Creating dashboards","Removing duplicates and handling missing values","Writing SQL queries","Publishing reports"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('70e54d1e-d142-5d97-b355-9e9ec3f17f3c','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6','mcq','Data Enrichment Purpose',E'What is the purpose of Data Enrichment?',495,'["Delete old data","Add additional information to improve data quality and completeness","Encrypt the dataset","Reduce dataset size"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('1e558a3b-17e2-55f7-8047-ea4a5648b47d','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6','mcq','Data Validation Stage',E'What is checked during the Data Validation stage?',533,'["Internet speed","Data accuracy and consistency","Hardware performance","Programming syntax"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('12ae69ea-1781-51b8-b57f-7b20e19c5f05','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6','mcq','Final Stage of Data Wrangling',E'What is the final stage of the Data Wrangling process?',613,'["Data Cleaning","Data Discovery","Data Publishing","Data Transformation"]'::jsonb,2,2,'easy','["Refer to the lecture concepts."]'::jsonb);

-- UNIT 2 LECTURE 5: Combining and Merging Data (8 MCQs)
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('cc6057ad-38c7-542e-a1ae-0a535b57d75d','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','d2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7','mcq','Data Wrangling Steps Order',E'Which of the following is the correct order of operations mentioned in the data wrangling process?',58,'["Merge -> Transform -> Clean -> Reshape","Clean -> Transform -> Merge -> Reshape","Transform -> Clean -> Publish -> Merge","Merge -> Clean -> Transform -> Analyze"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('e49bc167-05d3-5de4-8f5b-46e6ee9cc6ba','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','d2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7','mcq','pd.merge() Function',E'Which pandas function is commonly used to merge two dataframes based on a key?',144,'["pd.reshape()","pd.merge()","pd.drop()","pd.sort()"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('81113c01-e2ef-5a2f-a613-3679e2e0776f','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','d2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7','mcq','INNER JOIN Result',E'What does an INNER JOIN return when merging two datasets?',319,'["All records from both datasets","Only the records that are common in both datasets","Only records from the first dataset","Only records from the second dataset"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('1a742383-0567-5a58-9867-e8a052874811','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','d2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7','mcq','OUTER JOIN Result',E'What does an OUTER JOIN return when merging datasets?',359,'["Only matching records","Only records from the first dataframe","All records from both datasets, filling missing values with None/NaN","Only records from the second dataframe"]'::jsonb,2,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('067a9cdd-7764-5f03-93dd-f1b54b94692f','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','d2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7','mcq','LEFT JOIN Behavior',E'What happens in a LEFT JOIN?',443,'["Only records from the second dataframe are kept","All records from the first dataframe are kept, matching records from the second dataframe are added","Only common records are returned","Both datasets are ignored"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('1fe94244-d9b8-5299-b041-8d66dc467754','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','d2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7','mcq','RIGHT JOIN Priority',E'In a RIGHT JOIN, priority is given to which dataset?',529,'["First dataframe","Second dataframe","Both dataframes equally","Neither dataframe"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('23786ea0-337a-5826-8e0c-e888f82697be','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','d2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7','mcq','Merge Without Column Key',E'When merging two datasets without specifying a column, pandas merges based on:',691,'["Random columns","Common column names","File size","Data type"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('be2a13b7-5cc0-5ca6-a277-0becd2a2fca0','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','d2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7','mcq','Concatenation in Data Processing',E'What does concatenation do in data processing?',997,'["Deletes duplicate data","Joins datasets together along rows or columns","Converts data into JSON format","Sorts data alphabetically"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);

-- UNIT 2 LECTURE 6: Reshaping and Pivoting (3 Coding Questions)
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,initial_code,language_id,star_value,difficulty,hints,solution) VALUES ('005845e3-ec10-5369-a0cb-fef816519eaa','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','e3f7a8b9-c0d1-4e17-8fba-b3c4d5e6f7a8','coding','Stack Operation',E'Fill the blanks to convert columns into rows using stack. Blanks: 1) import keyword, 2) DataFrame, 3) stack, 4) print variable.',120,E'_____ pandas as pd\ndata = {"Math":[90,85],"Science":[88,92]}\ndf = pd._____(data)\nstacked = df._____\nprint(_____)',71,4,'medium','["Refer to the lecture concepts."]'::jsonb,E'import pandas as pd\ndata = {"Math":[90,85],"Science":[88,92]}\ndf = pd.DataFrame(data)\nstacked = df.stack()\nprint(stacked)');
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,initial_code,language_id,star_value,difficulty,hints,solution) VALUES ('cf708eef-0ad9-569e-857a-939bc484002c','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','e3f7a8b9-c0d1-4e17-8fba-b3c4d5e6f7a8','coding','Unstack Operation',E'Fill the blanks to convert rows back to columns using unstack. Blanks: 1) import keyword, 2) DataFrame, 3) unstack, 4) print variable.',318,E'_____ pandas as pd\ndata = {"Math":[90,85],"Science":[88,92]}\ndf = pd._____(data)\nstacked = df.stack()\nunstacked = stacked._____\nprint(_____)',71,4,'medium','["Refer to the lecture concepts."]'::jsonb,E'import pandas as pd\ndata = {"Math":[90,85],"Science":[88,92]}\ndf = pd.DataFrame(data)\nstacked = df.stack()\nunstacked = stacked.unstack()\nprint(unstacked)');
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,initial_code,language_id,star_value,difficulty,hints,solution) VALUES ('71277a8e-2997-5634-98a7-88da1cbed1f6','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','e3f7a8b9-c0d1-4e17-8fba-b3c4d5e6f7a8','coding','Reshape NumPy Array 2x3',E'Complete the code to reshape a NumPy array into 2 rows and 3 columns. Blanks: 1) import, 2) arange arg, 3) reshape, 4) print variable.',432,E'_____ numpy as np\narr = np._____(6)\nreshaped = arr._____(2,3)\nprint(_____)',71,4,'medium','["Refer to the lecture concepts."]'::jsonb,E'import numpy as np\narr = np.arange(6)\nreshaped = arr.reshape(2,3)\nprint(reshaped)');

-- UNIT 2 LECTURE 7: Handling Missing Values (6 MCQs + 1 Coding)
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('ad18ed29-b33d-5eb5-8882-a8341fe8ccda','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9','mcq','fillna() to Replace Missing Values',E'Which pandas function is used to replace missing values with the mean of the column?',61,'["dropna()","fillna()","merge()","concat()"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('d9556641-8ff0-5794-bbf5-a466d11f2e34','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9','mcq','Listwise Deletion Definition',E'What is Listwise Deletion?',107,'["Replacing missing values with averages","Removing only missing values","Removing the entire row or column that contains missing values","Replacing missing values using regression"]'::jsonb,2,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('98a87903-da8d-56d6-9fe3-fb7d79d19d8c','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9','mcq','Pairwise vs Listwise Deletion',E'Why is Pairwise Deletion sometimes preferred over Listwise Deletion?',147,'["It removes all data completely","It keeps more useful data for calculations","It converts missing values to zero","It duplicates rows"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('73ddc2b1-dcba-5b1b-bf6d-98d010ac6288','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9','mcq','Data Imputation Definition',E'What is Data Imputation?',276,'["Removing duplicate rows","Replacing missing values with estimated values","Sorting datasets","Encrypting datasets"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('453b0891-16ac-52a3-bd3c-b7544150602a','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9','mcq','Regression Imputation Method',E'Which method predicts missing values using regression models?',321,'["Pairwise deletion","Regression imputation","Multiple deletion","Random sampling"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('0efbd276-d564-5918-acad-211336165d02','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9','mcq','fit_transform() in Imputation',E'What does the fit_transform() function do in imputation?',522,'["Deletes missing values","Calculates statistics and replaces missing values","Converts data types","Sorts the dataset"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,initial_code,language_id,star_value,difficulty,hints,solution) VALUES ('3330ff2b-4ad9-55ce-a564-9800cfdb1836','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9','coding','SimpleImputer for Missing Values',E'Complete the code to replace missing values using sklearn SimpleImputer. Blanks: 1) import pandas, 2) sklearn submodule, 3) strategy, 4) method.',522,E'_____ pandas as pd\nfrom sklearn._____ import SimpleImputer\ndata = pd.DataFrame({"blood_pressure":[120,115,None,130]})\nimputer = SimpleImputer(strategy="_____")\ndata["blood_pressure"] = imputer._____(data[["blood_pressure"]])\nprint(data)',71,4,'medium','["Refer to the lecture concepts."]'::jsonb,E'import pandas as pd\nfrom sklearn.impute import SimpleImputer\ndata = pd.DataFrame({"blood_pressure":[120,115,None,130]})\nimputer = SimpleImputer(strategy="mean")\ndata["blood_pressure"] = imputer.fit_transform(data[["blood_pressure"]])\nprint(data)');

-- UNIT 2 LECTURE 8: Data Cleaning and Preparation (6 MCQs + 1 Coding)
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('0a4a7094-cc46-5357-a982-4c9e7e34c458','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0','mcq','Data Cleaning Steps NOT Included',E'Which of the following is NOT a step in data cleaning mentioned in the lecture?',58,'["Standardizing capitalization","Removing duplicates","Detecting outliers","Training machine learning models"]'::jsonb,3,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('dee4e279-7c0b-56b9-89b2-7ff650af0e14','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0','mcq','Data Discretization Purpose',E'What is the purpose of data discretization?',147,'["Convert data into numerical format","Divide continuous data into categories or bins","Remove duplicate records","Normalize the dataset"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('4c92d6f6-1715-54a7-a569-475f886545dd','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0','mcq','Standardizing Capitalization Importance',E'Why is standardizing capitalization important in data cleaning?',272,'["To improve hardware performance","To ensure the program treats similar text values as the same entity","To reduce dataset size","To remove duplicate rows automatically"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('169a0424-dd49-58af-932e-0f17dd1ed14e','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0','mcq','IQR for Outlier Detection',E'Which statistical method is used in the lecture to detect outliers?',353,'["Linear regression","Interquartile Range (IQR)","K-Means clustering","Logistic regression"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('f855682c-53ad-51d4-acef-702d1cb43137','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0','mcq','fillna() for Missing Values',E'Which pandas function is used to handle missing values by replacing them with a mean value?',393,'["drop()","fillna()","replace()","merge()"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('37acc7a6-dcb9-5598-9171-5fba58a5f16c','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0','mcq','df.drop_duplicates() Function',E'What does df.drop_duplicates() do?',578,'["Removes rows with missing values","Converts data types","Removes duplicate rows from a dataset","Normalizes the dataset"]'::jsonb,2,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,initial_code,language_id,star_value,difficulty,hints,solution) VALUES ('bb99b63e-b8b7-50bb-93dc-addaaf30c818','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0','coding','Handle Missing Values with fillna',E'Complete the code to handle missing values using pandas fillna. Blanks: 1) import pandas, 2) DataFrame, 3) fillna, 4) print variable.',393,E'_____ pandas as pd\ndata = {"salary":[50000,60000,None,55000,None]}\ndf = pd._____(data)\ndf["salary"] = df["salary"]._____(df["salary"].mean())\nprint(_____)',71,4,'medium','["Refer to the lecture concepts."]'::jsonb,E'import pandas as pd\ndata = {"salary":[50000,60000,None,55000,None]}\ndf = pd.DataFrame(data)\ndf["salary"] = df["salary"].fillna(df["salary"].mean())\nprint(df)');

-- UNIT 2 LECTURE 9: Data Transformation (6 MCQs + 1 Coding)
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('d912c437-cc74-544f-ad1e-56132bee37be','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1','mcq','Data Transformation Main Purpose',E'What is the main purpose of data transformation?',58,'["Delete datasets permanently","Convert and structure data into a useful format for analysis","Only visualize the data","Compress the data into ZIP files"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('ceabf080-3d0b-59da-b8f1-a686508ed7f0','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1','mcq','First Step in Data Transformation',E'Which of the following is the first step in the data transformation process?',136,'["Data aggregation","Data smoothing","Data discretization","Data normalization"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('a34a794a-67ed-50c2-87da-2380429dd44b','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1','mcq','Attribute Construction Definition',E'What is Attribute Construction?',268,'["Deleting unnecessary columns","Creating new attributes from existing data","Sorting data alphabetically","Converting strings into integers"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('59ffbc32-5ef2-5b8a-a0a8-e1e01b3f152e','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1','mcq','Data Generalization Purpose',E'What does data generalization do?',341,'["Deletes detailed data","Converts detailed values into broader categories","Encrypts data","Visualizes data in graphs"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('89a2e865-d254-5d8b-9cdf-ec29d58cd6cc','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1','mcq','groupby() for Data Aggregation',E'Which pandas function is used in the lecture to group data and compute aggregated results?',495,'["merge()","groupby()","reshape()","append()"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('e2b493b3-a5b9-54ef-9b7f-3ec8781edd7a','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1','mcq','Data Discretization in Transformation',E'What is the purpose of data discretization?',614,'["Convert categorical data into numbers","Convert continuous values into intervals or bins","Delete missing values","Compress large datasets"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,initial_code,language_id,star_value,difficulty,hints,solution) VALUES ('0ecfd723-709d-5f0e-ae9d-9db08e4db615','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1','coding','Group Sales by Region with groupby',E'Complete the code to group sales by region and compute total sales. Blanks: 1) import pandas, 2) DataFrame, 3) groupby arg, 4) aggregation function.',495,E'_____ pandas as pd\ndata = {"region":["North","South","North","East"],"sales":[200,150,300,250]}\ndf = pd._____(data)\nresult = df._____("region")["sales"]._____()\nprint(result)',71,4,'medium','["Refer to the lecture concepts."]'::jsonb,E'import pandas as pd\ndata = {"region":["North","South","North","East"],"sales":[200,150,300,250]}\ndf = pd.DataFrame(data)\nresult = df.groupby("region")["sales"].sum()\nprint(result)');

-- UNIT 2 LECTURE 10: String Manipulation (6 MCQs + 1 Coding)
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('0e9aaea2-3775-5c7b-a138-3f9548d9ca30','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2','mcq','Python String Definition',E'In Python, what is a string?',50,'["A collection of numbers","A sequence of characters enclosed in quotes","A type of loop","A mathematical function"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('f8a289b3-6cb8-5095-9281-95afdf9b5d3d','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2','mcq','String Padding',E'What is string padding?',94,'["Removing characters from a string","Adding extra characters to the beginning or end of a string","Splitting a string into words","Searching a string"]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('8a9ebafb-106b-5880-b003-bb6b462e0bec','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2','mcq','split() Method',E'Which Python method is used to divide a string into multiple substrings?',206,'["split()","strip()","find()","join()"]'::jsonb,0,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('8ec2a3c2-d6e7-5302-a291-d8fbf406e750','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2','mcq','strip() Method',E'Which function removes unwanted characters from the beginning and end of a string?',328,'["strip()","concat()","search()","append()"]'::jsonb,0,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('9d6f53aa-7429-5349-999b-4c4bb2e4a871','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2','mcq','String Concatenation Operator',E'Which operator is used for string concatenation in Python?',412,'["*","+","/","="]'::jsonb,1,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,options,correct_option,star_value,difficulty,hints) VALUES ('5ffcf1d3-7668-5122-898d-92652a268650','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2','mcq','find() Method for Substring Search',E'Which Python method is used to search for a substring inside a string?',450,'["split()","strip()","find()","append()"]'::jsonb,2,2,'easy','["Refer to the lecture concepts."]'::jsonb);
INSERT INTO public.challenges (id,course_id,lesson_id,challenge_type,title,description,timestamp_seconds,initial_code,language_id,star_value,difficulty,hints,solution) VALUES ('91476312-3f71-539b-acaf-73d10ad1e80e','d5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c','c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2','coding','Split Sentence into Words',E'Complete the code to split a sentence into individual words. Blanks: 1) split method, 2) print variable.',450,E'text = "Hello world how are you"\nwords = text._____()\nprint(_____)',71,4,'medium','["Refer to the lecture concepts."]'::jsonb,E'text = "Hello world how are you"\nwords = text.split()\nprint(words)');

-- ============================================================
-- END OF SCRIPT
-- Total: 121 MCQs + 14 Coding = 135 Challenges
-- ============================================================