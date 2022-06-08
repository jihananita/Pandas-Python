USE portfolio_db;
SELECT * FROM coviddeaths
WHERE continent is not null;
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM coviddeaths
ORDER BY 1,2;

-- Total Cases vs Total Deaths
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100
as deathprecentage
FROM coviddeaths
WHERE continent is not null
ORDER BY 1,2;

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100
as deathprecentage
FROM coviddeaths
WHERE location like '%Indonesia%'
ORDER BY 1,2;

-- Total Cases vs Population
SELECT location, date, total_cases, population, (total_cases/population)*100
as deathprecentage
FROM coviddeaths
WHERE location like '%Indonesia%'
ORDER BY 1,2;

-- Countries with Highest Infection Rate compared to Population
SELECT location, population, MAX(total_cases) as HighestInfectionCount, 
MAX((total_cases/population))*100
as PercentPopulationInfected
FROM coviddeaths
WHERE continent is not null
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;

-- Countries with Highest Death Count per Population
SELECT location, total_deaths, MAX(CAST(total_deaths as SIGNED))
as TotalDeathCount
FROM coviddeaths
WHERE continent is not null
GROUP BY location
ORDER BY TotalDeathCount DESC;

-- Break by Continent
-- Continent with HighestDeath Count per Population
SELECT continent, total_deaths, MAX(CAST(total_deaths as SIGNED))
as TotalDeathCount
FROM coviddeaths
WHERE continent is not null
GROUP BY continent
ORDER BY TotalDeathCount DESC;

-- GLOBAL NUMBER
SELECT date, SUM(new_cases)
FROM coviddeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2;

SELECT date, SUM(new_cases), MAX(CAST(new_deaths as SIGNED))
FROM coviddeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2;

SELECT date, SUM(new_cases) as total_cases, MAX(CAST(new_deaths as SIGNED)) as total_deaths, 
SUM(CAST(new_deaths as SIGNED))/SUM(NEW_CASES)*100 as DeathPrecentage
FROM coviddeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2;

SELECT SUM(new_cases) as total_cases, MAX(CAST(new_deaths as SIGNED)) as total_deaths, 
SUM(CAST(new_deaths as SIGNED))/SUM(NEW_CASES)*100 as DeathPrecentage
FROM coviddeaths
WHERE continent is not null
ORDER BY 1,2;

SELECT * FROM covidvaccination;

-- Total Population vs Vaccination

SELECT *
FROM coviddeaths dea
INNER JOIN covidvaccination vac
ON dea.location = vac.location
and dea.date = vac.date;

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccination
FROM coviddeaths dea
INNER JOIN covidvaccination vac
ON dea.location = vac.location
and dea.date = vac.date
ORDER BY 1,2,3;




