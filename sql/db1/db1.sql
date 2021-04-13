------------------- Sharding Client Table

-- DB2 Shard
COPY FROM admin1/oracle@DB1 TO admin2/oracle@DB2 CREATE Client_2 USING Select No, Nom, Prenom, Adresse FROM Client WHERE Ville='Rabat';

-- DB1 Shard
COPY FROM admin1/oracle@DB1 TO admin1/oracle@DB1 CREATE Client_1 USING Select No, Nom, Prenom, Adresse FROM Client WHERE Ville='Casablanca';

-- Alternative to DB1 Shard
-- CREATE TABLE Client_1 AS Select No, Nom, Prenom, Adresse FROM Client WHERE Ville='Casablanca';

---------------------------------------------------------


------------------- Sharding Compte Table

-- DB2 Shard
COPY FROM admin1/oracle@DB1 TO admin2/oracle@DB2 CREATE Compte_2 USING select  * from Compte Where Client_NO IN (select No from  Client Where Ville ='Rabat'); 

-- DB1 Shard
Create table Compte_1 As select  * from Compte Where Client_NO IN (select No from  Client Where Ville ='Casablanca');

---------------------------------------------------------


------------------- Sharding Operation Table

-- DB2 Shard
COPY FROM admin1/oracle@DB1 TO admin2/oracle@DB2 Create Operation_2 Using select * from Operation where  Compte_no IN (Select No from Compte where Client_NO IN (select No from  Client Where Ville ='Rabat'));

-- DB1 Shard
Create table Operation_1 As select * from Operation where  Compte_no IN (Select No from Compte where Client_NO IN (select No from  Client Where Ville ='Casablanca'));

---------------------------------------------------------


------------------- Sharding Type_Compte & Type_Operation Tables

COPY FROM admin1/oracle@DB1 TO admin2/oracle@DB2 Create Type_Compte_2 Using select * from Type_Compte;

COPY FROM admin1/oracle@DB1 TO admin2/oracle@DB2 Create Type_Operation_2 Using select * from Type_Operation;

---------------------------------------------------------


------------------- Creating database links

CREATE DATABASE LINK lien_DB1_DB2 CONNECT TO admin2 IDENTIFIED BY oracle using 'DB2';

-- Testing the link
-- select * from  Client_2@lien_DB1_DB2;

---------------------------------------------------------


------------------- Creating a foreign key constraint for Compte_2 shard (DB1 Side)

Create or replace trigger FK_NO_Agence_Compte_2
Before Delete OR Update of No ON Agence
For each row
Declare
X Number :=0;
Begin
Select COUNT(*) Into X from Compte_2@lien_DB1_DB2 Where Agence_No=:OLD.NO;

If X<>0 Then RAISE_APPLICATION_ERROR(-20100, 'Opération interdite : Agence référencée à partir de la table Compte_2 de la base DB2) ;
End IF ;
End;
/

---------------------------------------------------------