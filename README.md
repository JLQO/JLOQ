# JLOQ
# 👋 Hello, I'm JLQO  

Welcome to my GitHub profile! I'm a passionate developer currently learning new technologies and working on exciting projects.  

---

## 🛠️ Skills & Technologies  
### 🌐 Front-End  
![HTML](https://img.shields.io/badge/-HTML5-E34F26?style=flat-square&logo=html5&logoColor=white)  
![CSS](https://img.shields.io/badge/-CSS3-1572B6?style=flat-square&logo=css3&logoColor=white)  
![JavaScript](https://img.shields.io/badge/-JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black)  
![Bootstrap](https://img.shields.io/badge/-Bootstrap-7952B3?style=flat-square&logo=bootstrap&logoColor=white)  
![jQuery](https://img.shields.io/badge/-jQuery-0769AD?style=flat-square&logo=jquery&logoColor=white)  
![AJAX](https://img.shields.io/badge/-AJAX-0078D7?style=flat-square&logo=windows-terminal&logoColor=white)  

### 💾 Backend & Database  
![MySQL](https://img.shields.io/badge/-MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white)  

### 🔥 Programming Languages  
![Java](https://img.shields.io/badge/-Java-007396?style=flat-square&logo=java&logoColor=white)  
![C](https://img.shields.io/badge/-C-A8B9CC?style=flat-square&logo=c&logoColor=white)  

### 🚀 Currently Learning  
![Jsoup](https://img.shields.io/badge/-Jsoup-1572B6?style=flat-square&logo=java&logoColor=white)  
![Selenium](https://img.shields.io/badge/-Selenium-43B02A?style=flat-square&logo=selenium&logoColor=white)  

---

## 📌 Projects  
🚧 **Upcoming:** A **Checkers Game** built with Java (Coming soon!)  
🚧 **Upcoming:** A **Discord Bot** built with Java (Coming soon!)  

---

# Midterm Lab Task 2 - Data Cleaning and Transformation using Power Query

## 📌 Task Description
Company X wants to extract useful insights from the `Uncleaned_DS_jobs.csv` dataset from Kaggle. The dataset requires cleaning and transformation to answer the following questions:

1. Which job roles pay the highest and least?
2. What size companies pay the best?
3. Where do job roles or job titles pay the best and least in a specific state?

The task involves cleaning salary estimates, categorizing job roles, handling missing/negative values, and restructuring data using Power Query in Excel.

---

## 📂 Dataset Overview
- **Dataset Name:** `Uncleaned_DS_jobs.csv`
- **Source:** Kaggle
- **Loaded in:** Power Query (Excel)

---

## 📸 Before Cleaning (Raw Dataset)
👉 **[Add a screenshot of the raw dataset before cleaning]**

---

## 🔧 Data Cleaning & Transformation Steps

### **1️⃣ Salary Estimate Cleaning**
- Removed unwanted characters (everything after `(` in `Salary Estimate` column).
- Created **Min Sal** and **Max Sal** columns using **Column from Examples**.

### **2️⃣ Categorizing Job Roles**
- Created a new column `Role Type` by grouping job titles into:
  - Data Scientist
  - Data Analyst
  - Data Engineer
  - Machine Learning Engineer
  - Other

### **3️⃣ Splitting Location Information**
- Split the `Location` column using `,` as a delimiter.
- Handled cases where the state was missing or needed correction.
- Created a `State Abbreviation` column and replaced incorrect values.

### **4️⃣ Handling Missing & Negative Values**
- Filtered and removed `-1` values in `Competitors`, `Industry`, and `Revenue` columns.
- Replaced `0` values in the `Revenue` column.

### **5️⃣ Cleaning Company Names**
- Removed company ratings from `Company Name`.

### **6️⃣ Splitting & Transforming Company Size**
- Split `Size` column into **MinCompanySize** and **MaxCompanySize**.

---

## 📊 Reshaping & Grouping Data

### **1️⃣ Salary by Role Type**
- Grouped by `Role Type`.
- Calculated **average Min and Max salary**.

### **2️⃣ Salary by Company Size**
- Grouped by `Company Size`.
- Calculated **average Min and Max salary**.

### **3️⃣ Salary by State**
- Merged dataset with a state mapping file to get full state names.
- Grouped by `State`.
- Calculated **average Min and Max salary**.

---

## 📌 Final Output
👉 **[Add a screenshot of the final cleaned and transformed dataset]**

---

## 📝 Power Query M Code
```powerquery
let
    Source = Csv.Document(File.Contents("C:\Users\COMLAB\Downloads\Uncleaned_DS_jobs.csv"),[Delimiter=",", Columns=15, Encoding=1252, QuoteStyle=QuoteStyle.Csv]),
    #"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"index", Int64.Type}, {"Job Title", type text}, {"Salary Estimate", type text}, {"Job Description", type text}, {"Rating", type number}, {"Company Name", type text}, {"Location", type text}, {"Headquarters", type text}, {"Size", type text}, {"Founded", Int64.Type}, {"Type of ownership", type text}, {"Industry", type text}, {"Sector", type text}, {"Revenue", type text}, {"Competitors", type text}}),
    #"Extracted Text Before Delimiter" = Table.TransformColumns(#"Changed Type", {{"Salary Estimate", each Text.BeforeDelimiter(_, "("), type text}}),
    #"Inserted Literal" = Table.AddColumn(#"Extracted Text Before Delimiter", "Min Sal", each "101", type text),
    #"Inserted Literal1" = Table.AddColumn(#"Inserted Literal", "Max Sal", each "101", type text),
    #"Added Custom" = Table.AddColumn(#"Inserted Literal1", "Role Type", each if Text.Contains([Job Title], "Data Scientist") then
"Data Scientist"
else if Text.Contains([Job Title], "Data Analyst") then
"Data Analyst"
else if Text.Contains([Job Title], "Data Engineer") then
"Data Engineer"
else if Text.Contains([Job Title], "Machine Learning") then
"Machine Learning Engineer"
else
"other"),
    #"Changed Type1" = Table.TransformColumnTypes(#"Added Custom",{{"Role Type", type text}}),
    #"Added Custom1" = Table.AddColumn(#"Changed Type1", "Location Correction", each if [Location]= "New Jersey" then ", NJ"
else if [Location] = "Remote" then ", other"
else if [Location]= "United States" then ", other"
else if [Location]= "Texas" then ", TX"
else if [Location]= "Patuxent" then ", MA"
else if [Location]= "California" then ", CA"
else if [Location]= "Utah" then ", UT"
else [Location]),
    #"Split Column by Delimiter" = Table.SplitColumn(#"Added Custom1", "Location Correction", Splitter.SplitTextByDelimiter(",", QuoteStyle.Csv), {"Location Correction.1", "Location Correction.2"}),
    #"Changed Type2" = Table.TransformColumnTypes(#"Split Column by Delimiter",{{"Location Correction.1", type text}, {"Location Correction.2", type text}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type2","Anne Rundell","MA",Replacer.ReplaceText,{"Location Correction.2"}),
    #"Renamed Columns" = Table.RenameColumns(#"Replaced Value",{{"Location Correction.2", "State Abbreviations"}}),
    #"Split Column by Delimiter1" = Table.SplitColumn(#"Renamed Columns", "Size", Splitter.SplitTextByDelimiter(" ", QuoteStyle.Csv), {"Size.1", "Size.2", "Size.3", "Size.4"}),
    #"Changed Type3" = Table.TransformColumnTypes(#"Split Column by Delimiter1",{{"Size.1", type text}, {"Size.2", type text}, {"Size.3", Int64.Type}, {"Size.4", type text}}),
    #"Removed Columns" = Table.RemoveColumns(#"Changed Type3",{"Size.2", "Size.4"}),
    #"Renamed Columns1" = Table.RenameColumns(#"Removed Columns",{{"Size.1", "MinCompanySize"}, {"Size.3", "MaxCompanySize"}}),
    #"Replaced Value1" = Table.ReplaceValue(#"Renamed Columns1","-1","N/A",Replacer.ReplaceText,{"Competitors"}),
    #"Changed Type4" = Table.TransformColumnTypes(#"Replaced Value1",{{"Revenue", type text}}),
    #"Replaced Value2" = Table.ReplaceValue(#"Changed Type4","-1","0",Replacer.ReplaceText,{"Revenue"}),
    #"Filtered Rows" = Table.SelectRows(#"Replaced Value2", each ([Industry] <> "-1"))
in
    #"Filtered Rows"
```


---

## 📢 Submission & Repository Details
- **Repository Name:** `Midterm-Lab-PowerQuery`
- **Submission:** Uploaded to **GitHub Portfolio** with all required documentation.


![Profile Visitors](https://komarev.com/ghpvc/?username=JLQO&label=Profile+Views&color=blue&style=plastic)  
