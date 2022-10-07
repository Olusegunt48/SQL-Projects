SELECT * 
FROM project.covidvaccinations_csv
order by 3,4

SELECT * 
FROM project.coviddeaths_csv
order by 3,4

select location, date, total_cases, new_cases, total_deaths, population
FROM project.coviddeaths_csv
order by 1,2

-- Total cases vs total deaths
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM project.coviddeaths_csv
-- where location like '%states%'
order by 1,2

-- Countries with the highest death count
select location, max(total_deaths) as TotalDeathCount
FROM project.coviddeaths_csv
-- where location like '%states%'
group by location
order by TotalDeathCount