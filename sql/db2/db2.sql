------------------- Creating database links

CREATE DATABASE LINK lien_DB2_DB1 CONNECT TO admin1 IDENTIFIED BY oracle using 'DB1';

-- Testing the link
-- select * from  Client_1@lien_DB2_DB1;

-------------------


------------------- Creating a constraint for Compte_2 shard and its primary key

ALTER TABLE Compte_2 ADD CONSTRAINT PK_Compte_2 PRIMARY KEY(No);

-------------------


------------------- Creating a foreign key constraint for Compte_2 shard (DB2 Side)

Create or replace trigger FK_Agence_NO_Compte_2_Agence
Before Insert Or Update of Agence_No ON Compte_2
For each row
Declare
X Number :=0;
Begin
Select COUNT(*) into X from Agence@lien_DB2_DB1 where No=:New.Agence_No;
If X=0 then RAISE_APPLICATION_ERROR(-20200, 'Opération interdite : agence inconnue');
End if;

End;
/

-------------------