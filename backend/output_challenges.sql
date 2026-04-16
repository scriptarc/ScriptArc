-- ============================================================
-- ScriptArc — Supabase PostgreSQL Schema
-- Auto-generated Challenges Script
-- ============================================================

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('2d630a56-30fa-5ee8-b828-e326e5ec5edc', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a7b1c2d3-e4f5-4a01-8b6c-d7e8f9a0b1c2', 'mcq', 'Which of the following best summarizes Dat...', 'Which of the following best summarizes Data Science as explained in the lecture?', 84, '["Storing structured data in databases","Gathering data, analyzing patterns, and making informed decisions or predictions","Writing code for artificial intelligence systems","Managing business transactions digitally"]'::jsonb, 1, 2, 'easy', '["The lecture defines data science as gathering data, analyzing it, finding patterns, and using it for decision-making or future prediction."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('80c28b21-150b-5fae-a47b-63e3b8c5abe8', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a7b1c2d3-e4f5-4a01-8b6c-d7e8f9a0b1c2', 'mcq', 'In the robotic manufacturing example, mach...', 'In the robotic manufacturing example, machine learning is mainly used to:', 235, '["Replace all sensors in the system","Increase robot arm size","Find the best path and improve speed and precision","Eliminate energy consumption completely"]'::jsonb, 2, 2, 'easy', '["Machine learning helps optimize robotic assembly tasks by finding the best path and improving speed and precision."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('64301f05-7a0a-5b0d-8fe2-7c47bdf20bae', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a7b1c2d3-e4f5-4a01-8b6c-d7e8f9a0b1c2', 'mcq', 'Which of the following is the correct orde...', 'Which of the following is the correct order in the Data Science lifecycle?', 368, '["Data Modeling → Data Collection → Deployment → Cleaning","Problem Statement → Data Collection → Data Cleaning → Analysis → Modeling → Deployment","Data Cleaning → Problem Statement → Modeling → Deployment","Data Collection → Modeling → Cleaning → Deployment"]'::jsonb, 1, 2, 'easy', '["The lecture clearly explains the 6 steps in this sequence: Problem → Collection → Cleaning → Analysis → Modeling → Optimization & Deployment."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('c3f8fd84-00d5-5fe4-a601-f213329ce67a', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a7b1c2d3-e4f5-4a01-8b6c-d7e8f9a0b1c2', 'mcq', 'Why is Big Data compared to crude oil in t...', 'Why is Big Data compared to crude oil in the lecture?', 718, '["Because it is expensive","Because it needs refining to extract useful insights","Because it is only used in industries","Because it replaces data science"]'::jsonb, 1, 2, 'easy', '["Big Data represents raw data (like crude oil). Data Science extracts meaningful information (like refined petroleum products)."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('e2a84689-9dbd-5e6d-ba0f-2981ffb5da1d', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b8c2d3e4-f5a6-4b02-9c7d-e8f9a0b1c2d3', 'mcq', 'Which statement correctly differentiates s...', 'Which statement correctly differentiates structured and unstructured data?', 94, '["Structured data has no format, while unstructured data follows rows and columns","Structured data is organized in rows and columns, while unstructured data does not follow a predefined format","Both structured and unstructured data follow strict DBMS rules","Unstructured data is easier to retrieve than structured data"]'::jsonb, 1, 2, 'easy', '["Structured data is organized (like Excel or DBMS tables). Unstructured data does not follow rows/columns and is harder to retrieve."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('0bf288c1-5f9f-5ca1-be12-83d61c9d3fe8', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b8c2d3e4-f5a6-4b02-9c7d-e8f9a0b1c2d3', 'mcq', 'Which of the following is a key process in...', 'Which of the following is a key process in Natural Language Processing (NLP)?', 247, '["Data normalization in SQL","Entity recognition and sentiment analysis","Sensor calibration","Row-column indexing"]'::jsonb, 1, 2, 'easy', '["NLP involves tasks such as entity recognition, summarization, text completion, and sentiment analysis."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('de333c79-b732-51cb-a525-656817854bd8', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b8c2d3e4-f5a6-4b02-9c7d-e8f9a0b1c2d3', 'mcq', 'Which of the following is an example of ma...', 'Which of the following is an example of machine-generated data?', 301, '["Manually typed Excel sheet","Web server logs and sensor data","Printed newspaper article","Handwritten survey responses"]'::jsonb, 1, 2, 'easy', '["Machine-generated data is automatically created by systems without human intervention, such as server logs, call detail records, and sensor data."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('87e4fbca-f2bf-53db-95ec-e0a9b90959a3', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b8c2d3e4-f5a6-4b02-9c7d-e8f9a0b1c2d3', 'mcq', 'In graph-based data, what do nodes and edg...', 'In graph-based data, what do nodes and edges represent?', 380, '["Rows and columns","Characters and words","Objects and relationships between them","Images and pixels"]'::jsonb, 2, 2, 'easy', '["Graph-based data represents objects as nodes and relationships/interactions between them as edges (e.g., social networks)."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('88ea2722-25de-5c00-9ec7-27c1665c7fe0', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b8c2d3e4-f5a6-4b02-9c7d-e8f9a0b1c2d3', 'mcq', 'Why do audio, video, and image data pose c...', 'Why do audio, video, and image data pose challenges to data scientists?', 490, '["They cannot be stored digitally","They are easy only for machines to interpret","Machines require advanced techniques to interpret visual and audio content","They follow strict row-column formats"]'::jsonb, 2, 2, 'easy', '["Humans can easily interpret images and audio, but machines require specialized data science techniques for object recognition and analysis."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('36b7f694-46b6-5f7a-9414-9ea3c3cce412', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b8c2d3e4-f5a6-4b02-9c7d-e8f9a0b1c2d3', 'mcq', 'What is a key characteristic of streaming ...', 'What is a key characteristic of streaming data?', 581, '["It is stored permanently before processing","It is generated continuously and processed in real-time","It exists only in structured databases","It cannot be analyzed"]'::jsonb, 1, 2, 'easy', '["Streaming data is generated continuously (e.g., stock markets, Twitter feeds) and requires real-time analysis."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('98fda4e5-d540-5c36-b0be-c670877e1a45', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c9d3e4f5-a6b7-4c03-8d8e-f9a0b1c2d3e4', 'mcq', 'What is the primary purpose of setting the...', 'What is the primary purpose of setting the research goal in a data science project?', 74, '["To start building machine learning models immediately","To define objectives, required resources, timeline, and expected outcomes","To clean and transform data","To visualize data patterns"]'::jsonb, 1, 2, 'easy', '["The first step involves preparing a project charter including objectives, benefits to the company, required inputs, resources, schedule, and outcomes."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('c8740e2d-7096-5a21-bbfe-d583f1a0cba9', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c9d3e4f5-a6b7-4c03-8d8e-f9a0b1c2d3e4', 'mcq', 'What is the key difference between a Data ...', 'What is the key difference between a Data Warehouse and a Data Lake?', 212, '["Data warehouse stores raw data, while data lake stores processed data","Data lake stores only structured data","Data warehouse stores processed and organized data, while data lake stores raw and unstructured data","Both store only Excel sheets"]'::jsonb, 2, 2, 'easy', '["In a data warehouse, data is cleaned and organized before storage. In a data lake, raw and unstructured data is stored and processed later when needed."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('e79ebf5e-4ea3-57c1-993b-410baa389d69', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c9d3e4f5-a6b7-4c03-8d8e-f9a0b1c2d3e4', 'mcq', 'Which of the following activities belongs ...', 'Which of the following activities belongs to Data Preparation?', 311, '["Presenting results to stakeholders","Removing missing values, combining datasets, and transforming variables","Deploying automation tools","Running model diagnostics"]'::jsonb, 1, 2, 'easy', '["Data preparation includes data cleaning (removing errors, outliers), combining datasets, and transforming data into a suitable format."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('8b064d5e-674c-505a-b7bd-306c5d68fdd7', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c9d3e4f5-a6b7-4c03-8d8e-f9a0b1c2d3e4', 'mcq', 'What is the main goal of Exploratory Data ...', 'What is the main goal of Exploratory Data Analysis (EDA)?', 381, '["To deploy the final model","To build machine learning algorithms","To understand data distribution, relationships, and detect outliers","To automate business processes"]'::jsonb, 2, 2, 'easy', '["EDA helps build deeper understanding of data using descriptive statistics, visualization, and identifying relationships or anomalies."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('3da063a6-5e7a-54f8-b06a-e61fdccce02a', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c9d3e4f5-a6b7-4c03-8d8e-f9a0b1c2d3e4', 'mcq', 'If an R² value is extremely high, what pot...', 'If an R² value is extremely high, what potential issue should be checked?', 535, '["Underfitting","Data cleaning error","Overfitting","Missing value error"]'::jsonb, 2, 2, 'easy', '["A very high R² value may indicate overfitting, meaning the model fits training data too closely and may not generalize well."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('87e91ae9-153e-5747-93dc-0c1c03ea27a3', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c9d3e4f5-a6b7-4c03-8d8e-f9a0b1c2d3e4', 'mcq', 'Why is automation important in the final s...', 'Why is automation important in the final stage of the data science process?', 575, '["To reduce the need for research goals","To avoid using models in real-time","To reuse and apply insights efficiently across business operations","To delete historical data"]'::jsonb, 2, 2, 'easy', '["Automation allows businesses to repeatedly apply insights from one project to other operations, improving efficiency and scalability."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('6d9ba142-8f18-52e0-ae44-c03e3eab172b', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd0e4f5a6-b7c8-4d04-9e9f-a0b1c2d3e4f5', 'mcq', 'Which of the following correctly describes...', 'Which of the following correctly describes NumPy?', 57, '["A database management system","A numerical Python library for array processing and scientific computing","A web development framework","A visualization tool only"]'::jsonb, 1, 2, 'easy', '["NumPy (Numerical Python) is an open-source library designed for array processing and scientific computing, including linear algebra and Fourier transforms."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('2d8b0dbe-e613-59f3-bf5d-0a69849a59aa', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd0e4f5a6-b7c8-4d04-9e9f-a0b1c2d3e4f5', 'mcq', 'Why are NumPy arrays preferred over Python...', 'Why are NumPy arrays preferred over Python lists in data science?', 164, '["They consume more memory","They are slower but easier to write","They are significantly faster and optimized for numerical computation","They cannot handle multi-dimensional data"]'::jsonb, 2, 2, 'easy', '["NumPy arrays are optimized for performance and can be up to 50× faster than Python lists, making them suitable for large-scale numerical computation."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('8eef6145-97d2-5b6e-a0a2-7119b7cc99d9', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd0e4f5a6-b7c8-4d04-9e9f-a0b1c2d3e4f5', 'mcq', 'Which command is used to install NumPy usi...', 'Which command is used to install NumPy using Python’s package manager?', 209, '["install numpy","python get numpy","pip install numpy","import numpy install"]'::jsonb, 2, 2, 'easy', '["NumPy is installed using pip (Python Package Manager) with the command: pip install numpy."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('b5159424-b8cd-574a-8719-3814cea93ccf', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd0e4f5a6-b7c8-4d04-9e9f-a0b1c2d3e4f5', 'mcq', 'Which of the following is NOT a capability...', 'Which of the following is NOT a capability of NumPy mentioned in the lecture?', 235, '["Linear algebra operations","Random number generation","Web server hosting","Fourier transform"]'::jsonb, 2, 2, 'easy', '["NumPy supports linear algebra, Fourier transforms, random number generation, and array reshaping — but not web server hosting."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('61054621-242a-52da-b09a-683800c38a05', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd0e4f5a6-b7c8-4d04-9e9f-a0b1c2d3e4f5', 'mcq', 'NumPy is widely used in which of the follo...', 'NumPy is widely used in which of the following fields?', 254, '["Machine Learning and Scientific Computing","Social Media Marketing","Video Editing Software","Hardware Manufacturing"]'::jsonb, 0, 2, 'easy', '["NumPy is fundamental in machine learning, data science, image processing, signal processing, and scientific computing."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('d5fd5541-deee-5b1c-b20a-e8f39fb7395d', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e1f5a6b7-c8d9-4e05-8faf-b1c2d3e4f5a6', 'mcq', 'Which statement about a NumPy array is cor...', 'Which statement about a NumPy array is correct?', 52, '["It starts indexing from 1","It is an unordered collection of elements","It is an ordered collection of elements with zero-based indexing","It cannot store numerical data"]'::jsonb, 2, 2, 'easy', '["A NumPy array is an ordered collection of data elements and follows zero-based indexing similar to Python lists."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('a201d91e-05d2-5b0a-b1ca-ea313480538f', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e1f5a6b7-c8d9-4e05-8faf-b1c2d3e4f5a6', 'mcq', 'What is the difference between np.arange()...', 'What is the difference between np.arange() and np.array()?', 228, '["np.arange() creates arrays from an existing list, while np.array() generates ranges","np.arange() generates sequential values, while np.array() creates arrays from provided data","Both perform exactly the same function","np.array() only creates 1D arrays"]'::jsonb, 1, 2, 'easy', '["np.arange() generates a sequence of numbers (e.g., 0–19), while np.array() creates arrays from explicitly provided values."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('f5b9e9e5-24ff-5999-8f44-e5c5ab0e87be', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e1f5a6b7-c8d9-4e05-8faf-b1c2d3e4f5a6', 'mcq', 'Which NumPy attribute returns the number o...', 'Which NumPy attribute returns the number of dimensions of an array?', 294, '["size","shape","ndim","dtype"]'::jsonb, 2, 2, 'easy', '["ndim returns the number of dimensions (1D, 2D, 3D, etc.) of the array."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('0cc8b930-7571-5b0d-8f41-6ac334e83a4f', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'e1f5a6b7-c8d9-4e05-8faf-b1c2d3e4f5a6', 'mcq', 'If an array is defined with data type int3...', 'If an array is defined with data type int32, what will be its item size?', 410, '["2 bytes","4 bytes","8 bytes","16 bytes"]'::jsonb, 1, 2, 'easy', '["int32 occupies 4 bytes per element, while default int64 typically occupies 8 bytes."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('ef1a60d8-01b5-54a1-b6af-51458e5f1b05', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7', 'mcq', 'Which NumPy attribute is used to find the ...', 'Which NumPy attribute is used to find the number of dimensions of an array?', 3, '["size","shape","ndim","dtype"]'::jsonb, 2, 2, 'easy', '["ndim returns the number of dimensions of a NumPy array."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('40a70704-6e49-5df2-a89a-4899585e3beb', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7', 'mcq', 'Which attribute returns the total number o...', 'Which attribute returns the total number of elements in a NumPy array?', 40, '["shape","size","dtype","ndim"]'::jsonb, 1, 2, 'easy', '["size gives the total number of elements present in the array."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('6340e581-173d-543a-80ba-d8a22a5121ef', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7', 'mcq', 'What does the shape attribute return in a ...', 'What does the shape attribute return in a NumPy array?', 60, '["Total elements","Number of dimensions","Structure of rows and columns","Data type of elements"]'::jsonb, 2, 2, 'easy', '["shape returns the dimensions of the array (rows, columns, etc.)."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('bd42e858-8ad5-5296-ba08-76c1d89e0941', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7', 'mcq', 'What is the default integer data type retu...', 'What is the default integer data type returned by NumPy when dtype is not specified?', 75, '["int32","int16","int64","float64"]'::jsonb, 2, 2, 'easy', '["If dtype is not specified, NumPy usually uses int64 by default."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('da7e5b10-24ae-5fbe-9d2a-a30a14531e2f', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7', 'mcq', 'What does the itemsize attribute represent...', 'What does the itemsize attribute represent in a NumPy array?', 96, '["Total memory of the array","Size of each element in bytes","Number of elements in array","Number of rows"]'::jsonb, 1, 2, 'easy', '["itemsize returns the memory size of each element in bytes."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('28c485cb-9c48-57e6-b1e2-dab2dadfa9dd', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f2a6b7c8-d9e0-4f06-9a0b-c2d3e4f5a6b7', 'mcq', 'If an array uses int64, what will be the s...', 'If an array uses int64, what will be the size of each element?', 96, '["2 bytes","4 bytes","8 bytes","16 bytes"]'::jsonb, 2, 2, 'easy', '["int64 → 64 bits = 8 bytes"]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('d53578f1-fbb2-58a4-a07e-cef760bcd668', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'mcq', 'Which NumPy function is used to join two a...', 'Which NumPy function is used to join two arrays along a specified axis?', 56, '["np.join()","np.concatenate()","np.append()","np.combine()"]'::jsonb, 1, 2, 'easy', '["np.concatenate() joins arrays along a specified axis."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('9491fec8-3bc4-51f4-8cf6-8d68ab251984', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'mcq', 'What happens when axis = 0 is used in np.c...', 'What happens when axis = 0 is used in np.concatenate()?', 104, '["Horizontal stacking","Vertical stacking","Diagonal stacking","Array splitting"]'::jsonb, 1, 2, 'easy', '["axis = 0 joins arrays vertically (row-wise)."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('b7b95657-82bd-5fb8-809b-440260fed764', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'mcq', 'Which NumPy function is specifically used ...', 'Which NumPy function is specifically used for horizontal stacking of arrays?', 149, '["np.vstack()","np.concatenate()","np.hstack()","np.split()"]'::jsonb, 2, 2, 'easy', '["np.hstack() joins arrays horizontally (column-wise)."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('1d471511-95bc-5abf-9d9f-73e0d30e8e67', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'mcq', 'What is the limitation of the np.split() f...', 'What is the limitation of the np.split() function?', 227, '["It works only on 2D arrays","It can split arrays only into equal parts","It cannot split arrays","It only works on strings"]'::jsonb, 1, 2, 'easy', '["np.split() can divide arrays only into equal-sized subarrays."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('22ad5c06-6cb7-5436-9c30-7aea486e5c7a', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'mcq', 'Which NumPy function allows splitting arra...', 'Which NumPy function allows splitting arrays even if they cannot be divided equally?', 314, '["np.divide()","np.array_split()","np.break()","np.cut()"]'::jsonb, 1, 2, 'easy', '["np.array_split() can divide arrays even when equal division is not possible."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('7ec48c35-d6ff-58a1-ba4e-4938d3f51d7b', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'mcq', 'Which function is used to find the index o...', 'Which function is used to find the index of elements satisfying a condition in NumPy?', 490, '["np.search()","np.where()","np.find()","np.locate()"]'::jsonb, 1, 2, 'easy', '["np.where() returns the indices of elements that satisfy a condition."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('94f9107a-9dc1-5299-a81a-489689a2cd56', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a3b7c8d9-e0f1-4a07-8b1c-d3e4f5a6b7c8', 'mcq', 'What does np.sort() do by default?', 'What does np.sort() do by default?', 613, '["Sorts columns","Sorts rows","Sorts diagonally","Randomizes the array"]'::jsonb, 1, 2, 'easy', '["By default, np.sort() sorts along the last axis (row-wise for 2D arrays)."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('292bc361-480a-5f8a-9f68-f4838086c523', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq', 'What is array indexing in NumPy used for?', 'What is array indexing in NumPy used for?', 44, '["Sorting array elements","Accessing elements using their position","Deleting elements from arrays","Creating arrays"]'::jsonb, 1, 2, 'easy', '["Indexing allows us to access elements in an array using their position."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('6594f7ae-8af7-590e-a620-347d97db454a', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq', 'At what index does NumPy array indexing st...', 'At what index does NumPy array indexing start?', 75, '["-1","1","0","2"]'::jsonb, 2, 2, 'easy', '["Array indexing in Python starts from 0."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('bfa472c6-44e5-51d2-b1ae-6cfc0efb867b', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq', 'What does the negative index -1 represent ...', 'What does the negative index -1 represent in an array?', 164, '["First element","Last element","Middle element","Second element"]'::jsonb, 1, 2, 'easy', '["Negative indexing counts from the end of the array, so -1 refers to the last element."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('de7dd1d1-21ca-5678-a8a0-99babc01ffc0', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq', 'In a 2D NumPy array, what does array[1, :]...', 'In a 2D NumPy array, what does array[1, :] represent?', 239, '["First column","Second row","Second column","Entire array"]'::jsonb, 1, 2, 'easy', '["array[1, :] selects row index 1 (second row) and all columns."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('3b3eafa6-b603-56bf-b7ea-c3c4b09dab4c', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq', 'In array slicing syntax array[start:stop:s...', 'In array slicing syntax array[start:stop:step], what does the stop index represent?', 381, '["Inclusive value","Exclusive value","Always zero","Optional only for strings"]'::jsonb, 1, 2, 'easy', '["The stop index is exclusive, meaning that element is not included."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('4a222fb5-ab1a-5958-b983-b1819488cb8a', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq', 'What does the slicing expression array[3:]...', 'What does the slicing expression array[3:] return?', 530, '["Elements from index 0 to 3","Elements from index 3 to the end","Only element at index 3","Reverse array"]'::jsonb, 1, 2, 'easy', '["array[3:] returns all elements starting from index 3 to the end."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('0b718a8b-90dd-5cf3-ba62-437ad344a9ef', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq', 'Which loop is commonly used to iterate thr...', 'Which loop is commonly used to iterate through array elements?', 712, '["while loop","for loop","do-while loop","switch loop"]'::jsonb, 1, 2, 'easy', '["for x in array: is the standard method to iterate through NumPy arrays."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints, initial_code, language_id, solution)
VALUES ('917e280d-4154-5347-a116-1437eb63bc28', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'coding', 'Coding: Complete the code to print elements f...', 'Complete the code to print elements from index 2 to index 5 using slicing.', 0, '[]'::jsonb, 0, 4, 'medium', '["Review the previous lecture concepts."]'::jsonb, E'import numpy as np
arr = np.array([1,3,5,7,9,11])
result = arr[_____:_____]
print(result)
________________________________________
1️⃣ _____
2️⃣ _____
________________________________________', 71, E'import numpy as np
arr = np.array([1,3,5,7,9,11])
result = arr[2:6]
print(result)')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints,
  initial_code = EXCLUDED.initial_code,
  solution = EXCLUDED.solution;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('d6a48a34-ff4f-5c6e-b4ae-3149636f4648', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq', 'In NumPy arrays, indexing starts from whic...', 'In NumPy arrays, indexing starts from which value?', 61, '["1","-1","0","Depends on array size"]'::jsonb, 2, 2, 'easy', '["NumPy arrays follow zero-based indexing, meaning the first element has index 0."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('0efaea5e-03e2-51b1-a5ae-34fa6887b810', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq', 'Which of the following represents negative...', 'Which of the following represents negative indexing in Python arrays?', 82, '["0,1,2,3","1,2,3,4","-1,-2,-3,-4","A,B,C,D"]'::jsonb, 2, 2, 'easy', '["Negative indexing accesses elements from the end of the array, where -1 refers to the last element."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('c5b6ae48-911e-58f4-b1a6-5b7f4c4dedee', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq', 'Given the array: arr = [1,3,5,7,9] What wi...', 'Given the array: arr = [1,3,5,7,9] What will be the output of: arr[[0,2,4]]', 131, '["1,3,5","1,5,9","3,7,9","5,7,9"]'::jsonb, 1, 2, 'easy', '["Index 0,2,4 correspond to values 1,5,9."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('daeeb35f-9400-5054-b588-35cc70074026', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq', 'In the command: array[1, :] What does : re...', 'In the command: array[1, :] What does : represent?', 197, '["Select all rows","Select all columns","Skip values","Reverse array"]'::jsonb, 1, 2, 'easy', '[": selects all columns of the specified row."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('0f2dd832-ea53-5af9-8966-373398694b4c', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq', 'In 3D array indexing, the first index repr...', 'In 3D array indexing, the first index represents:', 278, '["Column","Slice","Row","Dimension size"]'::jsonb, 1, 2, 'easy', '["For 3D arrays: array[slice, row, column]"]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('e1b3649a-942b-5d06-899d-5bbe2b2b6131', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq', 'What does array slicing allow you to do?', 'What does array slicing allow you to do?', 387, '["Delete array elements","Access part of an array","Reverse arrays","Merge arrays"]'::jsonb, 1, 2, 'easy', '["Slicing extracts a subset of elements from an array."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('eb89b917-743f-534f-b44d-8cc7f80df8b1', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b4c8d9e0-f1a2-4b08-9c2d-e4f5a6b7c8d9', 'mcq', 'In Python slicing syntax: array[start : st...', 'In Python slicing syntax: array[start : stop : step] What does stop represent?', 425, '["Included index","Exclusive index","Last element always","Step size"]'::jsonb, 1, 2, 'easy', '["The stop index is exclusive, meaning that element is not included."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('187ab0b0-c08d-51d2-9a74-9b953906184b', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'What does the array.copy() method do in Nu...', 'What does the array.copy() method do in NumPy?', 54, '["Deletes the original array","Creates a reference to the same array","Creates a new independent copy of the array","Sorts the array"]'::jsonb, 2, 2, 'easy', '["copy() creates a new array independent of the original, so changes in the copy do not affect the original array."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('eed53dfd-e028-5606-8b1c-ed5a8e8a47cd', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'Which NumPy function is used to change the...', 'Which NumPy function is used to change the shape of an array without changing its data?', 127, '["reshape()","resize()","split()","concatenate()"]'::jsonb, 0, 2, 'easy', '["reshape() changes the dimensions of the array while keeping the same data."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('e6acae71-6932-562e-8d53-595eea1da40c', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'What does reshape(-1) do in NumPy?', 'What does reshape(-1) do in NumPy?', 173, '["Deletes the array","Flattens the array into one dimension","Converts array into matrix","Splits the array"]'::jsonb, 1, 2, 'easy', '["reshape(-1) converts a multi-dimensional array into a 1D array."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('7b068bc4-f11c-5c79-83c9-f64475f413fe', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'Which function creates an identity matrix ...', 'Which function creates an identity matrix in NumPy?', 210, '["np.matrix()","np.identity()","np.diagonal()","np.ones()"]'::jsonb, 1, 2, 'easy', '["np.identity() creates a square matrix with 1s on the diagonal and 0s elsewhere."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('f756bfd7-8470-507d-81fb-2ea05021003a', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'What is the default data type of values cr...', 'What is the default data type of values created using np.identity()?', 285, '["Integer","Float","Boolean","String"]'::jsonb, 1, 2, 'easy', '["If dtype is not specified, NumPy uses float values by default."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('1140ca03-8a28-5f9c-a5c7-6335d0f31487', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'What is the purpose of the k parameter in ...', 'What is the purpose of the k parameter in the np.eye() function?', 325, '["Controls array size","Sets the diagonal offset","Defines array datatype","Sorts diagonal values"]'::jsonb, 1, 2, 'easy', '["k shifts the diagonal position above or below the main diagonal."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('4468346b-0475-522d-97e5-23c140a83bea', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'What is the key difference between np.iden...', 'What is the key difference between np.identity() and np.eye()?', 452, '["np.eye() only creates square matrices","np.identity() supports rectangular matrices","np.eye() can create rectangular matrices and diagonal offsets","Both are identical"]'::jsonb, 2, 2, 'easy', '["np.eye() is more flexible, allowing rectangular matrices and diagonal offsets."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints, initial_code, language_id, solution)
VALUES ('5b92fdbc-bcd2-5027-8cbc-e3780c4c60a7', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'coding', 'Coding: Complete the code to reshape a 1D arr...', 'Complete the code to reshape a 1D array into a 3×4 matrix.', 0, '[]'::jsonb, 0, 4, 'medium', '["Review the previous lecture concepts."]'::jsonb, E'import numpy as np
arr = np.array(range(1,13))
new_arr = arr._____(_____,_____)
print(new_arr)
________________________________________
1️⃣ _____
2️⃣ _____
3️⃣ _____
________________________________________', 71, E'import numpy as np
arr = np.array(range(1,13))
new_arr = arr.reshape(3,4)
print(new_arr)')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints,
  initial_code = EXCLUDED.initial_code,
  solution = EXCLUDED.solution;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('e640cadf-9a8f-5234-a595-955ebb073e87', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'What is a Pandas Series?', 'What is a Pandas Series?', 46, '["A two-dimensional table","A one-dimensional labeled array","A matrix with rows and columns","A NumPy sorting function"]'::jsonb, 1, 2, 'easy', '["A Pandas Series is a 1-dimensional labeled array capable of holding different data types."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('63a9bc31-c057-573a-9907-8acbdb886325', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'Which of the following operations can be p...', 'Which of the following operations can be performed on both Series and DataFrames?', 83, '["Vectorized operations","Indexing","Aggregation functions","All of the above"]'::jsonb, 3, 2, 'easy', '["Both Series and DataFrames support indexing, vectorized operations, aggregation, and missing value handling."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('83a96ab3-f1ed-57fa-929c-a1a953dad0e4', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'Which command is used to create a Series f...', 'Which command is used to create a Series from a list in Pandas?', 122, '["pd.array()","pd.Series()","pd.DataFrame()","pd.list()"]'::jsonb, 1, 2, 'easy', '["pd.Series() creates a Series from lists, dictionaries, or arrays."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('71f00832-907d-50c0-9287-033f312de390', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'What must be true for vectorized operation...', 'What must be true for vectorized operations between two Series?', 246, '["Same data values","Same array size","Same datatype","Same column name"]'::jsonb, 1, 2, 'easy', '["Vectorized operations require Series of the same size for element-wise calculations."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('02c81223-823c-579c-84dd-bddbddec7c5d', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'Which Pandas function is used to check mis...', 'Which Pandas function is used to check missing values in a Series?', 372, '["checknull()","isna()","findnull()","missing()"]'::jsonb, 1, 2, 'easy', '["isna() returns True for missing values and False otherwise."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('e933ea48-e6ba-57bd-bef3-651060564f93', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'Which function is used to replace missing ...', 'Which function is used to replace missing values in a Series?', 498, '["replace()","fillna()","update()","addna()"]'::jsonb, 1, 2, 'easy', '["fillna() replaces missing values with specified values."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('c060c622-fa63-57dc-9685-fad3b744a7a2', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'What does df.loc[] represent in a DataFrame?', 'What does df.loc[] represent in a DataFrame?', 702, '["Position-based indexing","Label-based indexing","Sorting function","Aggregation method"]'::jsonb, 1, 2, 'easy', '["loc[] accesses rows and columns using labels."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('90dc98e9-9e6d-5265-b083-9cd08b13e519', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'mcq', 'Which DataFrame function is used for posit...', 'Which DataFrame function is used for position-based indexing?', 747, '["df.loc[]","df.iloc[]","df.index()","df.access()"]'::jsonb, 1, 2, 'easy', '["iloc[] is used for integer-position based indexing."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints, initial_code, language_id, solution)
VALUES ('e85261be-afd4-55dd-9202-0df736a1e2bf', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c7d1e2f3-a4b5-4c21-8dfe-f7a8b9c0d1e2', 'coding', 'Coding: Complete the code to create a Pandas ...', 'Complete the code to create a Pandas Series and print the first element.', 0, '[]'::jsonb, 0, 4, 'medium', '["Review the previous lecture concepts."]'::jsonb, E'import pandas as pd
data = [10,20,30,40]
s = pd._____(data)
print(s[_____])
________________________________________
1️⃣ _____
2️⃣ _____
________________________________________', 71, E'import pandas as pd
data = [10,20,30,40]
s = pd.Series(data)
print(s[0])')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints,
  initial_code = EXCLUDED.initial_code,
  solution = EXCLUDED.solution;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('a9c14f25-09d2-56ce-ac77-3f3c47449689', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3', 'mcq', 'What is the primary challenge when dealing...', 'What is the primary challenge when dealing with large volumes of data in data science?', 57, '["Lack of programming languages","Difficulty in visualizing data","Limited memory and computational resources","Lack of internet connectivity"]'::jsonb, 2, 2, 'easy', '["Handling large datasets often leads to memory overload, CPU limitations, and slower processing speeds."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('12484b51-38f6-5b10-8fa3-d7a3e94f991e', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3', 'mcq', 'What happens when the computer tries to lo...', 'What happens when the computer tries to load more data into RAM than its capacity?', 144, '["The computer deletes the data","The operating system swaps data from RAM to disk","The CPU stops functioning","The algorithm automatically compresses the data"]'::jsonb, 1, 2, 'easy', '["When RAM is insufficient, the operating system performs memory swapping, moving data from RAM to disk, which reduces performance."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('51999878-12b5-5ec0-a0c3-d23eeda2c006', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3', 'mcq', 'In a bottleneck situation, what typically ...', 'In a bottleneck situation, what typically happens in a computing system?', 229, '["All components work equally fast","Some components remain idle while one component slows the process","The algorithm stops immediately","The RAM increases automatically"]'::jsonb, 1, 2, 'easy', '["A bottleneck occurs when one component (CPU, RAM, Disk, or Network) slows down the system while other components wait idle."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('a04c1376-bd00-5395-bdff-2ae93a376a7e', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3', 'mcq', 'Why is reading data directly from a hard d...', 'Why is reading data directly from a hard drive slower compared to RAM?', 304, '["Hard drives store less data","Hard drives have slower data access speeds than RAM","RAM is used only for graphics","Hard drives cannot store large files"]'::jsonb, 1, 2, 'easy', '["Hard drives have significantly slower access times compared to RAM, making data processing slower when reading directly from disk."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('eed7bce4-471c-57bc-bfa3-631750d986e3', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a9b3c4d5-e6f7-4a13-8b7c-d9e0f1a2b3c4', 'mcq', 'Which of the following is NOT mentioned as...', 'Which of the following is NOT mentioned as a general technique for handling large volumes of data?', 55, '["Choosing the right algorithm","Choosing the right data structure","Choosing the right tool","Increasing internet bandwidth"]'::jsonb, 3, 2, 'easy', '["The lecture states three solutions: using the right algorithm, right data structure, and right tool."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('42190c2b-7a55-5897-baa1-a27136454154', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a9b3c4d5-e6f7-4a13-8b7c-d9e0f1a2b3c4', 'mcq', 'In online learning algorithms, what does “...', 'In online learning algorithms, what does “mini-batch learning” mean?', 144, '["Feeding the entire dataset at once","Feeding the algorithm with small portions of data based on hardware capacity","Feeding the algorithm with one observation per year","Storing all data permanently in memory"]'::jsonb, 1, 2, 'easy', '["Mini-batch learning processes small chunks of data, making it suitable for systems with limited memory."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('0e8230d4-d5a7-5673-9d93-9d622d70e38d', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a9b3c4d5-e6f7-4a13-8b7c-d9e0f1a2b3c4', 'mcq', 'In the MapReduce model, which phase groups...', 'In the MapReduce model, which phase groups similar keys together before aggregation?', 232, '["Map phase","Shuffle and sort phase","Reduce phase","Storage phase"]'::jsonb, 1, 2, 'easy', '["The shuffle and sort phase groups data with the same keys before the final aggregation step in the reduce phase."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('5e184027-093e-56f1-b400-b62ee8e37dec', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a9b3c4d5-e6f7-4a13-8b7c-d9e0f1a2b3c4', 'mcq', 'Which data structure allows fast data retr...', 'Which data structure allows fast data retrieval using key–value pairs?', 318, '["Tree","Hash function (hash table)","Sparse matrix","Linked list"]'::jsonb, 1, 2, 'easy', '["A hash table stores data using key–value pairs and allows fast lookup using hash functions."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('cec6bce7-6201-59d1-b39e-35ef1de49e27', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a9b3c4d5-e6f7-4a13-8b7c-d9e0f1a2b3c4', 'mcq', 'What is a sparse matrix?', 'What is a sparse matrix?', 398, '["A matrix with equal numbers of zeros and ones","A matrix with mostly zero values and few non-zero elements","A matrix containing only floating point values","A matrix used only in machine learning"]'::jsonb, 1, 2, 'easy', '["A sparse matrix contains many zeros and very few meaningful values, allowing memory-efficient storage."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('2c447c86-7320-5087-8e2f-7e28e3eedf65', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a9b3c4d5-e6f7-4a13-8b7c-d9e0f1a2b3c4', 'mcq', 'What is the role of Numba in Python?', 'What is the role of Numba in Python?', 517, '["It compresses large datasets","It converts Python code to machine code during runtime (Just-In-Time compilation)","It visualizes data using graphs","It stores data in a database"]'::jsonb, 1, 2, 'easy', '["Numba is a Just-In-Time (JIT) compiler that converts Python code into machine code at runtime to improve performance."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('0acedd9b-93e1-5812-ae50-d500cfb28275', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b0c4d5e6-f7a8-4b14-9c8d-e0f1a2b3c4d5', 'mcq', 'What does the phrase “Don’t reinvent the w...', 'What does the phrase “Don’t reinvent the wheel” mean in data science?', 59, '["Build all tools from scratch","Use existing tools and libraries developed by others","Avoid using programming languages","Only use manual calculations"]'::jsonb, 1, 2, 'easy', '["Instead of building everything from scratch, data scientists should use existing optimized libraries and tools."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('72d3bf68-8b7c-5dac-b770-83ff145c1567', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b0c4d5e6-f7a8-4b14-9c8d-e0f1a2b3c4d5', 'mcq', 'How can hardware be used efficiently when ...', 'How can hardware be used efficiently when handling large datasets?', 103, '["Run tasks sequentially and wait for each step to finish","Run different processes in parallel whenever possible","Always store data on disk before processing","Turn off the CPU during execution"]'::jsonb, 1, 2, 'easy', '["Running processes in parallel ensures that components like CPU, sensors, and processing units do not remain idle."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('d62dd81d-4e41-527e-bc30-488b410dfc19', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b0c4d5e6-f7a8-4b14-9c8d-e0f1a2b3c4d5', 'mcq', 'Why is reducing computing needs important ...', 'Why is reducing computing needs important when working with large data?', 146, '["It increases memory consumption","It reduces system performance","It allows large datasets to be processed efficiently using fewer resources","It eliminates the need for algorithms"]'::jsonb, 2, 2, 'easy', '["Reducing computing needs helps optimize memory usage and processing power, making large data processing more efficient."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('3a8f6365-003e-543a-b9c4-d86e5e2c3ea0', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6', 'mcq', 'What is Data Wrangling?', 'What is Data Wrangling?', 55, '["Storing raw data without modification","Transforming raw data into a usable format for analysis","Deleting unnecessary data permanently","Visualizing data using graphs"]'::jsonb, 1, 2, 'easy', '["Data wrangling is the process of transforming and mapping raw data into a usable format for analytics."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('5c61eb51-61c9-5e26-86a9-daaba0425ddb', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6', 'mcq', 'Which of the following is a real-world app...', 'Which of the following is a real-world application of data wrangling mentioned in the lecture?', 143, '["Video editing","Fraud detection and customer behavior analysis","Game development","Hardware manufacturing"]'::jsonb, 1, 2, 'easy', '["Data wrangling helps analyze patterns such as fraud detection and customer purchasing behavior."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('b20306bd-dd50-5763-ba56-9d7a8fade62c', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6', 'mcq', 'What is the main objective of the Data Dis...', 'What is the main objective of the Data Discovery step in data wrangling?', 260, '["Remove duplicate data","Understand the structure and content of the dataset","Publish the dataset","Normalize the dataset"]'::jsonb, 1, 2, 'easy', '["Data discovery helps understand the nature, format, and structure of the dataset and identify potential issues like missing values or outliers."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('18a767fa-3a02-5d01-9745-97b4f501f6af', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6', 'mcq', 'What happens during the Data Organization ...', 'What happens during the Data Organization stage?', 336, '["Data is deleted","Data is visualized using charts","Data is restructured into a suitable format for analysis","Data is encrypted"]'::jsonb, 2, 2, 'easy', '["Data organization reshapes and structures the data into formats suitable for analysis (often tabular form)."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('5376d452-a514-5c58-89f1-f0f18f963cb1', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6', 'mcq', 'Which operation is commonly used in the Da...', 'Which operation is commonly used in the Data Cleaning step?', 413, '["Creating dashboards","Removing duplicates and handling missing values","Writing SQL queries","Publishing reports"]'::jsonb, 1, 2, 'easy', '["Data cleaning removes outliers, duplicates, and missing values to ensure accuracy."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('55cadce5-b505-5c8a-a0f3-cc1995213fb7', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6', 'mcq', 'What is the purpose of Data Enrichment?', 'What is the purpose of Data Enrichment?', 495, '["Delete old data","Add additional information to improve data quality and completeness","Encrypt the dataset","Reduce dataset size"]'::jsonb, 1, 2, 'easy', '["Data enrichment improves datasets by adding useful information or features."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('797e8ac5-5667-52f8-baf8-0cd0cf1a47c0', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6', 'mcq', 'What is checked during the Data Validation...', 'What is checked during the Data Validation stage?', 533, '["Internet speed","Data accuracy and consistency","Hardware performance","Programming syntax"]'::jsonb, 1, 2, 'easy', '["Data validation ensures the data is accurate, complete, and follows predefined rules."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('466e1399-d3ad-5b31-95b1-efb1d934e58e', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'c1d5e6f7-a8b9-4c15-8d9e-f1a2b3c4d5e6', 'mcq', 'What is the final stage of the Data Wrangl...', 'What is the final stage of the Data Wrangling process?', 613, '["Data Cleaning","Data Discovery","Data Publishing","Data Transformation"]'::jsonb, 2, 2, 'easy', '["After processing and validation, the data is published or stored in formats like CSV, Excel, SQL, or dashboards."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('c6f1381d-fd21-58e2-9df2-042865b0ed51', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7', 'mcq', 'Which of the following is the correct orde...', 'Which of the following is the correct order of operations mentioned in the data wrangling process?', 58, '["Merge → Transform → Clean → Reshape","Clean → Transform → Merge → Reshape","Transform → Clean → Publish → Merge","Merge → Clean → Transform → Analyze"]'::jsonb, 1, 2, 'easy', '["The lecture explains four main steps: cleaning, transforming, merging, and reshaping the dataset."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('3f405918-c9e3-528a-8e0f-4aac020397c6', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7', 'mcq', 'Which pandas function is commonly used to ...', 'Which pandas function is commonly used to merge two dataframes based on a key?', 144, '["pd.reshape()","pd.merge()","pd.drop()","pd.sort()"]'::jsonb, 1, 2, 'easy', '["pd.merge() merges two dataframes based on a common key, similar to SQL join operations."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('232656c1-564e-593c-851e-4c889f6d3ae4', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7', 'mcq', 'What does an INNER JOIN return when mergin...', 'What does an INNER JOIN return when merging two datasets?', 319, '["All records from both datasets","Only the records that are common in both datasets","Only records from the first dataset","Only records from the second dataset"]'::jsonb, 1, 2, 'easy', '["Inner join returns only the matching records from both dataframes."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('e5905016-9f67-5de0-a92b-73230ba92852', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7', 'mcq', 'What does an OUTER JOIN return when mergin...', 'What does an OUTER JOIN return when merging datasets?', 359, '["Only matching records","Only records from the first dataframe","All records from both datasets, filling missing values with None/NaN","Only records from the second dataframe"]'::jsonb, 2, 2, 'easy', '["Outer join performs a union of both datasets, including unmatched records."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('6550492a-1e4a-54d3-8102-d55435ac8c7a', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7', 'mcq', 'What happens in a LEFT JOIN?', 'What happens in a LEFT JOIN?', 443, '["Only records from the second dataframe are kept","All records from the first dataframe are kept, matching records from the second dataframe are added","Only common records are returned","Both datasets are ignored"]'::jsonb, 1, 2, 'easy', '["Left join keeps all records from the left dataframe (df1) and adds matching values from df2."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('a4412575-8902-58cd-8d89-7a6bf468eb58', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7', 'mcq', 'In a RIGHT JOIN, priority is given to whic...', 'In a RIGHT JOIN, priority is given to which dataset?', 529, '["First dataframe","Second dataframe","Both dataframes equally","Neither dataframe"]'::jsonb, 1, 2, 'easy', '["Right join prioritizes the right dataframe (df2) and includes all its rows."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('80fc80e9-c53c-5808-949b-f671a5fc404a', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7', 'mcq', 'When merging two datasets without specifyi...', 'When merging two datasets without specifying a column, pandas merges based on:', 691, '["Random columns","Common column names","File size","Data type"]'::jsonb, 1, 2, 'easy', '["If no column is specified, pandas automatically merges using common column names."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('086c95fa-d477-5d84-9b15-fa92ca731124', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7', 'mcq', 'What does concatenation do in data process...', 'What does concatenation do in data processing?', 997, '["Deletes duplicate data","Joins datasets together along rows or columns","Converts data into JSON format","Sorts data alphabetically"]'::jsonb, 1, 2, 'easy', '["Concatenation joins datasets row-wise (axis=0) or column-wise (axis=1)."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints, initial_code, language_id, solution)
VALUES ('a6dc309e-9551-504e-8156-95f349a0e240', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7', 'coding', 'Coding: Fill the blanks to convert columns in...', 'Fill the blanks to convert columns into rows using stack.
_____ pandas as pd', 120, '[]'::jsonb, 0, 4, 'medium', '["Review the previous lecture concepts."]'::jsonb, E'data = {
''Math'':[90,85],
''Science'':[88,92]
}
df = pd._____(data)
stacked = df._____
print(_____)
1.	_____
2.	_____
3.	_____
4.	_____
________________________________________', 71, E'import pandas as pd
data = {
''Math'':[90,85],
''Science'':[88,92]
}
df = pd.DataFrame(data)
stacked = df.stack()
print(stacked)')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints,
  initial_code = EXCLUDED.initial_code,
  solution = EXCLUDED.solution;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints, initial_code, language_id, solution)
VALUES ('4267a2cf-9283-5d7e-9020-31bda7c92584', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'd2e6f7a8-b9c0-4d16-9eaf-a2b3c4d5e6f7', 'coding', 'Coding: Fill the blanks to convert rows back ...', 'Fill the blanks to convert rows back to columns using unstack.
_____ pandas as pd', 0, '[]'::jsonb, 0, 4, 'medium', '["Review the previous lecture concepts."]'::jsonb, E'data = {
''Math'':[90,85],
''Science'':[88,92]
}
df = pd._____(data)
stacked = df.stack()
unstacked = stacked._____
print(_____)
________________________________________
1.	_____
2.	_____
3.	_____
4.	_____
________________________________________', 71, E'import pandas as pd
data = {
''Math'':[90,85],
''Science'':[88,92]
}
df = pd.DataFrame(data)
stacked = df.stack()
unstacked = stacked.unstack()
print(unstacked)')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints,
  initial_code = EXCLUDED.initial_code,
  solution = EXCLUDED.solution;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('a22e9b9b-9a2f-5ea0-a862-3f9091d2cca4', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9', 'mcq', 'Which pandas function is used to replace m...', 'Which pandas function is used to replace missing values with the mean of the column?', 61, '["dropna()","fillna()","merge()","concat()"]'::jsonb, 1, 2, 'easy', '["fillna() replaces missing values using methods like mean, median, or a fixed value."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('f7c804ab-7e23-51ef-8364-ca6f671994fd', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9', 'mcq', 'What is Listwise Deletion?', 'What is Listwise Deletion?', 107, '["Replacing missing values with averages","Removing only missing values","Removing the entire row or column that contains missing values","Replacing missing values using regression"]'::jsonb, 2, 2, 'easy', '["Listwise deletion removes entire rows (or columns) that contain missing values."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('38ae6853-f639-5db3-b0b4-0259c849089d', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9', 'mcq', 'Why is Pairwise Deletion sometimes preferr...', 'Why is Pairwise Deletion sometimes preferred over Listwise Deletion?', 147, '["It removes all data completely","It keeps more useful data for calculations","It converts missing values to zero","It duplicates rows"]'::jsonb, 1, 2, 'easy', '["Pairwise deletion removes missing values only for specific operations, preserving more data."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('79889b91-77b6-595b-8d64-e3e784c2b748', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9', 'mcq', 'What is Data Imputation?', 'What is Data Imputation?', 276, '["Removing duplicate rows","Replacing missing values with estimated values","Sorting datasets","Encrypting datasets"]'::jsonb, 1, 2, 'easy', '["Imputation replaces missing values using statistical or predictive techniques."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('41cac048-8dc6-597b-8f88-b410fbacded7', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9', 'mcq', 'Which method predicts missing values using...', 'Which method predicts missing values using regression models?', 321, '["Pairwise deletion","Regression imputation","Multiple deletion","Random sampling"]'::jsonb, 1, 2, 'easy', '["Regression imputation predicts missing values using relationships between variables."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('4117355b-e798-502b-92ee-f18ee87d91f7', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f4a8b9c0-d1e2-4f18-9acb-c4d5e6f7a8b9', 'mcq', 'What does the fit_transform() function do ...', 'What does the fit_transform() function do in imputation?', 522, '["Deletes missing values","Calculates statistics and replaces missing values","Converts data types","Sorts the dataset"]'::jsonb, 1, 2, 'easy', '["fit() computes the statistic (like mean) and transform() replaces missing values."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('f2d01c86-ab96-599e-92d2-326bb216f825', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0', 'mcq', 'Which of the following is NOT a step in da...', 'Which of the following is NOT a step in data cleaning mentioned in the lecture?', 58, '["Standardizing capitalization","Removing duplicates","Detecting outliers","Training machine learning models"]'::jsonb, 3, 2, 'easy', '["Data cleaning includes standardization, removing outliers, handling missing values, removing irrelevant data, converting data types, and removing duplicates."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('b9eeef5a-bfa7-503a-b76e-4c5e6f5a50f6', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0', 'mcq', 'What is the purpose of data discretization?', 'What is the purpose of data discretization?', 147, '["Convert data into numerical format","Divide continuous data into categories or bins","Remove duplicate records","Normalize the dataset"]'::jsonb, 1, 2, 'easy', '["Data discretization divides continuous data into categories (e.g., young, middle age, senior)."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('1e34a378-6d8f-572e-a858-2c839144be07', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0', 'mcq', 'Why is standardizing capitalization import...', 'Why is standardizing capitalization important in data cleaning?', 272, '["To improve hardware performance","To ensure the program treats similar text values as the same entity","To reduce dataset size","To remove duplicate rows automatically"]'::jsonb, 1, 2, 'easy', '["Different capitalizations like “Alice”, “ALICE”, “alice” can be treated as different values unless standardized."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('31b7eab6-887d-5210-9158-d8380fd36da5', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0', 'mcq', 'Which statistical method is used in the le...', 'Which statistical method is used in the lecture to detect outliers?', 353, '["Linear regression","Interquartile Range (IQR)","K-Means clustering","Logistic regression"]'::jsonb, 1, 2, 'easy', '["Outliers are detected using the Interquartile Range (IQR) method."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('18b3e98e-b6b0-50b4-9948-bb70954fcebb', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0', 'mcq', 'Which pandas function is used to handle mi...', 'Which pandas function is used to handle missing values by replacing them with a mean value?', 393, '["drop()","fillna()","replace()","merge()"]'::jsonb, 1, 2, 'easy', '["fillna() fills missing values using mean, median, or other values."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('f5a188b5-d737-5855-a8a5-d64f806804c3', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'a5b9c0d1-e2f3-4a19-8bdc-d5e6f7a8b9c0', 'mcq', 'What does df.drop_duplicates() do?', 'What does df.drop_duplicates() do?', 578, '["Removes rows with missing values","Converts data types","Removes duplicate rows from a dataset","Normalizes the dataset"]'::jsonb, 2, 2, 'easy', '["drop_duplicates() removes repeated rows to maintain data accuracy."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('88a68918-fe5a-53ea-a202-0dcda28910b7', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1', 'mcq', 'What is the main purpose of data transform...', 'What is the main purpose of data transformation?', 58, '["Delete datasets permanently","Convert and structure data into a useful format for analysis","Only visualize the data","Compress the data into ZIP files"]'::jsonb, 1, 2, 'easy', '["Data transformation converts raw or unstructured data into a structured format suitable for analysis and decision-making."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('dd329643-162a-5c73-9049-0ae430e8db93', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1', 'mcq', 'Which of the following is the first step i...', 'Which of the following is the first step in the data transformation process?', 136, '["Data aggregation","Data smoothing","Data discretization","Data normalization"]'::jsonb, 1, 2, 'easy', '["The first step is data smoothing, which removes noise and irregularities from the dataset."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('116a371d-f6d2-5899-abaa-c7edddc4e5f5', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1', 'mcq', 'What is Attribute Construction?', 'What is Attribute Construction?', 268, '["Deleting unnecessary columns","Creating new attributes from existing data","Sorting data alphabetically","Converting strings into integers"]'::jsonb, 1, 2, 'easy', '["Attribute construction creates new useful features from existing attributes to improve analysis."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('96e4e31f-c54e-5dba-a3eb-dee52175fc0b', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1', 'mcq', 'What does data generalization do?', 'What does data generalization do?', 341, '["Deletes detailed data","Converts detailed values into broader categories","Encrypts data","Visualizes data in graphs"]'::jsonb, 1, 2, 'easy', '["Generalization converts specific values into higher-level categories, such as age groups."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('2cfbde55-168f-50ca-a327-583de5e31f8e', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1', 'mcq', 'Which pandas function is used in the lectu...', 'Which pandas function is used in the lecture to group data and compute aggregated results?', 495, '["merge()","groupby()","reshape()","append()"]'::jsonb, 1, 2, 'easy', '["groupby() is used for data aggregation, such as calculating total sales by region."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('46f30307-b276-5dbc-a285-dc7e62bd315d', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'b6c0d1e2-f3a4-4b20-9ced-e6f7a8b9c0d1', 'mcq', 'What is the purpose of data discretization?', 'What is the purpose of data discretization?', 614, '["Convert categorical data into numbers","Convert continuous values into intervals or bins","Delete missing values","Compress large datasets"]'::jsonb, 1, 2, 'easy', '["Discretization groups continuous data into intervals or bins such as low, medium, and high."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('f018e1bc-f1be-50c3-8b3e-986dff2fc011', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3', 'mcq', 'In Python, what is a string?', 'In Python, what is a string?', 50, '["A collection of numbers","A sequence of characters enclosed in quotes","A type of loop","A mathematical function"]'::jsonb, 1, 2, 'easy', '["A string is a sequence of characters enclosed in single or double quotes."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('201fa947-a145-52e6-a8c1-a953506e6264', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3', 'mcq', 'What is string padding?', 'What is string padding?', 94, '["Removing characters from a string","Adding extra characters to the beginning or end of a string","Splitting a string into words","Searching a string"]'::jsonb, 1, 2, 'easy', '["Padding adds extra characters or spaces to format text properly."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('8dcdf544-ceeb-5b43-a20b-525d291ddf0e', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3', 'mcq', 'Which Python method is used to divide a st...', 'Which Python method is used to divide a string into multiple substrings?', 206, '["split()","strip()","find()","join()"]'::jsonb, 0, 2, 'easy', '["split() divides a string into multiple substrings using a delimiter."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('e87ce813-98c8-56ba-853c-7d66f7e9076a', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3', 'mcq', 'Which function removes unwanted characters...', 'Which function removes unwanted characters from the beginning and end of a string?', 328, '["strip()","concat()","search()","append()"]'::jsonb, 0, 2, 'easy', '["strip() removes leading and trailing characters."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('a08c0632-c640-5c38-b711-cdbe7330de14', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3', 'mcq', 'Which operator is used for string concaten...', 'Which operator is used for string concatenation in Python?', 412, '["*","+","/","="]'::jsonb, 1, 2, 'easy', '["The + operator joins two strings together."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints)
VALUES ('341b7691-d294-5785-9f71-fb725b289cec', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3', 'mcq', 'Which Python method is used to search for ...', 'Which Python method is used to search for a substring inside a string?', 450, '["split()","strip()","find()","append()"]'::jsonb, 2, 2, 'easy', '["find() returns the index position of the substring in the string."]'::jsonb)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints;

INSERT INTO public.challenges 
(id, course_id, lesson_id, challenge_type, title, description, timestamp_seconds, options, correct_option, star_value, difficulty, hints, initial_code, language_id, solution)
VALUES ('c841ea1e-90e3-5f62-922b-9552d2cb8aa6', 'd5c1e7a3-9f2b-4e8d-a6c4-3b7f1e9d2a5c', 'f8a2b3c4-d5e6-4f12-9a6b-c8d9e0f1a2b3', 'coding', 'Coding: Complete the code to split a sentence...', 'Complete the code to split a sentence into individual words.
text = "Hello world how are you"
words = text._____()
print(_____)
________________________________________
1.	_____
2.	_____
________________________________________', 0, '[]'::jsonb, 0, 4, 'medium', '["Review the previous lecture concepts."]'::jsonb, E'', 71, E'text = "Hello world how are you"
words = text.split()
print(words)')
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  description = EXCLUDED.description,
  timestamp_seconds = EXCLUDED.timestamp_seconds,
  options = EXCLUDED.options,
  correct_option = EXCLUDED.correct_option,
  hints = EXCLUDED.hints,
  initial_code = EXCLUDED.initial_code,
  solution = EXCLUDED.solution;

