SELECT CONVERT(DATE,Tarih) AS Tarih 
INTO #days14_16
FROM days14_16 

--SELECT * FROM ozel_gunler WHERE ozel_gun_adi LIKE 'Veremle%'

SELECT 
	ozel_gun_adi, 
	TRY_CONVERT(DATE,baslangic_tarihi_2014, 104) AS start14, 
	TRY_CONVERT(DATE,bitis_tarihi_2014, 104) AS finish14,
	TRY_CONVERT(DATE,baslangic_tarihi_2015, 104) AS start15, 
	TRY_CONVERT(DATE,bitis_tarihi_2015, 104) AS finish15,
	TRY_CONVERT(DATE,baslangic_tarihi_2016, 104) AS start16,
	TRY_CONVERT(DATE,bitis_tarihi_2016, 104) AS finish16,
	aciklama, 
	ozel_gun_tipi 
INTO #tmpOzel_gunler
FROM ozel_gunler
WHERE TRY_CONVERT(DATE,baslangic_tarihi_2015, 104) IS NOT NULL

--SELECT * FROM #tmpOzel_gunler 
--WHERE start14 > finish14 OR start15 > finish15 OR start16 > finish16

DELETE FROM #tmpOzel_gunler 
WHERE start14 > finish14 OR start15 > finish15 OR start16 > finish16


SELECT 
	--COALESCE(OG.ozel_gun_adi,OG2.ozel_gun_adi,OG3.ozel_gun_adi),
	 *
INTO #tmpSubTable
FROM #days14_16 D 
LEFT JOIN #tmpOzel_gunler OG 
	ON (OG.start14 >= D.Tarih AND OG.finish14 <= D.Tarih) 
		OR (OG.start15 >= D.Tarih AND OG.finish15 <= D.Tarih) 
		OR (OG.start16 >= D.Tarih AND OG.finish16 <= D.Tarih)
--LEFT JOIN #tmpOzel_gunler OG2 ON OG2.start15 >= D.Tarih AND OG2.finish15 <= D.Tarih
--LEFT JOIN #tmpOzel_gunler OG3 ON OG3.start16 >= D.Tarih AND OG3.finish16 <= D.Tarih
--GROUP BY Tarih


