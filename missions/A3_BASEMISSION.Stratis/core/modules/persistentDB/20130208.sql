-- phpMyAdmin SQL Dump
-- version 2.11.9.4
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jan 13, 2013 at 10:44 PM
-- Server version: 5.0.67
-- PHP Version: 5.2.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

--
-- Database: `arma`
--
CREATE DATABASE  IF NOT EXISTS `arma` /* DEFAULT CHARACTER SET latin1 */;

USE `arma`;

-- --------------------------------------------------------

--
-- Table structure for table `aar`
--

DROP TABLE IF EXISTS `aar`;
CREATE TABLE IF NOT EXISTS `aar` (
  `id` int(11) NOT NULL auto_increment,
  `mid` int(11) default NULL,
  `intid` int(11) default NULL,
  `sitrep` varchar(4096) default NULL,
  `typ` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `cms_permissions`
--

DROP TABLE IF EXISTS `cms_permissions`;
CREATE TABLE IF NOT EXISTS `cms_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `username` varchar(255) default NULL,
  `password` varchar(255) default NULL,
  `permissionType` varchar(255) default 'users',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
CREATE TABLE IF NOT EXISTS `group` (
  `id` int(11) NOT NULL,
  `name` varchar(45) default NULL,
  `test` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `kills`
--

DROP TABLE IF EXISTS `kills`;
CREATE TABLE IF NOT EXISTS `kills` (
  `id` int(11) NOT NULL auto_increment,
  `mid` int(11) NOT NULL,
  `pid` varchar(45) NOT NULL default '',
  `wea` varchar(45) default NULL,
  `dist` varchar(45) default NULL,
  `fac` varchar(45) default NULL,
  `kil` varchar(45) default NULL,
  `dea` varchar(10) default NULL,
  `pos` varchar(45) default NULL,
  `da` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `landvehicles`
--

DROP TABLE IF EXISTS `landvehicles`;
CREATE TABLE IF NOT EXISTS `landvehicles` (
  `id` int(11) NOT NULL auto_increment,
  `mid` int(11) default NULL,
  `intid` int(11) default NULL,
  `obj` varchar(255) default '',
  `typ` varchar(100) default '',
  `pos` varchar(255) default 'Null',
  `dir` varchar(255) default 'Null',
  `up` varchar(255) default 'Null',
  `dam` float NOT NULL default '0',
  `fue` float default '1',
  `lkd` varchar(5) default 'false',
  `wcar` varchar(4096) default '',
  `eng` varchar(5) default 'false',
  `wmag` varchar(4096) default '',
  PRIMARY KEY  (`id`),
  KEY `obj` (`obj`),
  KEY `mid` (`mid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(11) NOT NULL auto_increment,
  `mid` int(11) default NULL,
  `intid` int(11) default NULL,
  `obj` varchar(255) default '',
  `pos` varchar(255) default 'Null',
  `hpo` int(11) default '0',
  `cle` varchar(10) default 'false',
  `sus` varchar(10) default 'false',
  `grt` varchar(4096) default '',
  `grs` int(11) default '0',
  `typ` varchar(255) default '',
  `pa` varchar(45) default '',
  PRIMARY KEY  (`id`),
  KEY `mid` (`mid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='InnoDB free: 4096 kB' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `markers`
--

DROP TABLE IF EXISTS `markers`;
CREATE TABLE IF NOT EXISTS `markers` (
  `id` int(11) NOT NULL auto_increment,
  `mid` int(11) default NULL,
  `intid` int(11) default NULL,
  `nam` varchar(4096) default NULL,
  `pos` varchar(45) default NULL,
  `typ` varchar(45) default NULL,
  `txt` varchar(4096) default NULL,
  `side` varchar(45) default NULL,
  `col` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `missions`
--

DROP TABLE IF EXISTS `missions`;
CREATE TABLE IF NOT EXISTS `missions` (
  `id` int(11) NOT NULL auto_increment,
  `na` varchar(255) NOT NULL default '',
  `td` int(1) default '1',
  `da` varchar(255) default '',
  `sc` int(1) default '1',
  `gsc` int(1) default '1',
  `log` int(1) default '1',
  `wea` int(1) default '1',
  `ace` int(1) default '0',
  `lv` int(1) default '0',
  `obj` int(1) default '0',
  `loc` int(1) default '0',
  `obc` int(1) default '0',
  `mar` int(1) default '0',
  `tas` int(1) default '0',
  `aar` int(1) default '0',
  `mda` varchar(45) default '',
  `map` varchar(45) default '',
  `svr` varchar(255) default '',
  `addr` varchar(45) default NULL,
  `sloc` varchar(255) default NULL,
  `aim` int(1) default '1',
  PRIMARY KEY  (`id`),
  KEY `missionName` (`na`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `objects`
--

DROP TABLE IF EXISTS `objects`;
CREATE TABLE IF NOT EXISTS `objects` (
  `id` int(11) NOT NULL auto_increment,
  `mid` int(11) default NULL,
  `intid` int(11) default NULL,
  `obj` varchar(255) default '',
  `typ` varchar(100) default NULL,
  `pos` varchar(255) default 'Null',
  `dir` varchar(255) default 'Null',
  `up` varchar(255) default 'Null',
  `dam` float default '0',
  `wcar` varchar(4096) default '',
  `wmag` varchar(4096) default '',
  PRIMARY KEY  (`id`),
  KEY `mid` (`mid`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL auto_increment,
  `na` varchar(255) NOT NULL default '',
  `pid` varchar(45) NOT NULL default '',
  `sc` int(11) default '0',
  `pos` varchar(255) default NULL,
  `wea` varchar(4096) default '',
  `mag` varchar(4096) default '',
  `mid` int(11) default NULL,
  `dam` float default '0',
  `dhe` float default '0',
  `dbo` float default '0',
  `dha` float default '0',
  `dle` float default '0',
  `dir` float default '0',
  `sta` varchar(10) default 'Stand',
  `sid` varchar(10) default NULL,
  `veh` varchar(255) default '',
  `sea` varchar(10) default '',
  `awb` varchar(4096) default '',
  `arc` varchar(45) default '',
  `aw` varchar(4096) default '',
  `arm` varchar(4096) default '',
  `awo` varchar(4096) default '' COMMENT 'ACE Wounds',
  `typ` varchar(45) default '',
  `rat` int(11) default '0',
  `vd` int(11) default '1600',
  `td` int(11) default '2',
  `ran` varchar(45) default '',
  `fir` int(11) default '0',
  `ek` int(11) default '0',
  `ck` int(11) default '0',
  `fk` int(11) default '0',
  `sui` int(11) default '0',
  `lif` varchar(45) default 'ALIVE',
  `dea` int(11) default '0',
  `tp` int(11) default '0',
  `grp` varchar(45) default '',
  `rck` varchar(45) default '',
  `rwe` varchar(4096) default '',
  `rma` varchar(4096) default '',
  `lc` varchar(45) default '',
  `ld` varchar(45) default '',
  `aim` varchar(4096) default '[100|100|100]' COMMENT 'AIM Module',
  PRIMARY KEY  (`id`),
  KEY `missionid` (`mid`),
  KEY `puid` (`pid`),
  KEY `pname` (`na`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `tasks`
--

DROP TABLE IF EXISTS `tasks`;
CREATE TABLE IF NOT EXISTS `tasks` (
  `id` int(11) NOT NULL auto_increment,
  `mid` int(11) default NULL,
  `intid` int(11) default NULL,
  `nam` varchar(4096) default NULL,
  `des` varchar(4096) default NULL,
  `dest` varchar(45) default NULL,
  `sta` varchar(45) default NULL,
  `side` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL,
  `FirstName` varchar(45) default NULL,
  `Surname` varchar(45) default NULL,
  `Codename` varchar(45) default NULL,
  `Picture` blob,
  `email` varchar(45) default NULL,
  `dob` varchar(45) default NULL,
  `gender` varchar(45) default NULL,
  `height` varchar(45) default NULL,
  `weight` varchar(45) default NULL,
  `build` varchar(45) default NULL,
  `hair` varchar(45) default NULL,
  `eyes` varchar(45) default NULL,
  `race` varchar(45) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `CountAARIDsByMission`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `CountAARIDsByMission`(IN tmid INTEGER(11))
BEGIN
  SELECT COUNT(*) FROM AAR WHERE mid=tmid;
END$$

DROP PROCEDURE IF EXISTS `CountLandVehicleIDsByMission`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `CountLandVehicleIDsByMission`(IN tmid INTEGER(11))
BEGIN
  SELECT COUNT(*) FROM landvehicles WHERE mid=tmid;
END$$

DROP PROCEDURE IF EXISTS `CountLocationIDsByMission`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `CountLocationIDsByMission`(IN tmid INTEGER(11))
BEGIN
  SELECT COUNT(*) FROM locations WHERE mid=tmid;
END$$

DROP PROCEDURE IF EXISTS `CountMarkerIDsByMission`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `CountMarkerIDsByMission`(IN tmid INTEGER(11))
BEGIN
  SELECT COUNT(*) FROM markers WHERE mid=tmid;
END$$

DROP PROCEDURE IF EXISTS `CountObjectIDsByMission`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `CountObjectIDsByMission`(IN tmid INTEGER(11))
BEGIN
  SELECT COUNT(*) FROM objects WHERE mid=tmid;
END$$

DROP PROCEDURE IF EXISTS `CountTaskIDsByMission`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `CountTaskIDsByMission`(IN tmid INTEGER(11))
BEGIN
  SELECT COUNT(*) FROM tasks WHERE mid=tmid;
END$$

DROP PROCEDURE IF EXISTS `GetAARByInitid`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `GetAARByInitid`(IN tintid INTEGER(11), IN tmid INTEGER(11))
BEGIN
  SELECT id,sitrep,typ FROM aar WHERE intid = tintid AND mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `GetGlobalEnemyKillsByPlayer`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `GetGlobalEnemyKillsByPlayer`(IN tpid varchar(45))
BEGIN
  SELECT ek FROM players WHERE pid=tpid;
END$$

DROP PROCEDURE IF EXISTS `GetGlobalScoreByPlayer`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `GetGlobalScoreByPlayer`(IN tpid varchar(45))
BEGIN
  SELECT sc FROM players WHERE pid=tpid;
END$$

DROP PROCEDURE IF EXISTS `GetLandVehicleByInitid`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `GetLandVehicleByInitid`(IN tintid INTEGER(11), IN tmid INTEGER(11))
BEGIN
  SELECT id,obj,typ,pos,dir,up,dam,fue,lkd,wcar,eng,wmag FROM landvehicles WHERE intid = tintid AND mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `GetLocationByInitid`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `GetLocationByInitid`(IN tintid INTEGER(11), IN tmid INTEGER(11))
BEGIN
  SELECT id,obj,pos,hpo,cle,sus,grt,grs,typ,pa FROM locations WHERE intid = tintid AND mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `GetMarkerByInitid`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `GetMarkerByInitid`(IN tintid INTEGER(11), IN tmid INTEGER(11))
BEGIN
  SELECT id,nam,pos,typ,txt,side,col FROM markers WHERE intid = tintid AND mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `GetMissionByName`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `GetMissionByName`(IN tna VARCHAR(255))
BEGIN
  SELECT * FROM missions WHERE na=tna;
END$$

DROP PROCEDURE IF EXISTS `GetObjectByInitid`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `GetObjectByInitid`(IN tintid INTEGER(11), IN tmid INTEGER(11))
BEGIN
  SELECT id,obj,typ,pos,dir,up,dam,wcar,wmag FROM objects WHERE intid = tintid AND mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `GetPlayer`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `GetPlayer`(IN tmid INTEGER(11), IN tpid varchar(45))
BEGIN
  SELECT id,na,pid,mid,sc,pos,dam,dhe,dbo,dha,dle,dir,sta,sid,veh,sea,typ,rat,vd,td,ran,fir,ek,ck,fk,sui,lif,dea,tp,lc,ld FROM players WHERE mid=tmid AND pid=tpid;
END$$

DROP PROCEDURE IF EXISTS `GetPlayerACE`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `GetPlayerACE`(IN tmid INTEGER(11), IN tpid varchar(45))
BEGIN
  SELECT awb,arc,aw,arm,awo FROM players WHERE mid=tmid AND pid=tpid;
END$$

DROP PROCEDURE IF EXISTS `GetPlayerAIM`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `GetPlayerAIM`(IN tmid INTEGER(11), IN tpid VARCHAR(45))
BEGIN
 SELECT aim FROM players WHERE mid=tmid AND pid=tpid;
END$$

DROP PROCEDURE IF EXISTS `GetPlayerWeapons`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `GetPlayerWeapons`(IN tmid INTEGER(11), IN tpid varchar(45))
BEGIN
  SELECT wea,mag,rck,rwe,rma FROM players WHERE mid=tmid AND pid=tpid;
END$$

DROP PROCEDURE IF EXISTS `GetTaskByInitid`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `GetTaskByInitid`(IN tintid INTEGER(11), IN tmid INTEGER(11))
BEGIN
  SELECT id,nam,des,dest,sta,side FROM tasks WHERE intid = tintid AND mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `InsertAARs`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `InsertAARs`(IN tsitrep VARCHAR(1000), IN ttyp VARCHAR(45), IN tmid INTEGER(11), IN tintid INTEGER(11))
BEGIN
  INSERT INTO aar (sitrep,typ,mid,intid) values (tsitrep,ttyp,tmid,tintid);
END$$

DROP PROCEDURE IF EXISTS `InsertLandVehicles`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `InsertLandVehicles`(IN tobj VARCHAR(255), IN ttyp VARCHAR(100), IN tpos VARCHAR(255), IN tdir VARCHAR(255), IN tup VARCHAR(255), IN tdam FLOAT, IN tfue FLOAT, IN tlkd VARCHAR(5), IN twcar VARCHAR(1000), IN teng VARCHAR(5), IN twmag VARCHAR(1000), IN tmid INTEGER(11), IN tintid INTEGER(11))
BEGIN
  INSERT INTO landvehicles (obj,typ,pos,dir,up,dam,fue,lkd,wcar,eng,wmag,mid,intid) values (tobj,ttyp,tpos,tdir,tup,tdam,tfue,tlkd,twcar,teng,twmag,tmid,tintid);
END$$

DROP PROCEDURE IF EXISTS `InsertLocations`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `InsertLocations`(IN tobj VARCHAR(255), IN tpos VARCHAR(255), IN thpo INTEGER(11), IN tcle VARCHAR(10), IN tsus VARCHAR(10), IN tgrt VARCHAR(1000), IN tgrs INTEGER(11), IN ttyp VARCHAR(255), IN tpa VARCHAR(45), IN tmid INTEGER(11), IN tintid INTEGER(11))
BEGIN
  INSERT INTO locations (obj,pos,hpo,cle,sus,grt,grs,typ,pa,mid,intid) values (tobj,tpos,thpo,tcle,tsus,tgrt,tgrs,ttyp,tpa,tmid,tintid);
END$$

DROP PROCEDURE IF EXISTS `InsertMarkers`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `InsertMarkers`(IN tnam VARCHAR(45), IN tpos VARCHAR(45), IN ttyp VARCHAR(45), IN ttxt VARCHAR(255), IN tside VARCHAR(45), IN tcol VARCHAR(45), IN tmid INTEGER(11), IN tintid INTEGER(11))
BEGIN
  INSERT INTO markers (nam,pos,typ,txt,side,col,mid,intid) values (tnam,tpos,ttyp,ttxt,tside,tcol,tmid,tintid);
END$$

DROP PROCEDURE IF EXISTS `InsertObjects`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `InsertObjects`(IN tobj VARCHAR(255), IN ttyp VARCHAR(100), IN tpos VARCHAR(255), IN tdir VARCHAR(255), IN tup VARCHAR(255), IN tdam FLOAT, IN twcar VARCHAR(1000), IN twmag VARCHAR(1000), IN tmid INTEGER(11), IN tintid INTEGER(11))
BEGIN
  INSERT INTO objects (obj,typ,pos,dir,up,dam,wcar,wmag,mid,intid) values (tobj,ttyp,tpos,tdir,tup,tdam,twcar,twmag,tmid,tintid);
END$$

DROP PROCEDURE IF EXISTS `InsertPlayer`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `InsertPlayer`(IN tpid varchar(45), IN tna VARCHAR(255), IN tmid INTEGER(11), IN tsid VARCHAR(10), IN tpos VARCHAR(255))
BEGIN
  INSERT INTO players (na,pid,mid,sid,pos) values (tna,tpid,tmid,tsid,tpos);
END$$

DROP PROCEDURE IF EXISTS `InsertTasks`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `InsertTasks`(IN tnam VARCHAR(45), IN tdes VARCHAR(255), IN tdest VARCHAR(45), IN tsta VARCHAR(45), IN tside VARCHAR(45), IN tmid INTEGER(11), IN tintid INTEGER(11))
BEGIN
  INSERT INTO tasks (nam,des,dest,sta,side,mid,intid) values (tnam,tdes,tdest,tsta,tside,tmid,tintid);
END$$

DROP PROCEDURE IF EXISTS `NewMission`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `NewMission`(IN tna VARCHAR(255), IN ttd INTEGER(1), IN tsc INTEGER(1), IN tgsc INTEGER(1), IN tlog INTEGER(1), IN twea INTEGER(1), IN tace INTEGER(1), IN tlv INTEGER(1), IN tobj INTEGER(1), IN tloc INTEGER(1), IN tobc INTEGER(1), IN tmar INTEGER(1), IN ttas INTEGER(1), IN taar INTEGER(1), IN tmda VARCHAR(45), IN tmap VARCHAR(45), IN tsvr VARCHAR(255), IN taddr VARCHAR(45), IN tsloc VARCHAR(255), IN taim INTEGER(1))
BEGIN
  INSERT INTO missions (na,td,sc,gsc,log,wea,ace,lv,obj,loc,obc,mar,tas,aar,mda,map,svr,addr,sloc,aim) values (tna,ttd,tsc,tgsc,tlog,twea,tace,tlv,tobj,tloc,tobc,tmar,ttas,taar,tmda,tmap,tsvr,taddr,tsloc,taim);
END$$

DROP PROCEDURE IF EXISTS `RemoveAARs`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `RemoveAARs`(IN tmid INTEGER(11))
BEGIN
  DELETE FROM aar WHERE mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `RemoveLandVehicles`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `RemoveLandVehicles`(IN tmid INTEGER(11))
BEGIN
  DELETE FROM landvehicles WHERE mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `RemoveLocations`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `RemoveLocations`(IN tmid INTEGER(11))
BEGIN
  DELETE FROM locations WHERE mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `RemoveMarkers`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `RemoveMarkers`(IN tmid INTEGER(11))
BEGIN
  DELETE FROM markers WHERE mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `RemoveObjects`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `RemoveObjects`(IN tmid INTEGER(11))
BEGIN
  DELETE FROM objects WHERE mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `RemoveTasks`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `RemoveTasks`(IN tmid INTEGER(11))
BEGIN
  DELETE FROM tasks WHERE mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `UpdateDate`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `UpdateDate`(IN tda VARCHAR(255), IN tmid INTEGER(11))
BEGIN
  UPDATE missions SET da = tda WHERE id = tmid;
END$$

DROP PROCEDURE IF EXISTS `UpdatePlayer`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `UpdatePlayer`(IN tna VARCHAR(255), IN tsc INTEGER(11), IN tpos VARCHAR(255), IN tdam FLOAT, IN tdhe FLOAT, IN tdbo FLOAT, IN tdha FLOAT, IN tdle FLOAT, IN tdir FLOAT, IN tsta VARCHAR(10), IN tsid VARCHAR(10), IN tveh VARCHAR(255), IN tsea VARCHAR(10), IN ttyp VARCHAR(45), IN trat INTEGER(11), IN tvd INTEGER(11), IN ttd INTEGER(11), IN tran VARCHAR(45), IN tfir INTEGER(11), IN tek INTEGER(11), IN tck INTEGER(11), IN tfk INTEGER(11), IN tsui INTEGER(11), IN tlif VARCHAR(45), IN tdea INTEGER(11), IN ttp INTEGER(11), IN tlc VARCHAR(45), IN tld VARCHAR(45), IN tpid VARCHAR(45), IN tmid INTEGER(11))
BEGIN
  UPDATE players SET na = tna, sc = tsc, pos = tpos, dam = tdam, dhe = tdhe, dbo = tdbo, dha = tdha, dle = tdle, dir = tdir, sta = tsta, sid = tsid, veh = tveh, sea = tsea, typ = ttyp, rat = trat, vd = tvd, td = ttd, ran = tran, fir = tfir, ek = tek, ck = tck, fk = tfk, sui = tsui, lif = tlif, dea = tdea, tp = ttp, lc = tlc, ld = tld WHERE pid = tpid AND mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `UpdatePlayerACE`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `UpdatePlayerACE`(IN tawb VARCHAR(1000), IN tarc VARCHAR(45), IN taw VARCHAR(1000), IN tarm VARCHAR(1000), IN tawo VARCHAR(1000), IN tpid VARCHAR(45), IN tmid INTEGER(11))
BEGIN
  UPDATE players SET awb = tawb, arc = tarc, aw = taw, arm = tarm, awo = tawo WHERE pid = tpid AND mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `UpdatePlayerAIM`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `UpdatePlayerAIM`(IN taim VARCHAR(4096), IN tpid VARCHAR(45), IN tmid INTEGER(11))
BEGIN
UPDATE players SET aim = taim WHERE pid = tpid AND mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `UpdatePlayerWeapons`$$
CREATE DEFINER=`arma`@`localhost` PROCEDURE `UpdatePlayerWeapons`(IN twea VARCHAR(1000), IN tmag VARCHAR(1000), IN trck VARCHAR(45), IN trwe VARCHAR(1000), IN trma VARCHAR(1000), IN tpid VARCHAR(45), IN tmid INTEGER(11))
BEGIN
  UPDATE players SET wea = twea, mag = tmag, rck = trck, rwe = trwe, rma = trma WHERE pid = tpid AND mid = tmid;
END$$

DROP PROCEDURE IF EXISTS `UpdateMissionByName`$$
CREATE DEFINER = 'arma'@'localhost' PROCEDURE `UpdateMissionByName`(IN ttd INTEGER(1), IN tsc INTEGER(1), IN tgsc INTEGER(1), IN tlog INTEGER(1), IN twea INTEGER(1), IN tace INTEGER(1), IN tlv INTEGER(1), IN tobj INTEGER(1), IN tloc INTEGER(1), IN tobc INTEGER(1), IN tmar INTEGER(1), IN ttas INTEGER(1), IN taar INTEGER(1), IN taim INTEGER(1), IN tna VARCHAR(255))
BEGIN
UPDATE missions SET td = ttd, sc = tsc, gsc = tgsc, log = tlog, wea = twea, ace = tace, lv = tlv, obj = tobj, loc = tloc, obc = tobc, mar = tmar, tas = ttas, aar = taar, aim = taim  WHERE na = tna;
END$$

DELIMITER ;
