
-- Covid cases and deaths worldwide

Select *
From "covid-deaths"
order by 3,4;


-- Covid vaccinations worldwide

Select *
From "covid-vaccinations"
order by 3,4;


-- Total cases vs total deaths UK

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as "% of cases fatal"
From "covid-deaths"
WHERE location = 'United Kingdom'
order by 1,2;


-- Total cases vs population UK
-- Note: This calculation does not consider the possibility of 'total_cases' including the same person contracting COVID-19 more than once, thus resulting in an exaggerated percentage.

Select location, date, total_cases, population, (total_cases/population)*100 as "% of population infected"
From "covid-deaths"
Where location = 'United Kingdom'
order by 2;


-- Countries with highest infection rate compared to population
-- Note: This calculation does not consider the possibility of 'total_cases' including the same person contracting COVID-19 more than once, thus resulting in an exaggerated percentage.

Select location, population, Max(total_cases) as latest_total_cases, 100*Max(total_cases)/population as "% of population infected"
From "covid-deaths"
WHERE continent is not null
Group by location, population
order by 4 desc;


-- Countries with highest death count compared to population

Select location, population, Max(total_deaths) as latest_total_deaths, 100*Max(total_deaths)/population as "% of population dead due to covid"
From "covid-deaths"
WHERE continent is not null
Group by location, population
order by 4 desc;


-- Death count by continent

Select location, MAX(total_deaths) as latest_total_deaths
From "covid-deaths"
WHERE location IN ('Africa','Asia','Europe','North America','South America','Australia')
Group by location
order by 2 desc;


-- Global % of population infected
-- Note: This calculation does not consider the possibility of 'total_cases' including the same person contracting COVID-19 more than once, thus resulting in an exaggerated percentage.

Select location, MAX(total_cases) as total_cases, MAX(population) as population, 100*MAX(total_cases)/Max(population) as "% of population infected"
From "covid-deaths"
WHERE location = 'World'
Group by location;


-- Global % of population dead
-- Note: This calculation does not consider the possibility of 'total_cases' including the same person contracting COVID-19 more than once, thus resulting in an exaggerated percentage.

Select location, MAX(total_deaths) as total_deaths, MIN(population) as original_population, 100*MAX(total_deaths)/MIN(population) as "% of population dead due to covid"
From "covid-deaths"
WHERE location = 'World'
Group by location;


-- Rolling total vaccinations by country

Select dths.continent, dths.location, dths.date, dths.population, vccs.new_vaccinations,
SUM(vccs.new_vaccinations) OVER (Partition by vccs.location order by vccs.location, vccs.date) as rolling_total_vaccinated
From "covid-deaths" dths Join "covid-vaccinations" vccs
	On dths.location = vccs.location
	and dths.date = vccs.date
WHERE dths.continent is not null
order by 2,3;


-- Using CTE to calculate percent of country's population vaccinated over time

With PopVsVacCTE (continent, location, date, population, new_vaccinations, rolling_total_vaccinated)
as
(
Select dths.continent, dths.location, dths.date, dths.population, vccs.new_vaccinations,
SUM(vccs.new_vaccinations) OVER (Partition by vccs.location order by vccs.location, vccs.date) as rolling_total_vaccinated
From "covid-deaths" dths Join "covid-vaccinations" vccs
	On dths.location = vccs.location
	and dths.date = vccs.date
WHERE dths.continent is not null
)
Select *,(rolling_total_vaccinated/population)*100 as "% of country's population vaccinated" from PopVsVacCTE;


-- Using temporary table to calculate percent of country's population vaccinated over time

Drop Table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(50),
Location nvarchar(50),
Date datetime,
Population float,
New_vaccinations float,
RollingPeopleVaccinated float
);

Insert into #PercentPopulationVaccinated
Select dths.continent, dths.location, dths.date, dths.population, vccs.new_vaccinations,
SUM(vccs.new_vaccinations) OVER (Partition by vccs.location order by vccs.location, vccs.date) as rolling_total_vaccinated
From "covid-deaths" dths Join "covid-vaccinations" vccs
	On dths.location = vccs.location
	and dths.date = vccs.date
WHERE dths.continent is not null;


-- Creating view to store data for visualisations

Create View PercentPopulationVaccinated as 
Select dths.continent, dths.location, dths.date, dths.population, vccs.new_vaccinations,
SUM(vccs.new_vaccinations) OVER (Partition by vccs.Location Order by vccs.location, vccs.Date) as RollingPeopleVaccinated
From "covid-deaths" dths
Join "covid-vaccinations" vccs
	On dths.location = vccs.location
	and dths.date = vccs.date
where dths.continent is not null 