------------ Aynı Günde iki özel gün gelirse kaybediliyor. Özel Gün tipinin göre sıraladım ama onlara bir rank verilebilir önem derecesine göre
SELECT 
	Tarih,
	(SELECT TOP 1 ozel_gun_adi FROM #tmpSubTable WHERE Tarih = ST.Tarih ORDER BY ozel_gun_tipi) AS OzelGun,
	(SELECT TOP 1 ozel_gun_tipi FROM #tmpSubTable WHERE Tarih = ST.Tarih ORDER BY ozel_gun_tipi) AS OzelGunTipi,
	COUNT(*) AS OzelGunSayisi
INTO #tmpSub2
FROM #tmpSubTable ST
GROUP BY ST.Tarih

--SELECT  * 
--FROM hava_durumu
--WHERE ISTASYON_ADI LIKE 'ISTANBUL%' 
--	AND (Weather_Bureau_AF_Navy <> '?'
--	OR Deniz_Seviyesi_Basinci <> '?'
--	OR Istasyon_Basinci <> '?')

SELECT  
	CONVERT(DATE,Tarih,104) AS Tarih,
	CASE sicaklik WHEN '?' THEN NULL ELSE Sicaklik END AS sicaklik
	,CASE Ciy_Dusme_Derecesi WHEN '?' THEN NULL ELSE Ciy_Dusme_Derecesi END AS Ciy_Dusme_Derecesi
	,CASE Gorus_Mesafesi WHEN '?' THEN NULL ELSE Gorus_Mesafesi END AS Gorus_Mesafesi 
	,CASE Ruzgar_Hizi WHEN '?' THEN NULL ELSE Ruzgar_Hizi END AS Ruzgar_Hizi
	,CASE Max_Ruzgar_Hizi WHEN '?' THEN NULL ELSE Max_Ruzgar_Hizi END AS Max_Ruzgar_Hizi
	,CASE Max_Tayfun_Hizi WHEN '?' THEN NULL ELSE Max_Tayfun_Hizi END AS Max_Tayfun_Hizi
	,CASE Sicaklik_Max WHEN '?' THEN NULL ELSE Sicaklik_Max END AS Sicaklik_Max
	,CASE Sicaklik_Min WHEN '?' THEN NULL ELSE Sicaklik_Min END AS Sicaklik_Min
	,CASE Yagis_Miktari WHEN '?' THEN NULL ELSE Yagis_Miktari END AS Yagis_Miktari
	,CASE Kar_Boyu WHEN '?' THEN NULL ELSE Kar_Boyu END AS Kar_Boyu
	,CASE Sis_Yag_Kar_Dolu_Simsek_Hortum WHEN '?' THEN NULL ELSE Sis_Yag_Kar_Dolu_Simsek_Hortum END AS Sis_Yag_Kar_Dolu_Simsek_Hortum
	,CASE hava_durumu WHEN '?' THEN NULL ELSE hava_durumu END AS hava_durumu
	,CASE sicaklik_sinifi WHEN '?' THEN NULL ELSE sicaklik_sinifi END AS sicaklik_sinifi
	,CASE sis WHEN '?' THEN NULL ELSE sis END AS sis
	,CASE yagmur WHEN '?' THEN NULL ELSE yagmur END AS yagmur
	,CASE kar WHEN '?' THEN NULL ELSE kar END AS kar
	,CASE dolu WHEN '?' THEN NULL ELSE dolu END AS dolu
	,CASE simsek WHEN '?' THEN NULL ELSE simsek END AS simsek
	,CASE hortum WHEN '?' THEN NULL ELSE hortum END AS hortum
	,CASE ilce_mi WHEN '?' THEN NULL ELSE ilce_mi END AS ilce_mi
INTO #tmpHavaDurumu
FROM hava_durumu
WHERE ISTASYON_ADI LIKE 'ISTANBUL%' 

--SELECT ISTASYON_ADI FROM hava_durumu WHERE City_Code = '34'
--GROUP BY ISTASYON_ADI

----- 4 istasyon var istanbulda Atatürk dışındakier de kullanılabilir

--select * FROM #tmpSub2
--ORDER BY Tarih

--SELECT S.Tarih, COUNT(*) FROM #tmpSub2 S
--LEFT JOIN #tmpHavaDurumu HD ON HD.Tarih = S.Tarih 
--GROUP BY S.Tarih
--HAVING COUNT(*) > 1

-----'2016-02-08'

--SELECT * FROM #tmpSub2 S
----LEFT JOIN #tmpHavaDurumu HD ON HD.Tarih = S.Tarih 
--WHERE S.Tarih = '2016-02-08'

--SELECT * FROM #tmpHavaDurumu S
----LEFT JOIN #tmpHavaDurumu HD ON HD.Tarih = S.Tarih 
--WHERE S.Tarih = '2016-02-08'

--SELECT * FROM #tmpHavaDurumu
--ORDER BY Tarih

SELECT S.Tarih, 
	S.OzelGun, 
	S.OzelGunTipi, 
	CASE WHEN OzelGun IS NULL THEN 0 ELSE S.OzelGunSayisi END AS OzelGunSayisi,
	HD.sicaklik,
	HD.Ciy_Dusme_Derecesi,
	HD.Gorus_Mesafesi,
	HD.Ruzgar_Hizi,
	HD.Max_Ruzgar_Hizi,
	HD.Max_Tayfun_Hizi,
	HD.Sicaklik_Max,
	HD.Sicaklik_Min,
	HD.Yagis_Miktari,
	HD.Kar_Boyu,
	HD.Sis_Yag_Kar_Dolu_Simsek_Hortum,
	HD.hava_durumu,
	HD.sicaklik_sinifi,
	HD.sis,
	HD.yagmur,
	HD.kar,
	HD.dolu,
	HD.simsek,
	HD.hortum,
	HD.ilce_mi
INTO #tmpSub3
FROM #tmpSub2 S
LEFT JOIN #tmpHavaDurumu HD ON HD.Tarih = S.Tarih
ORDER BY S.Tarih

----Ogün için iki veri var
--SELECT * FROM #tmpSub3 
--WHERE Tarih = '2016-02-08' AND sicaklik = '5,06'

DELETE FROM #tmpSub3
WHERE Tarih = '2016-02-08' AND sicaklik = '5,06'

-- Bugün için veri yok hava durumunda
--SELECT * FROM #tmpHavaDurumu
--WHERE Tarih = '2016-11-11'

SELECT * FROM #tmpSub3
ORDER BY Tarih

DROP TABLE #tmpSub3
DROP TABLE #tmpSub2
DROP TABLE #tmpHavaDurumu
DROP TABLE #tmpSubTable
DROP TABLE #tmpOzel_gunler
DROP TABLE #days14_16