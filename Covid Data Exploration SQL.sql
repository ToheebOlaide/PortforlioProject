select *
from portfolioproject..coviddeath

--  and (same)

select *
from coviddeath

--select data that we are going to be using

select location, date, total_cases, new_cases, total_deaths,population
from portfolioproject..coviddeath

select location, date, total_cases, new_cases, total_deaths,population
from portfolioproject..coviddeath
order by 1,2

--looking at total_cases vs total_deaths


select location, date, total_cases, total_deaths
from portfolioproject..coviddeath
order  by 1,2


select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage
from portfolioproject..coviddeath
order  by 1,2

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage
from portfolioproject..coviddeath
where location like 'nigeria%'
order  by 1,2

--looking at total cases vs population
--show percentage of population with covid

select location, date, population, total_cases,  (total_cases/population)*100 as gottenpercentage
from portfolioproject..coviddeath
where location like '%nigeria%'
order  by 1,2

select location, date, population, total_cases,  (total_cases/population)*100 as gottenpercentage
from portfolioproject..coviddeath
--where location like '%state%'
order  by 1,2

--looking at country with highest infection rate compared to population

select location, population, max(total_cases) as highestinfectioncount,  max(total_cases/population)*100 as gottenpercentage
from portfolioproject..coviddeath
--where location like '%state%'
group by location, population
order  by 1,2

select location, population, max(total_cases) as highestinfectioncount,  max(total_cases/population)*100 as gottenpercentage
from portfolioproject..coviddeath
--where location like '%state%'
group by location, population
order  by gottenpercentage desc

--showing countries with highest death count per population

select location, population, max(cast(total_deaths as int)) as totaldeathscount
from portfolioproject..coviddeath
--where location like '%state%'
group by location, population
order  by totaldeathscount desc
--(same)
select location, population, max(total_deaths) as totaldeathscount
from portfolioproject..coviddeath
--where location like '%state%'
group by location, population
order  by totaldeathscount desc

select location, max(cast(total_deaths as int)) as totaldeathscount
from portfolioproject..coviddeath
--where location like '%state%'
where continent is not null
group by location
order  by totaldeathscount desc

--lets break things down by continent

select continent, max(cast(total_deaths as int)) as totaldeathscount
from portfolioproject..coviddeath
--where location like '%state%'
where continent is not null
group by continent
order  by totaldeathscount desc

select location, max(cast(total_deaths as int)) as totaldeathscount
from portfolioproject..coviddeath
--where location like '%state%'
where continent is null
group by location
order  by totaldeathscount desc


select continent, max(cast(total_deaths as int)) as totaldeathscount
from portfolioproject..coviddeath
--where location like '%state%'
where continent is not null
group by continent
order  by totaldeathscount desc

--showing the continent with highest death count per population

select continent, max(cast(total_deaths as int)) as totaldeathscount
from portfolioproject..coviddeath
--where location like '%state%'
where continent is not null
group by continent
order  by totaldeathscount desc

--global numbers

select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage
from portfolioproject..coviddeath
-- location like 'state%'
where continent is not null
order  by 1,2

select date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage
from portfolioproject..coviddeath
-- location like 'state%'
where continent is not null
order  by 1,2

select date, total_cases, total_deaths, (total_deaths/total_cases)*100 as deathpercentage
from portfolioproject..coviddeath
-- location like 'state%'
where continent is not null
group by date
order  by 1,2

--(use aggregate function)

select date, sum(new_cases), sum(new_deaths) 
from portfolioproject..coviddeath
-- location like 'state%'
where continent is not null
group by date
order  by 1,2

select date, sum(new_cases) as totalcases, sum(new_deaths) as totaldeaths, sum(new_deaths)/sum(new_cases)*100 as globalpercent
from portfolioproject..coviddeath
-- location like 'state%'
where continent is not null
group by date
order  by 1,2

--solving Divide by zero error encountered problem, use any of the following
SET ARITHABORT OFF;
SET ANSI_WARNINGS OFF;
SELECT 20 / 0;
--or
SET ARITHABORT OFF;
SET ANSI_WARNINGS OFF;

SET ARITHIGNORE ON;
SELECT 0 / 0 AS Result_1;

SET ARITHIGNORE OFF;
SELECT 2 / 1 AS Result_2;

select sum(new_cases) as totalcases, sum(new_deaths) as totaldeaths, sum(new_deaths)/sum(new_cases)*100 as globalpercent
from portfolioproject..coviddeath
-- location like 'state%'
where continent is not null
-- by date
order  by 1,2


select *
from portfolioproject..covidvaccination

--looking at total population vs vaccination

select *
from portfolioproject..coviddeath d
join portfolioproject..covidvaccination v
on d.location = v.location
and d.date = v.date

select d.continent, d.location, d.date, d.population, v.new_vaccinations
from portfolioproject..coviddeath d
join portfolioproject..covidvaccination v
on d.location = v.location
and d.date = v.date
order by 1,2

