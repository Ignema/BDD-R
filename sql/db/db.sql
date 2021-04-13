------------------- Creating our distributed database

CREATE DATABASE LINK lien_DB_DB1 CONNECT TO admin1 IDENTIFIED BY oracle using 'DB1';

CREATE DATABASE LINK lien_DB_DB2 CONNECT TO admin2 IDENTIFIED BY oracle using 'DB2';

CREATE SYNONYM Agence FOR Agence@lien_DB_DB1;

CREATE VIEW Client (No, Nom, Prenom, Adresse, Ville) AS
Select No, Nom, Prenom, Adresse, 'Casablanca'
From Client_1@lien_DB_DB1
UNION
Select No, Nom, Prenom, Adresse, 'Rabat'
From Client_2@lien_DB_DB2;

-- Using the view
-- Select * from Client ;

---------------------------------------------------------


------------------- Handling Data Manipulation Operations

CREATE OR REPLACE TRIGGER MAJ_Client 
INSTEAD OF INSERT OR UPDATE OR DELETE  ON Client
FOR EACH ROW
BEGIN

IF INSERTING THEN
IF :NEW.Ville='Casablanca' THEN
      INSERT INTO Client_1@lien_DB_DB1
       VALUES(:NEW.No, :NEW.Nom, :NEW.Prenom, :NEW.Adresse);
ELSIF :NEW.Ville='Rabat' THEN
      INSERT INTO Client_2@lien_DB_DB2
       VALUES(:NEW.No, :NEW.Nom, :NEW.Prenom, :NEW.Adresse);
ELSE RAISE_APPLICATION_ERROR (-20189,'La Vielle ne peut être que Casablanca ou Rabat') ;
END IF ;
ELSIF DELETING THEN
Delete from Client_1@lien_DB_DB1 where No=:OLD.NO;
Delete from Client_2@lien_DB_DB2 where No=:OLD.NO;
ELSIF UPDATING THEN
UPDATE Client_1@lien_DB_DB1 
SET Nom=:NEW.Nom, Prenom=:NEW.Prenom, Adresse=:NEW.Adresse Where No=:OLD.No;
UPDATE Client_2@lien_DB_DB2 
SET Nom=:NEW.Nom, Prenom=:NEW.Prenom, Adresse=:NEW.Adresse Where No=:OLD.No;
END IF ;

END;
/

-- Testing Updates
-- Update Client set Nom='Tahiri' where NO=1;

---------------------------------------------------------
