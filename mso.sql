CREATE DATABASE  IF NOT EXISTS `arma` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `arma`;

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS landvehicles;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE landvehicles (
  id int(11) NOT NULL,
  mid int(11) DEFAULT NULL,
  intid int(11) DEFAULT NULL,
  obj varchar(255) DEFAULT '',
  pos varchar(255) DEFAULT 'Null',
  dir varchar(255) DEFAULT 'Null',
  up varchar(255) DEFAULT 'Null',
  dam float DEFAULT '0',
  fue float DEFAULT '1',
  lkd varchar(5) DEFAULT 'false',
  wcar varchar(1000) DEFAULT '',
  eng varchar(5) DEFAULT 'false',
  PRIMARY KEY (id),
  KEY mid (mid)
);
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS players;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE players (
  id int(11) NOT NULL,
  na varchar(255) NOT NULL DEFAULT '',
  pid int(11) NOT NULL,
  sc int(11) DEFAULT '0',
  pos varchar(255) DEFAULT NULL,
  wea varchar(1000) DEFAULT '',
  mag varchar(1000) DEFAULT '',
  mid int(11) DEFAULT NULL,
  dam float DEFAULT '0',
  dhe float DEFAULT '0',
  dbo float DEFAULT '0',
  dha float DEFAULT '0',
  dle float DEFAULT '0',
  dir float DEFAULT '0',
  sta varchar(10) DEFAULT 'Stand',
  sid varchar(10) DEFAULT NULL,
  veh varchar(255) DEFAULT '',
  sea varchar(10) DEFAULT '',
  awb varchar(1000) DEFAULT '',
  aw varchar(1000) DEFAULT '',
  arm varchar(1000) DEFAULT '',
  typ varchar(45) DEFAULT '',
  rat int(11) DEFAULT '0',
  vd int(11) DEFAULT '1600',
  td int(11) DEFAULT '2',
  ran varchar(45) DEFAULT '',
  fir int(11) DEFAULT '0',
  ek int(11) DEFAULT '0',
  ck int(11) DEFAULT '0',
  lif varchar(45) DEFAULT 'ALIVE',
  PRIMARY KEY (id),
  KEY missionid (mid),
  KEY puid (pid),
  KEY pname (na)
);
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS cms_permissions;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE cms_permissions (
  id int(11) NOT NULL,
  username varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  permissionType varchar(255) DEFAULT 'users',
  PRIMARY KEY (id)
);
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS missions;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE missions (
  id int(11) NOT NULL,
  na varchar(255) NOT NULL DEFAULT '',
  td int(1) DEFAULT '1',
  da varchar(255) DEFAULT '2011|6|7|6|01',
  sc int(1) DEFAULT '1',
  gsc int(1) DEFAULT '1',
  log int(1) DEFAULT '1',
  wea int(1) DEFAULT '1',
  ace int(1) DEFAULT '1',
  lv int(1) DEFAULT '0',
  man int(1) DEFAULT '0',
  air int(1) DEFAULT '0',
  shi int(1) DEFAULT '0',
  bui int(1) DEFAULT '0',
  mar int(1) DEFAULT '0',
  ban int(1) DEFAULT '0',
  PRIMARY KEY (id),
  KEY missionName (na)
);
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 DROP PROCEDURE IF EXISTS CountLandVehicleIDsByMission */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE CountLandVehicleIDsByMission(IN tmid INTEGER(11))
BEGIN
  SELECT COUNT(*) FROM landvehicles WHERE mid=tmid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS GetGlobalEnemyKillsByPlayer */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE GetGlobalEnemyKillsByPlayer(IN tpid INTEGER(11))
BEGIN
  SELECT ek FROM players WHERE pid=tpid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS GetGlobalScoreByPlayer */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE GetGlobalScoreByPlayer(IN tpid INTEGER(11))
BEGIN
  SELECT sc FROM players WHERE pid=tpid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS GetLandVehicleByInitid */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE GetLandVehicleByInitid(IN tintid INTEGER(11), IN tmid INTEGER(11))
BEGIN
  SELECT id,obj,pos,dir,up,dam,fue,lkd,wcar,eng FROM landvehicles WHERE intid = tintid AND mid = tmid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS GetMissionByName */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE GetMissionByName(IN tna VARCHAR(255))
BEGIN
  SELECT * FROM missions WHERE na=tna;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS GetPlayer */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE GetPlayer(IN tmid INTEGER(11), IN tpid INTEGER(11))