select d.continent, d.location, d.date, d.population, v.new_vaccinations
from portfolioproject..coviddeath d
join portfolioproject..covidvaccination v
on d.location = v.location
and d.date = v.date
where d.continent is not null
order by 1,2

--rolling

select d.continent, d.location, d.date, d.population, v.new_vaccinations
, sum(convert(int, new_vaccinations)) OVER(Partition by d.location)
from portfolioproject..coviddeath d
join portfolioproject..covidvaccination v
on d.location = v.location
and d.date = v.date
where d.continent is not null
order by 2,3
--or
select d.continent, d.location, d.date, d.population, v.new_vaccinations
, sum(cast(new_vaccinations as int)) OVER(Partition by d.location)
from portfolioproject..coviddeath d
join portfolioproject..covidvaccination v
on d.location = v.location
and d.date = v.date
where d.continent is not null
order by 2,

select d.continent, d.location, d.date, d.population, v.new_vaccinations
, sum(convert(int, new_vaccinations)) OVER(Partition by d.location order by d. location, d.date)
from portfolioproject..coviddeath d
join portfolioproject..covidvaccination v
on d.location = v.location
and d.date = v.date
where d.continent is not null
order by 2,3

select d.continent, d.location, d.date, d.population, v.new_vaccinations
, sum(convert(int, new_vaccinations)) OVER(Partition by d.location order by d. location, d.date) as rollingpeoplevaccinated
from portfolioproject..coviddeath d
join portfolioproject..covidvaccination v
on d.location = v.location
and d.date = v.date
where d.continent is not null
order by 2,3

select d.continent, d.location, d.date, d.population, v.new_vaccinations
, sum(convert(int, new_vaccinations)) OVER(Partition by d.location order by d. location, d.date) as rollingpeoplevaccinated
--, (rollingpeoplevaccinated/population)*100
from portfolioproject..coviddeath d
join portfolioproject..covidvaccination v
on d.location = v.location
and d.date = v.date
where d.continent is not null
order by 2,3
--you get an error bcos u cant use a new created column (rollingpeoplevaccinated), use CTE or Temp table

--using CTE

with PopvsVac (continent, location, date, population, new_vaccination, rollingpeoplevaccinated)
as
(
select d.continent, d.location, d.date, d.population, v.new_vaccinations
, sum(convert(int, new_vaccinations)) OVER(Partition by d.location order by d. location, d.date) as rollingpeoplevaccinated
--, (rollingpeoplevaccinated/population)*100
from portfolioproject..coviddeath d
join portfolioproject..covidvaccination v
on d.location = v.location
and d.date = v.date
where d.continent is not null
--order by 2,3
)
select *
from PopvsVac

with PopvsVac (continent, location, date, population, new_vaccination, rollingpeoplevaccinated)
as
(
select d.continent, d.location, d.date, d.population, v.new_vaccinations
, sum(convert(int, new_vaccinations)) OVER(Partition by d.location order by d. location, d.date) as rollingpeoplevaccinated
--, (rollingpeoplevaccinated/population)*100
from portfolioproject..coviddeath d
join portfolioproject..covidvaccination v
on d.location = v.location
and d.date = v.date
where d.continent is not null
--order by 2,3
)
select *, (rollingpeoplevaccinated/population)*100 as percentrollingpeoplevaccinated
from PopvsVac

with PopvsVac (continent, location, population, new_vaccination, rollingpeoplevaccinated)
as
(
select d.continent, d.location, d.population, v.new_vaccinations
, sum(convert(int, new_vaccinations)) OVER(Partition by d.location order by d. location) as rollingpeoplevaccinated
--, (rollingpeoplevaccinated/population)*100
from portfolioproject..coviddeath d
join portfolioproject..covidvaccination v
on d.location = v.location
where d.continent is not null
--order by 2,3
)
select *, (rollingpeoplevaccinated/population)*100 as percentrollingpeoplevaccinated
from PopvsVac

--using temp table

create table #percentpopulationvaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rollingpeoplevaccinated numeric
)

insert into #percentpopulationvaccinated
select d.continent, d.location, d.date, d.population, v.new_vaccinations
, sum(convert(int, new_vaccinations)) OVER(Partition by d.location order by d. location, d.date) as rollingpeoplevaccinated
--, (rollingpeoplevaccinated/population)*100
from portfolioproject..coviddeath d
join portfolioproject..covidvaccination v
on d.location = v.location
and d.date = v.date
where d.continent is not null
--order by 2,3
select *, (rollingpeoplevaccinated/population)*100 as percentrollingpeoplevaccinated
from #percentpopulationvaccinated

-- creating vie to store data for later visualization

create view Percentpopulationvaccinated as
select d.continent, d.location, d.population, v.new_vaccinations
, sum(convert(int, new_vaccinations)) OVER(Partition by d.location order by d. location) as rollingpeoplevaccinated
--, (rollingpeoplevaccinated/population)*100
from portfolioproject..coviddeath d
join portfolioproject..covidvaccination v
on d.location = v.location
where d.continent is not null
--order by 2,3

--once view is created it become permanent and can be used for visualization

select *
from Percentpopulationvaccinated