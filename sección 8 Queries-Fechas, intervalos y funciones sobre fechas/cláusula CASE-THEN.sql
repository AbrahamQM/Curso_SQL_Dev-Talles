--Trabajadores que llevan menos de un año en la empresa
SELECT
	first_name,
	last_name,
	hire_date,
	CASE
		WHEN hire_date > now() - INTERVAL '1 year' 	THEN 'Rango A (<1 año)'
		WHEN hire_date > now() - INTERVAL '3 year' 	THEN 'Rango B (1-3 años)'
		WHEN hire_date > now() - INTERVAL '6 year' 	THEN 'Rango C (3-6 años)'
		ELSE 'Rango D (> 6 años)'
	END AS Rango_antoguedad
FROM
	employees
ORDER BY hire_date DESC ;
--first_name |last_name  |hire_date |rango_antoguedad  |
-------------+-----------+----------+------------------+
--Charles    |Johnson    |2024-01-04|Rango A (<1 año)  |
--Luis       |Popp       |2023-12-07|Rango A (<1 año)  |
--Karen      |Colmenares |2023-08-10|Rango A (<1 año)  |
--Kimberely  |Grant      |2023-05-24|Rango A (<1 año)  |
--Diana      |Lorentz    |2023-02-07|Rango A (<1 año)  |
--Guy        |Himuro     |2022-11-15|Rango B (1-3 años)|
--Irene      |Mikkilineni|2022-09-28|Rango B (1-3 años)|
--Jack       |Livingston |2022-04-23|Rango B (1-3 años)|
--Jonathon   |Taylor     |2022-03-24|Rango B (1-3 años)|
--Jose Manuel|Urman      |2022-03-07|Rango B (1-3 años)|
--Valli      |Pataballa  |2022-02-05|Rango B (1-3 años)|
--Shelli     |Baida      |2021-12-24|Rango B (1-3 años)|
--Shanta     |Vollman    |2021-10-10|Rango B (1-3 años)|
--Ismael     |Sciarra    |2021-09-30|Rango B (1-3 años)|
--John       |Chen       |2021-09-28|Rango B (1-3 años)|
--Pat        |Fay        |2021-08-17|Rango B (1-3 años)|
--Sigal      |Tobias     |2021-07-24|Rango B (1-3 años)|
--David      |Austin     |2021-06-25|Rango B (1-3 años)|
--Adam       |Fripp      |2021-04-10|Rango B (1-3 años)|
--Britney    |Everett    |2021-03-03|Rango B (1-3 años)|
--Karen      |Partners   |2021-01-05|Rango C (3-6 años)|
--John       |Russell    |2020-10-01|Rango C (3-6 años)|
--Matthew    |Weiss      |2020-07-18|Rango C (3-6 años)|
--Michael    |Hartstein  |2020-02-17|Rango C (3-6 años)|
--Sarah      |Bell       |2020-02-04|Rango C (3-6 años)|
--Alexander  |Khoo       |2019-05-18|Rango C (3-6 años)|
--Payam      |Kaufling   |2019-05-01|Rango C (3-6 años)|
--Den        |Raphaely   |2018-12-07|Rango C (3-6 años)|
--Nancy      |Greenberg  |2018-08-17|Rango C (3-6 años)|
--Daniel     |Faviet     |2018-08-16|Rango C (3-6 años)|
--William    |Gietz      |2018-06-07|Rango C (3-6 años)|
--Susan      |Mavris     |2018-06-07|Rango C (3-6 años)|
--Hermann    |Baer       |2018-06-07|Rango C (3-6 años)|
--Shelley    |Higgins    |2018-06-07|Rango C (3-6 años)|
--Lex        |De Haan    |2017-01-13|Rango D (> 6 años)|
--Bruce      |Ernst      |2015-05-21|Rango D (> 6 años)|
--Alexander  |Hunold     |2014-01-03|Rango D (> 6 años)|
--Neena      |Kochhar    |2013-09-21|Rango D (> 6 años)|
--Jennifer   |Whalen     |2011-09-17|Rango D (> 6 años)|
--Steven     |King       |2011-06-17|Rango D (> 6 años)|
