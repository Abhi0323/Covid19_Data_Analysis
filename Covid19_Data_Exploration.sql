# SELECT * FROM coviddeaths_proj

#SELECT location, date, icu_patients FROM coviddeaths_proj 

#SELECT location, date, icu_patients FROM coviddeaths_proj WHERE icu_patients > 1000

#SELECT location, date, hosp_patients FROM coviddeaths_proj 

#SELECT location, date, MAX(hosp_patients)  FROM coviddeaths_proj
#GROUP BY location, date
#ORDER BY date

#SELECT location, date AS Start_of_Covid from coviddeaths_proj
#ORDER BY Start_of_Covid

#SELECT location, date, new_cases, total_cases, new_deaths, total_deaths, population FROM coviddeaths_proj
#ORDER BY location,date

#SELECT distinct(location) FROM coviddeaths_proj

#SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 AS Death_Percentage FROM coviddeaths_proj
#ORDER BY location, date

#SELECT location, date, total_cases, population, (total_cases/population) * 100 AS Covid_Positive_Percentage FROM coviddeaths_proj
#ORDER BY location, date

#SELECT location, date, total_cases, population, (total_cases/population) * 100 AS Covid_Positive_Percentage  FROM coviddeaths_proj
#WHERE total_cases > 10000000
#ORDER BY location, date

#SELECT location, population, MAX(total_cases) AS Highest_Cases,  MAX(total_cases/population) * 100 AS Covid_Positive_Percentage FROM #coviddeaths_proj
#GROUP BY location, population
#ORDER BY Population DESC

#SELECT location, population, total_deaths, (total_deaths/population) * 100 AS Death_Percentage  FROM coviddeaths_proj
#ORDER BY Death_Percentage DESC

#SELECT * FROM covidvaccinations_proj

#SELECT location, date, total_vaccinations FROM covidvaccinations_proj
#ORDER BY date

#SELECT * FROM coviddeaths_proj AS d
#JOIN covidvaccinations_proj AS v 
#ON d.location = v.location and d.date = v.date

#SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations FROM coviddeaths_proj AS d
#JOIN covidvaccinations_proj AS v 
#ON d.location = v.location and d.date = v.date
#ORDER BY continent,location,date

#SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations, 
#SUM(v.new_vaccinations) OVER ( PARTITION by d.location ORDER BY d.location,d.date) AS Rolling_People_Vaccinated FROM coviddeaths_proj AS d
#JOIN covidvaccinations_proj AS v 
#ON d.location = v.location and d.date = v.date
#ORDER BY continent,location,date