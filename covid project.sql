SELECT *
FROM PortfolioProject..[CovidDeaths$]
WHERE continent is not null
ORDER BY 3,4

--Select data that we are going to use

SELECT location,date,total_cases,new_cases,total_deaths,population
FROM PortfolioProject..[CovidDeaths$]
WHERE continent is not null
ORDER BY 1,2

--looking at total cases vs total deaths
SELECT location,date,total_cases,total_deaths,(total_deaths/total_cases)*100 as death_percent
FROM PortfolioProject..[CovidDeaths$]
WHERE continent is not null
ORDER BY 1,2

--looking at total cases vs population
--it shows what percentage of population got covid of particular state

SELECT location,date,total_cases,population,(total_cases/population)*100 as affected_percent
FROM PortfolioProject..[CovidDeaths$]
WHERE continent is not null
WHERE location like '%Afghanistan%'
ORDER BY 1,2

--looking at countries with highest infection rate vs population

SELECT location,population,MAX(total_cases) as HighestInfectionCount,MAX(total_cases/population)*100 as PercentagePopulationInfected
FROM PortfolioProject..[CovidDeaths$]
WHERE continent is not null
--WHERE location like '%Afghanistan%'
GROUP BY location,population
ORDER BY PercentagePopulationInfected desc

--looking at countries with highest death count vs population

SELECT location,MAX(cast(total_deaths as int)) as HighestDeathCount,MAX(total_deaths/population)*100 as deathpercentage --see at 31 mins
FROM PortfolioProject..[CovidDeaths$]
WHERE continent is not null
--WHERE location like '%Afghanistan%'
GROUP BY location
ORDER BY HighestDeathCount desc

--breaking down by continent

SELECT continent, MAX(cast(total_deaths as int)) as HighestDeathCount
FROM PortfolioProject..[CovidDeaths$]
WHERE continent is not null
GROUP BY continent
ORDER BY HighestDeathCount desc

--TOTAL CASES ON EACH DAY IRRESPECTIVE OF ANY LOCATION,CONTINENT

SELECT date,SUM(new_cases) as total_cases,SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases) * 100 as death_percentage
FROM PortfolioProject..[CovidDeaths$]
WHERE continent is not null
GROUP BY date
ORDER BY 1,2

--Total cases around the world

SELECT SUM(new_cases) as total_cases,SUM(cast(new_deaths as int)) as total_deaths,SUM(cast(new_deaths as int))/SUM(new_cases) * 100 as death_percentage
FROM PortfolioProject..[CovidDeaths$]
WHERE continent is not null
ORDER BY 1,2

--JOINING DEATH AND VACCINATION DATA

SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
FROM PortfolioProject..[CovidDeaths$] dea
JOIN PortfolioProject..CovidVaccinations$ vac
     ON dea.location = vac.location
	 and dea.date = vac.date
WHERE dea.continent is not null
--ORDER BY 3,4

--LOOKING AT TOTAL POPULATION VS VACCINATION

SELECT dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations,SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.location ORDER BY dea.location,dea.date) as RollingPeopleVaccinated--(RollingPeopleVaccinated/population)*100 as H
FROM PortfolioProject..[CovidDeaths$] dea
JOIN PortfolioProject..CovidVaccinations$ vac
    ON dea.location = vac.location
	and dea.date = vac.date
WHERE dea.continent is not null
ORDER BY 2,3


--SELECT *
--FROM PortfolioProject..CovidVaccinations$
--WHERE continent is not null
--ORDER BY 3,4




--




