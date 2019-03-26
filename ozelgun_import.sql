CREATE TABLE ozel_gunler
(ozel_gun_adi NVARCHAR(250),
baslangic_tarihi_2014 NVARCHAR(250),
bitis_tarihi_2014 NVARCHAR(250),
baslangic_tarihi_2015 NVARCHAR(250),
bitis_tarihi_2015 NVARCHAR(250),
baslangic_tarihi_2016 NVARCHAR(250),
bitis_tarihi_2016 NVARCHAR(250),
aciklama NVARCHAR(250),
ozel_gun_tipi NVARCHAR(250)
)
GO

--ozel_gun_adi	baslangic_tarihi_2014	bitis_tarihi_2014	baslangic_tarihi_2015	bitis_tarihi_2015	baslangic_tarihi_2016	bitis_tarihi_2016	aciklama	ozel_gun_tipi

BULK
INSERT ozel_gunler
FROM 'C:\Users\ugurs\Python Workspace Laptop\Migros Workspace\GSU_MIGROS\ozel_gunler.txt'
WITH
(
FIRSTROW = 2,
CODEPAGE = '1254',
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '\n'
--DATAFILETYPE = 'widechar'
)
GO
--Check the content of the table.
--SELECT *
--FROM ozel_gunler
--GO

--DROP TABLE ozel_gunler

CREATE TABLE days14_16(
Tarih NVARCHAR(250)
)

BULK
INSERT days14_16
FROM 'C:\Users\ugurs\Python Workspace Laptop\Migros Workspace\GSU_MIGROS\days2014-2016.csv'
WITH
(
FIRSTROW = 2,
CODEPAGE = '1254',
FIELDTERMINATOR = ';',
ROWTERMINATOR = '\n'
--DATAFILETYPE = 'widechar'
)

--SELECT * FROM days14_16

--DROP TABLE days14_16

--ISTASYON_ADI	Istasyon_Numarasi	Weather_Bureau_AF_Navy	Tarih	Sicaklik	Ciy_Dusme_Derecesi	Deniz_Seviyesi_Basinci	Istasyon_Basinci	
--Gorus_Mesafesi	Ruzgar_Hizi	Max_Ruzgar_Hizi	Max_Tayfun_Hizi	Sicaklik_Max	Sicaklik_Min	Yagis_Miktari	Kar_Boyu	Sis_Yag_Kar_Dolu_Simsek_Hortum	
--City_Code	hava_durumu	sicaklik_sinifi	sis	yagmur	kar	dolu	simsek	hortum	ilce_mi


CREATE TABLE hava_durumu
(ISTASYON_ADI NVARCHAR(250),
Istasyon_Numarasi NVARCHAR(250),
Weather_Bureau_AF_Navy NVARCHAR(250),
Tarih NVARCHAR(250),
Sicaklik NVARCHAR(250),
Ciy_Dusme_Derecesi NVARCHAR(250),
Deniz_Seviyesi_Basinci NVARCHAR(250),
Istasyon_Basinci NVARCHAR(250),
Gorus_Mesafesi NVARCHAR(250),
Ruzgar_Hizi NVARCHAR(250),
Max_Ruzgar_Hizi NVARCHAR(250),
Max_Tayfun_Hizi NVARCHAR(250),
Sicaklik_Max NVARCHAR(250),
Sicaklik_Min NVARCHAR(250),
Yagis_Miktari NVARCHAR(250),
Kar_Boyu NVARCHAR(250),
Sis_Yag_Kar_Dolu_Simsek_Hortum NVARCHAR(250),
City_Code NVARCHAR(250),
hava_durumu NVARCHAR(250),
sicaklik_sinifi NVARCHAR(250),
sis NVARCHAR(250),
yagmur NVARCHAR(250),
kar NVARCHAR(250),
dolu NVARCHAR(250),
simsek NVARCHAR(250),
hortum NVARCHAR(250),
ilce_mi NVARCHAR(250)
)
GO

BULK
INSERT hava_durumu
FROM 'C:\Users\ugurs\Python Workspace Laptop\Migros Workspace\GSU_MIGROS\hava_durumu.txt'
WITH
(
FIRSTROW = 2,
CODEPAGE = '1254',
FIELDTERMINATOR = '\t',
ROWTERMINATOR = '\n'
--DATAFILETYPE = 'widechar'
)
GO

--DROP TABLE hava_durumu