BEGIN
  SELECT id,na,pid,sc,pos,mid,dam,dhe,dbo,dha,dle,dir,sta,sid,veh,sea,typ,rat,vd,td,ran,fir,ek,ck,lif FROM players WHERE mid=tmid AND pid=tpid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS GetPlayerACE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE GetPlayerACE(IN tmid INTEGER(11), IN tpid INTEGER(11))
BEGIN
  SELECT awb,aw,arm FROM players WHERE mid=tmid AND pid=tpid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS GetPlayerWeapons */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE GetPlayerWeapons(IN tmid INTEGER(11), IN tpid INTEGER(11))
BEGIN
  SELECT wea,mag FROM players WHERE mid=tmid AND pid=tpid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS InsertLandVehicles */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE InsertLandVehicles(IN tobj VARCHAR(255), IN tpos VARCHAR(255), IN tdir VARCHAR(255), IN tup VARCHAR(255), IN tdam INTEGER(1), IN tfue INTEGER(1), IN tlkd VARCHAR(5), IN twcar VARCHAR(1000), IN teng VARCHAR(5), IN tmid INTEGER(11), IN tintid INTEGER(11))
BEGIN
  INSERT INTO landvehicles (obj,pos,dir,up,dam,fue,lkd,wcar,eng,mid,intid) values (tobj,tpos,tdir,tup,tdam,tfue,tlkd,twcar,teng,tmid,tintid);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS InsertPlayer */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE InsertPlayer(IN tpid INTEGER(11), IN tna VARCHAR(255), IN tmid INTEGER(11), IN tsid VARCHAR(10), IN tpos VARCHAR(255))
BEGIN
  INSERT INTO players (na,pid,mid,sid,pos) values (tna,tpid,tmid,tsid,tpos);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS NewMission */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE NewMission(IN tna VARCHAR(255))
BEGIN
  INSERT INTO missions (na) values (tna);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS RemoveLandVehicles */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE RemoveLandVehicles(IN tmid INTEGER(11))
BEGIN
  DELETE FROM landvehicles WHERE mid = tmid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS UpdateDate */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE UpdateDate(IN tda VARCHAR(255), IN tmid INTEGER(11))
BEGIN
  UPDATE missions SET da = tda WHERE id = tmid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS UpdatePlayer */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE UpdatePlayer(IN tsc INTEGER(11), IN tpos VARCHAR(255), IN tdam FLOAT, IN tdhe FLOAT, IN tdbo FLOAT, IN tdha FLOAT, IN tdle FLOAT, IN tdir FLOAT, IN tsta VARCHAR(10), IN tsid VARCHAR(10), IN tveh VARCHAR(255), IN tsea VARCHAR(10), IN ttyp VARCHAR(45), IN trat INT(11), IN tvd INT(11), IN ttd INT(11), IN tran VARCHAR(45), IN tfir INT(11), IN tek INT(11), IN tck INT(11), IN tlif VARCHAR(45), IN tpid INTEGER(11), IN tna VARCHAR(255), IN tmid INTEGER(11))
BEGIN
  UPDATE players SET sc = tsc, pos = tpos, dam = tdam, dhe = tdhe, dbo = tdbo, dha = tdha, dle = tdle, dir = tdir, sta = tsta, sid = tsid, veh = tveh, sea = tsea, typ = ttyp, rat = trat, vd = tvd, td = ttd, ran = tran, fir = tfir, ek = tek, ck = tck, lif = tlif WHERE pid = tpid AND na = tna AND mid = tmid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS UpdatePlayerACE */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE UpdatePlayerACE(IN tawb VARCHAR(1000), IN taw VARCHAR(1000), IN tarm VARCHAR(1000), IN tpid INTEGER(11), IN tna VARCHAR(255), IN tmid INTEGER(11))
BEGIN
  UPDATE players SET awb = tawb, aw = taw, arm = tarm WHERE pid = tpid AND na = tna AND mid = tmid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS UpdatePlayerWeapons */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50020 DEFINER=arma@localhost*/ /*!50003 PROCEDURE UpdatePlayerWeapons(IN twea VARCHAR(1000), IN tmag VARCHAR(1000), IN tpid INTEGER(11), IN tna VARCHAR(255), IN tmid INTEGER(11))
BEGIN
  UPDATE players SET wea = twea, mag = tmag WHERE pid = tpid AND na = tna AND mid = tmid;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

