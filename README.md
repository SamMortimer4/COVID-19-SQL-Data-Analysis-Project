# COVID-19 SQL Data Analysis Project
This portfolio project showcases my SQL skills in analyzing COVID-19 data sourced from Our World In Data. Leveraging fundamental SQL features and techniques, I present insightful queries to gain valuable insights into the global pandemic. These queries demonstrate my proficiency in using basic SQL functionalities.

# Key SQL Features Demonstrated:
1. Basic Retrieval:
	- Utilizing SELECT statements to retrieve data from the "covid-deaths" and "covid-vaccinations" tables.
	- Employing ORDER BY clause for result sorting.
2. Aggregate Functions:
	- Calculating percentages using aggregate functions such as MAX, MIN, and SUM.
	- Deriving metrics like the percentage of cases fatal and percentage of population infected.
3. Grouping and Filtering:
	- Employing GROUP BY clause to aggregate data at the country and continent levels.
	- Filtering data based on specific conditions, like excluding 'null' continents to only show countries.
4. Window Functions:
	- Implementing window functions for rolling calculations.
	- Showcasing the use of PARTITION BY for aggregating data over specific criteria.
5. Common Table Expressions (CTEs):
	- Using CTEs for readability and efficiency in calculating the percent of a country's population vaccinated over time.
6. Temporary Tables:
	- Employing temporary tables to store intermediate results for further analysis.
7. Creating Views:
	- Creating a view for seamless data retrieval, facilitating data visualization.

# Project Overview:
- Total Cases vs Total Deaths (UK): Analyzing the progression of COVID-19 cases and deaths in the United Kingdom.
- Infection and Death Rates (Global & Country Level): Calculating infection rates, death rates, and their variations across different countries.
- Death Count by Continent: Investigating total deaths by continent for a comprehensive overview.
- Global Vaccination Analysis: Utilizing CTEs, temporary tables, and views to analyze vaccination data globally and at the country level.

# Project Source:
The dataset spans from 2020 to 2024 (https://ourworldindata.org/covid-deaths), with "covid-deaths" excluding vaccination statistics and "covid-vaccinations" excluding infection and death statistics. The project draws inspiration from the Alex The Analyst tutorial (https://www.youtube.com/watch?v=qfyynHBFOsM).

Feel free to explore the queries and gain insights into the dynamic analysis of COVID-19 data.
