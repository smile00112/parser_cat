-- phpMyAdmin SQL Dump
-- version 2.11.8.1deb5+lenny6
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Июн 08 2012 г., 12:49
-- Версия сервера: 5.0.51
-- Версия PHP: 5.2.6-1+lenny9

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База данных: `nord`
--

-- --------------------------------------------------------

--
-- Структура таблицы `catalog_text`
--

CREATE TABLE IF NOT EXISTS `catalog_text` (
  `id` int(11) NOT NULL auto_increment,
  `idpage` int(11) NOT NULL,
  `idcatalog` int(11) NOT NULL,
  `top_text` text,
  `bottom_text` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 AUTO_INCREMENT=1 ;

--
-- Дамп данных таблицы `catalog_text`
--

