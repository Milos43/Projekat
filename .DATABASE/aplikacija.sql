/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

DROP DATABASE IF EXISTS `aplikacija`;
CREATE DATABASE IF NOT EXISTS `aplikacija` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `aplikacija`;

DROP TABLE IF EXISTS `administrator`;
CREATE TABLE IF NOT EXISTS `administrator` (
  `administrator_id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL DEFAULT '0',
  `password_hash` varchar(128) NOT NULL DEFAULT '0',
  PRIMARY KEY (`administrator_id`),
  UNIQUE KEY `uq_administrator_username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `administrator`;
/*!40000 ALTER TABLE `administrator` DISABLE KEYS */;
INSERT INTO `administrator` (`administrator_id`, `username`, `password_hash`) VALUES
	(11, 'milos', 'F5A43F2FE0B3ED50216666730C105B1FB48E2311201615B7701C2F6A13BD8AA08DC5BED8C6C2C6521DD6994B275E38C0F0120C93CDC1A33ED84386B20C15E774');
/*!40000 ALTER TABLE `administrator` ENABLE KEYS */;

DROP TABLE IF EXISTS `administrator_token`;
CREATE TABLE IF NOT EXISTS `administrator_token` (
  `administrator_token_id` int unsigned NOT NULL AUTO_INCREMENT,
  `administrator_id` int unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `token` text NOT NULL,
  `expires_at` datetime NOT NULL,
  `is_valid` tinyint unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`administrator_token_id`),
  KEY `fk_administrator_token_administrator_id` (`administrator_id`),
  CONSTRAINT `fk_administrator_token_administrator_id` FOREIGN KEY (`administrator_id`) REFERENCES `administrator` (`administrator_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `administrator_token`;
/*!40000 ALTER TABLE `administrator_token` DISABLE KEYS */;
INSERT INTO `administrator_token` (`administrator_token_id`, `administrator_id`, `created_at`, `token`, `expires_at`, `is_valid`) VALUES
	(131, 11, '2020-07-09 15:28:08', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk2OTc5Njg4LjgyNSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMSIsImlhdCI6MTU5NDMwMTI4OH0.8fW4fFavs8UPIAeJTwV3SPq7s_KsXCLz5sWG5ar2mIE', '2020-08-09 13:28:08', 1),
	(132, 11, '2020-07-09 15:29:05', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk2OTc5NzQ1LjgzNywiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMSIsImlhdCI6MTU5NDMwMTM0NX0.oJxT1we3e8tgly4hjVHPYTsBzXg-gRi_n3U48hirzDA', '2020-08-09 13:29:05', 1),
	(133, 11, '2020-07-10 15:53:03', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk3MDY3NTgzLjA2OSwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OC4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc4LjAiLCJpYXQiOjE1OTQzODkxODN9.bSboFugjYWQYwyhUejTno0yU7GPhWoQgPlbP23VB6Gw', '2020-08-10 13:53:03', 1),
	(134, 11, '2020-07-10 16:18:47', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk3MDY5MTI3LjU0LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzgzLjAuNDEwMy4xMTYgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NDM5MDcyN30.cTiA4r9R1Z_h5uXDXfCva3-RFRK6Cn6cVm7LGU_QX0Q', '2020-08-10 14:18:47', 1),
	(135, 11, '2020-07-10 16:39:31', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk3MDcwMzcxLjI2NiwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OC4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc4LjAiLCJpYXQiOjE1OTQzOTE5NzF9.FKXJ1Q8Jng1-1js4De-Znh9BYZIgnGblV57s9SgYEkg', '2020-08-10 14:39:31', 1),
	(136, 11, '2020-07-10 16:49:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk3MDcwOTcwLjEwMiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuMTE2IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTQzOTI1NzB9.LCZqd9qEBjHKn5E7MnV_EQxUggMfVAPFpSBCKa8WiD0', '2020-08-10 14:49:30', 1),
	(137, 11, '2020-07-10 16:53:38', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk3MDcxMjE4LjAwOCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84My4wLjQxMDMuMTE2IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTQzOTI4MTh9.0KbC4SusCGrq0fwURdaQkH1a65_Q1NEIwJDAaIsYUoY', '2020-08-10 14:53:38', 1),
	(138, 11, '2020-08-01 12:27:09', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk4OTU2MDI5LjcwOCwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYyNzc2Mjl9.mlTdPUtMofuBb__rkrNDgRzkoQ7G2MXimdOL8prouCo', '2020-09-01 10:27:09', 1),
	(139, 11, '2020-08-01 13:35:29', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk4OTYwMTI5LjMwMiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuMTA1IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTYyODE3Mjl9.gXpp_wk6-9DTtmHCBfmXZsSNPGCjuJZEPoGETzr6Qfg', '2020-09-01 11:35:29', 1),
	(140, 11, '2020-08-01 13:46:20', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk4OTYwNzgwLjcwNiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuMTA1IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTYyODIzODB9.yO3g2U2537WRRstVjj-MG0dXGYUKBxNt6mF6CR7O0eg', '2020-09-01 11:46:20', 1),
	(141, 11, '2020-08-01 14:49:26', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk4OTY0NTY2LjQ3OSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuMTA1IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTYyODYxNjZ9.wFPoMRfRnyzuOwaBM5bqj9yMJ2IrNOxWgcT0owovi54', '2020-09-01 12:49:26', 1),
	(142, 11, '2020-08-01 15:02:28', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk4OTY1MzQ4LjM1MSwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYyODY5NDh9.WO1e-2Tzgd3pynY8_OdI_J_gsVSwFOJjDujAP7quKHA', '2020-09-01 13:02:28', 1),
	(143, 11, '2020-08-02 12:45:49', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDQzNTQ5LjgxMywiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNjUxNDl9.ofNNb5bJQPUcl0Jm91ZHlEVsIMO1FshJj_NrRHO7mb0', '2020-09-02 10:45:49', 1),
	(144, 11, '2020-08-02 13:00:29', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDQ0NDI5LjUwOCwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNjYwMjl9.jgIXP5UhW1edl8t9PUBjGTB5s-7c1LQdvKtr8APnUns', '2020-09-02 11:00:29', 1),
	(145, 11, '2020-08-02 13:00:46', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDQ0NDQ2Ljk4NSwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNjYwNDZ9.35sK5TuZaK-j1qTAH2yVT-yxxf-zcAyVu2Jp8ucGyds', '2020-09-02 11:00:46', 1),
	(146, 11, '2020-08-02 13:00:59', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDQ0NDU5Ljk4NSwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNjYwNTl9.te0Kq5Fj5TFrJzl73DFoyIWSYGhPBVXr5CDoCFZ1nVY', '2020-09-02 11:00:59', 1),
	(147, 11, '2020-08-02 13:01:40', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDQ0NTAwLjY3MiwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNjYxMDB9.fk4QylYIOkTU-hdxQ2zBtrjjnUhynDOzsGyfY7b_HxE', '2020-09-02 11:01:40', 1),
	(148, 11, '2020-08-02 13:02:03', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDQ0NTIzLjQyNiwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNjYxMjN9.cBKdnYmclUi-e8HLLrMNQ2a8WAG27PTMriFrRS1DDFY', '2020-09-02 11:02:03', 1),
	(149, 11, '2020-08-02 13:05:50', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDQ0NzUwLjc5OCwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNjYzNTB9.L8g-pAKemXfQzB7_3Or-ZakSKX_dx4Cy0c_vF_s9_5o', '2020-09-02 11:05:50', 1),
	(150, 11, '2020-08-02 13:48:37', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDQ3MzE3LjQ3MiwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNjg5MTd9.J850VKnZ9TR72z0DtHbWDaXP05rVzPgtbJk2h5yfSQc', '2020-09-02 11:48:37', 1),
	(151, 11, '2020-08-02 14:00:56', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDQ4MDU2LjA3NCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQ7IHJ2Ojc5LjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvNzkuMCIsImlhdCI6MTU5NjM2OTY1Nn0.VD4Dw0ZoAYZSDcTsFiR738IreOFXbToZnh12Y_jhQGo', '2020-09-02 12:00:56', 1),
	(152, 11, '2020-08-02 14:43:48', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDUwNjI4LjcwNSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMiIsImlhdCI6MTU5NjM3MjIyOH0.LPI0NcHeoqGECQCnhMMLr3S9Ayq5vW3wjiE-LPYeaH0', '2020-09-02 12:43:48', 1),
	(153, 11, '2020-08-02 14:49:12', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDUwOTUyLjUzNCwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMiIsImlhdCI6MTU5NjM3MjU1Mn0.6sIKAZF5-qLYYRSAKZn-H4pgVWxBhKEAV1ts_tS0__Y', '2020-09-02 12:49:12', 1),
	(154, 11, '2020-08-02 15:01:38', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDUxNjk4LjcxMSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMiIsImlhdCI6MTU5NjM3MzI5OH0.1nlcxI8MULd_fqpKS3hzq-DW_Sq9Bw5U9biD7qhDgDo', '2020-09-02 13:01:38', 1),
	(155, 11, '2020-08-02 15:25:42', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDUzMTQyLjc0LCJpcCI6Ijo6ZmZmZjoxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQ7IHJ2Ojc5LjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvNzkuMCIsImlhdCI6MTU5NjM3NDc0Mn0.yIKKUhaS3BT0HsI97Re__i8voK-QC0kw3wDhoOkgvNQ', '2020-09-02 13:25:42', 1),
	(156, 11, '2020-08-02 15:27:40', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDUzMjYwLjU2NSwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNzQ4NjB9.wl8yDDhuoC2e9O3tfqovtWdgh8ESWMOF4H4MiPOnQWQ', '2020-09-02 13:27:40', 1),
	(157, 11, '2020-08-02 15:40:17', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU0MDE3Ljg5NCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuMTA1IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTYzNzU2MTd9.Xdiz-WaRGuc3Bsnuj0woa0HmYz-vrwJMb-uqKYNa3N0', '2020-09-02 13:40:17', 1),
	(158, 11, '2020-08-02 15:43:54', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU0MjM0LjM0NSwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNzU4MzR9.TGcJ81n2IxhPRnhXDA15dnTJuUTM2bm0jC0fomNvzuE', '2020-09-02 13:43:54', 1),
	(159, 11, '2020-08-02 15:44:09', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU0MjQ5Ljc0NSwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNzU4NDl9.NdD1JaSVRbeprKaNiqRaHRfVDtlCt4LyT879CWKtcPY', '2020-09-02 13:44:09', 1),
	(160, 11, '2020-08-02 15:44:22', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU0MjYyLjE5MywiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNzU4NjJ9.lrApPTOPClgDfO-k4OMDGA1C192WYUAOvb5_Bgk_8XE', '2020-09-02 13:44:22', 1),
	(161, 11, '2020-08-02 15:44:50', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU0MjkwLjY4LCJpcCI6Ijo6ZmZmZjoxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQ7IHJ2Ojc5LjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvNzkuMCIsImlhdCI6MTU5NjM3NTg5MH0.7q2ESf3GCyXmrOvRt4RH19tmArWZDos9VAVEpvhiiyU', '2020-09-02 13:44:50', 1),
	(162, 11, '2020-08-02 15:47:01', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU0NDIxLjc0NywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuMTA1IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTYzNzYwMjF9.3v9E-_2n4t8RivuF9cUjTehv36p1GtZ4k3plmD-Zniw', '2020-09-02 13:47:01', 1),
	(163, 11, '2020-08-02 15:47:31', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU0NDUxLjAxNSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMiIsImlhdCI6MTU5NjM3NjA1MX0.AclDqJ3WNXdVYyhrhSCHuWjYwKxiwMO2GwDv_fox0gw', '2020-09-02 13:47:31', 1),
	(164, 11, '2020-08-02 15:49:11', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU0NTUxLjI4NCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuMTA1IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTYzNzYxNTF9.tudHmX-oVmu2GtB6baFeDLGFax-QhzoaPBDRh7XQ8BE', '2020-09-02 13:49:11', 1),
	(165, 11, '2020-08-02 15:54:28', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU0ODY4LjM2NSwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuMTA1IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTYzNzY0Njh9.d-YQ6xiFXByHw_Y-81P0TdXqehRTu6SY1t2CQYRzPvc', '2020-09-02 13:54:28', 1),
	(166, 11, '2020-08-02 15:57:41', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU1MDYxLjc3NCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuMTA1IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTYzNzY2NjF9.HSpkfexEh_Eol_Vb8URKCwLtF7WiVjLdDZqoaVFFSh8', '2020-09-02 13:57:41', 1),
	(167, 11, '2020-08-02 16:12:33', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU1OTUzLjE5LCJpcCI6Ijo6MSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzg0LjAuNDE0Ny4xMDUgU2FmYXJpLzUzNy4zNiIsImlhdCI6MTU5NjM3NzU1M30.Vo8NX2iPLb5WtOUdyRPG-1Pi_PVyT8MWBRqMWSUIPc4', '2020-09-02 14:12:33', 1),
	(168, 11, '2020-08-02 16:13:47', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU2MDI3LjE2OCwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuMTA1IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTYzNzc2Mjd9.isTVPu5YXoawbcshEbb2ohGjzWuuizRT0mpbWTwi6Qs', '2020-09-02 14:13:47', 1),
	(169, 11, '2020-08-02 16:19:48', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU2Mzg4LjA5LCJpcCI6Ijo6ZmZmZjoxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQ7IHJ2Ojc5LjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvNzkuMCIsImlhdCI6MTU5NjM3Nzk4OH0.2re7kWHOibJyDZpmVdWoQUeTBwNfZOfledNPsHjza58', '2020-09-02 14:19:48', 1),
	(170, 11, '2020-08-02 16:21:23', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU2NDgzLjExNSwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNzgwODN9.71vr2QZM5TentOlpTr3wjiydFZurJ_4vZmYoYuyf4ao', '2020-09-02 14:21:23', 1),
	(171, 11, '2020-08-02 16:21:49', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU2NTA5Ljc0OCwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNzgxMDl9.M6l1m4FYt3tw_JlwsGsXVKXZZ6_7qRPkND3i44-W7gc', '2020-09-02 14:21:49', 1),
	(172, 11, '2020-08-02 16:28:57', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU2OTM3LjY0NywiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuMTA1IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTYzNzg1Mzd9.uqhXIS_TxYY6ujxp3u6QH8i2255QOehQRXa5_c9ECeg', '2020-09-02 14:28:57', 1),
	(173, 11, '2020-08-02 16:31:36', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU3MDk2LjQyMiwiaXAiOiI6OjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQpIEFwcGxlV2ViS2l0LzUzNy4zNiAoS0hUTUwsIGxpa2UgR2Vja28pIENocm9tZS84NC4wLjQxNDcuMTA1IFNhZmFyaS81MzcuMzYiLCJpYXQiOjE1OTYzNzg2OTZ9.9M8AieIQe8CL7h43XzveWRoH30Pwn19O28O0ah6nNac', '2020-09-02 14:31:36', 1),
	(174, 11, '2020-08-02 16:49:42', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU4MTgyLjQ0LCJpcCI6Ijo6ZmZmZjoxMjcuMC4wLjEiLCJ1YSI6Ik1vemlsbGEvNS4wIChXaW5kb3dzIE5UIDEwLjA7IFdpbjY0OyB4NjQ7IHJ2Ojc5LjApIEdlY2tvLzIwMTAwMTAxIEZpcmVmb3gvNzkuMCIsImlhdCI6MTU5NjM3OTc4Mn0.6QWwEnuNiOoj4bUsp_REdJnCnCHaRto4kBnEnekR-68', '2020-09-02 14:49:42', 1),
	(175, 11, '2020-08-02 16:50:04', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU4MjA0Ljg4MiwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNzk4MDR9.WNGcHhsVD4vTZzSmfey40RuuRocZgp-tQ2185xD6lq4', '2020-09-02 14:50:04', 1),
	(176, 11, '2020-08-02 16:50:51', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU4MjUxLjc0OSwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzNzk4NTF9.omCP2jbwhtOlXcxAMa2VAR5q2WviTInAZOqvM6_MStA', '2020-09-02 14:50:51', 1),
	(177, 11, '2020-08-02 16:55:13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU4NTEzLjQ5NCwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzODAxMTN9.5ssRnA8BnQziJYbSijauDs-uPJPpMQlvyHKXV6xFrSQ', '2020-09-02 14:55:13', 1),
	(178, 11, '2020-08-02 16:58:23', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU4NzAzLjM3MSwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzODAzMDN9.bUM2ls4GX6eJkAkBnZoqznlreCCdlKaVmHo3wsYZ7xQ', '2020-09-02 14:58:23', 1),
	(179, 11, '2020-08-02 17:07:11', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU5MjMxLjYyNywiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTYzODA4MzF9.sG2_x2S5ESFtDzfy1HHrBTQMtc8QfUKNme7mbWYo6BE', '2020-09-02 15:07:11', 1),
	(180, 11, '2020-08-02 17:10:19', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5MDU5NDE5LjIsImlwIjoiOjpmZmZmOjEyNy4wLjAuMSIsInVhIjoiTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NDsgcnY6NzkuMCkgR2Vja28vMjAxMDAxMDEgRmlyZWZveC83OS4wIiwiaWF0IjoxNTk2MzgxMDE5fQ.KBWIoyQVkQCxNU2wbSaCoeK4SObUDMQyUkvXa2lD7Hg', '2020-09-02 15:10:19', 1),
	(181, 11, '2020-08-10 14:45:29', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5NzQxOTI5LjAwOCwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTcwNjM1Mjl9.HOzMEIPg4CSP0w356gFYydPZ3FfJPMHjL2WhFX15syY', '2020-09-10 12:45:29', 1),
	(182, 11, '2020-08-10 16:57:30', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5NzQ5ODUwLjc3MiwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTcwNzE0NTB9.czGmPwa4URX6DT-oUtUULCkmwkOfEJICa4OvRjZrbvA', '2020-09-10 14:57:30', 1),
	(183, 11, '2020-08-10 18:16:42', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5NzU0NjAyLjMyMiwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTcwNzYyMDJ9.K7y-9Z8Z5DCVnIkWeXbG67NyEz1XKTB6VHPi8nKWIbg', '2020-09-10 16:16:42', 1),
	(184, 11, '2020-08-11 16:57:24', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODM2MjQ0LjkzMiwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMyIsImlhdCI6MTU5NzE1Nzg0NH0.vgzbYMIKcKDaTzO6hzFcayCjdrWdxLF-EIxIpnep9RY', '2020-09-11 14:57:24', 1),
	(185, 11, '2020-08-11 17:03:01', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODM2NTgxLjMxMywiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMyIsImlhdCI6MTU5NzE1ODE4MX0.HXESYz7COpv6pfjAo1TB_XDsrZ6I3ACUYA4jMQ43hAU', '2020-09-11 15:03:01', 1),
	(186, 11, '2020-08-11 17:21:14', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODM3Njc0LjE4NSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMyIsImlhdCI6MTU5NzE1OTI3NH0.xLaRnIJbm_kWSNQtQX0rJ7KHLJwTJFneq40qcwmgUmY', '2020-09-11 15:21:14', 1),
	(187, 11, '2020-08-11 17:27:59', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODM4MDc5LjI4MywiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMyIsImlhdCI6MTU5NzE1OTY3OX0.Ycwwr0VzPhkahrx68YiJT0ks_dV4ab05uVDsk52RsVw', '2020-09-11 15:27:59', 1),
	(188, 11, '2020-08-11 17:30:53', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODM4MjUzLjA1MywiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMyIsImlhdCI6MTU5NzE1OTg1M30.MfhFtHtmf4QDxALZZXb6ZT8qmiNqeUt1e0OOteInFgQ', '2020-09-11 15:30:53', 1),
	(189, 11, '2020-08-11 17:36:37', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODM4NTk3LjY4NSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMyIsImlhdCI6MTU5NzE2MDE5N30.5vfBZZ5zfAtBjEcKMU1lj0YTWeX316Qgf-jLNYLdte8', '2020-09-11 15:36:37', 1),
	(190, 11, '2020-08-11 17:41:44', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODM4OTA0LjA5OCwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMyIsImlhdCI6MTU5NzE2MDUwNH0.PE64G6GAbOsW67BEznI90sEnw3eBRzXX47FlUvO1lK8', '2020-09-11 15:41:44', 1),
	(191, 11, '2020-08-11 17:45:42', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODM5MTQyLjQyNSwiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMyIsImlhdCI6MTU5NzE2MDc0Mn0.CjQSem3hGGXuqImRSnCzp-7NL2HI3EfOm1ITqSG131w', '2020-09-11 15:45:42', 1),
	(192, 11, '2020-08-11 17:49:38', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODM5Mzc4LjAzLCJpcCI6Ijo6MSIsInVhIjoiUG9zdG1hblJ1bnRpbWUvNy4yNi4zIiwiaWF0IjoxNTk3MTYwOTc4fQ.bpqCaav7LVavFJxPva9uVpIPjyuerUieBBCRy-VeaIo', '2020-09-11 15:49:38', 1),
	(193, 11, '2020-08-11 17:50:06', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODM5NDA2Ljc1MywiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTcxNjEwMDZ9.USarHSafgh2IKnDpj_81CSd5Xhv8ojOMzwhXijdQ4rk', '2020-09-11 15:50:06', 1),
	(194, 11, '2020-08-11 17:58:33', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODM5OTEzLjE1MywiaXAiOiI6OjEiLCJ1YSI6IlBvc3RtYW5SdW50aW1lLzcuMjYuMyIsImlhdCI6MTU5NzE2MTUxM30.u34gB5Y_p_nAQFH-Gto6VmGJe0Wsl7y-NA6aNWqrmFs', '2020-09-11 15:58:33', 1),
	(195, 11, '2020-08-11 18:29:02', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODQxNzQyLjMyMSwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTcxNjMzNDJ9.3yEU_Pe433t0RHEeucoLGIoOEKt7vAGbDXTmz8sd5X8', '2020-09-11 16:29:02', 1),
	(196, 11, '2020-08-11 18:36:06', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODQyMTY2LjM2OCwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTcxNjM3NjZ9.5VZE5qfo5rTe77XcwV_7XsXWGaDkwZ7nq0jZjXcqdVc', '2020-09-11 16:36:06', 1),
	(197, 11, '2020-08-11 18:58:13', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODQzNDkzLjYxOCwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTcxNjUwOTN9.f0I9B_sQnG0BzaGA6wfSyEcXZ8K6i6snHVQG667i4C0', '2020-09-11 16:58:13', 1),
	(198, 11, '2020-08-11 19:01:39', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbmlzdHJhdG9ySWQiOjExLCJ1c2VybmFtZSI6Im1pbG9zIiwiZXhwIjoxNTk5ODQzNjk5LjY1NCwiaXAiOiI6OmZmZmY6MTI3LjAuMC4xIiwidWEiOiJNb3ppbGxhLzUuMCAoV2luZG93cyBOVCAxMC4wOyBXaW42NDsgeDY0OyBydjo3OS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc5LjAiLCJpYXQiOjE1OTcxNjUyOTl9.Kfrzlc0_Dmjj9gf-9Wh77MuVk5PTJ916HhyDNxN_LKM', '2020-09-11 17:01:39', 1);
/*!40000 ALTER TABLE `administrator_token` ENABLE KEYS */;

DROP TABLE IF EXISTS `article`;
CREATE TABLE IF NOT EXISTS `article` (
  `article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL DEFAULT '0',
  `description` text NOT NULL,
  `category_id` int unsigned NOT NULL DEFAULT '0',
  `short_description` varchar(255) NOT NULL DEFAULT '0',
  `price` decimal(10,2) unsigned NOT NULL DEFAULT '0.00',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`article_id`),
  KEY `fk_article_category_id` (`category_id`),
  CONSTRAINT `fk_article_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `article`;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` (`article_id`, `name`, `description`, `category_id`, `short_description`, `price`, `created_at`) VALUES
	(88, 'Cubic Zirconia Tennis Bracelet', 'Details & Care\n\nSparkling cubic zirconia dazzles your wrist on this simply stunning metallic band.\n\n    7 1/4" length; 1/8" width\n    Fold-over clasp closure\n    14k-gold plate or rhodium plate/cubic zirconia\n    Imported\n    Item #5570970', 29, 'Sparkling cubic zirconia dazzles your wrist on this simply stunning metallic band.', 99.00, '2020-08-11 18:58:30'),
	(89, 'Multistrand Pendant Necklace', 'Details & Care\n\nPavé cubic zirconia add tiny spotlights to the bar and disc pendants on a gleaming multistrand necklace that takes the guesswork out of layering.\n\n    Lobster clasp closure\n    Stainless steel/cubic zirconia\n    Imported\n    Item #5806727\n\nHelpful info:\nNecklace Lengths Guide\nKeep jewelry away from water and chemicals; remove during physical activities; store separately in a soft pouch.', 28, 'Pavé cubic zirconia add tiny spotlights to the bar and disc pendants on a gleaming multistrand necklace that takes the guesswork out of layering.', 44.00, '2020-08-11 19:08:16'),
	(90, 'Elisa Birthstone Pendant Necklace', 'Details & Care\n\nThis delicate gold-plated necklace features a mesmerizing pendant that signifies your birth month framed by Kendra Scott\'s iconic portrait setting.\n\n    14 3/4" length; 2" extender; 3/8"W x 5/8"L pendant\n    Lobster clasp closure\n    Due to natural variation, stone color may vary\n    14k-gold plate/glass, cat\'s-eye, quartz or mother-of-pearl\n    Imported\n    Item #5380505\n\nHelpful info:\nNecklace Lengths Guide\nKeep jewelry away from water and chemicals; remove during physical activities; store separately in a soft pouch.', 28, 'This delicate gold-plated necklace features a mesmerizing pendant that signifies your birth month framed by Kendra Scott\'s iconic portrait setting.', 68.00, '2020-08-11 19:09:51'),
	(91, 'Elisa Pendant Necklace', 'Details & Care\n\nA glittering stone sparkles at the center of a mesmerizing, versatile pendant necklace.\n\n    15" length; 2 1/2" extender; 5/8"W x 1/4"L pendant\n    Lobster clasp closure\n    Drusy/14k-gold plate or rhodium plate\n    Imported\n    Item #782660\n\nHelpful info:\nNecklace Lengths Guide\nKeep jewelry away from water and chemicals; remove during physical activities; store separately in a soft pouch.', 28, 'A glittering stone sparkles at the center of a mesmerizing, versatile pendant necklace.', 60.00, '2020-08-11 19:13:14'),
	(92, 'Opyum YSL Leather Bracelet', 'Details & Care\n\nThis calfskin-leather bracelet polished with an antiqued monogram makes an enduringly chic statement.\n\n    3/8" width\n    Box clasp closure\n    Leather/goldtone or silvertone plate\n    Made in Italy\n    Item #5881836\n\nHelpful info:\nKeep jewelry away from water and chemicals; remove during physical activities; store separately in a soft pouch.', 29, 'This calfskin-leather bracelet polished with an antiqued monogram makes an enduringly chic statement.', 325.00, '2020-08-11 19:16:08'),
	(93, 'T-Logo Single Wrap Bracelet', 'Details & Care\n\nA slim leather bracelet adorned with gleaming logo hardware can be worn by itself or paired with other Tory Burch bracelets to create a multiwrap look.\n\n    1/4" width\n    Slide closure\n    Leather/metal\n    Imported\n    Item #5972356\n\nHelpful info:\nKeep jewelry away from water and chemicals; remove during physical activities; store separately in a soft pouch.', 29, 'A slim leather bracelet adorned with gleaming logo hardware can be worn by itself or paired with other Tory Burch bracelets to create a multiwrap look.', 39.00, '2020-08-11 19:17:22'),
	(94, 'Double Huggie Chain Earring', 'Bring an edgy touch to your multipierced ears with this modern accessory made in liquid-shine plate and styled with two huggie hoops linked by a curb chain.\n\n    Sold as a single earring\n    3" drop; 1/2" width\n    Hinge with snap-post closures\n    Goldtone plate\n    Imported\n    Item #6081894\n\nHelpful info:\nKeep jewelry away from water and chemicals; remove during physical activities; store separately in a soft pouch.', 30, 'Bring an edgy touch to your multipierced ears with this modern accessory made in liquid-shine plate and styled with two huggie hoops linked by a curb chain.', 36.00, '2020-08-11 19:19:05'),
	(95, 'Gianna Beaded Hoop Earrings', 'Details & Care\n\nShiny goldtone beads bubble from striking statement hoop earrings.\n\n    1 3/8" diameter\n    Post back\n    Goldtone plate\n    Imported\n    Item #5988027\n\nHelpful info:\nKeep jewelry away from water and chemicals; remove during physical activities; store separately in a soft pouch.', 30, 'Shiny goldtone beads bubble from striking statement hoop earrings.', 38.00, '2020-08-11 19:20:35'),
	(96, 'Diamond Stud Earrings', 'Details & Care\n\nSparkling round diamonds are secured in a three-prong setting of 18-karat white gold.\n\n    Studs sold by total diamond weight.\n    Post back.\n    Color: H-I.\n    Clarity: SI2.\n    Item #291567\n\nHelpful info:\nDiamond Guide\nKeep jewelry away from water and chemicals; remove during physical activities; store separately in a soft pouch.', 30, 'Sparkling round diamonds are secured in a three-prong setting of 18-karat white gold.', 575.00, '2020-08-11 19:22:46'),
	(97, 'Miller Stud Ring', 'Details & Care\n\nTory\'s polished style is always at your fingertips thanks to this gleaming band punctuated by stacked-T logos.\n\n    1/4" band width\n    Goldtone or silvertone plate\n    Imported\n    Item #6077728\n\nHelpful info:\nKeep jewelry away from water and chemicals; remove during physical activities; store separately in a soft pouch.', 31, 'Tory\'s polished style is always at your fingertips thanks to this gleaming band punctuated by stacked-T logos.', 98.00, '2020-08-11 19:24:35'),
	(98, 'Cable Loop Ring with 18K Gold', 'Size Info\n\n    Refer to size chart for measurements.\n\nDetails & Care\n\nSterling silver with 18-karat yellow gold. Ring, 8mm. Imported.\n\n    Item #5607285', 31, 'Sterling silver with 18-karat yellow gold.', 325.00, '2020-08-11 19:26:23'),
	(99, 'Pavé Eternity Band', 'Details & Care\n\nShine with eternal brilliance in impeccable style, wearing this pavé crystal band.\n\n    1/8" band width\n    Goldtone plate, silvertone plate or hematite plate/cubic zirconia\n    Imported\n    Item #5571020', 31, 'Shine with eternal brilliance in impeccable style, wearing this pavé crystal band.', 39.00, '2020-08-11 19:27:27'),
	(100, 'Milanese Mesh Apple Watch® Bracelet', 'Details & Care\n\nA polished link bracelet in stainless steel brings a sophisticated flourish to your Apple Watch.\n\n    Apple Watch not included\n    Compatible with Series 1, Series 2, Series 3, or Series 4 Apple® 38mm or 40mm Watch\n    Safety clasp closure\n    Stainless steel\n    Imported\n    Item #5942836_1', 32, 'A polished link bracelet in stainless steel brings a sophisticated flourish to your Apple Watch.', 79.00, '2020-08-11 19:31:44'),
	(101, 'Major Leather Strap Watch, 35mm', 'Details & Care\n\nSlender indexes mark the refreshingly clean round dial of a classic timepiece in a slim, unobtrusive case on a supple, topstitched leather strap.\n\n    35mm case\n    Buckle closure\n    Two-hand quartz movement\n    Mineral crystal face\n    Stainless steel/leather\n    Imported\n    Item #5718052', 32, 'Slender indexes mark the refreshingly clean round dial of a classic timepiece in a slim, unobtrusive case on a supple, topstitched leather strap.', 47.00, '2020-08-11 19:33:17'),
	(102, 'Major Bracelet Watch, 35mm', 'Details & Care\n\nA glittery face, simple dial and bracelet complete the clean, minimalist aesthetic of a classic timepiece available in silver, gold, rose-gold and gunmetal plating.\n\n    35mm case\n    Self-adjustable bracelet with removable links\n    Deployant clasp closure\n    Three-hand quartz movement\n    Mineral crystal face\n    Plated stainless steel\n    Imported\n    Item #5718057', 32, 'A seven-link bracelet with a softly hued sunray dial and sparkling crystals enhances the look of a classic three-hand watch with sophisticated refinement.', 87.00, '2020-08-11 19:34:58');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;

DROP TABLE IF EXISTS `article_feature`;
CREATE TABLE IF NOT EXISTS `article_feature` (
  `article_feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `feature_id` int unsigned NOT NULL DEFAULT '0',
  `value` varchar(255) NOT NULL DEFAULT '0',
  PRIMARY KEY (`article_feature_id`),
  UNIQUE KEY `uq_article_feature_article_id_feature_id` (`article_id`,`feature_id`),
  KEY `fk_article_feature_feature_id` (`feature_id`),
  CONSTRAINT `fk_article_feature_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_article_feature_feature_id` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=219 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `article_feature`;
/*!40000 ALTER TABLE `article_feature` DISABLE KEYS */;
INSERT INTO `article_feature` (`article_feature_id`, `article_id`, `feature_id`, `value`) VALUES
	(139, 88, 30, 'Nordstorm'),
	(140, 88, 31, '14K Gold'),
	(141, 88, 32, 'Yellow'),
	(142, 88, 33, 'Regular'),
	(143, 89, 25, 'KNOTTY'),
	(144, 89, 27, 'Gold'),
	(145, 89, 28, 'Regular'),
	(146, 89, 29, 'Silver'),
	(147, 90, 25, 'KENDRA SCOTT'),
	(148, 90, 27, 'Gold'),
	(149, 90, 28, 'Regular'),
	(150, 90, 29, 'Silver'),
	(155, 91, 25, 'KENDRA SCOTT'),
	(156, 91, 27, 'Gold cobalt'),
	(157, 91, 28, 'Regular'),
	(158, 91, 29, 'Blue'),
	(159, 92, 30, 'SAINT LAURENT'),
	(160, 92, 31, 'Leather'),
	(161, 92, 32, 'Yellow'),
	(162, 92, 33, 'Regular'),
	(167, 94, 34, 'BAUBLEBAR'),
	(168, 94, 35, 'Gold'),
	(169, 94, 36, 'Yellow'),
	(170, 94, 37, 'Regular'),
	(171, 95, 34, 'BAUBLEBAR'),
	(172, 95, 35, 'Gold'),
	(173, 95, 36, 'Yellow'),
	(174, 95, 37, 'Regular'),
	(175, 96, 34, 'BONY LEVY'),
	(176, 96, 35, 'Diamond'),
	(177, 96, 36, 'White gold'),
	(178, 96, 37, 'Regular'),
	(179, 97, 38, 'TORY BURCH'),
	(180, 97, 39, 'Silver'),
	(181, 97, 40, '7'),
	(182, 97, 41, 'Regular'),
	(187, 98, 38, 'DAVID YURMAN'),
	(188, 98, 39, 'Gold'),
	(189, 98, 40, '6'),
	(190, 98, 41, 'Regular'),
	(191, 99, 38, 'NORDSTROM'),
	(192, 99, 39, 'Crystal'),
	(193, 99, 40, '7'),
	(194, 99, 41, 'Regular'),
	(195, 100, 42, 'REBECCA MINKOFF'),
	(196, 100, 43, 'Silver'),
	(197, 100, 44, 'Brown'),
	(198, 100, 45, 'Regular'),
	(199, 100, 46, 'Digital'),
	(205, 101, 42, 'REBECCA MINKOFF'),
	(206, 101, 43, 'Leather'),
	(207, 101, 44, 'Rose gold'),
	(208, 101, 45, 'Regular'),
	(209, 101, 46, 'Analog'),
	(210, 102, 42, 'REBECCA MINKOFF'),
	(211, 102, 43, 'Gold'),
	(212, 102, 44, 'Gold'),
	(213, 102, 45, 'Regular'),
	(214, 102, 46, 'Analog'),
	(215, 93, 30, 'TORY BURCH'),
	(216, 93, 31, 'Leather'),
	(217, 93, 32, 'Rose gold'),
	(218, 93, 33, 'Regular');
/*!40000 ALTER TABLE `article_feature` ENABLE KEYS */;

DROP TABLE IF EXISTS `cart`;
CREATE TABLE IF NOT EXISTS `cart` (
  `cart_id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `cart`;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` (`cart_id`, `created_at`) VALUES
	(90, '2020-08-11 19:36:23');
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;

DROP TABLE IF EXISTS `cart_article`;
CREATE TABLE IF NOT EXISTS `cart_article` (
  `cart_article_id` int unsigned NOT NULL AUTO_INCREMENT,
  `cart_id` int unsigned NOT NULL,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `quantity` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`cart_article_id`),
  UNIQUE KEY `uq_cart_article_cart_id_article_id` (`cart_id`,`article_id`),
  KEY `fk_cart_article_article_id` (`article_id`),
  CONSTRAINT `fk_cart_article_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_cart_article_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `cart_article`;
/*!40000 ALTER TABLE `cart_article` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_article` ENABLE KEYS */;

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `category_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '0',
  `image_path` varchar(128) NOT NULL DEFAULT '0',
  `description` varchar(128) NOT NULL,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `uq_category_name` (`name`),
  UNIQUE KEY `uq_category_image_path` (`image_path`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `category`;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`category_id`, `name`, `image_path`, `description`) VALUES
	(28, 'Necklaces', 'https://www.murujewellery.com/images/new-beginnings-butterfly-necklace-silver-p372-9412_zoom.jpg', 'A necklace is a form of jewelry worn suspended around the neck'),
	(29, 'Bracelets', 'https://www.uncommongoods.com/images/items/47600/47654_1_640px.jpg', 'A bracelet is an article of jewellery that is worn around the wrist'),
	(30, 'Earrings', 'https://www.kayoutlet.com/productimages/processed/V-502177203_0_800.jpg?pristine=true', 'An earring is a piece of jewelry attached to the ear via a piercing in the earlobe'),
	(31, 'Rings', 'https://images-na.ssl-images-amazon.com/images/I/71au4m8IsRL._AC_UY395_.jpg', 'A ring is a round band, usually of metal, worn as ornamental jewellery'),
	(32, 'Watches', 'https://n.nordstrommedia.com/id/sr3/7f2e72d3-ea0b-42b4-857d-c289917c883c.jpeg?crop=pad&pad_color=FFF&format=jpeg&w=780&h=1196', 'A watch is a portable timepiece intended to be carried or worn by a person');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

DROP TABLE IF EXISTS `feature`;
CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL DEFAULT '0',
  `category_id` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`feature_id`),
  UNIQUE KEY `uq_feature_name_category_id` (`name`,`category_id`),
  KEY `fk_feature_category_id` (`category_id`),
  CONSTRAINT `fk_feature_category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `feature`;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
INSERT INTO `feature` (`feature_id`, `name`, `category_id`) VALUES
	(29, 'Color', 28),
	(32, 'Color', 29),
	(36, 'Color', 30),
	(44, 'Color', 32),
	(46, 'Display type', 32),
	(25, 'Manufacturer', 28),
	(30, 'Manufacturer', 29),
	(34, 'Manufacturer', 30),
	(38, 'Manufacturer', 31),
	(42, 'Manufacturer', 32),
	(27, 'Material', 28),
	(31, 'Material', 29),
	(35, 'Material', 30),
	(39, 'Material', 31),
	(43, 'Material', 32),
	(40, 'Size', 31),
	(28, 'Style', 28),
	(33, 'Style', 29),
	(37, 'Style', 30),
	(41, 'Style', 31),
	(45, 'Style', 32);
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `order_id` int unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cart_id` int unsigned NOT NULL,
  `name` varchar(128) NOT NULL,
  `surname` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `address` varchar(128) NOT NULL,
  PRIMARY KEY (`order_id`),
  UNIQUE KEY `uq_order_cart_id` (`cart_id`),
  CONSTRAINT `fk_order_cart_id` FOREIGN KEY (`cart_id`) REFERENCES `cart` (`cart_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `order`;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;

DROP TABLE IF EXISTS `photo`;
CREATE TABLE IF NOT EXISTS `photo` (
  `photo_id` int unsigned NOT NULL AUTO_INCREMENT,
  `article_id` int unsigned NOT NULL DEFAULT '0',
  `image_path` varchar(128) NOT NULL DEFAULT '0',
  PRIMARY KEY (`photo_id`),
  UNIQUE KEY `uq_photo_image_path` (`image_path`),
  KEY `fk_photo_article_id` (`article_id`),
  CONSTRAINT `fk_photo_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DELETE FROM `photo`;
/*!40000 ALTER TABLE `photo` DISABLE KEYS */;
INSERT INTO `photo` (`photo_id`, `article_id`, `image_path`) VALUES
	(80, 88, '2020811-7357466652-07046f9a-513b-47f7-a49b-93be70791d6e.jpg'),
	(81, 89, '2020811-4866974636-71tdwygdyl._ac_ul1500_.jpg'),
	(82, 90, '2020811-5744452385-18e338e3-e4e5-4095-8cfd-eccb679e3411.jpg'),
	(83, 90, '2020811-2551278897-90541057-f31a-47c2-b7b7-9525cde6cdd6.jpg'),
	(84, 90, '2020811-7422424877-dfd882da-94e2-4ab7-bec1-4c9a1927a499.jpg'),
	(85, 89, '2020811-6572527177-b1672905-3c89-4007-a716-cf21602f20fc.jpg'),
	(86, 89, '2020811-8637170111-c0bd9ea4-eee6-4c27-bfc7-240e88198222.jpg'),
	(87, 91, '2020811-4574477010-45529e51-2ccb-4ee4-b469-32c26d47325a.jpg'),
	(89, 88, '2020811-5453867426-2221bce5-f8b6-4631-b1b8-ffbc78767c8a.jpg'),
	(90, 88, '2020811-3642085177-bf4a625e-b6db-494e-b72b-9902bfd6031d.jpg'),
	(91, 92, '2020811-3630143521-35dc2b9f-927c-4df3-ba35-740b5af638cb.jpg'),
	(92, 93, '2020811-7168153661-d0266cec-c0a4-4723-92cc-b80005513eeb.jpg'),
	(93, 94, '2020811-0501546796-5492b9c4-516a-4879-b2e9-da044f2d9de5.jpg'),
	(94, 94, '2020811-2877561967-2a643269-46ab-41cc-b51d-12e706366938.jpg'),
	(95, 94, '2020811-4647511353-1c3f870f-5ffe-45b0-8d37-08bc1547cdb8.jpg'),
	(97, 95, '2020811-6206768156-0a79dcd8-7bf5-4219-9c6a-09a5c1dc2eb3.jpg'),
	(98, 96, '2020811-6853928231-819bb8f5-f566-4f13-a5fc-8099c53a7c23.jpg'),
	(99, 97, '2020811-1812578683-1b29c602-fd07-4954-8910-f5784b884c3a.jpg'),
	(100, 97, '2020811-4821660566-7a73afdb-24ee-4671-bce1-f1311ee3da56.jpg'),
	(101, 97, '2020811-4785122345-795625b9-bdb0-4332-99d9-63051afdfc59.jpg'),
	(102, 98, '2020811-2845198268-3f953568-865b-465d-b465-518acff2fbf2.jpg'),
	(104, 99, '2020811-5037135702-1d10790f-b154-457b-aab3-12bd5f333089.jpg'),
	(105, 100, '2020811-3231697185-6fde64a1-939f-4537-aa9a-3fa731bd2656.jpg'),
	(106, 100, '2020811-7138573477-8cc68a58-61b2-487c-b690-9f2d12e9eada.jpg'),
	(108, 101, '2020811-6514687337-f61270f8-ab92-4e41-b88e-bb8c619a90f6.jpg'),
	(109, 102, '2020811-6471632387-3b95d5ff-034f-45f5-b1a5-c40fe952a1c1.jpg');
/*!40000 ALTER TABLE `photo` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
