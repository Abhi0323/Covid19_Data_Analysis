# This query provides a comprehensive overview of the entire Covid19 deaths dataset, retrieving all columns and rows, serving as the starting point for data analysis and exploration.
SELECT * FROM coviddeaths_proj


# This query selects specific columns 'location', 'date', and 'icu_patients' from the Covid19 deaths dataset, allowing for a closer examination of ICU patient data, a crucial factor in understanding the impact of the pandemic on healthcare systems.
SELECT location, date, icu_patients FROM coviddeaths_proj 


# This query filters the Covid19 deaths dataset based on 'icu_patients' column, retrieving records where the number of ICU patients exceeds 1000, providing insights into the severity of critical cases in different locations.
SELECT location, date, icu_patients FROM coviddeaths_proj WHERE icu_patients > 1000


# This query retrieves 'location', 'date', and 'hosp_patients' columns from the Covid19 deaths dataset, allowing for an analysis of hospitalization data, a key parameter in understanding the burden on healthcare facilities.
SELECT location, date, hosp_patients FROM coviddeaths_proj 


# This query retrieves the maximum value of 'hosp_patients' column from the Covid19 deaths dataset, grouped by 'location' and 'date', and sorted by 'date'. This can provide insights into the peak hospitalization numbers over time, helping to identify trends and patterns.
SELECT location, date, MAX(hosp_patients)  FROM coviddeaths_proj
GROUP BY location, date
ORDER BY date


# This query retrieves 'location' and 'date' columns from the Covid19 deaths dataset, with 'date' column aliased as 'Start_of_Covid', and the results are sorted by 'Start_of_Covid'. This can help identify the initial dates of Covid19 cases in different locations, aiding in understanding the spread of the pandemic.
SELECT location, date AS Start_of_Covid from coviddeaths_proj
ORDER BY Start_of_Covid


# This query retrieves multiple columns, including 'location', 'date', 'new_cases', 'total_cases', 'new_deaths', 'total_deaths', and 'population', from the Covid19 deaths dataset. The results are sorted by 'location' and 'date', allowing for a comprehensive analysis of various Covid19 statistics over time.
SELECT location, date, new_cases, total_cases, new_deaths, total_deaths, population FROM coviddeaths_proj
ORDER BY location,date


# This query retrieves distinct 'location' values from the Covid19 deaths dataset, providing a unique list of locations where the data is recorded, useful for identifying different geographical regions affected by the pandemic.
SELECT distinct(location) FROM coviddeaths_proj


# This query retrieves 'location', 'date', 'total_cases', and 'total_deaths' columns from the Covid19 deaths dataset. Additionally, it calculates the 'Death_Percentage' as the ratio of 'total_deaths' to 'total_cases' multiplied by 100, providing insights into the mortality rate of Covid19 cases. The results are sorted by 'location' and 'date'.
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 AS Death_Percentage FROM coviddeaths_proj
ORDER BY location, date


# This query selects 'location', 'date', 'total_cases', 'population', and calculates 'Covid_Positive_Percentage' as the ratio of 'total_cases' to 'population' multiplied by 100, and sorts the results by 'location' and 'date'.
SELECT location, date, total_cases, population, (total_cases/population) * 100 AS Covid_Positive_Percentage FROM coviddeaths_proj
ORDER BY location, date


# This query selects 'location', 'date', 'total_cases', 'population', calculates 'Covid_Positive_Percentage' as the ratio of 'total_cases' to 'population' multiplied by 100, and only returns results where the 'total_cases' are greater than 10 million. The results are sorted by 'location' and 'date'.
SELECT location, date, total_cases, population, (total_cases/population) * 100 AS Covid_Positive_Percentage  FROM coviddeaths_proj
WHERE total_cases > 10000000
ORDER BY location, date


# This query selects 'location', 'population', 'MAX(total_cases)' as 'Highest_Cases', and calculates 'Covid_Positive_Percentage' as the ratio of 'total_cases' to 'population' multiplied by 100. The results are grouped by 'location' and 'population', and ordered by 'Population' in descending order.
SELECT location, population, MAX(total_cases) AS Highest_Cases,  MAX(total_cases/population) * 100 AS Covid_Positive_Percentage FROM #coviddeaths_proj
GROUP BY location, population
ORDER BY Population DESC


# This query selects 'location', 'population', 'total_deaths', and calculates 'Death_Percentage' as the ratio of 'total_deaths' to 'population' multiplied by 100. The results are ordered by 'Death_Percentage' in descending order.
SELECT location, population, total_deaths, (total_deaths/population) * 100 AS Death_Percentage  FROM coviddeaths_proj
ORDER BY Death_Percentage DESC


# This query retrieves all columns from the Covid19 vaccinations dataset.
SELECT * FROM covidvaccinations_proj


# This query selects 'location', 'date', and 'total_vaccinations' columns from the Covid19 vaccinations dataset, and sorts the results by 'date'.
SELECT location, date, total_vaccinations FROM covidvaccinations_proj
ORDER BY date


# This query retrieves all columns from both the Covid19 deaths and vaccinations datasets where the 'location' and 'date' columns match in both datasets.
SELECT * FROM coviddeaths_proj AS d
JOIN covidvaccinations_proj AS v 
ON d.location = v.location and d.date = v.date


# This query retrieves the 'continent', 'location', 'date', 'population', and 'new_vaccinations' columns from the Covid19 deaths and vaccinations datasets, respectively. It joins the two datasets using the 'location' and 'date' columns and sorts the results by 'continent', 'location', and 'date'. This query provides insights into the vaccination progress of different countries and continents.
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations FROM coviddeaths_proj AS d
JOIN covidvaccinations_proj AS v 
ON d.location = v.location and d.date = v.date
ORDER BY continent,location,date


# This query selects 'continent', 'location', 'date', 'population', 'v.new_vaccinations', and calculates 'Rolling_People_Vaccinated' as the cumulative sum of 'new_vaccinations' for each 'location', ordered by 'continent', 'location', and 'date'. Both the Covid19 deaths and vaccinations datasets are joined using 'location' and 'date' columns.
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations, 
SUM(v.new_vaccinations) OVER ( PARTITION by d.location ORDER BY d.location,d.date) AS Rolling_People_Vaccinated FROM coviddeaths_proj AS d
JOIN covidvaccinations_proj AS v 
ON d.location = v.location and d.date = v.date
ORDER BY continent,location,date
