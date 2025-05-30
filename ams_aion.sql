-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 30-09-2024 a las 14:36:51
-- Versión del servidor: 10.6.18-MariaDB-cll-lve
-- Versión de PHP: 8.1.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ams.aion`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `acciones`
--

CREATE TABLE `acciones` (
  `id` int(11) NOT NULL,
  `tipo_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `departamento_id` int(11) NOT NULL,
  `proceso_id` int(11) NOT NULL,
  `estatus_id` int(11) DEFAULT NULL,
  `responsable_id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(200) DEFAULT NULL,
  `link` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `acciones`
--

INSERT INTO `acciones` (`id`, `tipo_id`, `area_id`, `departamento_id`, `proceso_id`, `estatus_id`, `responsable_id`, `titulo`, `link`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2, 1, 1, 1, 140, 2, 185, 'a3 contrataciones', 'https://docs.google.com/document/d/1Xe9Psk8VVKFfmfr-bzmBAHD1IrBszNE_IDEaQ9dN0js/edit?usp=sharing', '2024-08-10 03:51:27', '2024-08-17 04:07:48', NULL),
(4, 3, 3, 2, 218, 3, 172, 'Organización y Optimización de Documentos Gráficos  en el ´Área de Diseño', 'https://drive.google.com/drive/folders/1uQs7OUkWwtBdjR2gG5bQlGP1YI1jQish?usp=drive_link', '2024-08-22 06:58:01', '2024-08-22 06:58:01', NULL),
(5, 1, 5, 52, 309, 2, 1, 'test', 'https://www.lipsum.com/feed/html', '2024-09-27 02:39:35', '2024-09-27 02:39:35', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `areas`
--

CREATE TABLE `areas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `areas`
--

INSERT INTO `areas` (`id`, `nombre`, `descripcion`, `updated_at`, `created_at`, `deleted_at`) VALUES
(1, 'Gente y Cultura', 'Es el departamento de RH', '2024-08-23 23:35:04', '2024-06-14 10:51:32', NULL),
(2, 'TI', 'Nos provee todo para conectarnos', '2024-07-25 22:32:57', '2024-06-14 10:52:08', NULL),
(3, 'DNP/Ventas/MKT', 'Traen clientes y productos (Mkt, Nuevos Productos y Ventas)', '2024-07-25 23:32:41', '2024-06-14 11:37:38', NULL),
(4, 'Operaciones', 'Nada más hacen el producto', '2024-07-05 08:23:22', '2024-06-15 09:58:03', NULL),
(5, 'Administración', 'Aseguran los recursos', '2024-07-25 05:15:16', '2024-06-15 09:58:03', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `area_evaluacion`
--

CREATE TABLE `area_evaluacion` (
  `id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `feedback` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `assessments`
--

CREATE TABLE `assessments` (
  `id` int(11) NOT NULL,
  `titulo` varchar(250) DEFAULT NULL,
  `description` varchar(250) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `assessments`
--

INSERT INTO `assessments` (`id`, `titulo`, `description`, `created_by`, `created_at`, `updated_at`) VALUES
(1, NULL, NULL, 142, '2024-09-28 08:23:33', '2024-09-28 08:23:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `assessment_asignado`
--

CREATE TABLE `assessment_asignado` (
  `id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `seccion_id` int(11) NOT NULL,
  `estatus` varchar(250) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `assessment_asignado`
--

INSERT INTO `assessment_asignado` (`id`, `assessment_id`, `seccion_id`, `estatus`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(2, 1, 2, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(3, 1, 3, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(4, 1, 4, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(5, 1, 5, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(6, 1, 6, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(7, 1, 7, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(8, 1, 8, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(9, 1, 9, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(10, 1, 10, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(11, 1, 11, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(12, 1, 12, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(13, 1, 13, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(14, 1, 14, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(15, 1, 15, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(16, 1, 16, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(17, 1, 17, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(18, 1, 18, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(19, 1, 19, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(20, 1, 20, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(21, 1, 21, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(22, 1, 22, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(23, 1, 23, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(24, 1, 24, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(25, 1, 25, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(26, 1, 26, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(27, 1, 28, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(28, 1, 29, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(29, 1, 30, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(30, 1, 31, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(31, 1, 32, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(32, 1, 33, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(33, 1, 34, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(34, 1, 35, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(35, 1, 36, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(36, 1, 37, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(37, 1, 38, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33'),
(38, 1, 39, 'INCOMPLETO', '2024-09-28 08:23:33', '2024-09-28 08:23:33');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `avisos`
--

CREATE TABLE `avisos` (
  `id` int(11) NOT NULL,
  `departamento_id` int(11) NOT NULL,
  `semana_id` int(11) NOT NULL,
  `reporte_id` int(11) NOT NULL,
  `aviso` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_for` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bloque`
--

CREATE TABLE `bloque` (
  `id` int(11) NOT NULL,
  `titulo` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `bloque`
--

INSERT INTO `bloque` (`id`, `titulo`) VALUES
(1, 'pilar'),
(2, 'Flujo de valor'),
(3, 'Proceso'),
(4, 'Procedimiento');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('00a4fdca74f757d800f64918e8a7fb79', 'i:1;', 1727400233),
('00a4fdca74f757d800f64918e8a7fb79:timer', 'i:1727400233;', 1727400233),
('019ba7eca5abc6dd5699fad06766f724', 'i:1;', 1723212709),
('019ba7eca5abc6dd5699fad06766f724:timer', 'i:1723212709;', 1723212709),
('02450654362381851206d27d672e2778', 'i:1;', 1722447337),
('02450654362381851206d27d672e2778:timer', 'i:1722447337;', 1722447337),
('048f8eceb8756f1ca1751a72a26455f5', 'i:2;', 1727458496),
('048f8eceb8756f1ca1751a72a26455f5:timer', 'i:1727458496;', 1727458496),
('06312b2c9d1ec06ebb020c90aff5089a', 'i:1;', 1721260450),
('06312b2c9d1ec06ebb020c90aff5089a:timer', 'i:1721260450;', 1721260450),
('06658dac7426f610105fad90b8c0f1c7', 'i:1;', 1724374942),
('06658dac7426f610105fad90b8c0f1c7:timer', 'i:1724374942;', 1724374942),
('06e49d36155ed7ea0fb8f59d127f6273', 'i:1;', 1725041791),
('06e49d36155ed7ea0fb8f59d127f6273:timer', 'i:1725041791;', 1725041791),
('0711f54f546ec15046a180e4a412ba2e', 'i:1;', 1725041694),
('0711f54f546ec15046a180e4a412ba2e:timer', 'i:1725041694;', 1725041694),
('073b6e19e5f2b6301f6810f1cf30ae1a', 'i:1;', 1726803193),
('073b6e19e5f2b6301f6810f1cf30ae1a:timer', 'i:1726803193;', 1726803193),
('0858b449f8066b43da05a592786279ae', 'i:1;', 1726254497),
('0858b449f8066b43da05a592786279ae:timer', 'i:1726254497;', 1726254497),
('0c725043529f66c17e91ce8df5d48229', 'i:1;', 1727369276),
('0c725043529f66c17e91ce8df5d48229:timer', 'i:1727369276;', 1727369276),
('0d121e6ee16e6f3119ce501ab279a18d', 'i:1;', 1727223000),
('0d121e6ee16e6f3119ce501ab279a18d:timer', 'i:1727223000;', 1727223000),
('108bd8d7d089956ce6e051caff497f5f', 'i:2;', 1727471906),
('108bd8d7d089956ce6e051caff497f5f:timer', 'i:1727471906;', 1727471906),
('113431d67ce14b2e9e567581ee0a6a47', 'i:1;', 1720143291),
('113431d67ce14b2e9e567581ee0a6a47:timer', 'i:1720143291;', 1720143291),
('177a59e5f10b78f5584eff8dcde7d923', 'i:1;', 1727145679),
('177a59e5f10b78f5584eff8dcde7d923:timer', 'i:1727145679;', 1727145679),
('185940e798dd702349d82658a8bb4f70', 'i:1;', 1724170968),
('185940e798dd702349d82658a8bb4f70:timer', 'i:1724170967;', 1724170968),
('18d7e55b9055fc3eca4849351aba88cc', 'i:2;', 1727476550),
('18d7e55b9055fc3eca4849351aba88cc:timer', 'i:1727476550;', 1727476550),
('1ae5d7202add30588763168bcd7fa9d0', 'i:1;', 1727385926),
('1ae5d7202add30588763168bcd7fa9d0:timer', 'i:1727385926;', 1727385926),
('1af5bfa07013c2a7bbf75062336c1972', 'i:1;', 1724709022),
('1af5bfa07013c2a7bbf75062336c1972:timer', 'i:1724709022;', 1724709022),
('1b6987f319085742630d94bffdff0e2c', 'i:1;', 1722900586),
('1b6987f319085742630d94bffdff0e2c:timer', 'i:1722900586;', 1722900586),
('1ed4a685e77e232742b454492dcf0a1f', 'i:2;', 1722438842),
('1ed4a685e77e232742b454492dcf0a1f:timer', 'i:1722438842;', 1722438842),
('21fc0dde6fcd29909c59e177bae3a101', 'i:2;', 1726676088),
('21fc0dde6fcd29909c59e177bae3a101:timer', 'i:1726676088;', 1726676088),
('22136d4382a5bc420260b1848b95f8ad', 'i:1;', 1722444486),
('22136d4382a5bc420260b1848b95f8ad:timer', 'i:1722444486;', 1722444486),
('278083111ae5fc94dba49183f46e5e1b', 'i:1;', 1726232402),
('278083111ae5fc94dba49183f46e5e1b:timer', 'i:1726232402;', 1726232402),
('2b05450fd846d5f7dc5a61440ba87c3f', 'i:1;', 1720547068),
('2b05450fd846d5f7dc5a61440ba87c3f:timer', 'i:1720547067;', 1720547067),
('2da5fcc466841c87247d3904d5fcd256', 'i:1;', 1722284373),
('2da5fcc466841c87247d3904d5fcd256:timer', 'i:1722284373;', 1722284373),
('2e51c03584737c85cec462f53cf6f720', 'i:1;', 1718999978),
('2e51c03584737c85cec462f53cf6f720:timer', 'i:1718999978;', 1718999978),
('338f2011bc96a7b8703cce21adb2b436', 'i:1;', 1722288991),
('338f2011bc96a7b8703cce21adb2b436:timer', 'i:1722288991;', 1722288991),
('33e635956cf624253e912d483f5dabb8', 'i:1;', 1722603418),
('33e635956cf624253e912d483f5dabb8:timer', 'i:1722603418;', 1722603418),
('35ee7ad1671ed3d8c7104e318d5f66a2', 'i:2;', 1718912378),
('35ee7ad1671ed3d8c7104e318d5f66a2:timer', 'i:1718912378;', 1718912378),
('36cd1edc5e59616fc5f59d6ffb947b67', 'i:1;', 1727281657),
('36cd1edc5e59616fc5f59d6ffb947b67:timer', 'i:1727281657;', 1727281657),
('37ec08629416b4d802d154fcb8fdc960', 'i:1;', 1727710345),
('37ec08629416b4d802d154fcb8fdc960:timer', 'i:1727710345;', 1727710345),
('390d4ff9d203ad75cbfbaa2d9a1f8bef', 'i:1;', 1723228960),
('390d4ff9d203ad75cbfbaa2d9a1f8bef:timer', 'i:1723228960;', 1723228960),
('39f7e7688851c1fe5ef039bb99cbfd31', 'i:1;', 1725958673),
('39f7e7688851c1fe5ef039bb99cbfd31:timer', 'i:1725958673;', 1725958673),
('3a995d5567a96f529f52fcad34f16b1b', 'i:1;', 1722822611),
('3a995d5567a96f529f52fcad34f16b1b:timer', 'i:1722822611;', 1722822611),
('3b47d8f7423d84729e7f34da08e85346', 'i:1;', 1720546094),
('3b47d8f7423d84729e7f34da08e85346:timer', 'i:1720546094;', 1720546094),
('3cfd2bcced1facabf15af3bc3345e87a', 'i:1;', 1727471976),
('3cfd2bcced1facabf15af3bc3345e87a:timer', 'i:1727471976;', 1727471976),
('3d46569f6fc72f5aebe230e9b9e4cc91', 'i:1;', 1727287080),
('3d46569f6fc72f5aebe230e9b9e4cc91:timer', 'i:1727287080;', 1727287080),
('3dd5d0e3f890e55510f26dd8287a195a', 'i:1;', 1718983602),
('3dd5d0e3f890e55510f26dd8287a195a:timer', 'i:1718983602;', 1718983602),
('3eaf5bd5bbf53cac446b47ec1fa8310e', 'i:1;', 1726762924),
('3eaf5bd5bbf53cac446b47ec1fa8310e:timer', 'i:1726762924;', 1726762924),
('40ab4c67a9e98e4aa3a7527a54541819', 'i:1;', 1718983585),
('40ab4c67a9e98e4aa3a7527a54541819:timer', 'i:1718983585;', 1718983585),
('4316deddd592d36e04ecd6575692bf53', 'i:1;', 1722352748),
('4316deddd592d36e04ecd6575692bf53:timer', 'i:1722352748;', 1722352748),
('4339596e05a514c5103d62fbdbaffcd8', 'i:1;', 1727486206),
('4339596e05a514c5103d62fbdbaffcd8:timer', 'i:1727486206;', 1727486206),
('44e9ba97a67af3373f0bd8c739a968f2', 'i:1;', 1727284564),
('44e9ba97a67af3373f0bd8c739a968f2:timer', 'i:1727284564;', 1727284564),
('4aad8f5903a31f00c380cb15a4fb11a6', 'i:1;', 1725041502),
('4aad8f5903a31f00c380cb15a4fb11a6:timer', 'i:1725041502;', 1725041502),
('4bd9f8be276b9f7c5322adbca8d9633b', 'i:1;', 1721749501),
('4bd9f8be276b9f7c5322adbca8d9633b:timer', 'i:1721749501;', 1721749501),
('4c5e589377f7557b6666162c0eecb528', 'i:1;', 1720546446),
('4c5e589377f7557b6666162c0eecb528:timer', 'i:1720546446;', 1720546446),
('4d4cfdd85fd498d7a6e200268f414686', 'i:1;', 1725126785),
('4d4cfdd85fd498d7a6e200268f414686:timer', 'i:1725126785;', 1725126785),
('50dd1706b4292558f366a3b59dd93b11', 'i:1;', 1727446959),
('50dd1706b4292558f366a3b59dd93b11:timer', 'i:1727446959;', 1727446959),
('5280acdd9faa2f7d6ce5225432f158b4', 'i:1;', 1726772742),
('5280acdd9faa2f7d6ce5225432f158b4:timer', 'i:1726772742;', 1726772742),
('55665923750554d3dd2970ba024e3126', 'i:1;', 1722290926),
('55665923750554d3dd2970ba024e3126:timer', 'i:1722290926;', 1722290926),
('55df1a3d8a19455c2be99b0b517db449', 'i:2;', 1727218825),
('55df1a3d8a19455c2be99b0b517db449:timer', 'i:1727218825;', 1727218825),
('55e7fd9725cec48bb93a92145eb05747', 'i:1;', 1727470491),
('55e7fd9725cec48bb93a92145eb05747:timer', 'i:1727470491;', 1727470491),
('576bec8a4ec3765dc5e75eca9996e010', 'i:1;', 1718945266),
('576bec8a4ec3765dc5e75eca9996e010:timer', 'i:1718945266;', 1718945266),
('579f4bb6c40c835b84d5860dac4676e3', 'i:1;', 1718945138),
('579f4bb6c40c835b84d5860dac4676e3:timer', 'i:1718945138;', 1718945138),
('57aca805c854e96ab6c20ebc7fd7323c', 'i:1;', 1719501526),
('57aca805c854e96ab6c20ebc7fd7323c:timer', 'i:1719501526;', 1719501526),
('598003635a275f1fca7e617fd2b5c210', 'i:1;', 1726837118),
('598003635a275f1fca7e617fd2b5c210:timer', 'i:1726837118;', 1726837118),
('59a112909fdf979d80df40c5b6e37743', 'i:1;', 1721880329),
('59a112909fdf979d80df40c5b6e37743:timer', 'i:1721880329;', 1721880329),
('5cb95d1fe7a0523346671ebcf048a8da', 'i:1;', 1721764259),
('5cb95d1fe7a0523346671ebcf048a8da:timer', 'i:1721764259;', 1721764259),
('5cce504914f5991ce2524f5c4346641d', 'i:1;', 1718945159),
('5cce504914f5991ce2524f5c4346641d:timer', 'i:1718945159;', 1718945159),
('5f72a865b978a93a4f7880f775320a77', 'i:1;', 1727290761),
('5f72a865b978a93a4f7880f775320a77:timer', 'i:1727290761;', 1727290761),
('604f155bbd3ad365b317cf94c8a5cfe6', 'i:1;', 1722536766),
('604f155bbd3ad365b317cf94c8a5cfe6:timer', 'i:1722536766;', 1722536766),
('60845901a70c093304410d01f49277ad', 'i:2;', 1726872286),
('60845901a70c093304410d01f49277ad:timer', 'i:1726872286;', 1726872286),
('60d23e7b256e558b11055ae76a98edd7', 'i:1;', 1721942936),
('60d23e7b256e558b11055ae76a98edd7:timer', 'i:1721942936;', 1721942936),
('613bf9f135c447ee26a3bdd2c07f092b', 'i:1;', 1722031570),
('613bf9f135c447ee26a3bdd2c07f092b:timer', 'i:1722031570;', 1722031570),
('61f7a229591a4579e8f0f0388d53f1ff', 'i:1;', 1726254433),
('61f7a229591a4579e8f0f0388d53f1ff:timer', 'i:1726254433;', 1726254433),
('63c73587be3e9eb10f4109a376fa4387', 'i:1;', 1718809637),
('63c73587be3e9eb10f4109a376fa4387:timer', 'i:1718809637;', 1718809637),
('643d123dd6096984124b263d6d553059', 'i:1;', 1725910576),
('643d123dd6096984124b263d6d553059:timer', 'i:1725910576;', 1725910576),
('6758332a558bfe76bc00518be54b2c30', 'i:1;', 1727281820),
('6758332a558bfe76bc00518be54b2c30:timer', 'i:1727281820;', 1727281820),
('67b998c5969cedab4df5e61f71caa0a3', 'i:1;', 1727281445),
('67b998c5969cedab4df5e61f71caa0a3:timer', 'i:1727281445;', 1727281445),
('685bb2850bb6fdc2827cf8de977e7e27', 'i:1;', 1721673907),
('685bb2850bb6fdc2827cf8de977e7e27:timer', 'i:1721673907;', 1721673907),
('6a33a0d1e326f22f40c7fe82800f3a3b', 'i:2;', 1726164870),
('6a33a0d1e326f22f40c7fe82800f3a3b:timer', 'i:1726164870;', 1726164870),
('6b744ab00ed8d54ed108009b3dae78a4', 'i:1;', 1724422271),
('6b744ab00ed8d54ed108009b3dae78a4:timer', 'i:1724422271;', 1724422271),
('6c14892a4cd7ed110ce2552094e5b9f6', 'i:1;', 1721404041),
('6c14892a4cd7ed110ce2552094e5b9f6:timer', 'i:1721404041;', 1721404041),
('6c49e57ed9820f3ca465566d34067ff1', 'i:1;', 1718945031),
('6c49e57ed9820f3ca465566d34067ff1:timer', 'i:1718945031;', 1718945031),
('6dd7f3d8faa1a097a3013b1ef5064374', 'i:1;', 1727320273),
('6dd7f3d8faa1a097a3013b1ef5064374:timer', 'i:1727320273;', 1727320273),
('70c0c7ba2ce6fdbe6536812fdd5eaecb', 'i:1;', 1723236341),
('70c0c7ba2ce6fdbe6536812fdd5eaecb:timer', 'i:1723236341;', 1723236341),
('717b149f9abf66eb277ef23a895bc63b', 'i:1;', 1724373857),
('717b149f9abf66eb277ef23a895bc63b:timer', 'i:1724373857;', 1724373857),
('72cf9b09c537f3af7bb8d3640ae9c841', 'i:1;', 1725252754),
('72cf9b09c537f3af7bb8d3640ae9c841:timer', 'i:1725252754;', 1725252754),
('799f42e5fdb6e88ae144e7cd1d1fbab4', 'i:1;', 1724420701),
('799f42e5fdb6e88ae144e7cd1d1fbab4:timer', 'i:1724420701;', 1724420701),
('7a6a2bc2b4999a05dcb78a03d4cf8266', 'i:1;', 1724353058),
('7a6a2bc2b4999a05dcb78a03d4cf8266:timer', 'i:1724353058;', 1724353058),
('7f60f803957340743b8bb6230da58022', 'i:2;', 1727194636),
('7f60f803957340743b8bb6230da58022:timer', 'i:1727194636;', 1727194636),
('8161bb2335bf22370b39ba8c27ca402c', 'i:1;', 1725314095),
('8161bb2335bf22370b39ba8c27ca402c:timer', 'i:1725314095;', 1725314095),
('83202843967a8c49e50b041d7459deb4', 'i:1;', 1721765223),
('83202843967a8c49e50b041d7459deb4:timer', 'i:1721765223;', 1721765223),
('83897bb29a20669b6570c241d6d6b3b3', 'i:1;', 1719868993),
('83897bb29a20669b6570c241d6d6b3b3:timer', 'i:1719868993;', 1719868993),
('83b1cb32e8cf5e5ca33f5a4d2449aa53', 'i:1;', 1720558712),
('83b1cb32e8cf5e5ca33f5a4d2449aa53:timer', 'i:1720558712;', 1720558712),
('8464cad1fc16639c8ba3fac3262153d5', 'i:1;', 1725032906),
('8464cad1fc16639c8ba3fac3262153d5:timer', 'i:1725032906;', 1725032906),
('862a72d939b9ec3cd7191c535f4a96a0', 'i:1;', 1724433162),
('862a72d939b9ec3cd7191c535f4a96a0:timer', 'i:1724433162;', 1724433162),
('87d2d0fcba3cf06330a63856c86b638e', 'i:1;', 1722272929),
('87d2d0fcba3cf06330a63856c86b638e:timer', 'i:1722272929;', 1722272929),
('88fc8cd099ca4bbe758f7809fb548bb7', 'i:1;', 1727278407),
('88fc8cd099ca4bbe758f7809fb548bb7:timer', 'i:1727278407;', 1727278407),
('8a4631070deaeabdd8b3f43b4ea144fb', 'i:2;', 1727474953),
('8a4631070deaeabdd8b3f43b4ea144fb:timer', 'i:1727474953;', 1727474953),
('8d3426f9e736835539c3a3547a1d729d', 'i:1;', 1726162452),
('8d3426f9e736835539c3a3547a1d729d:timer', 'i:1726162452;', 1726162452),
('8e1466ed227826606f4a9f6af584aa00', 'i:2;', 1724088526),
('8e1466ed227826606f4a9f6af584aa00:timer', 'i:1724088526;', 1724088526),
('8f077eaa0bec33dcfa4a41ede207e5e1', 'i:4;', 1726162340),
('8f077eaa0bec33dcfa4a41ede207e5e1:timer', 'i:1726162340;', 1726162340),
('90568d5a1d2587fb8eacd20be075c5c3', 'i:1;', 1726254833),
('90568d5a1d2587fb8eacd20be075c5c3:timer', 'i:1726254833;', 1726254833),
('920d37b0dd512c33bf3e53277e299aaf', 'i:1;', 1725661931),
('920d37b0dd512c33bf3e53277e299aaf:timer', 'i:1725661931;', 1725661931),
('927211d11364908f14cdf1755e651e4a', 'i:1;', 1722894551),
('927211d11364908f14cdf1755e651e4a:timer', 'i:1722894551;', 1722894551),
('928e9035b7f5af3f753faa4bcbcd2ff0', 'i:1;', 1718945245),
('928e9035b7f5af3f753faa4bcbcd2ff0:timer', 'i:1718945245;', 1718945245),
('92d8f6a00aa1854f51c25000c6331484', 'i:1;', 1727727464),
('92d8f6a00aa1854f51c25000c6331484:timer', 'i:1727727464;', 1727727464),
('93155e604dc2ad2f256c090dd2dd8a87', 'i:1;', 1719442012),
('93155e604dc2ad2f256c090dd2dd8a87:timer', 'i:1719442012;', 1719442012),
('9391f78063e351b95ccc2eec58b11d70', 'i:1;', 1720049350),
('9391f78063e351b95ccc2eec58b11d70:timer', 'i:1720049350;', 1720049350),
('94da852f54020f91779d99ef4deb757b', 'i:1;', 1724175243),
('94da852f54020f91779d99ef4deb757b:timer', 'i:1724175243;', 1724175243),
('9610abb590d8ebf48f85921195041b59', 'i:1;', 1718983414),
('9610abb590d8ebf48f85921195041b59:timer', 'i:1718983414;', 1718983414),
('971b7f854324639858143310e0299ee6', 'i:1;', 1726176930),
('971b7f854324639858143310e0299ee6:timer', 'i:1726176930;', 1726176930),
('982a5e1e3b4a4c989ce22305d9c0618e', 'i:1;', 1721944716),
('982a5e1e3b4a4c989ce22305d9c0618e:timer', 'i:1721944716;', 1721944716),
('98477578614db0ac95a503257a7d6e6e', 'i:1;', 1725053741),
('98477578614db0ac95a503257a7d6e6e:timer', 'i:1725053741;', 1725053741),
('9881b65c745c68df47dd4299afd7c7ac', 'i:2;', 1725569227),
('9881b65c745c68df47dd4299afd7c7ac:timer', 'i:1725569227;', 1725569227),
('9b325ea4d235e9a45f8d63a3e2f17e2a', 'i:2;', 1726231174),
('9b325ea4d235e9a45f8d63a3e2f17e2a:timer', 'i:1726231174;', 1726231174),
('9ef12d3af82625d2d31f8a2db207e9af', 'i:1;', 1727106319),
('9ef12d3af82625d2d31f8a2db207e9af:timer', 'i:1727106319;', 1727106319),
('9f9e0e3165339c8421248a7a4ae1dc6e', 'i:1;', 1726874159),
('9f9e0e3165339c8421248a7a4ae1dc6e:timer', 'i:1726874159;', 1726874159),
('a0c34e19890240527bd1b2a73ec45f01', 'i:1;', 1727392746),
('a0c34e19890240527bd1b2a73ec45f01:timer', 'i:1727392746;', 1727392746),
('a249017945eb34641b71a39ad7bf12ee', 'i:1;', 1719962359),
('a249017945eb34641b71a39ad7bf12ee:timer', 'i:1719962359;', 1719962359),
('a33ac018bb48014909e51ebdd2afd177', 'i:1;', 1726762973),
('a33ac018bb48014909e51ebdd2afd177:timer', 'i:1726762973;', 1726762973),
('a5843f172ebe2a146adb6063726bc0d2', 'i:1;', 1724175283),
('a5843f172ebe2a146adb6063726bc0d2:timer', 'i:1724175283;', 1724175283),
('a5f5f50242a34ca6e325885254c078d1', 'i:1;', 1722048391),
('a5f5f50242a34ca6e325885254c078d1:timer', 'i:1722048391;', 1722048391),
('a804e232052da4979a5a6795aa0823c9', 'i:1;', 1722528906),
('a804e232052da4979a5a6795aa0823c9:timer', 'i:1722528906;', 1722528906),
('a8a70dbc239f8feb857dc806d5513aab', 'i:1;', 1722211457),
('a8a70dbc239f8feb857dc806d5513aab:timer', 'i:1722211457;', 1722211457),
('ac94256298f7db4270494a9a77d57b1b', 'i:1;', 1722624657),
('ac94256298f7db4270494a9a77d57b1b:timer', 'i:1722624657;', 1722624657),
('ac9c74196f9f8e61dcefb0e5ddfb5e04', 'i:1;', 1724588876),
('ac9c74196f9f8e61dcefb0e5ddfb5e04:timer', 'i:1724588876;', 1724588876),
('ad37d609d8952b6ee70b0b24af959771', 'i:1;', 1720119144),
('ad37d609d8952b6ee70b0b24af959771:timer', 'i:1720119144;', 1720119144),
('asistente.direccion@nutriton.com.mx|189.203.149.205', 'i:2;', 1727458496),
('asistente.direccion@nutriton.com.mx|189.203.149.205:timer', 'i:1727458496;', 1727458496),
('auxiliarcompras@nutriton.com|187.188.23.64', 'i:1;', 1727281657),
('auxiliarcompras@nutriton.com|187.188.23.64:timer', 'i:1727281657;', 1727281657),
('auxiliarproduccion@nutriton.com.mx|177.240.31.14', 'i:1;', 1726762925),
('auxiliarproduccion@nutriton.com.mx|177.240.31.14:timer', 'i:1726762925;', 1726762925),
('b252dfe515c78697e8a73f64af1db846', 'i:1;', 1726059837),
('b252dfe515c78697e8a73f64af1db846:timer', 'i:1726059837;', 1726059837),
('b424cc074a2f86732007b6ce571f8983', 'i:1;', 1727301123),
('b424cc074a2f86732007b6ce571f8983:timer', 'i:1727301123;', 1727301123),
('b790801bd1bcbff3a6e306170f50f924', 'i:1;', 1725725841),
('b790801bd1bcbff3a6e306170f50f924:timer', 'i:1725725841;', 1725725841),
('b9f30e9c53954aea73d6aa7accf0473d', 'i:1;', 1722048409),
('b9f30e9c53954aea73d6aa7accf0473d:timer', 'i:1722048409;', 1722048409),
('bb36cc3da2860fca60cc5cd56fa095c5', 'i:1;', 1721749452),
('bb36cc3da2860fca60cc5cd56fa095c5:timer', 'i:1721749452;', 1721749452),
('bead7a2c488d3c2c5d1003caf926c5c1', 'i:1;', 1726167004),
('bead7a2c488d3c2c5d1003caf926c5c1:timer', 'i:1726167004;', 1726167004),
('beae0172c4309a615429ae014f4e008f', 'i:1;', 1727303909),
('beae0172c4309a615429ae014f4e008f:timer', 'i:1727303909;', 1727303909),
('bfc3ad2c358d249ca0fb52c7c90075ff', 'i:1;', 1724364607),
('bfc3ad2c358d249ca0fb52c7c90075ff:timer', 'i:1724364607;', 1724364607),
('bfda459519a72f99f0960102c7e9f18e', 'i:1;', 1727474010),
('bfda459519a72f99f0960102c7e9f18e:timer', 'i:1727474010;', 1727474010),
('c.alvarez@nutriton.co.mx|187.188.23.64', 'i:1;', 1726772742),
('c.alvarez@nutriton.co.mx|187.188.23.64:timer', 'i:1726772742;', 1726772742),
('c.becerra@nutriton.com.mx|186.96.22.90', 'i:5;', 1726162402),
('c.becerra@nutriton.com.mx|186.96.22.90:timer', 'i:1726162402;', 1726162402),
('c0fdd96d697fe6d144a605536219ab80', 'i:1;', 1722981173),
('c0fdd96d697fe6d144a605536219ab80:timer', 'i:1722981173;', 1722981173),
('c22a9ea58411380d88f264c1a1b4aa44', 'i:2;', 1726165150),
('c22a9ea58411380d88f264c1a1b4aa44:timer', 'i:1726165150;', 1726165150),
('c2484402c2aa06f5bc86b5d78fac8d59', 'i:1;', 1722895017),
('c2484402c2aa06f5bc86b5d78fac8d59:timer', 'i:1722895017;', 1722895017),
('c425fdc94df70c8ac025ec0ba9a6264c', 'i:2;', 1727474959),
('c425fdc94df70c8ac025ec0ba9a6264c:timer', 'i:1727474959;', 1727474959),
('c592d7b98007e46d91a8fe37f3d698e6', 'i:1;', 1722289025),
('c592d7b98007e46d91a8fe37f3d698e6:timer', 'i:1722289025;', 1722289025),
('c5d5bdbbd59771cbe11d508a87ce51f7', 'i:2;', 1725575891),
('c5d5bdbbd59771cbe11d508a87ce51f7:timer', 'i:1725575891;', 1725575891),
('c60b20dc3e8a4bb60f50d8d4fe92fc3c', 'i:1;', 1720203696),
('c60b20dc3e8a4bb60f50d8d4fe92fc3c:timer', 'i:1720203696;', 1720203696),
('c78fce8020e7e9db36a90946bb0a1bf0', 'i:1;', 1722882727),
('c78fce8020e7e9db36a90946bb0a1bf0:timer', 'i:1722882727;', 1722882727),
('calidad@nutriton.com.mx|187.224.22.53', 'i:1;', 1724960460),
('calidad@nutriton.com.mx|187.224.22.53:timer', 'i:1724960460;', 1724960460),
('carlosgabrielbecerragallardo@gmail.com|186.96.22.90', 'i:4;', 1726162340),
('carlosgabrielbecerragallardo@gmail.com|186.96.22.90:timer', 'i:1726162340;', 1726162340),
('cb60d76e7ca0dd797c7fdaae73360ba5', 'i:1;', 1724085365),
('cb60d76e7ca0dd797c7fdaae73360ba5:timer', 'i:1724085365;', 1724085365),
('ccbbf253219be48dd441dc01cf4bef1d', 'i:1;', 1724960460),
('ccbbf253219be48dd441dc01cf4bef1d:timer', 'i:1724960460;', 1724960460),
('ced8e1a6be8766551348819c96c0cd3d', 'i:1;', 1727731220),
('ced8e1a6be8766551348819c96c0cd3d:timer', 'i:1727731220;', 1727731220),
('d.hermosillo@nutriton.com.mx|187.188.48.170', 'i:2;', 1727194336),
('d.hermosillo@nutriton.com.mx|187.188.48.170:timer', 'i:1727194336;', 1727194336),
('d225d1592f869a55170f5e3610ace4ef', 'i:1;', 1723161518),
('d225d1592f869a55170f5e3610ace4ef:timer', 'i:1723161518;', 1723161518),
('d38ec1d7088d88ba78954853e824e29b', 'i:1;', 1727474343),
('d38ec1d7088d88ba78954853e824e29b:timer', 'i:1727474343;', 1727474343),
('d3dffaaa767d8c088e47ac9cf7276fc3', 'i:1;', 1725905282),
('d3dffaaa767d8c088e47ac9cf7276fc3:timer', 'i:1725905282;', 1725905282),
('d43373a4fb315c4f2b6243010565db15', 'i:1;', 1725104485),
('d43373a4fb315c4f2b6243010565db15:timer', 'i:1725104485;', 1725104485),
('d623654a56c54883535fd1911eb08f60', 'i:1;', 1727218862),
('d623654a56c54883535fd1911eb08f60:timer', 'i:1727218862;', 1727218862),
('d77016d770053d1ce335ecf8d7bb9c8e', 'i:1;', 1721153611),
('d77016d770053d1ce335ecf8d7bb9c8e:timer', 'i:1721153611;', 1721153611),
('d97e06eb88be6832e4662f7525974e05', 'i:1;', 1718983621),
('d97e06eb88be6832e4662f7525974e05:timer', 'i:1718983621;', 1718983621),
('danupton1@aol.com|161.35.246.138', 'i:1;', 1718983621),
('danupton1@aol.com|161.35.246.138:timer', 'i:1718983621;', 1718983621),
('danupton1@aol.com|94.131.100.247', 'i:1;', 1718983414),
('danupton1@aol.com|94.131.100.247:timer', 'i:1718983414;', 1718983414),
('dba60fabf036028cc2433b2fafe5cb8b', 'i:1;', 1726165165),
('dba60fabf036028cc2433b2fafe5cb8b:timer', 'i:1726165165;', 1726165165),
('dc46f9177916792b582f5e5e6d19a8e4', 'i:1;', 1719886995),
('dc46f9177916792b582f5e5e6d19a8e4:timer', 'i:1719886995;', 1719886995),
('dcd70b131a461cee0913c807a55f6c9a', 'i:1;', 1720547022),
('dcd70b131a461cee0913c807a55f6c9a:timer', 'i:1720547022;', 1720547022),
('dde26cccc7133694d9ed05b018a983c1', 'i:1;', 1726871877),
('dde26cccc7133694d9ed05b018a983c1:timer', 'i:1726871877;', 1726871877),
('de72ef74cc2d463ccf6625c6a14b54ac', 'i:1;', 1722607768),
('de72ef74cc2d463ccf6625c6a14b54ac:timer', 'i:1722607768;', 1722607768),
('dedric.carroll@mteen.net|206.189.247.132', 'i:1;', 1718945183),
('dedric.carroll@mteen.net|206.189.247.132:timer', 'i:1718945183;', 1718945183),
('e.cabrera@nutrition.com.mx|187.188.48.170', 'i:1;', 1726254497),
('e.cabrera@nutrition.com.mx|187.188.48.170:timer', 'i:1726254497;', 1726254497),
('e.cabrera@nutrition.com|187.188.48.170', 'i:1;', 1726254433),
('e.cabrera@nutrition.com|187.188.48.170:timer', 'i:1726254433;', 1726254433),
('e0d1b1a7a8013389b1b9d698b626d44e', 'i:1;', 1726691284),
('e0d1b1a7a8013389b1b9d698b626d44e:timer', 'i:1726691284;', 1726691284),
('e176b91aec5759ebcb8f4034a582ff38', 'i:1;', 1722056551),
('e176b91aec5759ebcb8f4034a582ff38:timer', 'i:1722056551;', 1722056551),
('e2f434b16c1629da0e6e812e0719f812', 'i:2;', 1727194336),
('e2f434b16c1629da0e6e812e0719f812:timer', 'i:1727194336;', 1727194336),
('e5154229969de83ede700e669e4218d8', 'i:1;', 1726674406),
('e5154229969de83ede700e669e4218d8:timer', 'i:1726674406;', 1726674406),
('e6409583827d19edcb62501924bafba1', 'i:1;', 1725077040),
('e6409583827d19edcb62501924bafba1:timer', 'i:1725077040;', 1725077040),
('eafb6b313018ba79cb0f765963421cfe', 'i:1;', 1723766739),
('eafb6b313018ba79cb0f765963421cfe:timer', 'i:1723766739;', 1723766739),
('eb22ab1ae01bcc0e8bf2ee011454c8a8', 'i:1;', 1726192037),
('eb22ab1ae01bcc0e8bf2ee011454c8a8:timer', 'i:1726192037;', 1726192037),
('ebeca0f11d990d2b6d88a81517c69d6b', 'i:1;', 1727450412),
('ebeca0f11d990d2b6d88a81517c69d6b:timer', 'i:1727450412;', 1727450412),
('ebfe54788c1cfd0b69cf7b77baf0dc46', 'i:1;', 1727378488),
('ebfe54788c1cfd0b69cf7b77baf0dc46:timer', 'i:1727378488;', 1727378488),
('ec6f4be636e5ae84cfb03090f4777f55', 'i:1;', 1721843233),
('ec6f4be636e5ae84cfb03090f4777f55:timer', 'i:1721843233;', 1721843233),
('edd8b3fd348abdee084270a0413d0526', 'i:1;', 1724980758),
('edd8b3fd348abdee084270a0413d0526:timer', 'i:1724980758;', 1724980758),
('edf94cf5bcdf11d41ca16fa18583adcb', 'i:1;', 1725137845),
('edf94cf5bcdf11d41ca16fa18583adcb:timer', 'i:1725137845;', 1725137845),
('eeb46262c13b0801963f65a0af4aeb41', 'i:1;', 1727462181),
('eeb46262c13b0801963f65a0af4aeb41:timer', 'i:1727462181;', 1727462181),
('ef721cad4c3537cb4b61061c25fbac61', 'i:1;', 1727106368),
('ef721cad4c3537cb4b61061c25fbac61:timer', 'i:1727106368;', 1727106368),
('erik_murray20@mteen.net|146.190.197.169', 'i:1;', 1718945245),
('erik_murray20@mteen.net|146.190.197.169:timer', 'i:1718945245;', 1718945245),
('f086a86058ca45faf017f09de48085cb', 'i:2;', 1718945020),
('f086a86058ca45faf017f09de48085cb:timer', 'i:1718945020;', 1718945020),
('f10a3bc3614a543f8a493773011d1bdb', 'i:1;', 1727472532),
('f10a3bc3614a543f8a493773011d1bdb:timer', 'i:1727472532;', 1727472532),
('f2e1441064a5b0bae15368fe85012605', 'i:2;', 1727281621),
('f2e1441064a5b0bae15368fe85012605:timer', 'i:1727281621;', 1727281621),
('f3df23d285b7869c0106caa5e876d8d1', 'i:1;', 1727453531),
('f3df23d285b7869c0106caa5e876d8d1:timer', 'i:1727453531;', 1727453531),
('f5ea87a3e73c031ef1bcca4e94b9700d', 'i:1;', 1718945183),
('f5ea87a3e73c031ef1bcca4e94b9700d:timer', 'i:1718945183;', 1718945183),
('f76b70d47c4afa9930d75018cf8ae4ed', 'i:2;', 1722624601),
('f76b70d47c4afa9930d75018cf8ae4ed:timer', 'i:1722624601;', 1722624601),
('f9b6bbead07106884aec83b709ee90b4', 'i:1;', 1720734690),
('f9b6bbead07106884aec83b709ee90b4:timer', 'i:1720734690;', 1720734690),
('f9cbe8f0f746c93468706780845babea', 'i:1;', 1722291097),
('f9cbe8f0f746c93468706780845babea:timer', 'i:1722291097;', 1722291097),
('fc4ca07caf1f9dbc8c19f1f19b3f8af2', 'i:5;', 1726162402),
('fc4ca07caf1f9dbc8c19f1f19b3f8af2:timer', 'i:1726162402;', 1726162402),
('fcb01ef3dd9ded59b2871874d3f32086', 'i:2;', 1718983351),
('fcb01ef3dd9ded59b2871874d3f32086:timer', 'i:1718983351;', 1718983351),
('fdb3027a1478c3b921418a06112dd811', 'i:1;', 1718983393),
('fdb3027a1478c3b921418a06112dd811:timer', 'i:1718983393;', 1718983393),
('fe4b9c6a0545718a15d327be2c5d1206', 'i:2;', 1724426740),
('fe4b9c6a0545718a15d327be2c5d1206:timer', 'i:1724426740;', 1724426740),
('fe63d247dc8730f0d9d6a96e26ee6b53', 'i:1;', 1721931868),
('fe63d247dc8730f0d9d6a96e26ee6b53:timer', 'i:1721931868;', 1721931868),
('hilario.armstrong24@banglemail.com|94.131.100.247', 'i:2;', 1718983351),
('hilario.armstrong24@banglemail.com|94.131.100.247:timer', 'i:1718983351;', 1718983351),
('hugolehmann92@outlook.com|146.190.197.169', 'i:1;', 1718945266),
('hugolehmann92@outlook.com|146.190.197.169:timer', 'i:1718945266;', 1718945266),
('hugolehmann92@outlook.com|161.35.246.138', 'i:1;', 1718983602),
('hugolehmann92@outlook.com|161.35.246.138:timer', 'i:1718983602;', 1718983602),
('hugolehmann92@outlook.com|206.189.247.132', 'i:1;', 1718945159),
('hugolehmann92@outlook.com|206.189.247.132:timer', 'i:1718945159;', 1718945159),
('hugolehmann92@outlook.com|94.131.100.247', 'i:1;', 1718983393),
('hugolehmann92@outlook.com|94.131.100.247:timer', 'i:1718983393;', 1718983393),
('it@nutriton.com.mx|186.96.22.90', 'i:1;', 1726162452),
('it@nutriton.com.mx|186.96.22.90:timer', 'i:1726162452;', 1726162452),
('j.alvarado@nutriton.com.mx|187.188.48.170', 'i:2;', 1727218825),
('j.alvarado@nutriton.com.mx|187.188.48.170:timer', 'i:1727218825;', 1727218825),
('j.perez@nutriton.cm.mx|187.188.23.64', 'i:1;', 1726871877),
('j.perez@nutriton.cm.mx|187.188.23.64:timer', 'i:1726871877;', 1726871877),
('j.perez@nutriton.com|187.188.23.64', 'i:1;', 1726165165),
('j.perez@nutriton.com|187.188.23.64:timer', 'i:1726165165;', 1726165165),
('j.perz@nutriton.com.mx|187.188.23.64', 'i:1;', 1726762973),
('j.perz@nutriton.com.mx|187.188.23.64:timer', 'i:1726762973;', 1726762973),
('j.perz@nutriton.com|187.188.23.64', 'i:2;', 1726165150),
('j.perz@nutriton.com|187.188.23.64:timer', 'i:1726165150;', 1726165150),
('j.tovar@nutriton.com.mx|104.28.111.26', 'i:2;', 1724088526),
('j.tovar@nutriton.com.mx|104.28.111.26:timer', 'i:1724088526;', 1724088526),
('lalo@aion.com|186.96.26.66', 'i:1;', 1722288991),
('lalo@aion.com|186.96.26.66:timer', 'i:1722288991;', 1722288991),
('lalo@aion.com|187.188.48.170', 'i:1;', 1725126785),
('lalo@aion.com|187.188.48.170:timer', 'i:1725126785;', 1725126785),
('lalo@aion.com|187.190.202.32', 'i:1;', 1722352748),
('lalo@aion.com|187.190.202.32:timer', 'i:1722352748;', 1722352748),
('laura.hilll57@mteen.net|94.131.100.247', 'i:2;', 1718945020),
('laura.hilll57@mteen.net|94.131.100.247:timer', 'i:1718945020;', 1718945020),
('prueba@ion.com|187.188.48.170', 'i:1;', 1722290926),
('prueba@ion.com|187.188.48.170:timer', 'i:1722290926;', 1722290926),
('pureba@aion.com|187.188.48.170', 'i:1;', 1722291097),
('pureba@aion.com|187.188.48.170:timer', 'i:1722291097;', 1722291097),
('rickie_dibbert@banglemail.com|161.35.246.138', 'i:1;', 1718983585),
('rickie_dibbert@banglemail.com|161.35.246.138:timer', 'i:1718983585;', 1718983585),
('sstokes81@yahoo.com|206.189.247.132', 'i:1;', 1718945138),
('sstokes81@yahoo.com|206.189.247.132:timer', 'i:1718945138;', 1718945138),
('sstokes81@yahoo.com|94.131.100.247', 'i:1;', 1718945031),
('sstokes81@yahoo.com|94.131.100.247:timer', 'i:1718945031;', 1718945031);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `challenges`
--

CREATE TABLE `challenges` (
  `id` int(11) NOT NULL,
  `area_id` int(11) DEFAULT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `seccion_id` int(11) DEFAULT NULL,
  `challenge` varchar(100) NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `challenges`
--

INSERT INTO `challenges` (`id`, `area_id`, `departamento_id`, `seccion_id`, `challenge`, `updated_at`, `created_at`, `deleted_at`) VALUES
(1, 1, NULL, 1, 'Calidad de los Candidatos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(2, 1, NULL, 1, 'Tasa de Oferta a Aceptación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(3, 1, NULL, 1, 'Eficiencia del Proceso', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(4, 1, NULL, 1, 'Costo por Contratación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(5, 1, NULL, 1, 'Tiempo de Contratación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(6, 1, NULL, 2, 'Estructura de Compensación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(7, 1, NULL, 2, 'Beneficios para Empleados', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(8, 1, NULL, 2, 'Comunicación y Transparencia', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(9, 1, NULL, 2, 'Evaluación de la Compensación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(10, 1, NULL, 2, 'Exactitud y puntuliad de pagos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(11, 1, NULL, 3, 'Identificación de temas esenciales de capacitación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(12, 1, NULL, 3, 'Programa de Inducción', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(13, 1, NULL, 3, 'Cumplimiento de capacitación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(14, 1, NULL, 3, 'Calidad de la Formación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(15, 1, NULL, 3, 'Inversión en Formación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(16, 1, NULL, 3, 'Impacto en el Desempeño', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(17, 1, NULL, 4, 'Desarrollo del Personal', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(18, 1, NULL, 4, 'Satisfacción del Empleado', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(19, 1, NULL, 4, 'Planeación de vacaciones', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(20, 1, NULL, 4, 'Empoderamiento', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(21, 1, NULL, 5, 'Valores', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(22, 1, NULL, 5, 'Orden y limpieza ', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(23, 1, NULL, 5, 'Sistemas de ideas de mejora', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(24, 1, NULL, 5, 'Identificación de oportunidades', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(25, 1, NULL, 5, 'Reconocimiento y recompensa de los colaboradores', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(26, 1, NULL, 5, 'Comunicación Interna', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(27, 1, NULL, 5, 'Diversidad e Inclusión', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(28, 1, NULL, 5, 'Evaluación y Mejora de la Cultura', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(29, 1, NULL, 5, 'Celebración', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(30, 1, NULL, 5, 'Desvinculación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(31, 1, NULL, 5, 'Rotación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(32, 1, NULL, 5, 'Protección de datos de la compañía', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(33, 1, NULL, 6, 'Desarrollo de liderazgo en gerentes y coordinadores', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(34, 1, NULL, 6, 'Estilo de Liderazgo', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(35, 1, NULL, 6, 'Desarrollo de Líderes', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(36, 1, NULL, 6, 'Comunicación de los Líderes', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(37, 1, NULL, 6, 'Evaluación y Mejora del Liderazgo', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(38, 1, NULL, 7, 'Cumplimiento de Leyes Laborales', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(39, 2, NULL, 8, 'Selección de Hardware y Software', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(40, 2, NULL, 8, 'Configuración de Hardware y Software', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(41, 2, NULL, 8, 'Configuración de Redes', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(42, 2, NULL, 9, 'Selección de Aplicaciones', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(43, 2, NULL, 9, 'Implementación de Aplicaciones', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(44, 2, NULL, 9, 'Mantenimiento de Aplicaciones', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(45, 2, NULL, 10, 'Selección de Sistemas de Bases de Datos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(46, 2, NULL, 10, 'Implementación de Sistemas de Bases de Datos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(47, 2, NULL, 10, 'Mantenimiento de Sistemas de Bases de Datos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(48, 2, NULL, 11, 'Políticas de Seguridad de la Información', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(49, 2, NULL, 11, 'Implementación de Medidas de Seguridad', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(50, 2, NULL, 11, 'Monitoreo y Actualización de la Seguridad', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(51, 3, NULL, 12, 'Investigación de mercado', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(52, 3, NULL, 12, 'Canales de Marketing', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(53, 3, NULL, 12, 'Posicionamiento', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(54, 3, NULL, 12, 'Mensajes clave', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(55, 3, NULL, 13, 'Formación de Equipo de Ventas', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(56, 3, NULL, 13, 'Búsqueda y Adquisición de Clientes', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(57, 3, NULL, 13, 'Estrategia de Ventas', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(58, 3, NULL, 13, 'Gestión de Relaciones con los Clientes (CRM)', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(59, 3, NULL, 13, 'Análisis de Ventas y Rendimiento', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(60, 3, NULL, 14, 'Estrategia de Precios', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(61, 3, NULL, 14, 'Desarrollo de Plantillas de Cotización', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(62, 3, NULL, 14, 'Desarrollo de Propuestas de Venta', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(63, 3, NULL, 14, 'Procesos de Aprobación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(64, 3, NULL, 14, 'Seguimiento de Cotizaciones y Propuestas', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(65, 3, NULL, 15, 'Automatización de pedidos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(66, 3, NULL, 15, 'Seguimiento', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(67, 3, NULL, 15, 'Backlog', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(68, 3, NULL, 15, 'Integración de sistemas (CRM)', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(69, 3, NULL, 16, 'Evaluación del servicio', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(70, 3, NULL, 16, 'Servicio al cliente/Soporte postventa', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(71, 4, NULL, 17, 'Investigación de mercado', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(72, 4, NULL, 17, 'Generación de ideas', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(73, 4, NULL, 17, 'Desarrollo de conceptos ', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(74, 4, NULL, 17, 'Prototipos y pruebas', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(75, 4, NULL, 17, 'Lanzamiento al mercado', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(76, 4, NULL, 17, 'Evaluación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(77, 4, NULL, 18, 'Previsión de la Demanda', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(78, 4, NULL, 18, 'Planificación de la Capacidad', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(79, 4, NULL, 18, 'Programación de la Producción', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(80, 4, NULL, 18, 'Gestión de Inventarios (MP/PT)', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(81, 4, NULL, 19, 'Conocimiento del Mercado', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(82, 4, NULL, 19, 'Proyecciones de Demanda', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(83, 4, NULL, 19, 'Adaptabilidad a Cambios de Demanda', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(84, 4, NULL, 20, 'Selección de Proveedores', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(85, 4, NULL, 20, 'Relación con los Proveedores', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(86, 4, NULL, 20, 'Evaluación y Revisión de Proveedores', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(87, 4, NULL, 21, 'Proceso de Compra', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(88, 4, NULL, 21, 'Eficiencia de Compra', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(89, 4, NULL, 21, 'Supervisión y Revisión de Compras', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(90, 4, NULL, 22, 'Logística', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(91, 4, NULL, 22, 'Proceso de Inventario', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(92, 4, NULL, 22, 'Eficiencia del Inventario', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(93, 4, NULL, 23, 'Proceso de Almacenamiento', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(94, 4, NULL, 23, 'Exactitud del Almacenamiento', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(95, 4, NULL, 23, 'Supervisión y Revisión de Almacenamiento', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(96, 4, NULL, 24, 'Apoyos visuales de los procesos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(97, 4, NULL, 24, 'Uso de herramientas de mejora continua para asegurar flujo continuo', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(98, 4, NULL, 24, 'Uso de herramientas de mejora continua para asegurar la reducción de desperdicios', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(99, 4, NULL, 24, 'Poka yokes', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(100, 4, NULL, 24, 'Herramientas estádísticas', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(101, 4, NULL, 24, 'Seguimiento de acciones correctivas', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(102, 4, NULL, 24, 'Creación de controles en acciones correctivas', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(103, 4, NULL, 25, 'Sistema de calidad', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(104, 4, NULL, 25, 'Cumplimiento de especifiaciones', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(105, 4, NULL, 25, 'Control de la Calidad (Muestreo)', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(106, 4, NULL, 25, 'Confiabilidad de medición', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(107, 4, NULL, 26, 'Sistema de seguridad', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(108, 4, NULL, 26, 'Gestión Ambiental', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(109, 4, NULL, 28, 'Mantenimiento preventivo', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(110, 5, NULL, 29, 'Conocimiento de las Normativas', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(111, 5, NULL, 29, 'Procesos de Cumplimiento', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(112, 5, NULL, 29, 'Formación y Concienciación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(113, 5, NULL, 29, 'Evaluación del Cumplimiento', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(114, 5, NULL, 29, 'Gestión de Incumplimientos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(115, 5, NULL, 29, 'Auditorías', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(116, 5, NULL, 30, 'Documentación de normas y políticas', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(117, 5, NULL, 30, 'Alcance del presupuesto inicial', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(118, 5, NULL, 30, 'Contabilidad', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(119, 5, NULL, 30, 'Gestión de impuestos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(120, 5, NULL, 30, 'Gestión de activos fijos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(121, 5, NULL, 31, 'Depreciaciones', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(122, 5, NULL, 31, 'Renovación y actualización', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(123, 5, NULL, 31, 'Eliminación y bajas', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(124, 5, NULL, 32, 'Capital de trabajo', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(125, 5, NULL, 32, 'Rotación de inventarios', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(126, 5, NULL, 32, 'Rotación de cuentas por cobrar', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(127, 5, NULL, 32, 'Rotación de cuentas por pagar', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(128, 5, NULL, 32, 'Flujo de efectivo', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(129, 5, NULL, 32, 'Costos de No calidad / pérdidas', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(130, 5, NULL, 33, 'Protección de marca', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(131, 5, NULL, 33, 'Acceso a Asesoría Legal', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(132, 5, NULL, 33, 'Calidad de la Asesoría Legal', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(133, 5, NULL, 33, 'Implementación de Asesoría Legal', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(134, 5, NULL, 34, 'Redacción de Contratos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(135, 5, NULL, 34, 'Revisión de Contratos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(136, 5, NULL, 34, 'Cumplimiento de los Contratos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(137, 5, NULL, 35, 'Planeación de objetivos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(138, 5, NULL, 35, 'Comunicación y asignación de objetivos en las áreas de trabajo', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(139, 5, NULL, 36, 'Documentación de estándares', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(140, 5, NULL, 36, 'Definición de estándares operativos', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(141, 5, NULL, 36, 'Conocimiento de los procesos esenciales de la operación', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(142, 5, NULL, 37, 'Revisión de estándares en los procesos donde se llevan a cabo', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(143, 5, NULL, 37, 'Realización de juntas periódicas (diarias, semanales, mensuales) para hacer los mínimos acuerdos nec', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(144, 5, NULL, 37, 'Revisión de resultados (areas)', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(145, 5, NULL, 38, 'Uso de metodologías de análisis de causa raíz ', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(146, 5, NULL, 38, 'Sistema de Gestión', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(147, 5, NULL, 38, 'Propósito y valores', '2024-09-24 16:18:45', '2024-09-24 16:18:45', NULL),
(148, 3, NULL, 39, 'Consistencia de marca', '2024-09-24 22:18:45', '2024-09-24 22:18:45', NULL),
(149, 3, NULL, 39, 'Percepción de marca', '2024-09-24 22:18:45', '2024-09-24 22:18:45', NULL),
(150, 3, NULL, 39, 'Posicionamiento de la Marca', '2024-09-24 22:18:45', '2024-09-24 22:18:45', NULL),
(151, 3, NULL, 39, 'Análisis de Costos', '2024-09-24 22:18:45', '2024-09-24 22:18:45', NULL),
(152, 3, NULL, 39, 'Evaluación de la Competencia', '2024-09-24 22:18:45', '2024-09-24 22:18:45', NULL),
(153, 3, NULL, 39, 'Valor para el Cliente', '2024-09-24 22:18:45', '2024-09-24 22:18:45', NULL),
(154, 3, NULL, 39, 'Identidad de Marca', '2024-09-24 22:18:45', '2024-09-24 22:18:45', NULL),
(155, 3, NULL, 39, 'Valores de la Marca', '2024-09-24 22:18:45', '2024-09-24 22:18:45', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamentos`
--

CREATE TABLE `departamentos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(100) DEFAULT NULL,
  `area_id` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `departamentos`
--

INSERT INTO `departamentos` (`id`, `nombre`, `descripcion`, `area_id`, `updated_at`, `created_at`, `deleted_at`) VALUES
(1, 'Reclutamiento y Selección', 'Reclutamiento', 1, '2024-07-26 04:59:54', '2024-06-19 02:08:07', '2024-07-26 04:59:54'),
(2, 'Desarrollo y Aprendizaje', 'Capacitación', 1, '2024-07-25 06:02:50', '2024-07-05 23:45:40', '2024-07-25 06:02:50'),
(3, 'Servicios y Beneficios al Empleado', 'Servicios al empleado', 1, '2024-07-26 04:59:56', '2024-07-06 00:38:03', '2024-07-26 04:59:56'),
(4, 'Relaciones Laborales y Nóminas', 'Nomina', 1, '2024-07-26 04:59:58', '2024-07-06 00:38:14', '2024-07-26 04:59:58'),
(5, 'Gestión', 'Gestión', 1, '2024-07-19 05:29:28', '2024-07-06 00:38:28', '2024-07-19 05:29:28'),
(6, 'Cultura', 'Cultura', 1, '2024-07-19 05:29:15', '2024-07-06 00:38:38', '2024-07-19 05:29:15'),
(7, 'Admon de Devices', 'Admon de Devices', 2, '2024-08-12 22:43:18', '2024-07-06 00:39:16', '2024-08-12 22:43:18'),
(8, 'Admon de Software', 'Admon de Software', 2, '2024-08-12 22:43:22', '2024-07-06 00:39:29', '2024-08-12 22:43:22'),
(9, 'Redes', 'Redes', 2, '2024-08-12 22:43:25', '2024-07-06 00:39:40', '2024-08-12 22:43:25'),
(10, 'Help Desk', 'Help Desk', 2, '2024-08-12 22:43:31', '2024-07-06 00:39:53', '2024-08-12 22:43:31'),
(11, 'Seguridad de la Información', 'Seguridad de la Información', 2, '2024-08-12 22:43:34', '2024-07-06 00:40:11', '2024-08-12 22:43:34'),
(12, 'E-commerce', NULL, 3, '2024-08-15 04:36:19', '2024-07-06 00:40:50', '2024-08-15 04:36:19'),
(13, 'Servicio al cliente', 'Servicio al cliente', 3, '2024-08-14 00:59:50', '2024-07-06 00:41:09', NULL),
(14, 'Inik', 'Inik', 3, '2024-08-08 23:18:05', '2024-07-06 00:41:21', '2024-08-08 23:18:05'),
(15, 'DNP', 'DNP', 3, '2024-07-25 05:14:59', '2024-07-06 00:41:32', '2024-07-25 05:14:59'),
(16, 'Calidad', 'Calidad', 4, '2024-07-25 00:11:00', '2024-07-06 00:41:43', '2024-07-25 00:11:00'),
(17, 'Almacén', NULL, 4, '2024-09-04 03:22:15', '2024-07-06 00:41:54', '2024-09-04 03:22:15'),
(18, 'Compras y Planeación', 'Compras y Planeación', 4, '2024-08-20 23:20:00', '2024-07-06 00:42:09', '2024-08-20 23:20:00'),
(19, 'Logística', 'Logística', 4, '2024-07-06 00:42:21', '2024-07-06 00:42:21', NULL),
(20, 'Mantenimiento', 'Mantenimiento', 4, '2024-07-06 00:42:32', '2024-07-06 00:42:32', NULL),
(21, 'Producción', 'Producción', 4, '2024-07-06 00:42:48', '2024-07-06 00:42:48', NULL),
(22, 'Finanzas', 'CxC', 5, '2024-08-10 00:49:08', '2024-07-06 00:43:39', '2024-08-10 00:49:08'),
(23, 'CxP', 'CxP', 5, '2024-07-26 05:41:50', '2024-07-06 00:44:42', '2024-07-26 05:41:50'),
(24, 'Regulaciones', 'Regulaciones', 5, '2024-07-06 00:44:52', '2024-07-06 00:44:52', NULL),
(25, 'Seguridad Patrimonial', 'Seguridad', 5, '2024-09-23 23:05:50', '2024-07-06 00:45:02', NULL),
(26, 'Proyectos', 'Proyectos', 5, '2024-09-24 01:42:05', '2024-07-06 00:45:34', '2024-09-24 01:42:05'),
(27, 'Dirección General', 'FODA y Analisis de la situación estratégica actual', 5, '2024-07-18 07:03:48', '2024-07-06 01:48:10', NULL),
(28, 'Reclutamiento y Selección', 'Contratación', 1, '2024-07-26 05:00:00', '2024-07-23 04:50:49', '2024-07-26 05:00:00'),
(29, 'Servicios Y Beneficios al Empleado', 'Útiles Escolares', 1, '2024-07-26 05:00:02', '2024-07-23 04:52:46', '2024-07-26 05:00:02'),
(30, 'Servicios Y Beneficios Al Empleado', 'Admiración De Uniformes', 1, '2024-07-26 05:00:03', '2024-07-23 04:54:05', '2024-07-26 05:00:03'),
(31, 'Calidad', 'Calidad', 4, '2024-09-04 06:29:01', '2024-07-24 00:18:57', NULL),
(32, 'Ventas PT', NULL, 3, '2024-08-21 06:55:57', '2024-07-24 01:58:27', '2024-08-21 06:55:57'),
(33, 'Capacitación y DO', 'Capacitación y DO', 1, '2024-07-26 05:00:06', '2024-07-24 02:10:59', '2024-07-26 05:00:06'),
(34, 'Contraloría', NULL, 5, '2024-08-09 22:11:41', '2024-07-25 02:10:53', NULL),
(35, 'Seguridad y medio ambiente', NULL, 4, '2024-07-25 04:29:22', '2024-07-25 03:01:42', NULL),
(36, 'Desarrollo de Estrategias por Canal', NULL, 3, '2024-07-25 05:41:08', '2024-07-25 04:55:13', '2024-07-25 05:41:08'),
(37, 'Investigación de Nuevos Productos', NULL, 3, '2024-07-25 05:41:47', '2024-07-25 04:55:48', '2024-07-25 05:41:47'),
(38, 'Ciclo de Nuevos Productos', NULL, 3, '2024-07-25 05:41:30', '2024-07-25 04:55:56', '2024-07-25 05:41:30'),
(39, 'Evaluación  de nuevas  MP/ME', NULL, 3, '2024-07-25 05:41:50', '2024-07-25 04:56:20', '2024-07-25 05:41:50'),
(40, 'Reingeniería de Producto', NULL, 3, '2024-07-25 05:41:55', '2024-07-25 04:57:34', '2024-07-25 05:41:55'),
(41, 'Control Interno', NULL, 5, '2024-08-21 03:00:33', '2024-07-25 05:01:41', NULL),
(42, 'Desarrollo de Nuevos  Productos', NULL, 3, '2024-07-25 05:18:11', '2024-07-25 05:18:11', NULL),
(43, 'Maquila', NULL, 3, '2024-07-25 05:42:30', '2024-07-25 05:42:30', NULL),
(44, 'Marketing', NULL, 3, '2024-08-22 23:18:38', '2024-07-25 05:55:35', NULL),
(45, 'Hardware y Software', NULL, 2, '2024-08-12 22:46:14', '2024-07-25 22:34:19', NULL),
(46, 'Redes y seguridad Infomática', NULL, 2, '2024-08-12 23:27:26', '2024-07-26 00:55:24', '2024-08-12 23:27:26'),
(47, 'Ciberseguridad', NULL, 2, '2024-08-12 23:27:29', '2024-07-26 02:54:03', '2024-08-12 23:27:29'),
(48, 'Reclutamiento y Selección', NULL, 1, '2024-08-23 23:34:43', '2024-07-26 05:00:51', NULL),
(49, 'Relaciones Laborales y Nóminas', NULL, 1, '2024-08-28 00:59:13', '2024-07-26 05:05:02', NULL),
(50, 'Servicios y Beneficios al Empleado', NULL, 1, '2024-08-23 23:37:33', '2024-07-26 06:25:17', NULL),
(51, 'Capacitación y Desarrollo Organizacional', NULL, 1, '2024-08-23 23:40:47', '2024-07-26 21:22:25', NULL),
(52, 'Administración de Proyectos', 'Proyectos de Odoo y eficiencia operativa', 5, '2024-07-27 04:01:18', '2024-07-27 04:01:18', NULL),
(53, 'Asuntos Corporativos', NULL, 5, '2024-08-10 05:00:29', '2024-08-10 05:00:29', NULL),
(54, 'Administración de redes', NULL, 2, '2024-08-12 23:32:23', '2024-08-12 23:32:23', NULL),
(55, 'Seguridad de datos', NULL, 2, '2024-08-13 00:02:39', '2024-08-13 00:02:39', NULL),
(56, 'Soporte técnico/ Hardware', NULL, 2, '2024-08-13 00:13:17', '2024-08-13 00:13:17', NULL),
(57, 'Calidad', NULL, 4, '2024-08-15 00:37:34', '2024-08-13 22:47:25', '2024-08-15 00:37:34'),
(58, 'Supply Chain', NULL, 4, '2024-08-17 01:20:41', '2024-08-16 01:57:34', '2024-08-17 01:20:41'),
(59, 'Administración', NULL, 5, '2024-09-24 01:46:30', '2024-08-17 05:12:34', '2024-09-24 01:46:30'),
(60, 'Administración de proyectos infraestructura', NULL, 5, '2024-08-20 06:33:39', '2024-08-20 01:53:42', NULL),
(61, 'Compras', NULL, 4, '2024-08-20 01:56:03', '2024-08-20 01:56:03', NULL),
(62, 'Regulaciones', NULL, 5, '2024-09-26 00:23:30', '2024-08-20 01:59:53', '2024-09-26 00:23:30'),
(63, 'Planeación', NULL, 4, '2024-08-20 04:45:56', '2024-08-20 04:45:56', NULL),
(64, 'Sistema de gestión (certificaciones)', NULL, 5, '2024-08-20 06:35:10', '2024-08-20 04:48:03', NULL),
(65, 'Ventas PT', NULL, 3, '2024-08-22 03:29:16', '2024-08-22 03:29:16', NULL),
(66, 'INIK', NULL, 3, '2024-09-13 04:26:27', '2024-08-22 23:15:08', '2024-09-13 04:26:27'),
(67, 'Ventas en Linea', NULL, 3, '2024-09-23 23:37:08', '2024-09-11 23:37:21', NULL),
(68, 'INIK', NULL, 3, '2024-09-13 04:28:58', '2024-09-13 04:28:58', NULL),
(69, 'Almacén', 'Almacén', 4, '2024-09-14 01:54:42', '2024-09-14 01:54:42', NULL),
(70, 'ISO 9001', NULL, 5, '2024-09-25 00:40:11', '2024-09-25 00:34:01', '2024-09-25 00:40:11');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `departamento_evaluacion`
--

CREATE TABLE `departamento_evaluacion` (
  `id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `seccion_id` int(11) DEFAULT NULL,
  `score` int(11) NOT NULL,
  `feedback` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `desperdicios`
--

CREATE TABLE `desperdicios` (
  `id` int(11) NOT NULL,
  `area_id` int(11) DEFAULT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `tipoDesperdicio_id` int(11) NOT NULL,
  `monto` float NOT NULL,
  `descripcion` text DEFAULT NULL,
  `rango` int(11) DEFAULT NULL,
  `recurrencia` int(11) DEFAULT NULL,
  `detectabilidad` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_for` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `desperdicios`
--

INSERT INTO `desperdicios` (`id`, `area_id`, `departamento_id`, `tipoDesperdicio_id`, `monto`, `descripcion`, `rango`, `recurrencia`, `detectabilidad`, `created_at`, `updated_at`, `created_for`, `deleted_at`) VALUES
(3, NULL, NULL, 9, 17000, 'Se fue la luz por mantenimiento', 1, 1, 1, '2024-09-18 23:12:51', '2024-09-18 23:14:29', 6, '2024-09-18 23:14:29'),
(4, NULL, NULL, 11, 80000, 'cambio de fecha de pruebas en corea', 8, 9, 10, '2024-09-21 03:58:04', '2024-10-01 03:59:56', 6, '2024-10-01 03:59:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `encargado_flujos`
--

CREATE TABLE `encargado_flujos` (
  `id` int(11) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `departamento_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estandares`
--

CREATE TABLE `estandares` (
  `id` int(11) NOT NULL,
  `procedimiento_id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `link_externo` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estatus`
--

CREATE TABLE `estatus` (
  `id` int(11) NOT NULL,
  `titulo` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `estatus`
--

INSERT INTO `estatus` (`id`, `titulo`) VALUES
(1, 'Retrasado'),
(2, 'Iniciado'),
(3, 'En proceso'),
(4, 'Terminado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `kpis`
--

CREATE TABLE `kpis` (
  `id` int(11) NOT NULL,
  `titulo` varchar(200) NOT NULL,
  `area_id` int(11) DEFAULT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `proceso_id` int(11) DEFAULT NULL,
  `procedimiento_id` int(11) DEFAULT NULL,
  `actual` float NOT NULL,
  `objetivo` float NOT NULL,
  `medicion` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `regla` int(11) DEFAULT NULL,
  `tipo` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `promedio` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lights`
--

CREATE TABLE `lights` (
  `id` int(11) NOT NULL,
  `departamento_id` int(11) NOT NULL,
  `semana_id` int(11) NOT NULL,
  `reporte_id` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `light` varchar(250) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_for` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metaflujos`
--

CREATE TABLE `metaflujos` (
  `id` int(11) NOT NULL,
  `departamento_id` int(11) NOT NULL,
  `trimestre_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_for` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metas`
--

CREATE TABLE `metas` (
  `id` int(11) NOT NULL,
  `departamento_id` int(11) NOT NULL,
  `trimestre_id` int(11) NOT NULL,
  `metaFlujo_id` int(11) NOT NULL,
  `tipo` int(11) NOT NULL,
  `meta` varchar(250) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_for` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `metatrimestres`
--

CREATE TABLE `metatrimestres` (
  `id` int(11) NOT NULL,
  `trimestre` int(11) DEFAULT NULL,
  `inicio` date DEFAULT NULL,
  `fin` date DEFAULT NULL,
  `ano` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `metatrimestres`
--

INSERT INTO `metatrimestres` (`id`, `trimestre`, `inicio`, `fin`, `ano`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 4, '2024-10-01', '2024-12-31', 2024, '2024-09-28 08:44:34', '2024-09-28 08:44:34', NULL),
(2, 3, '2024-07-01', '2024-09-30', 2024, '2024-09-27 02:42:27', '2024-09-27 02:42:27', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_06_10_153818_add_two_factor_columns_to_users_table', 1),
(5, '2024_06_10_153844_create_personal_access_tokens_table', 1),
(6, '2024_06_10_155208_create_permission_tables', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `minutas`
--

CREATE TABLE `minutas` (
  `id` int(11) NOT NULL,
  `area_id` int(11) DEFAULT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `proceso_id` int(11) DEFAULT NULL,
  `lider_id` bigint(20) UNSIGNED NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `tipo` varchar(50) DEFAULT NULL,
  `notas` text DEFAULT NULL,
  `estatus` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `minutas_asistentes`
--

CREATE TABLE `minutas_asistentes` (
  `id` int(11) NOT NULL,
  `minuta_id` int(11) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_permissions`
--

CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `model_has_roles`
--

CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `model_type` varchar(255) NOT NULL,
  `model_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `model_has_roles`
--

INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`) VALUES
(1, '6', 1),
(1, 'App\\Models\\User', 1),
(1, 'App\\Models\\User', 6),
(1, 'App\\Models\\User', 7),
(1, 'App\\Models\\User', 8),
(1, 'App\\Models\\User', 115),
(1, 'App\\Models\\User', 130),
(1, 'App\\Models\\User', 133),
(1, 'App\\Models\\User', 161),
(1, 'App\\Models\\User', 172),
(1, 'App\\Models\\User', 174),
(1, 'App\\Models\\User', 180),
(1, 'App\\Models\\User', 187),
(2, 'App\\Models\\User', 101),
(2, 'App\\Models\\User', 102),
(2, 'App\\Models\\User', 103),
(2, 'App\\Models\\User', 106),
(2, 'App\\Models\\User', 107),
(2, 'App\\Models\\User', 108),
(2, 'App\\Models\\User', 121),
(2, 'App\\Models\\User', 142),
(2, 'App\\Models\\User', 148),
(2, 'App\\Models\\User', 160),
(2, 'App\\Models\\User', 181),
(2, 'App\\Models\\User', 182),
(2, 'App\\Models\\User', 184),
(2, 'App\\Models\\User', 185);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `notificaciones`
--

CREATE TABLE `notificaciones` (
  `id` int(11) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `titulo` varchar(200) DEFAULT NULL,
  `link` varchar(200) DEFAULT NULL,
  `readed` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `objetivos`
--

CREATE TABLE `objetivos` (
  `id` int(11) NOT NULL,
  `objetivo` varchar(100) NOT NULL,
  `meta` text NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opciones`
--

CREATE TABLE `opciones` (
  `id` int(11) NOT NULL,
  `challenge_id` int(11) DEFAULT NULL,
  `madurez` varchar(100) NOT NULL,
  `formal` text NOT NULL,
  `informal` text NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `opciones`
--

INSERT INTO `opciones` (`id`, `challenge_id`, `madurez`, `formal`, `informal`, `updated_at`, `created_at`, `deleted_at`) VALUES
(1, 1, 'Nulo', 'No se cuenta con un perfíl de los candidatos. Esto puede llevar a contrataciones de baja calidad y un desajuste entre los empleados y la organización.\n \"Se hace por feeling, corazonada, con que nos caiga bien ya la hicimos\"', '\"Se hace por feeling, corazonada, con que nos caiga bien ya la hicimos\"', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(2, 1, 'Basico', 'Se tienen establecidos criterios para evaluar la calidad de los candidatos. Esto proporciona una base para la toma de decisiones de contratación.', '\"Criterios de evaluación de candidatos establecidos\"', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(3, 1, 'Maduro', 'Se están utilizando métricas de desempeño para evaluar la efectividad de las contrataciones. Esto permite a la organización evaluar y mejorar continuamente su proceso de contratación.', '\"Utilización de métricas de desempeño en la contratación\"', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(4, 1, 'Avanzado', 'Se utilizan técnicas avanzadas, como el análisis de datos, para mejorar la calidad de los candidatos y el desempeño de los nuevos empleados. Esto puede llevar a una mejor adaptación de los nuevos empleados y a una mayor productividad general.', '\"Reclutamiento y selección basados en análisis de datos\"', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(5, 2, 'Nulo', 'No se realiza ninguna medición de la tasa de oferta a aceptación. Esto puede llevar a una falta de entendimiento de la eficacia del proceso de contratación. ', '\"¡Vamos a lo loco, sin medir nada!\"', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(6, 2, 'Basico', 'Se está rastreando la tasa de ofertas de trabajo aceptadas en relación con las extendidas. Esto proporciona datos cuantitativos para evaluar el éxito de la contratación.', '\"Contando cuántos sí y no recibimos\"', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(7, 2, 'Maduro', 'Se analizan las razones por las que los candidatos rechazan las ofertas de trabajo. Esto puede proporcionar información valiosa para mejorar el proceso de contratación y la propuesta de valor para los empleados.', '\"Jugando al detective para entender por qué nos rechazan\"', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(8, 2, 'Avanzado', 'Se están utilizando estrategias avanzadas, como la mejora de la marca del empleador, para aumentar la tasa de aceptación de las ofertas. Esto puede atraer a candidatos de alta calidad y aumentar la tasa de retención de empleados.', '\"Convirtiéndonos en el empleador más deseadode toda la comarca\"', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(9, 3, 'Nulo', 'No se realiza ningún seguimiento de la eficiencia en el proceso de selección, lo que puede resultar en un uso ineficiente del tiempo y de los recursos. ', '\"Vamos al tanteo, sin medir esfuerzos\"', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(10, 3, 'Basico', 'Se rastrea el número de entrevistas por contratación y el tiempo invertido en el proceso de selección, lo que proporciona una medida básica de la eficiencia del proceso. ', '\"Contamos entrevistas y relojeamos el proceso\"', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(11, 3, 'Maduro', 'Se están identificando y mejorando los pasos ineficientes en el proceso de selección, lo que puede resultar en un proceso de contratación más fluido y efectivo.  ', '\"Pulimos los pasos torpes del proceso de selección\"', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(12, 3, 'Avanzado', 'Se están utilizando tecnologías avanzadas, como la IA y la automatización, para mejorar la eficiencia del proceso de selección, reduciendo así el tiempo y esfuerzo necesarios para contratar a nuevos empleados.  ', '\"Nos echamos al hombro la tecnología para agilizar selecciones\"', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(13, 4, 'Nulo', 'No se realiza un seguimiento de los costos de contratación, lo que puede resultar en un gasto excesivo sin un análisis apropiado. ', '\"Gastamos a manos llenas, sin contar\"', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(14, 4, 'Basico', 'Se está rastreando el costo total de contratar a un nuevo empleado, lo que permite un entendimiento básico del gasto en recursos humanos. ', '\"Vamos sumando cada centavo en la contratación\"', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(15, 4, 'Maduro', 'Se están analizando los costos de contratación para identificar oportunidades de ahorro, lo que puede resultar en una utilización más eficiente de los recursos. ', '\"Haciendo de detectives para encontrar ahorros\"', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(16, 4, 'Avanzado', 'Se están utilizando estrategias avanzadas,como aplicaciones, para reducir los costos de contratación, lo que puede resultar en significativas economías a largo plazo.  ', '\"Optimizando todo el camino del talento para ahorrar más\"', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(17, 5, 'Nulo', 'No se realiza un seguimiento del tiempo que toma desde que se publica una vacante hasta que se hace una oferta. El proceso de contratación puede ser ineficiente y prolongado sin una comprensión clara de las áreas de mejora.', '\"No realizamos un seguimiento del tiempo que toma desde que publicamos una vacante hasta que hacemos una oferta. El proceso de contratación puede ser bastante largo.\"', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(18, 5, 'Basico', 'Se está rastreando el tiempo que toma desde que se publica una vacante hasta que se hace una oferta. Sin embargo, no se están analizando y mejorando de manera activa los puntos de demora en el proceso de contratación. ', '\"Rastreamos el tiempo que toma desde que publicamos una vacante hasta que hacemos una oferta, pero no estamos analizando y mejorando activamente los puntos de demora.\"', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(19, 5, 'Maduro', 'Se están analizando y mejorando los puntos de demora en el proceso de contratación. Se están tomando medidas para reducir el tiempo de contratación, pero aún no se compara con los estándares de la industria.', '\"Estamos analizando y mejorando los puntos de demora en el proceso de contratación. Sin embargo, nuestro tiempo de contratación aún no se compara con los estándares de la industria.\"', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(20, 5, 'Avanzado', 'Se comparan regularmente los tiempos de contratación con los estándares de la industria y se implementan estrategias para optimizarlos. Se realizan esfuerzos constantes para mejorar el proceso de contratación.', '\"Comparamos regularmente nuestros tiempos de contratación con los estándares de la industria y estamos implementando estrategias para optimizarlos\"', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(21, 6, 'Nulo', 'No se realiza una estructura de compensación clara y equitativa para todos los empleados, lo que puede llevar a desigualdades y descontento. ', '\"Nuestra compensación es un misterio incluso para nosotros\"', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(22, 6, 'Basico', 'Existe una estructura de compensación clara y equitativa para todos los empleados, proporcionando una base para la equidad en la compensación. ', '\"Tenemos una guía para pagar a todos de manera justa\"', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(23, 6, 'Maduro', 'Se revisa y actualiza de manera regular la estructura de compensación para mantener su relevancia y competitividad en el mercado, asegurando que los empleados se sientan valorados y retener talento.', '\"Mantenemos nuestra estructura de compensación fresca y competitiva\"', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(24, 6, 'Avanzado', 'La estructura de compensación está alineada con los objetivos estratégicos de la empresa, y se utilizan datos y benchmarks para asegurar su eficacia y competitividad, lo que demuestra un enfoque estratégico y basado en datos para la compensación. ', '\"Nuestra compensación es una estrategia en sí misma, siempre afinada con datos y benchmarks\"', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(25, 7, 'Nulo', 'No se ofrecen beneficios básicos a los empleados, como seguro de salud y tiempo libre remunerado, lo que puede afectar la satisfacción y retención de los empleados.  ', '\"No ofrecemos muchos beneficios adicionales aquí\"', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(26, 7, 'Basico', 'Se ofrecen beneficios básicos a los empleados, como seguro de salud y tiempo libre remunerado, lo que satisface las necesidades básicas pero puede no ser suficiente para diferenciarse de otras empresas.  ', '\"Ofrecemos los beneficios básicos que esperarías\"', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(27, 7, 'Maduro', 'Se revisan y actualizan los beneficios de manera regular para asegurar su relevancia y competitividad, lo que muestra un compromiso con el bienestar de los empleados y puede ayudar a atraer y retener talento.  ', '\"Revisamos nuestros beneficios regularmente para mantenernos competitivos\"', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(28, 7, 'Avanzado', 'Se ofrecen beneficios personalizados y flexibles que se adaptan a las necesidades individuales de los empleados, y se utilizan datos para evaluar y mejorar su eficacia, lo que demuestra un enfoque cuidadosamente pensado y centrado en el empleado para los beneficios. ', '\"Nuestros beneficios están diseñados para cada empleado y los mejoramos constantemente con datos\"', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(29, 8, 'Nulo', 'No se comunican de manera clara y transparente las políticas de compensación y beneficios a los empleados, lo que puede llevar a la confusión y la insatisfacción. ', '\"Nuestra comunicación sobre compensación y beneficios es prácticamente inexistente\"', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(30, 8, 'Basico', 'Se comunican de manera clara y transparente las políticas de compensación y beneficios a los empleados, lo que proporciona una base para la comprensión y la equidad.', '\"Somos claros sobre nuestra compensación y beneficios\"', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(31, 8, 'Maduro', 'Se recogen y utilizan las opiniones de los empleados para mejorar la comunicación y la transparencia en torno a la compensación y los beneficios, lo que muestra un compromiso con la mejora continua y la participación de los empleados.  ', '\"Escuchamos a nuestros empleados para mejorar la comunicación sobre compensación y beneficios\"', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(32, 8, 'Avanzado', 'Se utilizan canales de comunicación digitales y personalizados para informar a los empleados sobre su compensación y beneficios, y para recoger y actuar en base a sus opiniones, lo que demuestra un enfoque proactivo y orientado al empleado para la comunicación y transparencia.  ', '\"Usamos tecnología para mantener a nuestros empleados informados y para actuar en base a sus opiniones\"', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(33, 9, 'Nulo', 'No se realizan evaluaciones para asegurar que la compensación es equitativa y competitiva, lo que puede resultar en prácticas de compensación injustas y no competitivas en el mercado.', '\"No realizamos evaluaciones de compensación\"', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(34, 9, 'Basico', 'Se realizan evaluaciones básicas para asegurar que la compensación es equitativa y competitiva, lo que proporciona un punto de partida para una compensación justa y competitiva en el mercado', '\"Realizamos evaluaciones básicas de compensación\"', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(35, 9, 'Maduro', 'Se realizan evaluaciones regulares y se utilizan benchmarks del mercado para evaluar la competitividad de la compensación, lo que muestra un enfoque sistemático y basado en el mercado para la compensación.  ', '\"Usamos benchmarks del mercado en nuestras evaluaciones de compensación\"', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(36, 9, 'Avanzado', 'Se utilizan técnicas avanzadas, como el análisis de datos, para evaluar y mejorar la equidad, competitividad y eficacia de la compensación, lo que demuestra un enfoque sofisticado y basado en datos para la compensación.', '\"Usamos análisis de datos para mejorar nuestra compensación\"', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(37, 10, 'Nulo', 'Los pagos de nómina son frecuentemente imprecisos y/o tardíos. Los errores y retrasos en la nómina son comunes y no hay estrategias definidas para abordarlos.', '', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(38, 10, 'Basico', 'Los pagos de nómina son generalmente a tiempo y correctos, pero sin procesos robustos para asegurar su consistencia. Aunque la mayoría de los pagos son correctos y a tiempo, no tenemos un sistema robusto para prevenir errores o retrasos.', '', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(39, 10, 'Maduro', 'Los pagos de nómina son consistentemente puntuales y precisos, con procesos formales para asegurar la exactitud y puntualidad. Contamos con procesos estandarizados y estamos comprometidos con la mejora continua para garantizar la exactitud y puntualidad en la nómina.', '', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(40, 10, 'Avanzado', 'La nómina se gestiona a través de sistemas automatizados y sofisticados que garantizan la exactitud y la puntualidad en todo momento. Se utilizan métricas y análisis para mejorar continuamente. Nuestros sistemas de nómina son altamente confiables y utilizamos la tecnología para anticipar y resolver proactivamente cualquier irregularidad.', '', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(41, 11, 'Nulo', 'No identificamos las necesidades de capacitación de nuestros colaboradores. ', '\"Aprendemos sobre la marcha\"', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(42, 11, 'Basico', 'Identificamos algunas necesidades básicas de capacitación. ', '\"Podría ser peor\"', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(43, 11, 'Maduro', 'Identificamos la mayoría de necesidades de capacitación, pero de manera informal.', '\"lo agarramos al vuelo\"', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(44, 11, 'Avanzado', 'Identificamos formalmente las necesidades de capacitación para cada puesto y proceso.', '\"Enseñar para no enmendar\"', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(45, 12, 'Nulo', 'No se realiza ninguna inducción para los nuevos empleados. Los nuevos empleados se ven obligados a aprender por su cuenta o a través de la orientación informal de otros empleados.', '\"No realizamos ninguna inducción para los nuevos empleados. A menudo tienen que aprender por su cuenta.\"', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(46, 12, 'Basico', 'Existe un programa de inducción para los nuevos empleados, pero puede ser básico y no cubrir todas las áreas necesarias. El programa puede no revisarse ni actualizarse regularmente. ', '\"Tenemos un programa de inducción para los nuevos empleados, pero puede ser bastante básico y no siempre se revisa ni actualiza.\"', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(47, 12, 'Maduro', 'El programa de inducción se revisa y actualiza regularmente para reflejar las necesidades cambiantes de la empresa y sus empleados. Sin embargo, la integración de la inducción con la estrategia general de la empresa puede no ser completa.', '\"Nuestro programa de inducción se revisa y actualiza regularmente para reflejar las necesidades cambiantes de la empresa y de nuestros empleados. Sin embargo, su integración con la estrategia general de la empresa aún necesita mejorar.\"', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(48, 12, 'Avanzado', 'El programa de inducción está completamente integrado con la estrategia general de la empresa. Se revisa y actualiza continuamente en base a los datos recopilados para garantizar su efectividad. ', '\"Nuestro programa de inducción está completamente integrado con la estrategia general de la empresa. Lo revisamos y actualizamos constantemente en base a los datos recopilados para garantizar su efectividad\"', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(49, 13, 'Nulo', 'No ofrecemos capacitación estructurada a nuestros colaboradores. ', 'Cada quien decide qué aprende', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(50, 13, 'Basico', 'La capacitación es ocasional y depende del interés individual. ', 'No obligamos pero no alentamos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(51, 13, 'Maduro', 'Ofrecemos capacitación obligatoria de los requerimientos legales de operación', 'Mejor algo que nada', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(52, 13, 'Avanzado', 'Ofrecemos un plan de capacitación completo y obligatorio para todos los colaboradores. ', 'Capacitar es prevenir, no curar', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(53, 14, 'Nulo', 'No se realiza una evaluación de la calidad de la formación', 'Nos fiamos de que la formación es buena porque sí.', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(54, 14, 'Basico', '¿Existen mecanismos básicos para evaluar la calidad de la formación?', 'Al menos le preguntamos a la gente si les sirvió la formación.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(55, 14, 'Maduro', '¿Se revisa y ajusta la calidad de la formación de manera regular en función de los comentarios y resultados?', 'Vamos mejorando la formación basándonos en lo que nos dicen.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(56, 14, 'Avanzado', '¿La evaluación de la calidad de la formación está integrada con la estrategia general de la empresa y se revisa y ajusta de manera continua basándose en los datos recopilados? ', 'Estamos constantemente afinando nuestra formación para que sea la mejor posible, basándonos en la información que recopilamos.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(57, 15, 'Nulo', 'No se realiza seguimiento de la inversión en formación.  ', 'No tenemos idea de cuánto gastamos en formación y cuanto nos beneficia.', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(58, 15, 'Basico', '¿Se está rastreando la inversión en formación y se está comparando con un presupuesto establecido? ', 'Sabemos cuánto gastamos en formación, pero no siempre nos apegamos al presupuesto.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(59, 15, 'Maduro', '¿Se está analizando el retorno de inversión (ROI) de la formación y se está buscando formas de aumentar la eficiencia? ¿Se está comparando el costo de la formación con los beneficios que aporta, como la mejora del rendimiento o la reducción de errores?', 'Estamos tratando de entender si nuestra formación vale la pena en términos de costos y beneficios.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(60, 15, 'Avanzado', '¿Se están utilizando técnicas avanzadas como el benchmarking y el análisis de datos para optimizar la inversión en formación? ¿Se está comparando la inversión en formación con la de otras organizaciones similares y se están utilizando los datos para tomar decisiones informadas sobre la formación?  ', 'Utilizamos todas las herramientas a nuestra disposición para asegurarnos de que nuestra inversión en formación es efectiva y eficiente.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(61, 16, 'Nulo', 'No se realiza seguimiento del impacto de la formación en el desempeño del trabajo.  ', 'Capacitamos, pero no sabemos qué tanto ayud', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(62, 16, 'Basico', '¿Se está rastreando el impacto básico de la formación en el desempeño del trabajo, como el aumento de productividad o la disminución de errores?  ', 'Vemos si la formación ayuda, pero solo a simple vista.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(63, 16, 'Maduro', '¿Se está midiendo el impacto de la formación en una variedad de métricas de desempeño, como la satisfacción del cliente, la eficiencia operativa, o la retención de empleados? ', 'Tratamos de ver el impacto de la formación en diferentes áreas, pero no tenemos un sistema formalizado.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(64, 16, 'Avanzado', '¿Se está utilizando el análisis de datos para entender y mejorar el impacto de la formación en el desempeño individual, de equipo y de la empresa? Esta comprensión se utiliza para informar y mejorar el diseño y la entrega de la formación. ', 'Utilizamos los datos para entender cómo nuestra formación afecta el desempeño, y lo usamos para hacer que nuestras capacitaciones sean más efectivas cada vez.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(65, 17, 'Nulo', 'No se realiza ningún tipo de desarrollo del personal.', 'Cada quien se rasca con sus propias uñas', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(66, 17, 'Basico', '¿Se ofrecen oportunidades básicas para el desarrollo personal y profesional, como cursos de capacitación o programas de aprendizaje en línea? ', 'Tenemos algunas oportunidades de desarrollo, pero nada demasiado sofisticado', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(67, 17, 'Maduro', '¿Se están implementando planes de desarrollo individualizados que tomen en cuenta las habilidades, intereses y aspiraciones de carrera de cada empleado? ', 'Cada uno de nuestros empleados tiene un plan de desarrollo personalizado, pero aún estamos trabajando en la implementación', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(68, 17, 'Avanzado', '¿Los empleados están activamente involucrados en su propio desarrollo, y se utilizan técnicas avanzadas como el coaching y el mentoring, y se promueve que los empleados tomen la iniciativa en su propio desarrollo y aprendizaje continuo? ', 'Nuestros empleados son los conductores de su propio desarrollo, y utilizamos todas las herramientas disponibles para ayudarles a llegar a donde quieren ir', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(69, 18, 'Nulo', 'No se realiza seguimiento de la satisfacción del empleado con la organización. ', 'No sabemos si a nuestros empleados les gusta o no la organización', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(70, 18, 'Basico', '¿Se está midiendo la satisfacción básica del empleado con la orgaización, tal vez a través de encuestas de satisfacción o retroalimentación informal?  ', 'Hacemos un chequeo para ver si a la gente le gusta la organización, pero nada muy formal', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(71, 18, 'Maduro', '¿Se están utilizando los comentarios de los empleados para mejorar la organización? ¿Existe un proceso establecido para recoger y responder a la retroalimentación? ', 'Tomamos en cuenta lo que nuestros empleados dicen sobre la organización y tratamos de hacer mejoras', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(72, 18, 'Avanzado', '¿La satisfacción del empleado con la organización se está utilizando para mejorar continuamente la experiencia del empleado y la retención? ¿Existe un sistema para analizar y actuar sobre la retroalimentación de los empleados de manera oportuna y estratégica? ', 'Nos tomamos muy en serio la opinión de nuestros empleados sobre la organización y la usamos para hacer mejoras constantes y significativas', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(73, 19, 'Nulo', 'Los empleados no tienen autoridad para tomar decisiones y no se les da retroalimentación.', 'Los empleados son meros espectadores en su propio trabajo', '2024-09-24 18:45:04', '2024-09-24 18:28:58', NULL),
(74, 19, 'Basico', 'Los empleados tienen alguna autoridad para tomar decisiones, pero no se les da suficiente retroalimentación. ', '', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(75, 19, 'Maduro', 'Los empleados tienen autoridad para tomar decisiones y se les da retroalimentación regularmente. ', 'Los empleados son como un equipo deportivo, trabajando juntos para lograr un objetivo común', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(76, 19, 'Avanzado', 'Los empleados tienen autoridad para tomar decisiones y se les da retroalimentación regularmente, además de que se les proporciona el apoyo y los recursos necesarios para tomar decisiones informadas.', 'Los empleados son dueños de su trabajo y tienen el poder para llevarlo al siguiente nivel', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(77, 20, 'Nulo', 'Los empleados no tienen autoridad para tomar decisiones y no se les da retroalimentación.', 'Los empleados son meros espectadores en su propio trabajo', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(78, 20, 'Basico', 'Los empleados tienen alguna autoridad para tomar decisiones, pero no se les da suficiente retroalimentación. ', 'Los empleados tienen una voz, pero a veces se sienten como si hablaran con una pared', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(79, 20, 'Maduro', 'Los empleados tienen autoridad para tomar decisiones y se les da retroalimentación regularmente. ', 'Los empleados son como un equipo deportivo, trabajando juntos para lograr un objetivo común', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(80, 20, 'Avanzado', 'Los empleados tienen autoridad para tomar decisiones y se les da retroalimentación regularmente, además de que se les proporciona el apoyo y los recursos necesarios para tomar decisiones informadas.', 'Los empleados son dueños de su trabajo y tienen el poder para llevarlo al siguiente nivel', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(81, 21, 'Nulo', 'Los valores no están definidos o no se comunican a los empleados.', 'Estamos navegando en un mar sin brújula', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(82, 21, 'Basico', 'Los valores están definidos, pero no se reflejan en las acciones y decisiones diarias de la empresa.', 'Tenemos valores, pero solo se muestran en la pared', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(83, 21, 'Maduro', 'Los valores están definidos y se reflejan en las acciones y decisiones diarias de la empresa.', 'Son como nuestra sombra, siempre nos acompañan y nos guían en el camino', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(84, 21, 'Avanzado', 'Los valores están definidos, se reflejan en las acciones y decisiones diarias de la empresa, y se utilizan para guiar la toma de decisiones y la evaluación del desempeño.', 'Nuestros valores son nuestra receta secreta, nos hacen únicos', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(85, 22, 'Nulo', 'Existen estandares de orden pero no son aplicados realmente ni se les da seguimiento.', 'El orden brilla por su ausencia', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(86, 22, 'Basico', 'Se ha comenzado a aplicar algunas reglas de limpieza y orden pero de forma aislada. ', 'Algo es mejor que nada', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(87, 22, 'Maduro', 'Hay un programa que establece, la Selecci[on, Orden y Limpieza de manera sistemática pero con margen de mejora.', 'El orden es bueno, la limpieza es mejor', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(88, 22, 'Avanzado', 'Hay un programa formalmente establecido en la operación que mejora nuestras practicas de Selección de lo que sirve, le brinda un orden, crea estándares de limpieza, estandariza las practicas y nos ayuda a mantener los resultados  que  de forma integral.', 'El orden es nuestro segundo nombre', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(89, 23, 'Nulo', 'No fomentamos ideas de mejora.', 'Si hay ideas pero no hay recursos', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(90, 23, 'Basico', 'Se aceptan algunas ideas de forma esporádica pero pasan por un proceso complejo', 'A veces alguien propone algo que suena razonable', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(91, 23, 'Maduro', 'Se aceptan la mayoría de ideas aunque de forma informal. ', 'Las buenas ideas flotan eventualmente', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(92, 23, 'Avanzado', 'Tenemos un sistema estructurado para recibir, evaluar e implementar ideas de mejora.', 'Tenemos un proceso formal para aprovechar el potencial creativo de todos', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(93, 24, 'Nulo', 'No identificamos oportunidades de mejora.', 'Nos hacemos los ciegos', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(94, 24, 'Basico', 'Identificamos bastantes oportunidades de mejora de forma esporádica y poco estructurada,   ', 'Vemos los hoyos en el camino, pero no los tapamos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(95, 24, 'Maduro', 'Sabemos lo que nos duele y como nos afecta , mejoramos varios problemas pero en general sentimos que ', 'Curamos las ampollas pero seguimos con los zapatos rotos', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(96, 24, 'Avanzado', 'Identificamos y documentamos todas las oportunidades de mejora de forma estructurada.', 'Les tomamos rayos X a los procesos para ver sus fallas', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(97, 25, 'Nulo', 'No reconocemos ni recompensamos las contribuciones.', 'Los errores los ventilamos, los aciertos ni los comentamos', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(98, 25, 'Basico', 'Reconocemos contribuciones de forma esporádica.', 'Felicitamos de vez en cuando y cuando nos acordamos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(99, 25, 'Maduro', 'Cuando hay mejoras desarrolladas por el equipo lo aplaudimos y reconocemos publicamente.', 'Los reconocimientos son estructurados, poco frecuentes y podriamos decir frios', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(100, 25, 'Avanzado', 'Tenemos un sistema estructurado de reconocimiento y recompensas.', 'Tenemos una política clara para reconocer, tenemos las medallas listas para colgarlas al pecho', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(101, 26, 'Nulo', 'No se realiza ninguna acción para promover la comunicación interna en la organización. Los canales de comunicación no están claramente definidos y la información no fluye de manera eficaz. ', 'Silencio radiofónico', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(102, 26, 'Basico', 'Se promueve la comunicación abierta y honesta dentro de la organización. Sin embargo, los esfuerzos para fomentar la comunicación pueden ser inconsistentes y no todos los miembros de la organización pueden sentirse cómodos o capacitados para comunicarse abierta y honestamente ', 'Se habla, pero no siempre se escucha', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(103, 26, 'Maduro', 'Se utilizan herramientas y plataformas digitales para facilitar y mejorar la comunicación interna. Estas herramientas pueden incluir intranets corporativas, aplicaciones de mensajería instantánea, foros de discusión en línea y otras tecnologías digitales. Sin embargo, el uso y la eficacia de estas herramientas pueden variar.', 'Digitalizando la comunicación', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(104, 26, 'Avanzado', 'La empresa tiene una estrategia de comunicación interna que promueve la transparencia, el compromiso y la colaboración. Se utilizan datos para medir y mejorar su eficacia. La comunicación interna es una parte integral de la cultura y las operaciones de la organización. ', 'Transparencia y colaboración en cada mensaje', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(105, 27, 'Nulo', 'No se realizan acciones para promover la diversidad y la inclusión en la organización. No existe una comprensión clara o un compromiso con la diversidad y la inclusión.  ', 'No es algo que nos interese', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(106, 27, 'Basico', 'Se respeta y valora la diversidad en la organización y se promueve un ambiente de trabajo inclusivo. Sin embargo, no puede haber políticas claras o consistentes para apoyar la diversidad y la inclusión, y los esfuerzos para promover un ambiente de trabajo inclusivo pueden ser esporádicos. ', 'Respeto a la diversidad', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(107, 27, 'Maduro', 'Se tiene una estrategia para aumentar la diversidad y la inclusión en la organización. Esta estrategia puede incluir políticas y prácticas específicas para atraer, retener y promover a personas de diversos antecedentes. ', 'Con estrategia en la diversidad', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(108, 27, 'Avanzado', 'La diversidad y la inclusión se consideran una ventaja competitiva y se utilizan datos para medir y mejorar la diversidad y la inclusión en todos los aspectos de la organización. La diversidad y la inclusión son fundamentales para la misión, los valores y las prácticas de la organización.  ', 'Diversidad como ventaja competitiva', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(109, 28, 'Nulo', 'No se realizan acciones para evaluar o mejorar la cultura de la organización. No existe una comprensión clara de la cultura actual de la organización o un camino definido para su mejora.  ', 'Cultura en el espejo retrovisor', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(110, 28, 'Basico', 'Se realizan evaluaciones básicas para entender y mejorar la cultura de la organización. Estas evaluaciones pueden ser informales o esporádicas, y pueden no abarcar todas las facetas de la cultura de la organización.  ', 'Primeros pasos hacia la mejora cultural', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(111, 28, 'Maduro', 'Se realizan evaluaciones regulares de la cultura y se utilizan los resultados para planificar mejoras. Estas evaluaciones pueden ser más formales y consistentes, y pueden incluir mecanismos para seguir el progreso hacia los objetivos de mejora de la cultura.  ', 'Cultura bajo revisión regular', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(112, 28, 'Avanzado', 'Se utilizan técnicas avanzadas, como encuestas y análisis de datos, para entender y mejorar continuamente la cultura de la empresa. Estas técnicas pueden proporcionar una comprensión más profunda y matizada de la cultura de la organización y pueden conducir a mejoras más efectivas y medibles.', 'Cultura optimizada con datos', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(113, 29, 'Nulo', 'No hay reconocimiento o celebración de fechas relevantes. ', '', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(114, 29, 'Basico', 'Pasamos por alto las fechas especiales, como si fueran días comunes.	Se reconocen algunas fechas relevantes con celebraciones esporádicas o inconsistentes. Marcamos algunas fechas en el calendario, pero sin mucha pompa o consistencia.	', '', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(115, 29, 'Maduro', 'Las fechas importantes se celebran consistentemente y con participación activa. Se recopila feedback. Celebramos con consistencia y buscamos la participación de todos, mejorando con cada evento.	', '', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(116, 29, 'Avanzado', 'Las celebraciones son parte integral de la cultura empresarial, inclusivas y con impacto medido en la satisfacción del personal. Nuestras celebraciones son un reflejo de nuestra cultura y diversidad, y su impacto positivo es palpable y medido.', '', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(117, 30, 'Nulo', 'No existen procesos formales de desvinculación. Es como si estuviéramos diciendo adiós sin un plan.	', '', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(118, 30, 'Basico', 'Los procesos de desvinculación son básicos y podrían no ser totalmente efectivos o ampliamente conocidos. Es como si estuviéramos diciendo adiós con un plano, pero podríamos necesitar más detalles.	', '', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(119, 30, 'Maduro', 'Los procesos de desvinculación son robustos y conocidos, pero su aplicación podría ser más consistente. Es como si estuviéramos diciendo adiós con un mapa detallado, pero podríamos necesitar mejores indicaciones.	', '', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(120, 30, 'Avanzado', 'Los procesos de desvinculación son integrales, efectivos, ampliamente conocidos y consistentemente aplicados. Es como si estuviéramos diciendo adiós con un GPS que nos guía a través de cada paso del camino.', '', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(121, 31, 'Nulo', 'No hay un proceso formal para entender las razones de la salida del personal. Las salidas se ven como eventos aislados sin análisis posterior.', 'Nos tomamos las salidas como algo personal, sin buscar causas o patrones', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(122, 31, 'Basico', 'Se realizan entrevistas de salida ad hoc para recoger feedback de los empleados que se van, pero sin un proceso estructurado o análisis sistemático.', 'Hacemos preguntas al salir, pero sin un plan claro de acción', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(123, 31, 'Maduro', 'Existe un proceso formalizado de entrevistas de salida que se analiza para identificar tendencias y áreas de mejora. Se toman acciones correctivas basadas en los datos recogidos.', 'Analizamos las despedidas para entender cómo mejorar y retenemos lo aprendido', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(124, 31, 'Avanzado', 'Se utiliza análisis predictivo y datos agregados para prevenir la rotación antes de que ocurra. Las estrategias de retención están alineadas con los resultados de las entrevistas de salida y se enfocan en la mejora continua.', 'Anticipamos y actuamos proactivamente para mejorar la retención y la satisfacción', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(125, 32, 'Nulo', 'No hay un enfoque formal en proteger los datos durante la desvinculación. ', 'Es como si estuviéramos dejando la puerta abierta después de que alguien se va.', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(126, 32, 'Basico', 'Existen esfuerzos para proteger los datos durante la desvinculación, pero podrían ser más efectivos o consistentes. ', 'Es como si estuviéramos intentando cerrar la puerta, pero podríamos necesitar una cerradura más fuerte.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(127, 32, 'Maduro', 'Los datos se protegen durante la desvinculación, pero podría haber riesgos que aún necesitan ser abordados. ', 'Es como si estuviéramos protegiendo nuestros datos, pero podríamos necesitar un sistema de seguridad más robusto.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(128, 32, 'Avanzado', 'Los datos se protegen de manera efectiva durante la desvinculación, minimizando los riesgos de brechas de seguridad. ', 'Es como si estuviéramos protegiendo nuestros datos con un sistema de seguridad de vanguardia que mantiene a raya cualquier amenaza', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(129, 33, 'Nulo', 'No brindamos desarrollo de liderazgo. ', 'La verdad es que no fomentamos mucho el crecimiento de nuestros líderes', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(130, 33, 'Basico', 'Ofrecemos algún desarrollo de liderazgo de forma esporádica.', 'Soltamos algunos consejos de vez en cuando o brindamos algunas herramientas', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(131, 33, 'Maduro', 'Ofrecemos desarrollo de liderazgo informal. ', 'Hay cursos pero no un programa de liderazgo', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(132, 33, 'Avanzado', 'Tenemos un programa estructurado y continuo de desarrollo de liderazgo.', 'Tenemos un camino claro para ayudar a los líderes actuales y futuros', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(133, 34, 'Nulo', 'No se realizan acciones para definir o mejorar un estilo de liderazgo en la organización. No hay un estilo de liderazgo claro o coherente. ', 'Liderazgo en punto muerto', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(134, 34, 'Basico', 'Existe un estilo de liderazgo definido que se alinea con los valores de la organización. Este estilo puede ser bastante básico y puede no ser coherente en toda la organización. ', 'Liderazgo con valores definidos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(135, 34, 'Maduro', 'Se revisa y actualiza el estilo de liderazgo para asegurar su relevancia y eficacia en un entorno cambiante. Esta revisión puede ser periódica y puede implicar la retroalimentación de los miembros de la organización. ', 'Liderazgo en constante evolución', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(136, 34, 'Avanzado', 'El estilo de liderazgo es flexible y adaptable, y se utilizan datos y feedback para mejorar continuamente el liderazgo y su impacto en la organización. Este estilo de liderazgo puede ser altamente efectivo y puede conducir a mejoras significativas en la organización.', 'Liderazgo adaptable y basado en hechos y datos', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(137, 35, 'Nulo', 'No se realizan acciones para desarrollar habilidades de liderazgo en la organización. No hay oportunidades claras o coherentes para el desarrollo del liderazgo. ', 'Desarrollo de liderazgo en el estante', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(138, 35, 'Basico', 'Se ofrecen oportunidades básicas para el desarrollo de habilidades de liderazgo. Estas oportunidades pueden ser limitadas y no cubrir completamente las necesidades de liderazgo de la organización.  ', 'Primeros pasos en el desarrollo del liderazgo', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(139, 35, 'Maduro', 'Se revisa y actualiza regularmente el programa de desarrollo de liderazgo para reflejar las necesidades cambiantes de la organización y del mercado. Este proceso de revisión puede ser sistemático y puede implicar la retroalimentación de los líderes en la organización. ', 'Desarrollo de liderazgo en revisión', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(140, 35, 'Avanzado', 'El desarrollo de líderes es una prioridad estratégica, y se utilizan técnicas avanzadas, como el coaching y el aprendizaje en línea, para desarrollar líderes en todos los niveles de la organización. Este enfoque puede conducir a un liderazgo más eficaz y a una mejora significativa en el rendimiento de la organización. ', 'Desarrollo de liderazgo estratégico y avanzado', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(141, 36, 'Nulo', 'No se realizan acciones para promover o mejorar la comunicación de los líderes en la organización. La comunicación de los líderes puede ser ineficaz o inexistente.  ', 'Comunicación de líderes ausente', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(142, 36, 'Basico', 'Los líderes comunican de manera clara y transparente sus decisiones y políticas. Esta comunicación puede ser básica y no siempre se realiza de manera coherente. ', 'Líderes con comunicación transparente', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(143, 36, 'Maduro', 'Se recoge y utiliza feedback para mejorar la comunicación de los líderes. Este proceso puede ser sistemático pero puede no cubrir todas las áreas de mejora. ', 'Comunicación de líderes en mejora continua', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(144, 36, 'Avanzado', 'Los líderes se comunican de manera continua y bidireccional, y se utilizan datos para medir y mejorar la eficacia de su comunicación. Este enfoque puede conducir a una comunicación altamente efectiva y a una mejora significativa en el rendimiento y la moral de la organización. ', 'Comunicación de líderes estratégica y basada en hechos y datos', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(145, 37, 'Nulo', 'No se realizan acciones para evaluar o mejorar la eficacia del liderazgo en la organización. La eficacia del liderazgo puede ser incierta o insatisfactoria.  ', 'Evaluación de liderazgo en el estante', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(146, 37, 'Basico', 'Se realizan evaluaciones básicas para medir la eficacia del liderazgo y planificar las mejoras necesarias. Estas evaluaciones pueden ser limitadas y no cubrir completamente todas las áreas críticas de liderazgo. ', 'Primeros pasos en la evaluación del liderazgo', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(147, 37, 'Maduro', 'Se realizan evaluaciones periódicas del liderazgo y se utilizan los resultados para mejorar el desempeño de los líderes. Este proceso puede ser sistemático y puede implicar retroalimentación y mejoras continuas. ', 'Evaluación continua del liderazgo', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(148, 37, 'Avanzado', 'Se utilizan técnicas avanzadas, como el análisis de datos, para medir y mejorar continuamente la eficacia del liderazgo y su impacto en la organización. Este enfoque puede conducir a un liderazgo más eficaz y a una mejora significativa en el rendimiento de la organización.', 'Evaluación de liderazgo estratégica y basada en hechos y datos', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(149, 38, 'Nulo', 'No hay un proceso formal para asegurar el cumplimiento de estas leyes. ', 'Es como si estuviéramos pasando por alto las leyes laborales.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(150, 38, 'Basico', 'Se asegura el cumplimiento de estas leyes de forma irregular o solo cuando surgen problemas. ', 'Es como si estuviéramos cumpliendo con las leyes laborales solo cuando detectamos problemas.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(151, 38, 'Maduro', 'Se asegura regularmente el cumplimiento de estas leyes, pero hay margen para mejorar la consistencia o la exhaustividad. ', 'Es como si estuviéramos respetando las leyes laborales la mayoría del tiempo, pero podríamos ser más cuidadosos.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(152, 38, 'Avanzado', 'Se realiza una revisión sistemática y completa del cumplimiento de estas leyes, asegurando que toda la empresa las respeta. ', 'Es como si estuviéramos cumpliendo con las leyes laborales como un reloj suizo, sin dejar espacio para errores.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(153, 39, 'Nulo', 'No se realiza una selección formal de hardware y software. ', 'Es como si compráramos un teléfono sin mirar las especificaciones.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(154, 39, 'Basico', 'Se realiza una selección básica de hardware y software basada principalmente en el costo. ', 'Es como si solo compráramos el teléfono más barato, sin considerar si tiene las funciones que necesitamos.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(155, 39, 'Maduro', 'Se realiza una selección de hardware y software basada en múltiples factores, como el costo, la funcionalidad y la compatibilidad. ', 'Es como si compráramos un teléfono que generalmente tiene lo que necesitamos, pero a veces nos falta algo.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(156, 39, 'Avanzado', 'Se realiza una selección estratégica de hardware y software que considera múltiples factores y se adapta a las necesidades cambiantes de la empresa. ', 'Es como si siempre tuviéramos el teléfono perfecto para nosotros, que tiene todas las funciones que necesitamos.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(157, 40, 'Nulo', 'No se realiza una configuración formal de hardware y software. ', 'Es como si intentáramos armar un mueble sin leer las instrucciones.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(158, 40, 'Basico', 'Se realiza una configuración básica de hardware y software que puede no ser óptima o completa. ', 'Es como si armáramos el mueble siguiendo las instrucciones básicas, pero sin ajustarlo correctamente.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(159, 40, 'Maduro', 'Se realiza una configuración de hardware y software que generalmente satisface las necesidades de la empresa, pero podría ser más eficiente. ', 'Es como si armáramos y ajustáramos el mueble correctamente, pero sin optimizarlo para nuestro espacio.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(160, 40, 'Avanzado', 'Se realiza una configuración eficiente de hardware y software que maximiza el rendimiento y la seguridad. ', 'Es como si siempre tuviéramos el mueble perfectamente armado y ajustado para nuestro espacio.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(161, 41, 'Nulo', 'No se realiza una configuración formal de redes. ', 'Es como si tuviéramos una casa sin puertas ni ventanas.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(162, 41, 'Basico', 'Se realiza una configuración básica de redes que puede no ser segura o eficiente.', 'Es como si tuviéramos puertas y ventanas, pero sin cerraduras.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(163, 41, 'Maduro', 'Se realiza una configuración de redes que generalmente es segura y eficiente, pero podría ser más sofisticada. ', 'Es como si tuviéramos cerraduras en nuestras puertas y ventanas, pero sin un sistema de seguridad.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(164, 41, 'Avanzado', 'Se realiza una configuración sofisticada de redes que maximiza la seguridad y la eficiencia y se adapta a las necesidades cambiantes de la empresa. ', 'Es como si tuviéramos un sistema de seguridad de alta tecnología que siempre nos mantiene seguros.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(165, 42, 'Nulo', 'No se realiza una selección formal de aplicaciones. ', 'Es como si eligiéramos una app sin leer las reseñas.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(166, 42, 'Basico', 'Se realiza una selección básica de aplicaciones basada principalmente en el costo. ', 'Es como si descargáramos la app gratis, sin considerar si tiene las funciones que necesitamos.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(167, 42, 'Maduro', 'Se realiza una selección de aplicaciones basada en múltiples factores, como el costo y la funcionalidad. ', 'Es como si descargáramos una app que generalmente tiene lo que necesitamos, pero a veces nos falta algo.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL);
INSERT INTO `opciones` (`id`, `challenge_id`, `madurez`, `formal`, `informal`, `updated_at`, `created_at`, `deleted_at`) VALUES
(168, 42, 'Avanzado', 'Se realiza una selección estratégica de aplicaciones que considera múltiples factores y se adapta a las necesidades cambiantes de la empresa. ', 'Es como si siempre tuviéramos la app perfecta para nosotros, que tiene todas las funciones que necesitamos.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(169, 43, 'Nulo', 'No se realiza una implementación formal de aplicaciones. ', 'Es como si intentáramos usar una app sin configurarla correctamente.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(170, 43, 'Basico', 'Se realiza una implementación básica de aplicaciones que puede no ser completa o eficiente. ', 'Es como si configuráramos la app siguiendo las instrucciones básicas, pero sin ajustarla correctamente.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(171, 43, 'Maduro', 'Se realiza una implementación de aplicaciones que generalmente satisface las necesidades de la empresa, pero podría ser más eficiente. ', 'Es como si configuráramos la app correctamente, pero sin optimizarla para nuestro uso.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(172, 43, 'Avanzado', 'Se realiza una implementación eficiente de aplicaciones que maximiza el rendimiento y la seguridad. ', 'Es como si siempre tuviéramos la app perfectamente configurada y optimizada para nuestro uso.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(173, 44, 'Nulo', 'No se realiza un mantenimiento formal de aplicaciones. ', 'Es como si tuviéramos una app sin actualizarla nunca.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(174, 44, 'Basico', 'Se realiza un mantenimiento básico de aplicaciones que puede no ser seguro o eficaz. ', 'Es como si actualizáramos la app solo cuando deja de funcionar.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(175, 44, 'Maduro', 'Se realiza un mantenimiento de aplicaciones que generalmente es seguro y eficaz, pero podría ser más proactivo y completo. ', 'Es como si actualizáramos la app regularmente, pero sin anticiparnos a los problemas.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(176, 44, 'Avanzado', 'Se realiza un mantenimiento proactivo y completo de aplicaciones que maximiza la seguridad y la eficacia y se adapta a las necesidades cambiantes de la empresa. ', 'Es como si siempre mantuviéramos la app actualizada y segura, anticipándonos a los problemas.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(177, 45, 'Nulo', 'No se realiza una selección formal de sistemas de bases de datos. ', 'Es como si eligiéramos un sistema de bases de datos sin leer las reseñas.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(178, 45, 'Basico', 'Se realiza una selección básica de sistemas de bases de datos basada principalmente en el costo. ', 'Es como si escogiéramos el sistema de bases de datos más barato, sin considerar si realmente se ajusta a nuestras necesidades.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(179, 45, 'Maduro', 'Se realiza una selección de sistemas de bases de datos basada en múltiples factores, como el costo y la funcionalidad. ', 'Es como si eligiéramos un sistema de bases de datos que generalmente funciona, pero a veces nos deja en aprietos.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(180, 45, 'Avanzado', 'Se realiza una selección estratégica de sistemas de bases de datos que considera múltiples factores y se adapta a las necesidades cambiantes de la empresa. ', 'Es como si siempre eligiéramos el sistema de bases de datos perfecto para cada situación.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(181, 46, 'Nulo', 'No se realiza una implementación formal de sistemas de bases de datos. ', 'Es como si intentáramos armar un mueble sin leer las instrucciones.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(182, 46, 'Basico', 'Se realiza una implementación básica de sistemas de bases de datos sin garantizar su eficiencia. ', 'Es como si montáramos el mueble, pero nos sobraran algunas piezas y no estuviéramos seguros si lo hicimos correctamente.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(183, 46, 'Maduro', 'Se realiza una implementación de sistemas de bases de datos que generalmente satisface las necesidades de la empresa, pero podría ser más eficiente. ', 'Es como si montáramos el mueble correctamente la mayoría de las veces, pero a veces nos cuesta un poco más de trabajo.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(184, 46, 'Avanzado', 'Se realiza una implementación eficiente de sistemas de bases de datos que maximiza el rendimiento y la seguridad. ', 'Es como si fuéramos expertos montando muebles, siempre lo hacemos perfectamente y de manera eficiente.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(185, 47, 'Nulo', 'No se realiza un mantenimiento formal de sistemas de bases de datos. ', 'Es como si tuviéramos un coche pero nunca lo lleváramos al taller.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(186, 47, 'Basico', 'Se realiza un mantenimiento básico de sistemas de bases de datos que puede no ser seguro o eficaz. ', 'Es como si lleváramos el coche al taller solo cuando se avería.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(187, 47, 'Maduro', 'Se realiza un mantenimiento de sistemas de bases de datos que generalmente es seguro y eficaz, pero podría ser más proactivo y completo. ', 'Es como si lleváramos el coche al taller regularmente, pero sin revisar algunos aspectos importantes.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(188, 47, 'Avanzado', 'Se realiza un mantenimiento proactivo y completo de sistemas de bases de datos que maximiza la seguridad y la eficacia y se adapta a las necesidades cambiantes de la empresa. ', 'Es como si siempre mantuviéramos el coche en perfectas condiciones, revisándolo a fondo y anticipándonos a los problemas.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(189, 48, 'Nulo', 'No existen políticas formales de seguridad de la información. ', 'Es como si dejáramos la puerta de casa abierta todo el tiempo.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(190, 48, 'Basico', 'Se tienen políticas básicas de seguridad de la información, pero pueden ser insuficientes o no se aplican de manera efectiva. ', 'Es como si cerráramos la puerta, pero dejáramos las ventanas abiertas.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(191, 48, 'Maduro', 'Se tienen políticas de seguridad de la información que cubren la mayoría de las necesidades, pero podrían ser más exhaustivas o efectivas. ', 'Es como si cerráramos la puerta y la mayoría de las ventanas, pero a veces olvidamos una.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(192, 48, 'Avanzado', 'Se cuentan con políticas de seguridad de la información exhaustivas y efectivas que se aplican de manera consistente y se revisan y actualizan regularmente. ', 'Es como si siempre cerráramos y aseguráramos la puerta y todas las ventanas antes de salir.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(193, 49, 'Nulo', 'No se implementan medidas formales de seguridad para proteger la información. ', 'Es como si no tuviéramos cerraduras en nuestras puertas.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(194, 49, 'Basico', 'Se implementan medidas básicas de seguridad, pero pueden ser insuficientes o no se aplican de manera efectiva. ', 'Es como si tuviéramos cerraduras, pero a veces olvidáramos usarlas.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(195, 49, 'Maduro', 'Se implementan medidas de seguridad que cubren la mayoría de las necesidades, pero podrían ser más exhaustivas o efectivas. ', 'Es como si usáramos las cerraduras la mayoría de las veces, pero a veces las dejáramos sin cerrar.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(196, 49, 'Avanzado', 'Se implementan medidas de seguridad exhaustivas y efectivas que se revisan y actualizan regularmente. ', 'Es como si siempre cerráramos las cerraduras y tuviéramos un sistema de alarma avanzado para proteger nuestra casa.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(197, 50, 'Nulo', 'No se realiza un monitoreo o actualización formal de las medidas de seguridad. ', 'Es como si nunca revisáramos nuestras cerraduras o sistemas de seguridad.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(198, 50, 'Basico', 'Se realiza un monitoreo y actualización básicos de las medidas de seguridad, pero podrían ser insuficientes. ', 'Es como si solo revisáramos nuestras cerraduras y sistemas de seguridad cuando algo sale mal.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(199, 50, 'Maduro', 'Se realiza un monitoreo y actualización de las medidas de seguridad que generalmente son suficientes, pero podrían ser más proactivos y completos. ', 'Es como si revisáramos nuestras cerraduras y sistemas de seguridad regularmente, pero a veces nos saltamos las revisiones.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(200, 50, 'Avanzado', 'Se realiza un monitoreo y actualización proactivos y completos de las medidas de seguridad que se adaptan a las necesidades cambiantes y amenazas emergentes. ', 'Es como si siempre estuviéramos revisando y actualizando nuestras cerraduras y sistemas de seguridad para mantenernos seguros.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(201, 51, 'Nulo', 'No se realiza ninguna investigación de las tendencias del mercado para guiar la estrategia de marketing del producto. ', 'No realizamos ninguna investigación de las tendencias del mercado para nuestro producto', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(202, 51, 'Basico', 'Se realiza una investigación básica de las tendencias del mercado, pero no se utiliza de manera efectiva para guiar la estrategia de marketing del producto. ', 'Realizamos una investigación básica de las tendencias del mercado, pero no la utilizamos realmente para guiar nuestra estrategia de marketing', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(203, 51, 'Maduro', 'Se realiza una investigación detallada de las tendencias del mercado y se utiliza para influir en la estrategia de marketing del producto, pero la investigación no se actualiza regularmente para reflejar los cambios en las tendencias del mercado. ', 'Realizamos una investigación detallada de las tendencias del mercado, pero no actualizamos nuestra investigación regularmente', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(204, 51, 'Avanzado', 'La investigación de las tendencias del mercado es un componente integral de la estrategia de marketing del producto, se realiza regularmente y se actualiza para reflejar los cambios en las tendencias del mercado. ', 'La investigación de las tendencias del mercado es una parte integral de nuestra estrategia de marketing. La actualizamos regularmente para reflejar los cambios en las tendencias', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(205, 52, 'Nulo', 'No se han identificado canales de marketing para llegar al público objetivo.', 'No hemos identificado canales de marketing específicos para nuestro público objetivo', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(206, 52, 'Basico', 'Se han identificado algunos canales de marketing, pero no se han optimizado ni se ha evaluado su efectividad.  ', 'Hemos identificado algunos canales de marketing, pero no hemos evaluado su efectividad ni los hemos optimizado', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(207, 52, 'Maduro', 'Se han identificado y evaluado múltiples canales de marketing, pero no se monitorean o ajustan regularmente en función de la eficacia. ', 'Hemos identificado y evaluado múltiples canales de marketing, pero no los ajustamos de manera regular en función de su efectividad', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(208, 52, 'Avanzado', 'Los canales de marketing se han identificado, optimizado, y se monitorean y ajustan regularmente en función de su efectividad.', 'Hemos identificado y optimizado nuestros canales de marketing, y los monitoreamos y ajustamos regularmente en función de su efectividad', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(209, 53, 'Nulo', 'No se ha definido claramente el posicionamiento de la empresa y el producto ', 'No hemos definido claramente el posicionamiento de nuestra empresa o producto', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(210, 53, 'Basico', 'El posicionamiento de la empresa y del producto se ha definido, pero no se ha comunicado de manera efectiva al público objetivo.', 'Hemos definido el posicionamiento de nuestra empresa y producto, pero no hemos logrado comunicarlo de manera efectiva a nuestro público objetivo', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(211, 53, 'Maduro', 'El posicionamiento de la empresa y del producto se ha definido y comunicado al público objetivo, pero no se revisa ni se ajusta regularmente', 'Hemos definido y comunicado el posicionamiento de nuestra empresa y producto, pero no lo revisamos ni ajustamos regularmente', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(212, 53, 'Avanzado', 'El posicionamiento de la empresa y del producto se ha definido claramente, se comunica efectivamente al público objetivo y se revisa y ajusta regularmente. ', 'Somos unos cracks en esto del posicionamiento, somos una referencia en el mercado', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(213, 54, 'Nulo', 'No se han desarrollado mensajes clave para comunicar el valor del producto. ', 'No hemos desarrollado mensajes clave para nuestro producto', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(214, 54, 'Basico', 'Se han desarrollado mensajes clave, pero no se han probado con el público objetivo ni se han ajustado en función de los comentarios.', 'Hemos desarrollado mensajes clave para nuestro producto, pero no los hemos probado con nuestro público objetivo ni los hemos adaptado en función de los comentarios', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(215, 54, 'Maduro', 'Se han desarrollado mensajes clave y se han probado con el público objetivo, pero no se revisan ni se ajustan regularmente en función de los comentarios y cambios en el mercado. ', 'Hemos desarrollado y probado mensajes clave con nuestro público objetivo, pero no los revisamos ni ajustamos regularmente', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(216, 54, 'Avanzado', 'Los mensajes clave se han desarrollado, probado con el público objetivo, y se revisan y ajustan regularmente en función de los comentarios y cambios en el mercado.', 'Hemos desarrollado y probado mensajes clave con nuestro público objetivo, y los revisamos y ajustamos regularmente para mantenerlos relevantes y efectivos', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(217, 55, 'Nulo', 'No se ha formado un equipo de ventas.', 'Es como un solista tratando de tocar toda la sinfonía', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(218, 55, 'Basico', 'Se ha formado un equipo de ventas básico, pero puede carecer de las habilidades o la formación necesaria.', 'Es como una banda recién formada que aún está ensayando sus primeras canciones', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(219, 55, 'Maduro', 'Se ha formado un equipo de ventas competente, pero podría necesitar más formación o recursos.', 'Es como una banda que toca bien juntos, pero que todavía necesita un poco más de práctica', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(220, 55, 'Avanzado', 'Se ha formado un equipo de ventas altamente competente y bien formado que tiene todos los recursos que necesita.', 'Es como una banda de rock bien afinada que siempre llena estadios', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(221, 56, 'Nulo', 'Los clientes no llegan', 'La campana de venta nunca suena', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(222, 56, 'Basico', 'Los clientes llegan pero no cerramos', 'Si llegan los clientes pero nos hacen falta herramientas para cerrar, es frustrante no concluir la venta', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(223, 56, 'Maduro', 'Los clientes llegan, tenemos definidos procesos formales y convertimos a ventas de acuerdo a las metas establecidas', 'Que bien se siente vender, nosotros diriamos que ya no vendemos si no que nos compran', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(224, 56, 'Avanzado', 'Los clientes llegan, los atendemos con pasión y superamos las expectativas, todo el equipo sabe como abordarlos y no perdemos ni una oportunidad de venta, somos la referencia en el mercado.', 'Huuuuyyy chulada de proceso, el producto se vende solo, el cliente compra en línea nosotros solo asesoramos o abordamos ventas especiales', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(225, 57, 'Nulo', 'No se ha definido una estrategia de ventas.', 'Es como un marinero que navega sin mapa', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(226, 57, 'Basico', 'Se ha definido una estrategia de ventas básica, pero puede no ser la más efectiva.', 'Es como un marinero con un mapa dibujado en un servilleta', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(227, 57, 'Maduro', 'Se ha definido una estrategia de ventas que funciona en algunas ocasiones, pero no se ajusta con regularidad.', 'Es como un marinero con un mapa decente, pero que olvida revisarlo cuando cambian las corrientes', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(228, 57, 'Avanzado', 'Se ha definido una estrategia de ventas efectiva y se revisa y ajusta regularmente.', 'Es como un marinero con un mapa detallado y una brújula, que siempre ajusta su rumbo', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(229, 58, 'Nulo', 'La Empresa no tiene un proceso formal de CRM, lo que conduce a una relación inconsistente con los clientes. ', 'Nuestra gestión de relaciones con los clientes es como un diario, nos cuesta seguir la historia.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(230, 58, 'Basico', 'La Empresa tiene un CRM básico para gestionar las interacciones con los clientes, pero carece de personalización y análisis de datos. ', 'Nuestra gestión de relaciones con los clientes es como un libro de texto, tiene toda la información pero no es muy personal.\"	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(231, 58, 'Maduro', 'La Empresa tiene un CRM avanzado que permite una gestión personalizada y basada en datos de las relaciones con los clientes. ', 'Nuestra gestión de relaciones con los clientes es como una biografía bien escrita, conocemos y entendemos a nuestros clientes.\"	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(232, 58, 'Avanzado', 'La Empresa tiene un CRM de última generación con IA que permite una gestión proactiva, personalizada y basada en el análisis de datos de las relaciones con los clientes. ', 'Nuestra gestión de relaciones con los clientes es como un libro interactivo, siempre estamos aprendiendo y adaptándonos a las necesidades de nuestros clientes.\"', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(233, 59, 'Nulo', 'No se monitorizan ni analizan las métricas de ventas.', 'Es como tratar de mejorar tu tiempo de carrera sin cronómetro', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(234, 59, 'Basico', 'Se monitorizan algunas métricas de ventas, pero no se realizan análisis profundos o no se utilizan para mejorar.', 'Es como tener un cronómetro, pero olvidar mirarlo después de cada carrera', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(235, 59, 'Maduro', 'Se monitorizan y analizan regularmente varias métricas de ventas, y se utilizan para hacer ajustes ocasionales.', 'Es como mirar tu cronómetro después de cada carrera, pero olvidar ajustar tu estrategia basándote en los tiempos', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(236, 59, 'Avanzado', 'Se realiza un seguimiento y análisis exhaustivo de una amplia gama de métricas de ventas, y se utilizan de manera proactiva para mejorar.', 'Es como tener un cronómetro, un plan de entrenamiento personalizado y un entrenador que te ayuda a mejorar tu tiempo después de cada carrera', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(237, 60, 'Nulo', 'No se ha definido una estrategia de precios.', 'Es como vender sin etiquetas de precio.\"	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(238, 60, 'Basico', 'Se ha definido una estrategia de precios básica, pero puede no estar alineada con el mercado o los objetivos de la empresa.', 'Es como poner precio a ojo y esperar que nadie se queje.\"	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(239, 60, 'Maduro', 'Se ha definido una estrategia de precios que generalmente está alineada con el mercado y los objetivos de la empresa, pero podría necesitar ajustes.', 'Es como ajustar los precios según el clima, tienen sentido la mayoría de las veces, pero a veces no.\"	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(240, 60, 'Avanzado', 'Se ha definido una estrategia de precios efectiva y competitiva que siempre está alineada con el mercado y los objetivos de la empresa.', 'Es como tener precios perfectamente ajustados a la calidad del producto y al bolsillo del cliente.\"', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(241, 61, 'Nulo', 'No se utilizan plantillas de cotización.', 'Es como escribir una carta de amor cada vez que te gusta alguien', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(242, 61, 'Basico', 'Se utilizan plantillas de cotización básicas, pero pueden no ser claras o fáciles de personalizar.', 'Es como tener una carta de amor estándar, pero que no expresa tus verdaderos sentimientos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(243, 61, 'Maduro', 'Se utilizan plantillas de cotización claras y relativamente fáciles de personalizar, pero podrían ser más profesionales o eficientes.', 'Es como tener una carta de amor que generalmente funciona, pero podría ser más personal', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(244, 61, 'Avanzado', 'Se utilizan plantillas de cotización claras, profesionales y fácilmente personalizables que ahorran tiempo y refuerzan la marca de la empresa.', 'Es como tener una carta de amor que siempre conquista al destinatario', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(245, 62, 'Nulo', 'No se desarrollan propuestas de venta. ', 'Es como invitar a alguien a cenar sin decirle por qué debería ir.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(246, 62, 'Basico', 'Se desarrollan propuestas de venta básicas, pero pueden no ser convincentes o responder a las necesidades del cliente. ', 'Es como decir vamos a cenar porque tengo hambre, puede que funcione, pero no es muy convincente.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(247, 62, 'Maduro', 'Se desarrollan propuestas de venta que suelen ser convincentes y responder a las necesidades del cliente, pero podrían ser más personalizadas. ', 'Es como invitar a alguien a cenar explicándole que la comida será buena, pero sin darle más detalles.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(248, 62, 'Avanzado', 'Se desarrollan propuestas de venta altamente personalizadas y convincentes que siempre responden a las necesidades y preocupaciones del cliente. ', 'Es como invitar a alguien a cenar describiéndole el delicioso menú y la maravillosa velada que pasará.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(249, 63, 'Nulo', 'No existen procesos de aprobación para las cotizaciones y propuestas. ', 'Es como un partido de fútbol sin árbitro.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(250, 63, 'Basico', 'Existen procesos de aprobación básicos para las cotizaciones y propuestas, pero pueden ser ineficientes o inconsistente. ', 'Es como un árbitro que hace las reglas sobre la marcha.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(251, 63, 'Maduro', 'Existen procesos de aprobación eficientes para las cotizaciones y propuestas, pero podrían ser más estandarizados o automatizados. ', 'Es como un árbitro que sigue las reglas, pero a veces se le olvida sacar tarjeta.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(252, 63, 'Avanzado', 'Existen procesos de aprobación eficientes, estandarizados y posiblemente automatizados para las cotizaciones y propuestas. ', 'Es como un árbitro que siempre aplica las reglas de manera justa y eficiente.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(253, 64, 'Nulo', 'No se realiza un seguimiento de las cotizaciones y propuestas enviadas. ', 'Es como lanzar mensajes en botellas al océano y esperar una respuesta.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(254, 64, 'Basico', 'Se realiza un seguimiento básico de las cotizaciones y propuestas enviadas, pero puede ser inconsistente o no proporcionar datos útiles. ', 'Es como revisar el océano de vez en cuando para ver si alguna botella ha vuelto.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(255, 64, 'Maduro', 'Se realiza un seguimiento consistente y útil de las cotizaciones y propuestas enviadas, pero podría ser más detallado o automatizado. ', 'Es como seguir la corriente para ver dónde podrían llegar las botellas, pero sin un plan claro.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(256, 64, 'Avanzado', 'Se realiza un seguimiento detallado y posiblemente automatizado de las cotizaciones y propuestas enviadas, proporcionando valiosos datos de rendimiento. ', 'Es como tener un GPS en cada botella para saber exactamente dónde y cuándo llegará.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(257, 65, 'Nulo', 'La Empresa procesa todos los pedidos manualmente, lo que puede llevar a errores y retrasos. ', 'Nuestra automatización de pedidos es como un carro tirado por caballos, todo es manual.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(258, 65, 'Basico', 'La Empresa tiene algunos procesos automatizados, pero aún depende en gran medida del manejo manual. ', 'Nuestra automatización de pedidos es como un carro híbrido, mitad manual, mitad automatizado.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(259, 65, 'Maduro', 'La Empresa tiene la mayoría de sus procesos de pedidos automatizados, lo que mejora la eficiencia y reduce los errores. ', 'Nuestra automatización de pedidos es como un coche moderno, en su mayoría automático.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(260, 65, 'Avanzado', 'La Empresa tiene un sistema completamente automatizado para manejar pedidos, desde la recepción hasta la confirmación, lo que maximiza la eficiencia y minimiza los errores. ', 'Nuestra automatización de pedidos es como un coche autónomo, todo se hace automáticamente.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(261, 66, 'Nulo', 'La Empresa no proporciona seguimiento de pedidos, lo que deja a los clientes en la oscuridad.', 'Nuestro seguimiento de pedidos es como un submarino, los clientes están a oscuras.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(262, 66, 'Basico', 'La Empresa proporciona actualizaciones de seguimiento, pero sólo a petición del cliente. ', 'Nuestro seguimiento de pedidos es como un viejo telégrafo, sólo recibes actualizaciones si preguntas.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(263, 66, 'Maduro', 'La Empresa proporciona actualizaciones automáticas de seguimiento a los clientes en puntos clave del proceso de envío. ', 'Nuestro seguimiento de pedidos es como recibir postales de viaje, sabes cuando llegas a ciertos puntos.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(264, 66, 'Avanzado', 'La Empresa proporciona seguimiento en tiempo real con actualizaciones automáticas a los clientes, y permite a los clientes ver el estado de sus pedidos en cualquier momento a través de un portal en línea. ', 'Nuestro seguimiento de pedidos es como un GPS en tiempo real, siempre sabes dónde está tu pedido.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(265, 67, 'Nulo', 'La Empresa no tiene un proceso formal para resolver problemas de pedidos, lo que causa frustración en los clientes. ', 'Nuestro manejo de problemas de pedidos es como un laberinto, es fácil perderse.\"	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(266, 67, 'Basico', 'La Empresa tiene un proceso básico, pero los problemas a menudo requieren intervención manual. ', 'Nuestro manejo de problemas de pedidos es como un juego de mesa, a veces necesitas la ayuda de un coordinador, supervisor o gerente\"	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(267, 67, 'Maduro', 'La Empresa tiene un proceso eficaz que resuelve la mayoría de los problemas de pedidos de manera oportuna. ', 'Nuestro manejo de problemas de pedidos es como un videojuego bien diseñado, por lo general sabes cómo resolverlos.\"	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(268, 67, 'Avanzado', 'La Empresa tiene un proceso altamente eficiente y automatizado que resuelve problemas de pedidos y servicios rápidamente y mantiene informados a los clientes en todo momento. ', 'Nuestro manejo de problemas de pedidos es como un equipo de soporte en un videojuego, los problemas se resuelven rápidamente y siempre sabes lo que está pasando.\"', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(269, 68, 'Nulo', 'La Empresa tiene sistemas separados para pedidos, inventario, contabilidad y servicio al cliente, lo que causa ineficiencias y errores. ', 'Nuestra integración de sistemas es como un grupo de solistas, cada uno hace su propio show', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(270, 68, 'Basico', 'La Empresa tiene una integración parcial entre algunos sistemas, pero aún tiene problemas de coherencia de datos. ', 'Nuestra integración de sistemas es como una banda de garaje, a veces tocan juntos, a veces no', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(271, 68, 'Maduro', 'La Empresa tiene una integración sólida entre la mayoría de sus sistemas, lo que mejora la eficiencia y el servicio al cliente. ', 'Nuestra integración de sistemas es como una orquesta sinfónica, por lo general todos tocan la misma melodía', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(272, 68, 'Avanzado', 'La Empresa tiene una integración completa y sin fisuras entre todos sus sistemas, incluyendo CRM, pedidos, inventario, contabilidad y servicio al cliente, lo que optimiza la eficiencia y proporciona una visión unificada de los datos. ', 'Nuestra integración de sistemas es como un coro perfectamente sincronizado, todos en armonía todo el tiempo', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(273, 69, 'Nulo', 'Actualmente, no contamos con un proceso establecido para evaluar la calidad de nuestro producto o servicio. ', 'Estamos volando a ciegas, no tenemos un mapa para evaluar cómo lo estamos haciendo con nuestros productos o servicios.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(274, 69, 'Basico', 'Tenemos un proceso básico de evaluación de producto o servicio en su lugar, pero aún no estamos utilizando los resultados de esta evaluación para informar nuestras decisiones o mejoras. ', 'Tenemos un mapa básico para evaluar nuestros productos o servicios, pero no estamos usando la brújula para guiar nuestras decisiones.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(275, 69, 'Maduro', 'Nuestro proceso de evaluación de servicio es sólido y nos proporciona una valiosa percepción de las áreas que necesitamos mejorar. Los cambios que implementamos están fuertemente ligados a los resultados de estas evaluaciones. ', 'Nuestro mapa de evaluación es detallado y nos muestra los baches en el camino. Los cambios en nuestra ruta están directamente relacionados con lo que el mapa nos muestra.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(276, 69, 'Avanzado', 'Nuestro proceso de evaluación de servicio es altamente eficaz y oportuno. Se lleva a cabo inmediatamente después de la entrega del producto o servicio, y se refuerza con un seguimiento posterior para entender la percepción del cliente una vez que el producto o servicio ha sido entregado. ', 'Nuestro mapa de evaluación es un GPS en tiempo real. Revisamos la ruta justo cuando terminamos el viaje y seguimos verificando la satisfacción del pasajero después de que llegan a su destino.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(277, 70, 'Nulo', 'El servicio al cliente y el soporte postventa de la Empresa  son deficientes y no satisfacen las necesidades de los clientes. ', 'Nuestro servicio al cliente es como una vieja radio, difícil de sintonizar y no siempre claro.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(278, 70, 'Basico', 'El servicio al cliente y el soporte postventa de la Empresa son buenos pero hay espacio para mejoras. ', 'Nuestro servicio al cliente es como una emisora de radio decente, generalmente buena pero mejorable.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(279, 70, 'Maduro', 'El servicio al cliente y el soporte postventa de la Empresa son muy buenos y satisfacen las necesidades de los clientes la mayoría del tiempo. ', 'Nuestro servicio al cliente es como una emisora de radio popular, casi siempre en sintonía con el oyente.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(280, 70, 'Avanzado', 'El servicio al cliente y el soporte postventa de la Empresa son excepcionales y siempre superan las expectativas de los clientes. ', 'Nuestro servicio al cliente es como una emisora de radio personal, siempre en sintonía y superando expectativas.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(281, 71, 'Nulo', 'No se realiza ninguna investigación de mercado para el desarrollo de nuevos productos. La empresa desarrolla nuevos productos basándose únicamente en suposiciones internas, lo que puede llevar a fallas en el mercado y pérdida de inversión. ', 'No hacemos investigación de mercado para nuestros nuevos productos, simplemente los desarrollamos basándonos en lo que creemos que funcionará', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(282, 71, 'Basico', 'Se realiza alguna investigación de mercado, pero es limitada en alcance y/o frecuencia. Los nuevos productos pueden no estar completamente alineados con las necesidades del mercado, lo que puede resultar en ventas menores a las esperadas. ', 'Hacemos algo de investigación de mercado, pero no es muy profunda. A veces nuestros nuevos productos no se venden tan bien como esperábamos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(283, 71, 'Maduro', 'Existe una investigación de mercado sólida para el desarrollo de nuevos productos, pero puede haber ocasionalmente lagunas en la comprensión de las necesidades del cliente. La mayoría de los nuevos productos son bien recibidos por el mercado. ', 'Normalmente hacemos una buena investigación de mercado para nuestros nuevos productos, pero a veces hay cosas que se nos escapan', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(284, 71, 'Avanzado', 'Se realiza una investigación de mercado rigurosa y continua para el desarrollo de nuevos productos. La empresa tiene una comprensión profunda de las necesidades del cliente y los nuevos productos suelen ser un éxito en el mercado.', 'Hacemos una investigación de mercado rigurosa y continua para nuestros nuevos productos y usualmente son muy bien recibidos por el mercado', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(285, 72, 'Nulo', 'No se realiza ninguna generación sistemática de ideas para nuevos servicios o productos. Los nuevos servicios oproductos son desarrollados de forma ad hoc y no están basados en un entendimiento profundo de las necesidades del mercado. ', 'No tenemos un proceso real para generar ideas de nuevos productos, simplemente hacemos lo que creemos que funcionará', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(286, 72, 'Basico', 'Se realiza alguna generación de ideas para nuevos productos, pero no es consistente ni se basa en una investigación de mercado sólida. Los nuevos productos/servicios pueden no satisfacer las necesidades del mercado de manera efectiva. ', 'A veces tenemos sesiones de lluvia de ideas para nuevos productos, pero no siempre están basadas en una comprensión clara de las necesidades del mercado', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(287, 72, 'Maduro', 'Existe un proceso de generación de ideas para nuevos productos que se basa en algún grado de investigación de mercado. La mayoría de las ideas de productos son relevantes para las necesidades del mercado. ', 'Tenemos un proceso para generar ideas de nuevos productos que se basa en alguna investigación de mercado. La mayoría de nuestras ideas son relevantes para el mercado', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(288, 72, 'Avanzado', 'Se realiza una generación continua y sistemática de ideas para nuevos productos basada en una investigación de mercado rigurosa. Las ideas de productos suelen ser innovadoras y bien recibidas por el mercado.  ', 'Tenemos un proceso continuo y sistemático de generación de ideas para nuevos productos basado en investigación de mercado. Nuestras ideas de productos suelen ser innovadoras y bien recibidas por el mercado', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(289, 73, 'Nulo', 'No existe un proceso formal de desarrollo de conceptos para nuevos productos o servicios. Los conceptos de productos son desarrollados de manera ad hoc sin una comprensión clara de las necesidades del cliente. ', 'No tenemos un proceso formal para desarrollar conceptos de nuevos productos o servicios. Simplemente creamos lo que creemos que funcionará', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(290, 73, 'Basico', 'Existe un proceso básico de desarrollo de conceptos para nuevos productos o servicios, pero puede ser inconsistente y no se basa en una comprensión sólida de las necesidades del cliente. Los conceptos de productos pueden no estar bien alineados con el mercado.', 'Tenemos un proceso básico para desarrollar conceptos de nuevos productos o servicios, pero no siempre se basa en una comprensión clara de las necesidades del mercado', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(291, 73, 'Maduro', 'Existe un proceso de desarrollo de conceptos para nuevos productos o servicios que se basa en una investigación de mercado decente. La mayoría de los conceptos de productos son relevantes para las necesidades del mercado. ', 'Tenemos un proceso decente para desarrollar conceptos de nuevos productos o servicios que se basa en una investigación de mercado. La mayoría de nuestros conceptos son relevantes para el mercado', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(292, 73, 'Avanzado', 'Existe un proceso de desarrollo de conceptos continuo y sistemático para nuevos productos o servicios basado en una investigación de mercado rigurosa. Los conceptos de productos suelen ser innovadores y bien recibidos por el mercado. ', 'Hemos establecido un proceso continuo y sistemático de desarrollo de conceptos para nuevos productos o servicios basado en una investigación de mercado rigurosa. Nuestros conceptos suelen ser innovadores y bien recibidos por el mercado', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(293, 74, 'Nulo', 'No se realizan prototipos ni pruebas sistemáticas para nuevos productos o servicios. Los productos o servicios son lanzados al mercado sin pruebas previas. ', 'No realizamos prototipos ni pruebas para nuestros nuevos productos o servicios. Simplemente los lanzamos al mercado', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(294, 74, 'Basico', 'Se realizan prototipos y pruebas básicas para nuevos productos o servicios, pero el proceso puede ser inconsistente y no se basa en estándares de prueba rigurosos. Es posible que los problemas no se identifiquen antes del lanzamiento. ', 'Hacemos prototipos y pruebas básicas para nuestros nuevos productos o servicios, pero no siempre identificamos todos los problemas antes del lanzamiento', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(295, 74, 'Maduro', 'Existe un proceso para la creación de prototipos y pruebas de nuevos productos o servicios que se basa en estándares de prueba decentes. La mayoría de los problemas se identifican y se solucionan antes del lanzamiento.', 'Tenemos un proceso decente para hacer prototipos y pruebas de nuestros nuevos productos o servicios. La mayoría de los problemas se identifican antes del lanzamiento', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(296, 74, 'Avanzado', 'Existe un proceso sistemático y continuo de creación de prototipos y pruebas para nuevos productos o servicios basado en estándares de prueba rigurosos. Casi todos los problemas se identifican y se solucionan antes del lanzamiento. ', 'Tenemos un proceso sistemático para hacer prototipos y pruebas de nuestros nuevos productos o servicios. Casi todos los problemas se identifican y se solucionan antes del lanzamiento', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(297, 75, 'Nulo', 'No existe un proceso formal de lanzamiento al mercado para nuevos productos o servicios. Los productos o servicios son lanzados de manera ad hoc sin una estrategia de mercado clara. ', 'No tenemos un proceso formal para lanzar nuevos productos o servicios al mercado. Simplemente los lanzamos y esperamos lo mejor', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(298, 75, 'Basico', 'Existe un proceso básico de lanzamiento al mercado para nuevos productos o servicios, pero puede ser inconsistente y no se basa en una estrategia de mercado sólida. Los lanzamientos pueden no tener el impacto deseado.', 'Tenemos un proceso básico para lanzar nuevos productos o servicios al mercado, pero no siempre es efectivo', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(299, 75, 'Maduro', 'Existe un proceso de lanzamiento al mercado para nuevos productos o servicios que se basa en una estrategia de mercado decente. La mayoría de los lanzamientos son efectivos y alcanzan a su público objetivo. ', 'Tenemos un proceso decente para lanzar nuevos productos o servicios al mercado. La mayoría de nuestros lanzamientos son efectivos y alcanzan a su público objetivo', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(300, 75, 'Avanzado', 'Existe un proceso de lanzamiento al mercado continuo y sistemático para nuevos productos o servicios basado en una estrategia de mercado rigurosa. Los lanzamientos suelen ser altamente efectivos y alcanzan una amplia audiencia. ', 'Hemos establecido un proceso continuo y sistemático para lanzar nuevos productos o servicios al mercado. Nuestros lanzamientos suelen ser altamente efectivos y alcanzan una amplia audiencia', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(301, 76, 'Nulo', 'No se realiza ninguna evaluación formal de nuevos productos o servicios después de su lanzamiento. No se recopilan datos de rendimiento ni feedback de los clientes.  ', 'No evaluamos nuestros nuevos productos o servicios después del lanzamiento. No recopilamos datos de rendimiento ni feedback de los clientes', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(302, 76, 'Basico', 'Se realiza una evaluación básica de nuevos productos o servicios después de su lanzamiento, pero el proceso puede ser inconsistente y no se basa en métricas de rendimiento claras. Es posible que no se recoja o utilice todo el feedback de los clientes. ', 'Realizamos una evaluación básica de nuestros nuevos productos o servicios después del lanzamiento, pero no siempre recopilamos o utilizamos todo el feedback de los clientes', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(303, 76, 'Maduro', 'Existe un proceso para la evaluación de nuevos productos o servicios que se basa en métricas de rendimiento decentes. La mayoría del feedback de los clientes se recopila y se utiliza para hacer mejoras.  ', 'Tenemos un proceso decente para evaluar nuestros nuevos productos o servicios después del lanzamiento. Recopilamos y utilizamos la mayoría del feedback de los clientes', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(304, 76, 'Avanzado', 'Existe un proceso sistemático y continuo de evaluación de nuevos productos o servicios basado en métricas de rendimiento rigurosas. Todo el feedback de los clientes se recopila y se utiliza para hacer mejoras continuas. ', 'Tenemos un proceso sistemático para evaluar el desempeño de nuestros nuevos productos o servicios después del lanzamiento. Recopilamos y utilizamos todo el feedback de los clientes para hacer mejoras continuas', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(305, 77, 'Nulo', 'No se realiza previsión de la demanda. ', 'Es como intentar adivinar el clima sin salir a la calle.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(306, 77, 'Basico', 'Se realiza una previsión básica de la demanda, pero puede no ser precisa o completa. ', 'Es como mirar por la ventana para adivinar el clima del día.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(307, 77, 'Maduro', 'Se realiza una previsión de la demanda relativamente precisa y completa, pero podría ser más sofisticada o basada en datos. ', 'Es como usar una aplicación de clima, suele acertar, pero a veces falla.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(308, 77, 'Avanzado', 'Se realiza una previsión de la demanda sofisticada y basada en datos que proporciona una estimación precisa de la demanda futura. ', 'Es como tener tu propia estación meteorológica personal, siempre sabes qué esperar.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(309, 78, 'Nulo', 'No se realiza la planificación de la capacidad. ', 'Es como hacer una fiesta sin contar los invitados.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(310, 78, 'Basico', 'Se realiza una planificación básica de la capacidad, pero puede no ser suficiente para satisfacer la demanda. ', 'Es como hacer comida para una fiesta, pero sin saber cuántos vendrán.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(311, 78, 'Maduro', 'Se realiza una planificación de capacidad adecuada que generalmente puede satisfacer la demanda, pero podría ser más eficiente o previsora. ', 'Es como preparar comida para la fiesta según las confirmaciones de asistencia, pero siempre sobra o falta algo.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(312, 78, 'Avanzado', 'Se realiza una planificación de la capacidad eficiente y previsora que siempre puede satisfacer la demanda y se adapta a los cambios del mercado. ', 'Es como tener la cantidad perfecta de comida en la fiesta, nunca sobra ni falta.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(313, 79, 'Nulo', 'No se realiza la programación de la producción o servicios. ', 'Es como intentar organizar un desfile sin horario ni ruta.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(314, 79, 'Basico', 'Se realiza una programación básica de la producción o servicios, pero puede ser ineficiente o poco fiable. ', 'Es como tener un desfile con horario y ruta, pero sin coordinación entre los participantes.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(315, 79, 'Maduro', 'Se realiza una programación eficiente y fiable de la producción o servicios, pero podría ser más flexible o detallada. ', 'Es como tener un desfile bien coordinado, pero a veces se retrasa o adelanta.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(316, 79, 'Avanzado', 'Se realiza una programación flexible y detallada de la producción o servicios que maximiza la eficiencia y puede adaptarse a las interrupciones. ', 'Es como tener un desfile que siempre empieza y termina a tiempo, y todos saben dónde deben estar.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(317, 80, 'Nulo', 'No se realiza la gestión de inventarios. ', 'Es como ir al supermercado sin una lista de compras.', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(318, 80, 'Basico', 'Se realiza una gestión básica de inventarios, pero puede ser inexacta o ineficiente. ', 'Es como tener una lista de compras, pero sin revisar lo que ya tienes en la despensa.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(319, 80, 'Maduro', 'Se realiza una gestión eficiente de inventarios que generalmente mantiene los niveles de inventario adecuados, pero podría ser más sofisticada. ', 'Es como revisar la despensa antes de ir de compras, pero a veces compras cosas que ya tenías.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(320, 80, 'Avanzado', 'Se realiza una gestión sofisticada de inventarios que siempre mantiene los niveles de inventario adecuados y minimiza el desperdicio. ', 'Es como tener un sistema que te dice exactamente qué necesitas comprar cada vez que vas al supermercado', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(321, 81, 'Nulo', 'No hay una comprensión clara de la demanda del mercado para los productos o servicios. ', 'Es como si estuviéramos navegando en la oscuridad.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(322, 81, 'Basico', 'Hay una comprensión básica de la demanda del mercado, pero podría ser más detallada o precisa. ', 'Es como si tuviéramos un mapa básico, pero no los detalles.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(323, 81, 'Maduro', 'Hay una comprensión detallada de la mayoría de los aspectos de la demanda del mercado, pero algunos aspectos podrían ser mejor entendidos. ', 'Es como si tuviéramos un mapa detallado, pero a veces nos perdemos.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(324, 81, 'Avanzado', 'Hay una comprensión exhaustiva y precisa de todos los aspectos de la demanda del mercado. ', 'Es como si tuviéramos un GPS de alta precisión que nos guía en cada paso.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(325, 82, 'Nulo', 'No se realizan proyecciones de demanda.', 'Es como si estuviéramos adivinando qué cocinar para la cena.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL);
INSERT INTO `opciones` (`id`, `challenge_id`, `madurez`, `formal`, `informal`, `updated_at`, `created_at`, `deleted_at`) VALUES
(326, 82, 'Basico', 'Se realizan proyecciones de demanda básicas, pero podrían ser más detalladas o precisas. ', 'Es como si tuviéramos una idea de lo que queremos cocinar, pero no estamos seguros de las cantidades.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(327, 82, 'Maduro', 'Se realizan proyecciones de demanda que son generalmente precisas para la mayoría de los productos o servicios, pero podrían ser más precisas. ', 'Es como si tuviéramos una receta detallada, pero a veces nos equivocamos en las medidas.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(328, 82, 'Avanzado', 'Se realizan proyecciones de demanda exhaustivas y precisas para todos los productos o servicios que se actualizan regularmente. ', 'Es como si tuviéramos un chef experimentado que siempre sabe exactamente cuánto de cada ingrediente necesita.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(329, 83, 'Nulo', 'No se adapta a los cambios en la demanda. ', 'Es como si estuviéramos atrapados en el tráfico sin un plan B.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(330, 83, 'Basico', 'Se adapta de manera básica a los cambios en la demanda, pero podría ser más eficaz o rápido. ', 'Es como si tuviéramos un plan B, pero tardamos en ponerlo en marcha.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(331, 83, 'Maduro', 'Se adapta eficazmente a la mayoría de los cambios en la demanda, pero podría ser más rápido o eficaz en algunos casos. ', 'Es como si generalmente tuviéramos un plan B listo, pero a veces nos cuesta cambiar de ruta.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(332, 83, 'Avanzado', 'Se adapta de manera rápida y eficaz a todos los cambios en la demanda. ', 'Es como si siempre tuviéramos varios planes y pudiéramos cambiar de ruta de inmediato cuando es necesario.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(333, 84, 'Nulo', 'No hay un proceso formal para la selección de proveedores. ', 'Es como si eligiéramos a nuestros amigos al azar.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(334, 84, 'Basico', 'Hay un proceso básico para la selección de proveedores, pero podría ser más detallado o riguroso. ', 'Es como si tuviéramos una idea de lo que buscamos en un amigo, pero no somos muy selectivos.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(335, 84, 'Maduro', 'Hay un proceso detallado para la selección de proveedores que generalmente es efectivo, pero podría ser más riguroso. ', 'Es como si fuéramos selectivos con nuestros amigos, pero a veces nos dejamos llevar por la primera impresión.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(336, 84, 'Avanzado', 'Hay un proceso riguroso y detallado para la selección de proveedores que se aplica de manera consistente y efectiva. ', 'Es como si siempre supiéramos exactamente lo que buscamos en un amigo y nunca nos conformáramos con menos.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(337, 85, 'Nulo', 'No se mantiene una relación formal con los proveedores. ', 'Es como si sólo habláramos con nuestros amigos cuando los necesitamos.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(338, 85, 'Basico', 'Se mantiene una relación básica con los proveedores, pero podría ser más colaborativa o estratégica. ', 'Es como si mantuviéramos una relación básica con nuestros amigos, pero no profundizamos mucho.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(339, 85, 'Maduro', 'Se mantiene una relación colaborativa con la mayoría de los proveedores, pero podría ser más estratégica. ', 'Es como si tuviéramos una buena relación con la mayoría de nuestros amigos, pero a veces falta profundidad.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(340, 85, 'Avanzado', 'Se mantiene una relación estratégica y colaborativa con todos los proveedores que se revisa y mejora regularmente. ', 'Es como si tuviéramos una relación fuerte y profunda con todos nuestros amigos.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(341, 86, 'Nulo', 'No se realiza una evaluación o revisión formal del rendimiento de los proveedores. ', 'Es como si nunca diéramos o buscáramos retroalimentación con nuestros amigos.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(342, 86, 'Basico', 'Se realiza una evaluación y revisión básicas del rendimiento de los proveedores, pero podrían ser más rigurosas. ', 'Es como si sólo diéramos o buscáramos retroalimentación cuando algo va mal.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(343, 86, 'Maduro', 'Se realiza una evaluación y revisión rigurosas del rendimiento de la mayoría de los proveedores, pero podrían ser más frecuentes o detalladas. ', 'Es como si diéramos o buscáramos retroalimentación regularmente, pero podríamos hacerlo con más profundidad.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(344, 86, 'Avanzado', 'Se realiza una evaluación y revisión rigurosas y frecuentes del rendimiento de todos los proveedores que se utiliza para mejorar las relaciones y el rendimiento. ', 'Es como si siempre diéramos y buscáramos retroalimentación para mejorar nuestras relaciones y crecer juntos.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(345, 87, 'Nulo', 'No hay un proceso formal para las compras operativas. ', 'Es como si estuviéramos comprando sin hacer una lista de la compra.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(346, 87, 'Basico', 'Hay un proceso básico para las compras operativas, pero podría ser más detallado o riguroso. ', 'Es como si hiciéramos una lista de la compra, pero a veces nos olvidamos de cosas importantes.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(347, 87, 'Maduro', 'Hay un proceso detallado para las compras operativas que generalmente es efectivo, pero podría ser más riguroso. ', 'Es como si tuviéramos una lista de la compra detallada, pero a veces nos desviamos de la lista.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(348, 87, 'Avanzado', 'Hay un proceso riguroso y detallado para las compras operativas que se aplica de manera consistente y efectiva. ', 'Es como si tuviéramos una lista de la compra perfectamente organizada y siempre nos apegáramos a ella.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(349, 88, 'Nulo', 'Las compras operativas no se realizan de manera eficiente. ', 'Es como si estuviéramos comprando sin tener en cuenta el precio o la calidad.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(350, 88, 'Basico', 'Las compras operativas se realizan de manera básicamente eficiente, pero podría haber más eficiencia. ', 'Es como si tuviéramos en cuenta el precio y la calidad al comprar, pero podríamos ser más eficientes.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(351, 88, 'Maduro', 'La mayoría de las compras operativas se realizan de manera eficiente, pero algunas compras podrían ser más eficientes. ', 'Es como si la mayoría de nuestras compras fueran eficientes, pero a veces podríamos ser más eficientes.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(352, 88, 'Avanzado', 'Todas las compras operativas se realizan de manera extremadamente eficiente. ', 'Es como si todas nuestras compras fueran hechas con la máxima eficiencia, teniendo en cuenta el precio y la calidad.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(353, 89, 'Nulo', 'No se realiza una supervisión o revisión formal de las compras operativas. ', 'Es como si nunca revisáramos nuestros recibos después de comprar.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(354, 89, 'Basico', 'Se realiza una supervisión y revisión básicas de las compras operativas, pero podrían ser más rigurosas. ', 'Es como si revisáramos nuestros recibos sólo cuando algo parece incorrecto.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(355, 89, 'Maduro', 'Se realiza una supervisión y revisión rigurosas de la mayoría de las compras operativas, pero algunas compras podrían ser revisadas más a fondo. ', 'Es como si revisáramos regularmente nuestros recibos, pero podríamos ser más detallados en nuestra revisión.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(356, 89, 'Avanzado', 'Se realiza una supervisión y revisión rigurosas y frecuentes de todas las compras operativas que se utiliza para mejorar las operaciones y la eficiencia. ', 'Es como si siempre revisáramos nuestros recibos en detalle y usáramos esa información para mejorar nuestras compras.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(357, 90, 'Nulo', 'No se realiza una gestión formal de la logística. ', 'Es como intentar enviar un paquete sin una dirección o fecha de entrega.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(358, 90, 'Basico', 'Se realiza una gestión básica de la logística que se centra principalmente en la entrega a tiempo. ', 'Es como enviar el paquete a tiempo, pero sin considerar el costo o la mejor ruta.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(359, 90, 'Maduro', 'Se realiza una gestión de la logística que considera factores como el costo, la velocidad y la fiabilidad, pero podría ser más eficiente. ', 'Es como elegir la mejor ruta para enviar el paquete, pero sin considerar otras opciones de entrega.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(360, 90, 'Avanzado', 'Se realiza una gestión eficiente de la logística que minimiza los costos y maximiza la velocidad y la fiabilidad de la entrega. ', 'Es como tener un sistema de entrega que siempre encuentra la ruta más rápida y barata.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(361, 91, 'Nulo', 'No hay un proceso formal para la gestión del inventario. ', 'Es como si estuviéramos almacenando cosas sin tener una idea de lo que tenemos.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(362, 91, 'Basico', 'Hay un proceso básico para la gestión del inventario, pero podría ser más detallado o riguroso. ', 'Es como si tuviéramos un sistema básico para rastrear lo que tenemos, pero no es muy completo.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(363, 91, 'Maduro', 'Hay un proceso detallado para la gestión del inventario que generalmente es efectivo, pero podría ser más riguroso. ', 'Es como si tuviéramos un buen sistema para rastrear lo que tenemos, pero a veces perdemos la pista.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(364, 91, 'Avanzado', 'Hay un proceso riguroso y detallado para la gestión del inventario que se aplica de manera consistente y efectiva. ', 'Es como si tuviéramos un sistema perfecto que siempre nos dice exactamente lo que tenemos en inventario.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(365, 92, 'Nulo', 'El inventario no se gestiona de manera eficiente. ', 'Es como si estuviéramos almacenando cosas sin tener en cuenta el espacio o el costo.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(366, 92, 'Basico', 'El inventario se gestiona de manera básicamente eficiente, pero podría haber más eficiencia. ', 'Es como si estuviéramos intentando usar nuestro espacio de manera eficiente, pero a veces nos quedamos cortos.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(367, 92, 'Maduro', 'La mayoría del inventario se gestiona de manera eficiente, pero algunos artículos podrían ser gestionados de manera más eficiente. ', 'Es como si la mayoría de nuestras decisiones de almacenamiento fueran eficientes, pero algunas podrían ser mejores.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(368, 92, 'Avanzado', 'Todo el inventario se gestiona de manera extremadamente eficiente. ', 'Es como si almacenáramos todo de la forma más eficiente posible, maximizando el espacio y minimizando el costo.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(369, 93, 'Nulo', 'No hay un proceso formal para la gestión del almacenamiento. ', 'Es como si estuviéramos llenando un armario sin tener un plan.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(370, 93, 'Basico', 'Hay un proceso básico para la gestión del almacenamiento, pero podría ser más detallado o riguroso. ', 'Es como si tuviéramos un plan básico para llenar el armario, pero a veces las cosas se pierden.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(371, 93, 'Maduro', 'Hay un proceso detallado para la gestión del almacenamiento que generalmente es efectivo, pero podría ser más riguroso. ', 'Es como si tuviéramos un buen plan para llenar el armario, pero a veces las cosas se salen de lugar.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(372, 93, 'Avanzado', 'Hay un proceso riguroso y detallado para la gestión del almacenamiento que se aplica de manera consistente y efectiva. ', 'Es como si tuviéramos un plan perfecto para llenar el armario y siempre supiéramos exactamente dónde está todo.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(373, 94, 'Nulo', 'No hay prácticas establecidas para la exactitud de inventario; los registros no reflejan el inventario real. ', 'No sabemos cuál es la exactitud de nuestro inventario; no hay datos confiables ni seguimiento.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(374, 94, 'Basico', 'Se realizan conteos periódicos, pero no hay un sistema sólido ni procesos de reconciliación regulares. ', 'Tenemos una idea general de nuestro inventario, pero aún enfrentamos discrepancias significativas y errores frecuentes.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(375, 94, 'Maduro', 'Los procesos de control de inventario están bien definidos, y la exactitud del inventario se mantiene a través de auditorías frecuentes. ', 'Nuestro inventario es preciso y confiable; usamos métricas para mejorar constantemente la exactitud del inventario.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(376, 94, 'Avanzado', 'Se utiliza tecnología de vanguardia y procesos de clase mundial para obtener una exactitud casi perfecta del inventario. ', 'Somos líderes en la gestión de inventario, con sistemas automatizados y procesos de mejora continua que aseguran la exactitud.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(377, 95, 'Nulo', 'No se realiza una supervisión o revisión formal del almacenamiento. ', 'Es como si nunca revisáramos nuestro armario a menos que algo se perdiera.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(378, 95, 'Basico', 'Se realiza una supervisión y revisión básicas del almacenamiento, pero podrían ser más rigurosas. ', 'Es como si revisáramos nuestro armario de vez en cuando, pero no de forma regular.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(379, 95, 'Maduro', 'Se realiza una supervisión y revisión rigurosas de la mayoría del almacenamiento, pero algunos espacios podrían ser revisados más a fondo. ', 'Es como si revisáramos nuestro armario regularmente, pero podríamos ser más detallados.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(380, 95, 'Avanzado', 'Se realiza una supervisión y revisión rigurosas y frecuentes de todo el almacenamiento que se utiliza para mejorar las operaciones y la eficiencia. ', 'Es como si siempre revisáramos nuestro armario en detalle y usáramos esa información para mejorar nuestras operaciones.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(381, 96, 'Nulo', 'No utilizamos apoyos visuales en nuestros procesos.', 'Nos guiamos a ciegas', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(382, 96, 'Basico', 'Utilizamos pocos apoyos visuales de manera informal.', 'Nos guiamos con lo que improvisamos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(383, 96, 'Maduro', 'Utilizamos la mayoría de los apoyos visuales necesarios pero de manera inconsistente para mantener nuestros estandares activos. ', 'Nos falta consistencia', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(384, 96, 'Avanzado', 'Utilizamos todos los apoyos visuales necesarios de manera estructurada y actualizada que nos ayudan a trabajar más rápido, con mejor calidad y de manera segura evitando costos innecesarios. ', 'Nuestros estándares visuales nos permiten hacer las tareas a la perfección y sin demoras', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(385, 97, 'Nulo', 'No utilizamos herramientas de ningún tipo, ', 'Mientras salga el producto que cada quien le haga como pueda', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(386, 97, 'Basico', 'Utilizamos algunas herramientas \"\"LEAN\"\" de manera informal. ', 'Usamos las herramientas de  o manufactura esbelta cuando nos acordamos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(387, 97, 'Maduro', 'Utilizamos la mayoría de herramientas necesarias de manufactua esbelta pero de manera inconsistente. ', 'Utilizamos las herramientas pero sin un sistema', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(388, 97, 'Avanzado', 'Utilizamos todas las herramientas necesarias de manera estructurada y actualizada.', 'Le entramos duro y seguro', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(389, 98, 'Nulo', 'No identificamos ni reducimos ni cuantificamos los desperdicios.', 'Desperdiciamos el tiempo en desperdicios', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(390, 98, 'Basico', 'Identificamos algunos desperdicios pero no implementamos soluciones.', 'Cuidamos los centavos aunque perdamos los pesos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(391, 98, 'Maduro', 'Identificamos y reducimos la mayoría de desperdicios aunque de manera informal, mejoramos lo que se ve, pero no analizamos más.', 'Somos los apagafuegos de las pérdidas y fallas', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(392, 98, 'Avanzado', 'Identificamos, reducimos y controlamos todos los desperdicios de manera estructurada.', 'Trabajamos sin derroches', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(393, 99, 'Nulo', 'No estamos familiarizados con el concepto de poka yoke.', 'Nunca hemos oído de ese término y suena que está en chino o japonés', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(394, 99, 'Basico', 'Hemos recibido información al respecto  a nivel básico del concepto poka yoke pero no hemos aplicado técnicas.', 'Sabemos lo que es, pero no hemos puesto nada en práctica', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(395, 99, 'Maduro', 'Hemos desarrollado algunas cosas fáciles como revisiones visuales y trampitas mecánicas para que no la reguemos.', 'Tenemos nuestros truquitos básicos anti-metidas de pata', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(396, 99, 'Avanzado', 'Tenemos mapeados todos los puntos de calidad y les hemos asignado un pokayoke adecuado los cuales  cuentan con su plan de mantenimiento y control de cambios.', 'Trabajamos libres de errores y tenemos un plan para colocar los que hacen falta', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(397, 100, 'Nulo', 'No tenemos idea de herramientas estadísticas para análisis de causa raíz.', 'Las estadísticas son una lengua extranjera para nosotros, solo llegamos a revisar promedios y desviación si bien nos va', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(398, 100, 'Basico', 'Conocemos  algunas herramientas básicas como histogramas y gráficos de control.', 'Nuestras habilidades estadísticas son de bachilerato, pero al menos dominamos las tablas y gráficas', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(399, 100, 'Maduro', 'Podemos identificar y aplicar herramientas como histogramas, gráficos de control, prueba Z y prueba t para análisis básicos de datos.', 'Podemos hacer algo de magia con los números y obtener conslusiones válidas', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(400, 100, 'Avanzado', 'Aplicamos una amplia gama de herramientas estadísticas como análisis de regresión, análisis de varianza (ANOVA) y diseño de experimentos para controlar los procesos con alta variabilidad.', 'Las complejas técnicas estadísticas son nuestra segunda lengua', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(401, 101, 'Nulo', 'No realizamos seguimiento a las acciones correctivas.', 'Esperamos a que las soluciones funcionen por arte de magia', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(402, 101, 'Basico', 'Realizamos algo de seguimiento aunque de forma esporádica. ', 'Revisamos por encima de vez en cuando', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(403, 101, 'Maduro', 'Usualmente les damos seguimiento a las mejoras, no de forma estructurada pero con la idea de verificar su progreso.', 'Le echamos un ojo de vez en cuando', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(404, 101, 'Avanzado', 'Realizamos seguimiento estructurado a todas las acciones correctivas.', 'Llevamos un registro detallado para asegurarnos de que la magia no se haya ido', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(405, 102, 'Nulo', 'No implementamos controles en las acciones correctivas. ', 'Basicamente solucionamos un problema y creamos otro al no crear controles', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(406, 102, 'Basico', 'Implementamos algunos controles aunque de forma esporádica.', 'Ponemos parches aquí y allá pero la ropa sigue rota', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(407, 102, 'Maduro', 'Implementamos la mayoría de controles necesarios aunque de forma informal.', 'Improvisamos sobre la marcha', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(408, 102, 'Avanzado', 'Implementamos todos los controles necesarios de forma estructurada y actualizada.', 'Tenemos un plan de acción y lo seguimos (al menos la mayor parte del tiempo', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(409, 103, 'Nulo', 'No hay un sistema de calidad definido. Las actividades de calidad son reactivas y no estructuradas.', 'No tenemos un enfoque sistemático para la gestión de calidad.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(410, 103, 'Basico', 'Existe un reconocimiento de la calidad, con prácticas básicas y procedimientos simples en su lugar. ', 'Estamos empezando a desarrollar procesos de calidad y a documentar procedimientos.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(411, 103, 'Maduro', 'El sistema de calidad está formalizado, con procesos documentados y un enfoque en la prevención y mejora continua. ', 'Nuestro sistema de calidad está bien establecido, es conocido por todo el personal y es parte de nuestra cultura.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(412, 103, 'Avanzado', 'El sistema de calidad es una referencia en la industria, con integración de mejores prácticas y liderazgo en innovación y rendimiento. ', 'Somos líderes en calidad, exploramos continuamente nuevas metodologías y compartimos nuestras prácticas con otros.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(413, 104, 'Nulo', 'Los productos / servicios de la Empresa a menudo no cumplen con las especificaciones establecidas. ', 'Menos del 80% del producto es acreditado. Nuestros productos son como un traje mal hecho, a menudo no se ajustan bien', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(414, 104, 'Basico', 'Los productos de la Empresa generalmente cumplen con las especificaciones, pero a veces hay desviaciones. (80-95%)  ', 'Nuestros productos son como un traje a medida, generalmente bien ajustado pero a veces hay errores', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(415, 104, 'Maduro', 'Los productos de la Empresa  siempre cumplen con las especificaciones, con desviaciones mínimas en raras ocasiones. (> 95%) ', 'Nuestros productos son como un traje de alta costura, casi siempre a medida perfecta', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(416, 104, 'Avanzado', 'Los productos de la Empresa siempre cumplen exactamente con las especificaciones sin desviaciones. (proceso Six Sigma 3.4 defectos por millón)  ', 'Nuestros productos son como un traje hecho por un sastre experto, siempre a medida perfecta', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(417, 105, 'Nulo', 'No hay un sistema de muestreo durante la manufactura, o si existe, es inconsistente y no sistemático. ', 'No tenemos un enfoque estandarizado para el muestreo y la confiabilidad de nuestro proceso es incierta', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(418, 105, 'Basico', 'Se realiza muestreo, pero no está bien definido o estandarizado y su frecuencia y metodología pueden ser arbitrarias. ', 'Hemos comenzado a implementar muestreo en la manufactura, pero necesitamos mejorar la consistencia y la metodología', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(419, 105, 'Maduro', 'El sistema de muestreo es parte integral del proceso de manufactura, con procedimientos estandarizados y análisis de datos para la mejora. ', 'Contamos con un sistema de muestreo robusto que nos permite monitorear y controlar la calidad de manera efectiva', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(420, 105, 'Avanzado', 'El sistema de muestreo es sofisticado, con análisis estadístico avanzado, y es un referente para la industria en términos de mejores prácticas. ', 'Somos líderes en la implementación de sistemas de muestreo y seguimos innovando para asegurar la máxima calidad del producto', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(421, 106, 'Nulo', 'No hay procesos definidos para asegurar la confiabilidad de los sistemas de medición; los datos de medición son a menudo inexactos o no se utilizan. ', 'No confiamos plenamente en nuestras mediciones y no hay control sobre los sistemas de medición', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(422, 106, 'Basico', 'Existen procesos rudimentarios para la medición de productos, pero carecen de estandarización y no siempre son confiables. ', 'Hemos comenzado a prestar atención a nuestras mediciones, pero el proceso todavía carece de coherencia y precisión', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(423, 106, 'Maduro', 'Los sistemas de medición son robustos, estandarizados y regularmente calibrados; hay un enfoque en la mejora continua de su confiabilidad. ', 'Nuestros sistemas de medición son fiables y están integrados en nuestros procesos de calidad para garantizar la consistencia del producto', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(424, 106, 'Avanzado', 'La confiabilidad de los sistemas de medición es de clase mundial, con prácticas líderes en la industria y un enfoque en la innovación y precisión avanzada. ', 'Somos reconocidos por la precisión y confiabilidad de nuestras mediciones, y buscamos continuamente mejorar nuestras capacidades de medición', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(425, 107, 'Nulo', 'En la Empresa la seguridad de los colaboradores no es una prioridad y ocurren accidentes con frecuencia. ', 'Nuestra seguridad laboral es como una montaña rusa, llena de altibajos y giros inesperados', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(426, 107, 'Basico', 'En la Empresa se aplican algunas medidas de seguridad y se cuenta con un programa de seguridad pero no se siguen de manera consistente, lo que lleva a incidentes ocasionales. ', 'Nuestra seguridad laboral es como un camino de grava, mayormente seguro pero con algunos baches', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(427, 107, 'Maduro', 'En la Empresa  la seguridad laboral es importante y se siguen la mayoría de las normas y el programa de seguridad lo cual involucra operadores pero también en oficinas, sin embargo aún se producen incidentes menores. ', 'Nuestra seguridad laboral es como un camino asfaltado, generalmente seguro pero con algunas pequeñas grietas', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(428, 107, 'Avanzado', 'En la Empresa, la seguridad laboral es prioritaria y se siguen todas las normas, las mejoras y los estándares, lo que resulta en un ambiente de trabajo seguro y sin incidentes. ', 'Nuestra seguridad laboral es como una autopista bien mantenida, segura y sin obstáculos', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(429, 108, 'Nulo', 'En la Empresa , la gestión ambiental y sostenibilidad no son prioridades, y no se toman acciones significativas para mitigar el impacto ambiental de la operación o del producto o servicio que se ofrece. ', 'Nuestra gestión ambiental es como un viejo coche de gasolina, contamina mucho y recicla poco', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(430, 108, 'Basico', 'En la Empresa, se toman algunas medidas para reducir el impacto ambiental, pero no hay una estrategia de sostenibilidad bien definida para los productos o servicios ofrecidos. ', 'Nuestra gestión ambiental es como un coche híbrido, estamos tratando de ser más verdes pero aún tenemos un largo camino por recorrer', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(431, 108, 'Maduro', 'En la Empresa , se toman medidas significativas para reducir el impacto ambiental del producto o servicio que entrega la organización y existe una estrategia de sostenibilidad en desarrollo alineada a las necesidades ambientales. ', 'Nuestra gestión ambiental es como un coche eléctrico, estamos haciendo grandes esfuerzos para ser más limpios y sostenibles', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(432, 108, 'Avanzado', 'La gestión ambiental y sostenibilidad son pilares centrales de la organización, nuestras operaciones cuentan con una estrategia sólida y medidas efectivas en su lugar. ', 'Nuestra gestión ambiental es como un bosque bien gestionado, todo está en equilibrio y trabajamos para preservar y mejorar', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(433, 109, 'Nulo', 'No se realiza ningún tipo de mantenimiento preventivo. ', 'Es como tener un automóvil y no hacer revisiones regulares, simplemente esperar a que algo se rompa para arreglarlo', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(434, 109, 'Basico', 'Se realiza algún tipo de mantenimiento preventivo, pero es esporádico y no sigue un programa establecido. ', 'Es como hacer revisiones ocasionales de nuestro auto cuando nos acordamos, pero sin un plan establecido. ', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(435, 109, 'Maduro', 'Existe un programa de mantenimiento preventivo, pero no se sigue rigurosamente o se omite en algunas ocasiones. ', 'Es como tener un programa de revisión para nuestro auto, pero a veces aplazamos o saltamos las revisiones', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(436, 109, 'Avanzado', 'Se tiene un programa de mantenimiento preventivo bien establecido y se sigue rigurosamente. ', 'Es como tener un programa de revisión detallado para nuestro automóvil y adherirse estrictamente a él para garantizar su óptimo funcionamiento', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(437, 110, 'Nulo', 'No se tiene un proceso básico de las normativas relevantes para la organización, lo que puede exponer a la organización a riesgos legales y regulatorios. ', 'No tenemos un conocimiento básico de las normativas relevantes', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(438, 110, 'Basico', 'Se tiene un proceso básico de las normativas relevantes para la organización, lo que proporciona una base para el cumplimiento normativo.', 'Tenemos un conocimiento básico de las normativas relevantes', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(439, 110, 'Maduro', 'Se lleva a cabo una revisión regular de las normativas para mantenerse al día con los cambios, lo que muestra un enfoque proactivo para el cumplimiento normativo. ', 'Revisamos regularmente las normativas para mantenernos al día', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(440, 110, 'Avanzado', 'Se tienen sistemas avanzados para rastrear y mantenerse al día con los cambios en las normativas y cómo afectan a la organización, lo que demuestra un enfoque sistemático y basado en datos para el cumplimiento normativo.  ', 'Tenemos sistemas avanzados para rastrear y estar al día con las normativas', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(441, 111, 'Nulo', 'No existen procesos básicos para cumplir con las normativas, como la recopilación de la documentación necesaria, lo que puede poner en riesgo el cumplimiento normativo de la organización.  ', 'No tenemos procesos básicos para el cumplimiento normativo', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(442, 111, 'Basico', 'Existen procesos básicos para cumplir con las normativas, como la recopilación de la documentación necesaria, proporcionando un enfoque inicial para el cumplimiento normativo. ', 'Tenemos procesos básicos para cumplir con las normativas', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(443, 111, 'Maduro', 'Estos procesos se revisan y actualizan regularmente para asegurar su eficacia, lo que muestra un enfoque proactivo y consciente de la importancia de mantener los procesos de cumplimiento al día. ', 'Revisamos y actualizamos regularmente nuestros procesos de cumplimiento', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(444, 111, 'Avanzado', 'Los procesos de cumplimiento están totalmente integrados en las operaciones de la empresa y se utilizan tecnologías avanzadas para su gestión, lo que demuestra un enfoque altamente sistemático y eficiente para el cumplimiento normativo', 'Nuestros procesos de cumplimiento están totalmente integrados en nuestras operaciones y utilizamos tecnología avanzada para gestionarlos', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(445, 112, 'Nulo', 'No se ofrece formación básica en cumplimiento normativo a los empleados, lo que puede resultar en una falta de concienciación y potencial incumplimiento. ', 'No ofrecemos formación básica en cumplimiento normativo', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(446, 112, 'Basico', 'Se ofrece formación básica en cumplimiento normativo a los empleados, lo que proporciona una base para la concienciación y el cumplimiento. ', 'Ofrecemos formación básica en cumplimiento normativo', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(447, 112, 'Maduro', 'Se revisa y actualiza regularmente la formación para reflejar las nuevas normativas y las necesidades cambiantes de la empresa, lo que demuestra un compromiso con la formación continua y adaptativa.', 'Revisamos y actualizamos regularmente nuestra formación en cumplimiento normativo', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(448, 112, 'Avanzado', 'La formación en cumplimiento normativo es continua y personalizada para los diferentes roles dentro de la empresa, y se utiliza la tecnología para mejorar la eficacia de la formación, lo que indica un enfoque altamente estratégico y efectivo para la formación y concienciación en cumplimiento normativo. ', 'Nuestra formación en cumplimiento normativo es continua, personalizada y potenciada por tecnología', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(449, 113, 'Nulo', 'No se realizan evaluaciones básicas para comprobar el cumplimiento de las normativas, lo que puede resultar en un desconocimiento del estado de cumplimiento de la organización. ', 'No realizamos evaluaciones básicas de cumplimiento', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(450, 113, 'Basico', 'Se realizan evaluaciones básicas para comprobar el cumplimiento de las normativas, proporcionando una visión inicial del estado de cumplimiento.  ', 'Realizamos evaluaciones básicas de cumplimiento', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(451, 113, 'Maduro', 'Se realizan evaluaciones periódicas y se siguen los procedimientos para corregir cualquier incumplimiento, lo que muestra un compromiso continuo y formalizado con el mantenimiento del cumplimiento de las normativas. ', 'Realizamos evaluaciones periódicas de cumplimiento y corregimos cualquier incumplimiento identificado', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(452, 113, 'Avanzado', 'Se utilizan técnicas avanzadas, como el análisis de datos, para evaluar el cumplimiento y prever posibles problemas de cumplimiento en el futuro, demostrando un enfoque proactivo y tecnológicamente avanzado para la evaluación del cumplimiento. ', 'Utilizamos técnicas avanzadas como el análisis de datos para la evaluación del cumplimiento', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(453, 114, 'Nulo', 'No se tiene un proceso para gestionar los incumplimientos, lo que puede resultar en repetición de errores y falta de transparencia. ', 'No tenemos un proceso para gestionar los incumplimientos', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(454, 114, 'Basico', 'Se tiene un proceso básico para gestionar los incumplimientos, como la documentación y la corrección de los errores, proporcionando una base para la responsabilidad y la mejora.  ', 'Tenemos un proceso básico para gestionar los incumplimientos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(455, 114, 'Maduro', 'Se analizan los incumplimientos para identificar patrones y áreas de mejora, lo que demuestra un enfoque proactivo y basado en el análisis para la mejora del cumplimiento.  ', 'Analizamos los incumplimientos para identificar patrones y áreas de mejora', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(456, 114, 'Avanzado', 'Se tiene un proceso avanzado para gestionar los incumplimientos que incluye la prevención de futuros errores y la mejora continua, lo que indica una gestión de incumplimientos altamente desarrollada y estratégica.', 'Tenemos un proceso avanzado para gestionar incumplimientos que incluye la prevención de futuros errores y la mejora continua', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(457, 115, 'Nulo', 'No se realizan auditorías para verificar el cumplimiento de las normativas, lo que puede causar un desconocimiento de la situación real de la organización y la falta de mejora.', 'No realizamos auditorías', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(458, 115, 'Basico', 'Se realizan auditorías básicas para comprobar el cumplimiento de las normativas, lo que proporciona una visión inicial de la situación de cumplimiento de la organización.', 'ealizamos auditorías básicas para comprobar el cumplimiento', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(459, 115, 'Maduro', 'Se realizan auditorías periódicas y se siguen los procedimientos para corregir cualquier incumplimiento, lo que muestra un compromiso continuo con el mantenimiento del cumplimiento de las normativas.  ', 'Realizamos auditorías periódicas y corregimos cualquier incumplimiento identificado', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(460, 115, 'Avanzado', 'Se realizan auditorías internas y externas regulares y se utilizan sus resultados para mejorar continuamente los procesos de cumplimiento, lo que indica un enfoque proactivo y sistemático para el mantenimiento y la mejora del cumplimiento. ', 'Realizamos auditorías internas y externas regulares y usamos sus resultados para mejorar continuamente nuestros procesos de cumplimiento', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(461, 116, 'Nulo', 'No existen normas y políticas formales que guíen la conducta y las operaciones de la empresa. No hay ninguna orientación clara para los empleados. ', 'No tenemos normas ni políticas formales en nuestra empresa. Los empleados a menudo tienen que adivinar lo que se espera de ellos', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(462, 116, 'Basico', 'Existen algunas normas y políticas básicas, pero pueden no ser completas ni coherentes. Su comunicación puede ser irregular y no todos los empleados pueden estar al tanto de ellas. ', 'Tenemos algunas normas y políticas básicas, pero no las comunicamos regularmente, por lo que no todos los empleados las conocen', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(463, 116, 'Maduro', 'Existen normas y políticas bien definidas que guían la mayoría de las áreas de la empresa. Se comunican de manera efectiva a la mayoría de los empleados. ', 'Tenemos normas y políticas bien definidas para la mayoría de las áreas de nuestra empresa. Hacemos un buen trabajo comunicándolas a la mayoría de nuestros empleados', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(464, 116, 'Avanzado', 'Existe un conjunto completo y coherente de normas y políticas que cubre todas las áreas de la empresa. Se comunican de manera efectiva a todos los empleados y se actualizan regularmente. ', 'Tenemos un conjunto completo de normas y políticas que cubren todas las áreas de la empresa. Nos aseguramos de que todos los empleados las conozcan y las actualizamos regularmente', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(465, 117, 'Nulo', 'No se tiene un presupuesto inicial que cubra todos los gastos de inicio y operación, lo que puede crear incertidumbre financiera y riesgos para la viabilidad del proyecto.', 'No tenemos un presupuesto que cubra todos nuestros gastos de inicio y operación', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(466, 117, 'Basico', 'Se tiene un presupuesto inicial que cubre los gastos básicos de inicio, pero no todos los costos operativos, lo que proporciona una base mínima de planificación financiera.  ', 'Tenemos un presupuesto inicial que cubre nuestros gastos básicos de inicio', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(467, 117, 'Maduro', 'Se tiene un presupuesto que cubre tanto los gastos de inicio como una parte significativa de los costos operativos, lo que muestra una planificación financiera más completa y realista. ', 'Nuestro presupuesto cubre los gastos de inicio y una parte significativa de los costos operativos', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(468, 117, 'Avanzado', 'Se tiene un presupuesto detallado y completo que cubre todos los gastos de inicio y operación, lo que muestra una gestión financiera sólida y reduce el riesgo de sorpresas financieras desagradables. ', 'Tenemos un presupuesto detallado y completo que cubre todos nuestros gastos de inicio y operación', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(469, 118, 'Nulo', 'No se han establecido políticas y procedimientos contables desde el inicio, lo que puede causar desorganización financiera y riesgos para la gestión de las finanzas de la empresa. Esto implica que no se han definido o implementado reglas básicas para la contabilidad, como la forma en que se registrarán y clasificarán los ingresos y gastos.  ', 'No hemos establecido políticas y procedimientos contables desde el inicio', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(470, 118, 'Basico', 'Se han establecido políticas y procedimientos contables básicos desde el inicio, lo que proporciona una estructura mínima para la gestión de las finanzas de la empresa. Esto podría incluir políticas sobre cómo se registrarán y categorizarán los ingresos y gastos, pero puede que no cubra todas las eventualidades o que no se aplique de manera consistente.  ', 'Hemos establecido políticas y procedimientos contables básicos desde el inicio', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(471, 118, 'Maduro', 'Se han establecido políticas y procedimientos contables completos y se siguen de forma regular, lo que muestra una gestión financiera más consistente y organizada. Esto implica que se han definido políticas y procedimientos detallados que cubren una amplia variedad de situaciones y se aplican de manera regular y consistente.', 'Seguimos políticas y procedimientos contables completos que hemos establecido desde el inicio', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(472, 118, 'Avanzado', 'Se han establecido políticas y procedimientos contables robustos desde el inicio, se siguen de manera regular y se revisan y actualizan sistemáticamente, lo que indica una gestión financiera sólida y proactiva. Esto significa que además de tener políticas y procedimientos contables detallados y bien definidos, estos se revisan regularmente y se actualizan según sea necesario para reflejar los cambios en la empresa o en las regulaciones financieras.', 'Nuestras políticas y procedimientos contables robustos, establecidos desde el inicio, se siguen, revisan y actualizan sistemáticamente', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(473, 119, 'Nulo', 'No se entienden ni se cumplen las obligaciones fiscales, lo que puede resultar en sanciones y complicaciones legales. ', 'Nuestra gestión de impuestos es tan desordenada como un armario después de una venta de ropa. No entendemos ni cumplimos nuestras obligaciones fiscales', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(474, 119, 'Basico', 'Se tiene una comprensión básica de las obligaciones fiscales y se hacen algunos esfuerzos para cumplirlas. ', 'Estamos aprendiendo a bailar la salsa de los impuestos: entendemos lo básico, pero aún tropezamos aquí y allá', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(475, 119, 'Maduro', 'Se entienden bien las obligaciones fiscales y se cumplen regularmente, aunque puede haber ocasiones en las que se pierda un paso o dos. ', 'Somos como bailarines de salsa experimentados con nuestra gestión de impuestos. Lo hacemos bien la mayoría de las veces, pero a veces perdemos un paso', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(476, 119, 'Avanzado', 'Se entienden completamente las obligaciones fiscales y se cumplen siempre.', 'Nuestra gestión de impuestos es tan fluida como un bailarín de salsa experto. Entendemos y cumplimos nuestras obligaciones fiscales sin perder el ritmo', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(477, 120, 'Nulo', 'No se tiene control sobre los activos fijos de la empresa.  ', 'Nuestra gestión de activos fijos es como un jardín salvaje, no tenemos control sobre ellos', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(478, 120, 'Basico', 'Se tiene una noción básica de los activos fijos y se intenta mantener cierto orden.', 'Estamos intentando ordenar nuestro jardín de activos fijos, pero aún hay algunas malas hierbas que necesitan ser arrancadas', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(479, 120, 'Maduro', 'Se tiene un buen control sobre los activos fijos, aunque puede haber ocasiones en las que se pierda el seguimiento de algunos', 'Nuestro jardín de activos fijos está bien cuidado, pero de vez en cuando encontramos una flor que necesita ser podada', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(480, 120, 'Avanzado', 'Se tiene un control total sobre los activos fijos', 'Nuestra gestión de activos fijos es como un jardín perfectamente mantenido, donde cada planta está en su lugar', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(481, 121, 'Nulo', 'No existe un proceso para calcular ni registrar la depreciación de los activos. ', 'No llevamos un registro de cómo nuestros muebles de casa se desgastan con el tiempo', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(482, 121, 'Basico', 'Se tiene una idea general de cómo funcionan las depreciaciones y se hacen intentos ocasionales para calcularlas, pero no hay un proceso sólido en su lugar. ', 'De vez en cuando notamos el desgaste de nuestros muebles, pero no tenemos un plan claro para manejarlo', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(483, 121, 'Maduro', 'Se tiene un proceso establecido para calcular y registrar la depreciación de los activos, pero puede haber ocasiones en las que se cometen errores o se pierden algunas depreciaciones. ', 'Mantenemos un buen seguimiento del desgaste de nuestros muebles, pero a veces se nos olvida actualizar el registro', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(484, 121, 'Avanzado', 'Se tiene un proceso sólido y bien definido para calcular y registrar la depreciación de los activos', 'Llevamos un registro meticuloso de cada pequeño desgaste que ocurre en nuestros muebles', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(485, 122, 'Nulo', 'No se tiene un proceso para la renovación ni la actualización de los activos fijos.', 'Tenemos un conjunto de herramientas antiguas y no consideramos reemplazarlas ni mejorarlas', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(486, 122, 'Basico', 'Se tiene una idea general de la renovación y actualización de los activos fijos, pero se realiza de manera esporádica y sin un proceso definido. ', 'De vez en cuando, reemplazamos una herramienta antigua con una más nueva, pero sin un plan claro', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(487, 122, 'Maduro', 'Existe un proceso para la renovación y actualización de los activos fijos, pero no se sigue de manera rigurosa o se omite en algunas ocasiones. ', 'Tenemos un plan para reemplazar nuestras herramientas antiguas, pero a veces olvidamos seguirlo', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(488, 122, 'Avanzado', 'Se tiene un proceso bien establecido y rigurosamente seguido para la renovación y actualización de los activos fijos. ', 'Tenemos un plan detallado para actualizar nuestras herramientas y lo seguimos estrictamente', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(489, 123, 'Nulo', 'No se tiene un proceso para la eliminación ni las bajas de los activos fijos. ', 'Es como si tuviéramos un montón de herramientas viejas y rotas en nuestro garaje y nunca nos molestamos en deshacernos de ellas', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(490, 123, 'Basico', 'Se tiene una idea general de la eliminación y las bajas de los activos fijos, pero se realiza de manera esporádica y sin un proceso definido. ', 'Es como si de vez en cuando, desecháramos una herramienta vieja y rota, pero sin un plan claro', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(491, 123, 'Maduro', 'Existe un proceso para la eliminación y las bajas de los activos fijos, pero no se sigue de manera rigurosa o se omite en algunas ocasiones. ', 'Tenemos un plan para deshacernos de nuestras herramientas viejas, pero a veces olvidamos seguirlo', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL);
INSERT INTO `opciones` (`id`, `challenge_id`, `madurez`, `formal`, `informal`, `updated_at`, `created_at`, `deleted_at`) VALUES
(492, 123, 'Avanzado', 'Se tiene un proceso bien establecido y rigurosamente seguido para la eliminación y las bajas de los activos fijos. ', 'Tenemos un plan detallado para deshacernos de nuestras herramientas y lo seguimos estrictamente', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(493, 124, 'Nulo', 'No se tiene una comprensión ni gestión del capital de trabajo. No hay una planificación para manejar los fondos a corto plazo y no se entiende la importancia de mantener un equilibrio entre los activos y pasivos corrientes. ', 'No tenemos un plan para manejar nuestro dinero a corto plazo y no entendemos por qué es importante hacerlo', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(494, 124, 'Basico', 'Se tiene una comprensión básica del capital de trabajo y se hacen esfuerzos para gestionarlo, pero sin una estrategia clara ni eficiente. No se tiene una visión a largo plazo y las decisiones se toman en reacción a los problemas, en lugar de prevenirlos.', 'Intentamos manejar nuestro dinero a corto plazo, pero a menudo nos encontramos reaccionando a los problemas en lugar de prevenirlos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(495, 124, 'Maduro', 'Se tiene una estrategia definida para la gestión del capital de trabajo, pero la implementación puede ser inconsistente. Se entiende la importancia de mantener un equilibrio entre los activos y pasivos corrientes, pero puede haber dificultades para mantener este equilibrio en todas las circunstancias. ', 'Tenemos un plan para manejar nuestro dinero a corto plazo, pero a veces tenemos problemas para seguirlo', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(496, 124, 'Avanzado', 'Se tiene una comprensión completa del capital de trabajo y se gestiona eficazmente a través de una estrategia bien definida y ejecutada de manera consistente. Se mantiene un equilibrio óptimo entre los activos y pasivos corrientes, lo que permite a la empresa manejar sus obligaciones a corto plazo sin problemas.', 'Tenemos un plan sólido para manejar nuestro dinero a corto plazo', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(497, 125, 'Nulo', 'No se tiene un entendimiento de la rotación de inventarios ni se tiene una estrategia para manejar los niveles de inventario. Los productos pueden quedarse en el inventario por largos periodos de tiempo, lo que puede resultar en obsolescencia y costos de almacenamiento elevados.', 'No tenemos un plan para manejar nuestro inventario y los productos a menudo se quedan en el inventario por mucho tiempo', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(498, 125, 'Basico', 'Se tiene un entendimiento básico de la rotación de inventarios y se hacen esfuerzos para manejar los niveles de inventario, pero sin una estrategia clara ni eficiente. Los productos aún pueden quedarse en el inventario por más tiempo del deseado. ', 'Estamos tratando de manejar nuestro inventario, pero los productos aún tienden a quedarse en el inventario por más tiempo del que quisiéramos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(499, 125, 'Maduro', 'Se tiene una estrategia definida para la rotación de inventarios, pero la implementación puede ser inconsistente. Se hace un esfuerzo por mantener los niveles de inventario en un equilibrio óptimo, pero puede haber dificultades para mantener este equilibrio en todas las circunstancias. ', 'Tenemos un plan para manejar nuestro inventario, pero a veces tenemos problemas para seguirlo', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(500, 125, 'Avanzado', 'Se tiene una comprensión completa de la rotación de inventarios y se gestiona eficazmente a través de una estrategia bien definida y ejecutada de manera consistente. Se mantiene un equilibrio óptimo en los niveles de inventario, minimizando los costos de almacenamiento y evitando la obsolescencia. ', 'Tenemos un sólido plan de manejo de inventario que seguimos consistentemente. Esto nos permite mantener nuestros costos de almacenamiento bajos y evitar la obsolescencia', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(501, 126, 'Nulo', 'No hay comprensión ni estrategia para la rotación de cuentas por cobrar. Los pagos pueden retrasarse significativamente o pueden no recibir seguimiento, lo que puede resultar en problemas de flujo de efectivo. ', 'No tenemos un plan para seguir nuestras cuentas por cobrar y a menudo tenemos problemas con los pagos retrasados', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(502, 126, 'Basico', 'Existe una comprensión básica de la rotación de cuentas por cobrar y se hacen esfuerzos para hacer un seguimiento de los pagos, pero sin una estrategia clara o eficiente. Los pagos pueden retrasarse a menudo y no siempre se hacen esfuerzos para resolver estos retrasos. ', 'Estamos tratando de seguir nuestras cuentas por cobrar, pero los pagos a menudo se retrasan y no siempre resolvemos estos retrasos de manera eficiente', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(503, 126, 'Maduro', 'Existe una estrategia definida para la rotación de cuentas por cobrar, pero la implementación puede ser inconsistente. Se hacen esfuerzos para seguir los pagos y resolver los retrasos, pero estos esfuerzos pueden no ser siempre efectivos.', 'Tenemos un plan para seguir nuestras cuentas por cobrar, pero a veces tenemos problemas para implementarlo de manera efectiva', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(504, 126, 'Avanzado', 'Se tiene una comprensión completa de la rotación de cuentas por cobrar y se gestiona eficazmente a través de una estrategia bien definida y ejecutada de manera consistente. Se sigue de cerca los pagos y se resuelven rápidamente los retrasos, lo que ayuda a mantener un flujo de efectivo saludable. ', 'Tenemos un sólido plan para seguir nuestras cuentas por cobrar y lo implementamos consistentemente. Esto nos permite resolver rápidamente los pagos retrasados y mantener un flujo de efectivo saludable.\"\" ', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(505, 127, 'Nulo', 'No hay ningún sistema o proceso para gestionar las cuentas por pagar. Los pagos pueden ser inconsistentes, tardíos, o a veces se olvidan por completo, lo que puede resultar en relaciones tensas con los proveedores y posibles problemas legales. ', 'Realmente no tenemos un sistema para manejar nuestras cuentas por pagar, y a veces nos olvidamos de los pagos o pagamos tarde', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(506, 127, 'Basico', 'Hay un sistema básico para gestionar las cuentas por pagar, pero puede ser ineficiente o inconsistente. Los pagos pueden ser a menudo tardíos o incorrectos, y la empresa puede luchar para mantener un buen flujo de caja. ', 'Tenemos un sistema para manejar nuestras cuentas por pagar, pero a veces es un poco ineficiente y nos encontramos pagando tarde o luchando con el flujo de caja', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(507, 127, 'Maduro', 'Existe un sistema eficiente para manejar las cuentas por pagar, pero puede haber problemas ocasionales con pagos tardíos o incorrectos. La empresa hace un esfuerzo para mantener un buen flujo de caja y pagar a los proveedores a tiempo. ', 'Nuestro sistema para manejar las cuentas por pagar generalmente funciona bien, pero a veces tenemos problemas con pagos tardíos o incorrectos', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(508, 127, 'Avanzado', 'Hay un sistema robusto y eficiente para manejar las cuentas por pagar. La empresa paga consistentemente a sus proveedores a tiempo y mantiene un buen flujo de caja. Los problemas son raros y se resuelven rápidamente cuando ocurren.  ', 'Tenemos un sistema sólido y eficiente para manejar nuestras cuentas por pagar. Generalmente pagamos a nuestros proveedores a tiempo y mantenemos un buen flujo de caja¡Claro! Ahora, vamos a definir los niveles para el elemento \"Rotación de Cuentas por Pagar', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(509, 128, 'Nulo', 'No se lleva un control del flujo de efectivo. Las entradas y salidas de dinero no se registran de manera sistemática, lo que puede llevar a dificultades financieras inesperadas o a la insolvencia. ', 'No llevamos un registro de nuestro flujo de efectivo, lo que a veces nos lleva a tener problemas financieros inesperados', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(510, 128, 'Basico', 'Hay un seguimiento básico del flujo de efectivo, pero puede ser inexacto o inconsistente. La empresa puede tener dificultades para prever sus necesidades de efectivo o puede enfrentar problemas de liquidez. ', 'Llevamos un registro básico de nuestro flujo de efectivo, pero a veces nos encontramos con problemas de liquidez o dificultades para prever nuestras necesidades de efectivo', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(511, 128, 'Maduro', 'Existe un seguimiento eficiente del flujo de efectivo, pero puede haber problemas ocasionales con la precisión o la previsibilidad. La empresa generalmente es capaz de prever sus necesidades de efectivo y mantener la liquidez. ', 'Generalmente somos buenos en el seguimiento de nuestro flujo de efectivo, pero a veces tenemos problemas con la precisión o la previsibilidad', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(512, 128, 'Avanzado', 'Hay un seguimiento preciso y consistente del flujo de efectivo. La empresa tiene una buena comprensión de sus necesidades de efectivo futuras y puede prever y manejar eficazmente las fluctuaciones en su flujo de efectivo', 'Llevamos un seguimiento preciso y consistente de nuestro flujo de efectivo y somos buenos en la previsión de nuestras necesidades de efectivo futuras', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(513, 129, 'Nulo', 'No existe un reconocimiento o medición de los costos de no calidad. Las pérdidas no se rastrean sistemáticamente. ', 'No sabemos cuánto nos cuestan nuestros errores y pérdidas, no hay seguimiento.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(514, 129, 'Basico', 'Hay conciencia de los costos de no calidad, y se realizan intentos esporádicos para rastrearlos, pero sin un enfoque estructurado. ', 'Tenemos algunas estimaciones de los costos de no calidad, pero no son precisas ni se utilizan para hacer mejoras.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(515, 129, 'Maduro', 'Los costos de no calidad se miden y analizan de manera sistemática con procedimientos establecidos y se utilizan para la mejora continua. ', 'Contamos con un sistema efectivo para medir y reducir nuestros costos de no calidad y lo usamos como herramienta de gestión.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(516, 129, 'Avanzado', 'El sistema de medición de los costos de no calidad es líder en la industria, con análisis profundos y acciones preventivas que minimizan las pérdidas. ', 'Tenemos un enfoque de clase mundial para gestionar y optimizar los costos de no calidad, estableciendo estándares para la industria.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(517, 130, 'Nulo', 'La empresa no ha registrado su marca. ', 'Es como si estuviéramos dejando que cualquiera se apropie de nuestra marca.	', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(518, 130, 'Basico', 'La empresa ha registrado su marca de manera básica, pero puede faltar registro en algunos territorios clave. ', 'Es como si estuviéramos protegiendo nuestra marca solo en nuestro vecindario.	', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(519, 130, 'Maduro', 'La empresa ha registrado su marca en la mayoría de los territorios clave, pero podría haber algunos huecos. ', 'Es como si estuviéramos protegiendo nuestra marca en la mayoría de los lugares, pero podríamos ir más lejos.	', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(520, 130, 'Avanzado', 'La empresa ha registrado su marca de manera completa en todos los territorios relevantes. ', 'Es como si estuviéramos protegiendo nuestra marca como un tigre protege a sus cachorros, en todos los lugares que importan.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(521, 131, 'Nulo', 'No dispone de asesoría legal. ', 'Es como si estuviéramos tratando de navegar en un mar legal sin un capitán.', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(522, 131, 'Basico', 'Dispone de asesoría legal ocasional o limitada, insuficiente para todas sus necesidades.', 'Es como si tuviéramos un capitán legal a tiempo parcial para ayudarnos a navegar.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(523, 131, 'Maduro', 'Accede a asesoría legal regularmente, pero algunas áreas podrían beneficiarse de una asesoría más frecuente o especializada.', 'Es como si tuviéramos un buen capitán legal, pero a veces necesitamos un poco más de ayuda.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(524, 131, 'Avanzado', 'Goza de una asesoría legal integral, constante y adaptada a todas sus necesidades.', 'Es como si tuviéramos un capitán legal de tiempo completo que siempre está listo para ayudarnos a navegar por las aguas legales.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(525, 132, 'Nulo', 'La asesoría legal que recibe es de baja calidad o poco confiable.', 'Es como si estuviéramos recibiendo consejos legales de un libro de derecho antiguo.', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(526, 132, 'Basico', 'La asesoría legal que recibe es suficiente para las necesidades más básicas, pero carece de profundidad y detalle.', 'Es como si estuviéramos recibiendo consejos legales básicos, pero a veces necesitamos más detalle.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(527, 132, 'Maduro', 'La asesoría legal que recibe es de buena calidad y generalmente confiable, pero hay margen para una mayor especialización o detalle.', 'Es como si estuviéramos recibiendo buenos consejos legales, pero a veces necesitamos más detalle.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(528, 132, 'Avanzado', 'La asesoría legal que recibe es de la más alta calidad: detallada, especializada y completamente confiable.', 'Es como si estuviéramos recibiendo excelentes consejos legales que cubren todos los detalles.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(529, 133, 'Nulo', 'No hay una práctica de implementar las recomendaciones de la asesoría legal.', 'Es como si estuviéramos recibiendo consejos legales pero nunca los pusiéramos en práctica.', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(530, 133, 'Basico', 'Algunas recomendaciones de la asesoría legal se implementan, pero otras se ignoran o se olvidan.', 'Es como si estuviéramos poniendo en práctica algunos de los consejos legales, pero no todos.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(531, 133, 'Maduro', 'La mayoría de las recomendaciones de la asesoría legal se implementan, pero la implementación podría ser más consistente.', 'Es como si estuviéramos poniendo en práctica la mayoría de los consejos legales, pero podríamos hacerlo mejor.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(532, 133, 'Avanzado', 'La empresa sigue e implementa todas las recomendaciones de la asesoría legal, asegurando el cumplimiento en todas sus operaciones.', 'Es como si estuviéramos poniendo en práctica todos los consejos legales para asegurarnos de estar siempre en el lado correcto de la ley.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(533, 134, 'Nulo', 'No hay un proceso formal para redactar contratos.', 'Es como si estuviéramos escribiendo contratos en una servilleta de papel.', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(534, 134, 'Basico', 'Los contratos son redactados de manera básica, pero pueden carecer de algunos términos y condiciones necesarios.', 'Es como si estuviéramos escribiendo contratos decentes, pero podríamos estar olvidando algunos detalles.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(535, 134, 'Maduro', 'La redacción de contratos es generalmente completa, pero podría mejorarse para incluir más detalles o cláusulas específicas.', 'Es como si estuviéramos escribiendo buenos contratos, pero podríamos incluir más detalles o cláusulas.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(536, 134, 'Avanzado', 'Los contratos son redactados de manera exhaustiva y detallada, incluyendo todos los términos y condiciones necesarios.', 'Es como si estuviéramos escribiendo contratos a prueba de balas, con todos los términos y condiciones cubiertos.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(537, 135, 'Nulo', 'No hay un proceso formal para revisar contratos.', 'Es como si estuviéramos revisando contratos con los ojos medio cerrados.', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(538, 135, 'Basico', 'Los contratos son revisados de manera básica, pero se pueden pasar por alto detalles importantes.', 'Es como si estuviéramos revisando contratos decentemente, pero podríamos estar pasando por alto algunos detalles.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(539, 135, 'Maduro', 'La revisión de contratos es generalmente completa, pero podría mejorarse para detectar más detalles o posibles problemas.', 'Es como si estuviéramos haciendo una buena revisión de los contratos, pero podríamos ser más detallados.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(540, 135, 'Avanzado', 'Los contratos son revisados de manera exhaustiva y detallada, asegurando que no se pasen por alto detalles o posibles problemas.', 'Es como si estuviéramos revisando contratos con una lupa, asegurándonos de que no se nos pasa nada por alto.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(541, 136, 'Nulo', 'No hay una revisión sistemática del cumplimiento de los contratos.', 'Es como si estuviéramos confiando en la suerte para asegurar el cumplimiento de los contratos.', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(542, 136, 'Basico', 'Se revisa el cumplimiento de los contratos de forma irregular o solo en casos problemáticos.', 'Es como si estuviéramos comprobando el cumplimiento de los contratos solo cuando surgen problemas.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(543, 136, 'Maduro', 'Se revisa regularmente el cumplimiento de los contratos, pero hay margen para mejorar la consistencia o la exhaustividad de las revisiones.', 'Es como si estuviéramos revisando el cumplimiento de los contratos regularmente, pero podríamos ser más sistemáticos.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(544, 136, 'Avanzado', 'Se realiza una revisión sistemática y completa del cumplimiento de los contratos, asegurando que todos los términos y condiciones se respetan.', 'Es como si estuviéramos revisando el cumplimiento de los contratos con una precisión de relojero, asegurándonos de que todo va según lo acordado.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(545, 137, 'Nulo', 'No tenemos objetivos claros. Solamente trabajamos duro.', 'Trabajamos sin brújula ni mapa', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(546, 137, 'Basico', 'Tenemos algunas metas generales, pero no son medibles.', 'Trazamos metas moldeadas en sueños, no en números.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(547, 137, 'Maduro', 'Tenemos objetivos medibles, pero realmente no revisamos su cumplimiento.', 'Pintamos el punto de llegada pero sin seguirle la pista.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(548, 137, 'Avanzado', 'Tenemos objetivos medibles y revisamos su cumplimiento. Ejemplo: Queremos reducir tiempos muertos en un 10% para fin de año y lo medimos mensualmente.', 'Vamos tras los objetivos midiendo cada paso del camino.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(549, 138, 'Nulo', 'No involucramos a nadie en la definición de objetivos.Se establecen las metas de producción sin consultar las necesidades del supervisor o trabajadores.', 'Los objetivos son como órdenes militares.', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(550, 138, 'Basico', 'Involucramos a pocos en la definición de objetivos.', 'Definimos metas entre cuates, sin abrir el círculo.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(551, 138, 'Maduro', 'Comunicamos los objetivos a todo el equipo, pero no los involucramos activamente en la definición de los mismos.', 'Soltamos el plan al equipo, pero sin pedirles su opinión.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(552, 138, 'Avanzado', 'Involucramos a todo el equipo en la definición y comunicación de objetivos.', 'Las metas las construimos hombro con hombro, sumando ideas.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(553, 139, 'Nulo', 'No tenemos nuestros estándares documentados.', 'Las reglas nomás están en nuestra cabeza, no en papel o en algún sistema', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(554, 139, 'Basico', 'Algunos estándares están documentados de manera básica.', 'Documentamos lo básico nomás, los detalles lo dejamos a la suerte', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(555, 139, 'Maduro', 'La mayoría de estándares están documentados pero de manera informal.', 'Es nomás para la auditoria', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(556, 139, 'Avanzado', 'Todos nuestros estándares operativos están documentados y actualizados formalmente a través de  un sisema práctico.', 'Los estándares se conocen, se valoran y son el plan de juego de cada equipo', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(557, 140, 'Nulo', 'No tenemos estándares definidos para ninguno de nuestros procesos.', 'No hay formato que cumplir, cada proceso se hace diferente.', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(558, 140, 'Basico', 'Tenemos algunos estándares básicos en operación pero no incluyen todas las especificaciones necesarias.', 'Muy seguido el producto o servicio no sale como esperamos.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(559, 140, 'Maduro', 'En operaciones Nuestros estándares cubren la mayoría de especificaciones necesarias, pero no siempre se siguen, sin embargo en las demás areas no hay estándares claros.', 'Las pautas dan buena guía, aunque de repente le hacemos como queremos.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(560, 140, 'Avanzado', 'Tenemos estándares  completos en todas las áreas los cuales actualizamos para la mayoría de nuestros procesos clave, y se siguen consistentemente de acuerdo a un ciclo de operación.', 'Las pautas las llevamos como en misa, todo en orden y completas.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(561, 141, 'Nulo', 'Los colaboradores no conocen bien los procesos clave y solo pueden realizar su tarea asignada.', 'Se conoce el proceso por la experiencia', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(562, 141, 'Basico', 'Algunos conocen los pasos básicos de los procesos.', 'Ojala nunca se enferme Juan por que es el único que le mueve a eso', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(563, 141, 'Maduro', 'La mayoría conoce los pasos de los procesos aunque de manera informal. ', 'Pues si le sabemos a todo, no', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(564, 141, 'Avanzado', 'Todos los colaboradores conocen, comprenden y están certificados en los detalles de los procesos clave. ', 'Sabemos como hacer las cosas pero también por qué y cuándo hacerlo', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(565, 142, 'Nulo', 'Revisamos los estándares cuando nos acordamos.', 'o sea casi nunca', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(566, 142, 'Basico', 'Revisamos los estándares de forma esporádica, principalmente cuando tenemos alguna auditoria o revisión, ', 'Los revisamos para disimular que sí los seguimos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(567, 142, 'Maduro', 'Revisamos la operación y hacemos observaciones al personal de lo que no esta siguiendo el proceso esperado.  ', 'Le echamos un ojo a lo que están haciendo e indicamos a nuestros queridos colaboradores dónde mejorar', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(568, 142, 'Avanzado', 'Revisamos los estándares de forma estructurada con los responsables de la ejecución y le damos recursos y  seguimiento a las acciones. ', 'Chulada de sistema, decimos lo que hacemos y hacemos lo que decimos', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(569, 143, 'Nulo', 'Realizamos reuniones informales ocasionalmente. ', 'Nos reunimos cuando el cliente se queja o hay algún cambio de plan', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(570, 143, 'Basico', 'Nos juntamos para ver qué podemos hacer , pero no tenemos un plan claro ni un orden para discutir las cosas, en ocasiones no hay agenda y tampoco de una minuta', 'Nos juntamos para ver qué hay que hacer, pero a veces nos perdemos en temas irrelevantes', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(571, 143, 'Maduro', 'Realizamos  reuniones  periódicas para fijar tareas, sin embargo  nos llevan  al   fenómeno de juntitis recurrentes en las cuales asignamos tareas reactivas', 'Sufrimos de juntitis y vamos a las juntas a pasar lista', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(572, 143, 'Avanzado', 'Realizamos reuniones periódicas estructuradas con alta participación y seguimiento de tareas que nos permiten ser eficientes y enfocarnos en el trabajo para alcanzar la meta del dia, semana o mes.', 'Muchas cabezas piensan mejor que una', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(573, 144, 'Nulo', 'No hay revisiones de resultados periódicas establecidas o son completamente ad hoc y desorganizadas.', 'No tenemos un método consistente para revisar y discutir los resultados de nuestro trabajo.', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(574, 144, 'Basico', 'Se llevan a cabo revisiones periódicas de resultados, pero carecen de estructura y no siempre conducen a acciones concretas.', 'Realizamos revisiones de resultados con cierta regularidad, pero sin una estructura clara o seguimiento efectivo.', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(575, 144, 'Maduro', 'Las revisiones de resultados son sistemáticas y siguen un proceso definido; se utilizan para tomar decisiones y acciones correctivas.', 'Nuestras revisiones periódicas son parte de un proceso formal que nos ayuda a identificar y abordar áreas de mejora.', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(576, 144, 'Avanzado', 'Las revisiones de resultados están integradas en la gestión de la organización, son altamente analíticas y orientadas a la mejora continua y la excelencia operacional.', 'Utilizamos herramientas avanzadas para analizar tendencias y resultados, y las revisiones son cruciales para nuestra estrategia y mejora continua.', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(577, 145, 'Nulo', 'Cuando hay un problema solucionamos el problema por que no conocemos metodologías de análisis de causa raíz.', 'Análisis de causa raíz suena a rollo complicado, nosotros nomás resolvemos el problema rápido y ya', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(578, 145, 'Basico', 'Conocemos algo de Análisis de causa raíz pero solo lo aplicamos de forma esporádica. ', 'Lo usamos ya cuando vemos muy intensos al jefe o al cliente', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(579, 145, 'Maduro', 'Aplicamos análisis de causa raíz en la mayoría de problemas pero nos falla el control, el problema se repite con el tiempo.', 'Casi siempre le encontramos al verdadero origen y mejoramos la situación, el detallito es que se nos va el avión y se vuelve a repetir el problemilla', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(580, 145, 'Avanzado', 'No solo usamos el análisis de causa raíz eficientemente, sino que las mejoras quedan documentadas en los procesos, con guias visuales para mantenerlas en el tiempo, después solo vigilamos en el Gemba para que se mantengan.', 'Como dicen en mi pueblo, somos la chucha cuerera de todo el análisis de causa raíz', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(581, 146, 'Nulo', 'No tenemos un sistema de gestión estructurado y respondemos a los problemas de manera reactiva. ', 'Corremos de un lado a otro apagando fuegos en lugar de planificar e implementar un sistema antifuego', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(582, 146, 'Basico', 'Tenemos algunos elementos de un sistema de gestión, pero sin coordinación. Nos falta monitoreo y mejora continua.', 'No hay una integración de procesos en las áreas y cada quien trabaja por su lado', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(583, 146, 'Maduro', 'Nuestro sistema de gestión incluye objetivos, estándares, procesos documentados y capacitación limitada. Aún así, nuestro enfoque sigue siendo reactivo en lugar de preventivo.', 'Hacemos algunas cosas bien pero seguimos limpiando desastres en lugar de evitarlos, el día a día nos gana', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(584, 146, 'Avanzado', 'Tenemos un sistema estructurado que nos permite planificar objetivos, conocer nuestros procesos críticos, establecer estándares y monitorear resultados. Contamos con herramientas y capacitación que nos permiten mejoras proactivas y continuas.', 'Contamos con un sistema de gestión aplicable a toda la organización basado en la mejora continua y excelencia operacional', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(585, 147, 'Nulo', 'No se cuenta con un propósito y principios de actuación en la organización ', 'solo trabajamos para que no nos despidan', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(586, 147, 'Basico', 'Se cuenta con un propósito y principios de actuación definidos, pero no han sido desplegados en la organización ', 'Sabemos que existen pero son una leyenda urbana', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(587, 147, 'Maduro', 'El propósito y valores es la guia que nos acciona nuestras tareas, sin embargo aún no se alinean las acciones diarias a estos elementos ', 'Se reconocen y se viven sin embargo aún no los integramos al dia a dia', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(588, 147, 'Avanzado', 'Estos elementos nos ayudan  en todo momento a buscar oportunidades y mejoras en nuestros procesos, cada vez que hacemos algo estos elementos nos inspiran y nos ayudan a decidir si estamos haciendo lo correcto ', 'Son como el aire en un ser humano, no podríamos vivir sin ellos', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(589, 148, 'Nulo', 'No hay consistencia en la presentación de la marca.', 'Estamos como un cantante que cambia de género musical en cada concierto, no mantenemos la consistencia de nuestra marca', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(590, 148, 'Basico', 'Hay un cierto nivel de consistencia en la presentación de la marca, pero aún hay áreas de divergencia.', 'Somos como un cantante que toca rock en un concierto y reguetón en otro, mantenemos la consistencia de nuestra marca en algunos canales, pero no en todos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(591, 148, 'Maduro', 'Hay una alta consistencia en la presentación de la marca en la mayoría de los canales y puntos de contacto con el cliente.', 'Somos como un cantante que siempre toca rock, pero a veces se le olvida la letra de las canciones, mantenemos la consistencia de nuestra marca en todos los canales, pero a veces no seguimos las guías de la marca', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(592, 148, 'Avanzado', 'La marca se presenta de manera completamente consistente en todos los canales y puntos de contacto con el cliente, creando una experiencia de marca coherente.', 'Somos como un cantante que siempre toca rock, se sabe todas las letras de sus canciones y hasta las adapta para mantener a su público interesado y emocionado', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(593, 149, 'Nulo', 'No se ha medido la percepción de la marca.', 'Estamos como un actor que no lee las críticas de sus películas, no sabemos cómo nos percibe nuestro público objetivo', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(594, 149, 'Basico', 'Se ha medido la percepción de la marca, pero los resultados no se utilizan para informar las decisiones de la marca.', 'Somos como un actor que lee las críticas de sus películas, pero no las toma en cuenta para mejorar su actuación', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(595, 149, 'Maduro', 'Se mide regularmente la percepción de la marca y los resultados informan algunas decisiones de la marca.', 'Somos como un actor que lee las críticas de sus películas y las toma en cuenta para algunas de sus decisiones, pero no todas', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(596, 149, 'Avanzado', 'Se mide regularmente la percepción de la marca y los resultados informan todas las decisiones de la marca, ayudando a la marca a adaptarse y evolucionar.', 'Somos como un actor que lee las críticas de sus películas, las toma en cuenta para todas sus decisiones y siempre busca maneras de mejorar y sorprender a su público', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(597, 150, 'Nulo', 'No se ha definido el posicionamiento de la marca.', 'Estamos como el artista desconocido de un festival, nadie nos reconoce', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(598, 150, 'Basico', 'Se ha definido el posicionamiento de la marca, pero no es distintivo ni relevante para el público objetivo.', 'Somos como el artista emergente de un festival, algunos nos reconocen pero aún no somos muy conocidos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(599, 150, 'Maduro', 'Se ha definido el posicionamiento de la marca, es distintivo y relevante para el público objetivo, pero no se revisa ni se ajusta regularmente.', 'Somos como el artista popular de un festival, muchos nos reconocen pero aún no somos la estrella principal', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(600, 150, 'Avanzado', 'El posicionamiento de la marca está bien definido, es distintivo y relevante para el público objetivo, y se revisa y ajusta regularmente en base a los cambios en el mercado.', 'Somos como la estrella principal de un festival, todos nos conocen y esperan ver qué haremos a continuación', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(601, 151, 'Nulo', 'No se realiza un análisis de los costos de producción, por lo que la fijación de precios carece de fundamento.', 'Estamos como el chef que hace una receta sin saber cuánto cuestan los ingredientes, no hacemos un análisis de costos', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(602, 151, 'Basico', 'Se realiza un análisis parcial de los costos de producción, pero no se consideran todos los costos relevantes.', 'Somos como el chef que hace una receta sabiendo cuánto cuestan algunos ingredientes, pero no todos', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(603, 151, 'Maduro', 'Se realiza un análisis completo de los costos de producción, pero no siempre se aplica de manera adecuada en la fijación de precios.', 'Somos como el chef que sabe cuánto cuestan todos los ingredientes, pero no siempre los suma correctamente', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(604, 151, 'Avanzado', 'Se realiza un análisis completo y preciso de los costos de producción y se aplica consistentemente en la fijación de precios.', 'Somos como el chef que sabe cuánto cuestan todos los ingredientes y siempre los suma correctamente, incluso ajustando los precios según la temporada', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(605, 152, 'Nulo', 'No se evalúa la competencia para la fijación de precios, lo que puede resultar en precios no competitivos.', 'Estamos como el corredor que participa en una carrera sin mirar a sus competidores, no evaluamos a la competencia', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(606, 152, 'Basico', 'Se realiza una evaluación parcial de la competencia, pero no se ajustan los precios de manera efectiva.', 'Somos como el corredor que mira a sus competidores, pero no ajusta su estrategia basándose en lo que ve', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(607, 152, 'Maduro', 'Se realiza una evaluación completa de la competencia y se ajustan los precios, pero solo en respuesta a los cambios de la competencia.', 'Somos como el corredor que mira a sus competidores y ajusta su estrategia, pero sólo durante la carrera', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(608, 152, 'Avanzado', 'Se realiza una evaluación proactiva y completa de la competencia y se ajustan los precios de manera estratégica.', 'Somos como el corredor que estudia a sus competidores antes de la carrera, ajusta su estrategia de acuerdo a lo que ve y siempre está listo para adaptarse en la carrera', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(609, 153, 'Nulo', 'El valor para el cliente no se considera al fijar los precios, lo que puede resultar en una mala percepción.', 'Estamos como el vendedor que pone el precio que se le antoja, sin considerar el valor que el producto tiene para el cliente', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(610, 153, 'Basico', 'A veces se considera el valor para el cliente al fijar los precios, pero no de manera consistente.', 'Somos como el vendedor que a veces considera el valor para el cliente al poner el precio', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(611, 153, 'Maduro', 'Se considera regularmente el valor para el cliente al fijar los precios, pero no siempre se maximiza este valor.', 'Somos como el vendedor que usualmente considera el valor para el cliente al poner el precio, pero a veces se le olvida', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(612, 153, 'Avanzado', 'Siempre se considera el valor para el cliente al fijar los precios y se buscan formas de aumentar este valor de manera continua.', 'Somos como el vendedor que siempre considera el valor para el cliente al poner el precio, y está constantemente buscando maneras de aumentar ese valor', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(613, 154, 'Nulo', 'No se ha creado una identidad de marca. ', 'Estamos como el chico que llega a la fiesta y nadie lo reconoce porque no tiene una identidad definida', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(614, 154, 'Basico', 'Se ha creado una identidad de marca básica (nombre, logotipo y colores). ', 'Somos como el chico que llega a la fiesta con una identidad, pero es tan genérica que nadie lo recuerda', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(615, 154, 'Maduro', 'Se ha creado una identidad de marca completa que incluye atributos intangibles (voz de marca, personalidad de marca, etc.)', 'Somos como el chico que llega a la fiesta con un estilo único y memorable, pero que nunca cambia su ropa y con el tiempo se vuelve menos interesante', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(616, 154, 'Avanzado', 'La identidad de marca está completamente desarrollada, es coherente en todos los puntos de contacto con el cliente y se actualiza regularmente en función de los comentarios y las tendencias del mercado.', 'Somos como el chico que llega a la fiesta con un estilo único y memorable, y siempre tiene algo nuevo que lo mantiene interesante y relevante', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL),
(617, 155, 'Nulo', 'No se han definido los valores de la marca.', 'Estamos como un barco sin brújula, no tenemos definidos nuestros valores', '2024-09-24 18:45:43', '2024-09-24 18:28:58', NULL),
(618, 155, 'Basico', 'Se han definido los valores de la marca, pero no se reflejan consistentemente. ', 'Estamos como un barco sin brújula, no tenemos definidos nuestros valores', '2024-09-24 18:46:26', '2024-09-24 18:46:26', NULL),
(619, 155, 'Maduro', 'Se han definido los valores de marca y se reflejan consistentemente en las comunicaciones y comportamientos de la marca.', 'Somos como un barco con brújula que la usamos para navegar, pero no le contamos a nadie hacia dónde vamos, por eso nuestros valores no se comunican de manera efectiva a nuestro público objetivo', '2024-09-24 18:46:48', '2024-09-24 18:46:48', NULL),
(620, 155, 'Avanzado', 'Los valores de la marca están bien definidos, se reflejan en todas las actividades de la marca, y los empleados y clientes entienden y se alinean con estos valores. ', 'Somos como un barco con brújula que la usamos para navegar y siempre le contamos a todo el mundo hacia dónde vamos, y ajustamos nuestro rumbo en función de los cambios del mar y el viento', '2024-09-24 18:47:12', '2024-09-24 18:47:12', NULL);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personalizar`
--

CREATE TABLE `personalizar` (
  `id` int(11) NOT NULL,
  `proposito` text DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `banner` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `slogan` varchar(200) DEFAULT NULL,
  `actuacion` text DEFAULT NULL,
  `portada` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personalizar`
--

INSERT INTO `personalizar` (`id`, `proposito`, `logo`, `banner`, `created_at`, `updated_at`, `deleted_at`, `slogan`, `actuacion`, `portada`) VALUES
(1, 'Desarrollamos bienestar físico y mental de toda la familia a través de suplementos alimenticios responsables, que son creados gracias a la colaboración de socios visionarios y especialistas en todas nuestras áreas.', 'logos/TvYwUeHzWLCY2rIYqcpqcpuZdjhpGT2tvX54bYXu.png', 'banners/7X297QPWgJGnXKdFLNK3VKpvlJs9LKdWvCsHqloF.jpg', '2024-07-03 11:44:47', '2024-10-01 04:36:11', NULL, 'En AION: \"HACEMOS QUE LAS COSAS SUCEDAN\"', 'INTEGRIDAD-RESPONSABILIDAD-RESPETO-SENTIDO DE URGENCIA-EXCELENCIA-BIEN COMÚN-COMUNICACIÓN-TRABAJO EN EQUIPO-ORIENTACIÓN AL CLIENTE', 'portada/M50XZZFsDdhe7HAJwNvf5VYoT3lE2sBMlAeAx0Cd.png');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `procedimientos`
--

CREATE TABLE `procedimientos` (
  `id` int(11) NOT NULL,
  `proceso_id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `link_externo` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `link_herramienta` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `procesos`
--

CREATE TABLE `procesos` (
  `id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `departamento_id` int(11) NOT NULL,
  `nombre` varchar(200) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `link_externo` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `link_herramienta` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `registros_kpi`
--

CREATE TABLE `registros_kpi` (
  `id` int(11) NOT NULL,
  `kpi_id` int(11) NOT NULL,
  `actual` float NOT NULL,
  `promedio` float DEFAULT NULL,
  `created_for` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reportes`
--

CREATE TABLE `reportes` (
  `id` int(11) NOT NULL,
  `departamento_id` int(11) NOT NULL,
  `semana_id` int(11) NOT NULL,
  `aviso` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_for` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reporteSemanal`
--

CREATE TABLE `reporteSemanal` (
  `id` int(11) NOT NULL,
  `numeroSemana` int(11) DEFAULT NULL,
  `inicio` date DEFAULT NULL,
  `fin` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `respuestas`
--

CREATE TABLE `respuestas` (
  `id` int(11) NOT NULL,
  `assessment_id` int(11) NOT NULL,
  `seccion_id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `challenge_id` int(11) NOT NULL,
  `opcion_id` int(11) NOT NULL,
  `valor_opcion` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `guard_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'web', '2024-07-10 22:29:06', '2024-07-10 22:29:06'),
(2, 'user', 'web', '2024-07-23 03:02:03', '2024-07-23 03:02:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_has_permissions`
--

CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `secciones`
--

CREATE TABLE `secciones` (
  `id` int(11) NOT NULL,
  `area_id` int(11) NOT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `titulo` varchar(200) DEFAULT NULL,
  `created_by` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `secciones`
--

INSERT INTO `secciones` (`id`, `area_id`, `departamento_id`, `titulo`, `created_by`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'Reclutamiento y selección', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(2, 1, NULL, 'Com&Ben', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(3, 1, NULL, 'Desarrollo y Aprendizaje', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(4, 1, NULL, 'Empoderamiento', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(5, 1, NULL, 'Cultura', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(6, 1, NULL, 'Liderazgo', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(7, 1, NULL, 'Gestión de Regulaciones', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(8, 2, NULL, 'Gestión de infraestructura de IT', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(9, 2, NULL, 'Aplicaciones', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(10, 2, NULL, 'Administración de bases de datos', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(11, 2, NULL, 'Seguridad en la información', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(12, 3, NULL, 'Estratégia de Marketing', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(13, 3, NULL, 'Gestión de venta', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(14, 3, NULL, 'Propuestas y cotizaciones', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(15, 3, NULL, 'Venta', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(16, 3, NULL, 'Servicio al cliente', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(17, 4, NULL, 'Desarrollo de nuevos productos / servicios', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(18, 4, NULL, 'Planeación de la producción', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(19, 4, NULL, 'Planificación de la demanda', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(20, 4, NULL, 'Evaluación de proveedores', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(21, 4, NULL, 'Gestión de compras operativas', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(22, 4, NULL, 'Gestión de inventario', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(23, 4, NULL, 'Almacenamiento', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(24, 4, NULL, 'Procesos de ejecución', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(25, 4, NULL, 'Calidad', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(26, 4, NULL, 'Seguridad en la operación', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(28, 4, NULL, 'Gestión de activos fijos', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(29, 5, NULL, 'Cumplimiento normativo', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(30, 5, NULL, 'Administración', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(31, 5, NULL, 'Gestión de activos fijos', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(32, 5, NULL, 'Capital de trabajo', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(33, 5, NULL, 'Asesoria Legal', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(34, 5, NULL, 'Gestión de contratos', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(35, 5, NULL, 'Sistemas de planeación', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(36, 5, NULL, 'Procesos de ejecución', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(37, 5, NULL, 'Sistemas de Verificación', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(38, 5, NULL, 'Mejora Continua', 1, '2024-09-24 15:22:31', '2024-09-24 15:29:06'),
(39, 3, NULL, 'Gestión de marca', 1, '2024-09-27 06:43:57', '2024-09-27 06:43:57');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('4CU2prenA6n8Zn7LTgnuL81uTfcNjsxvCOFzfgN1', NULL, '64.15.129.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiOEhzUFVWOEJkWUdCOGZPR1lJckZXdEo5UjVIVUpobm9DV0JmZ0NZSyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyOToiaHR0cDovL3Rlc3QuYWlvbi1idXNpbmVzcy5jb20iO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czoyOToiaHR0cDovL3Rlc3QuYWlvbi1idXNpbmVzcy5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1727727011),
('5RSg5Tcoou45wLQTYuaX79rfy3tGOmGYRv5UGeeD', NULL, '192.175.111.254', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaHJCVVBGVjcxWnlmZnUwWE1JTlVyUmYzeDFkeVc5b3BWQlJWbElzVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly90ZXN0LmFpb24tYnVzaW5lc3MuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1727727012),
('7DTkCY8NKQbbu2BeUTeyssC32NKPxy43NkPcDIvG', NULL, '64.15.129.125', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicXZkaDB4clFyZUFMOVFTZVBKeXBScHc1R1ZLc0JyWVVkZjBXZlNqYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly90ZXN0LmFpb24tYnVzaW5lc3MuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1727727011),
('8pKUL2coOw6YlxVIsyGciUiXWM9VN1qn50F6eawL', NULL, '192.175.111.254', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiY0VGeExoT0h0RXBNbjBJQU1BOE1Pd0dVbnFkY3J0dURiWnRtRU1oNyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyOToiaHR0cDovL3Rlc3QuYWlvbi1idXNpbmVzcy5jb20iO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czoyOToiaHR0cDovL3Rlc3QuYWlvbi1idXNpbmVzcy5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1727727012),
('e95BoxmSD1QuzxCs5X1elalao2ZizXC3zx42h3bR', NULL, '88.99.26.177', 'Mozilla/5.0 (Linux; Android 14) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.5993.80 Mobile Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiangwWDU4aDI2S29XcG9UaUE3a05xN0lHTkJlSmxTdEFsaThwZjY3MyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyOToiaHR0cDovL3Rlc3QuYWlvbi1idXNpbmVzcy5jb20iO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNToiaHR0cDovL3Rlc3QuYWlvbi1idXNpbmVzcy5jb20vbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1727726702),
('lA3csdhePtXjsulIIUzIkHn7LwBe7OBR87NtWn6j', NULL, '34.248.137.227', 'Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101 Firefox/83.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiY0c1NlE3cmtTWjNqYXZUNjFnQXhjRFRLSkhTOHhnM055UWJYVE00RyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMDoiaHR0cHM6Ly90ZXN0LmFpb24tYnVzaW5lc3MuY29tIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHBzOi8vdGVzdC5haW9uLWJ1c2luZXNzLmNvbS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1727729568),
('mFkZll69r3dpaMk0ehuSSdPZa6tFQaLzgs2QyXdC', NULL, '34.248.137.227', 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiQ29rREVsbDdlOGJCdURaRWZPdmVta3EwVVAzNDRRVEgxYW9XSEpTdyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozMDoiaHR0cHM6Ly90ZXN0LmFpb24tYnVzaW5lc3MuY29tIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHBzOi8vdGVzdC5haW9uLWJ1c2luZXNzLmNvbS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1727729570),
('MXy7i7URHV0xj3s1W9A6ZIND2QrQIADhYN89a2Ub', NULL, '189.203.6.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidXdObVRYUFZGSDllSHloWjFheWZYbkR1MFRVbDFuS05hM1RDc2VtayI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyOToiaHR0cDovL3Rlc3QuYWlvbi1idXNpbmVzcy5jb20iO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNToiaHR0cDovL3Rlc3QuYWlvbi1idXNpbmVzcy5jb20vbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1727731151),
('NzmF6vpuf1RrbVs2jwRz1ZjAz6FHCah8ASrfQ4XC', NULL, '64.15.129.117', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiU0JGTUtEcWZZNEhvQVZYdnZad0F2b2ZoOG9kVDJReVlYaHlIdzFFUSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyOToiaHR0cDovL3Rlc3QuYWlvbi1idXNpbmVzcy5jb20iO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czoyOToiaHR0cDovL3Rlc3QuYWlvbi1idXNpbmVzcy5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1727727014),
('oDgdxYaArrj7avdqWtlHV1UZP5qDhD4EHmqSOqdV', 6, '189.203.6.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiYlhOUEpnV0tCamJxME9HSGpkaXRZZWJaSnBvUmI1TE5qdVpyNGxRUyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjY7czoyMToicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjtzOjYwOiIkMnkkMTIkOE00QVdzcFRFMU5lUzJmUG1reWYwLlhDcHhTTndXUDRuUGprSi5UQVZ6Q3VBNGJrUVVteDIiO3M6MTc6InBhc3N3b3JkX2hhc2hfd2ViIjtzOjYwOiIkMnkkMTIkOE00QVdzcFRFMU5lUzJmUG1reWYwLlhDcHhTTndXUDRuUGprSi5UQVZ6Q3VBNGJrUVVteDIiO3M6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM2OiJodHRwczovL2Ftcy5haW9uLWJ1c2luZXNzLmNvbS9jb25maWciO319', 1727732171),
('pCU6AVWAdS9bXs3FD65LYNxzKDa4iaY4UZhWMhHf', 6, '189.203.6.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoicU5uQUpJUWtXNHlFeGZnTkxoTDBKR3NQWHp3VTRTcnNaRnlSVnVXdCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM4OiJodHRwczovL2Ftcy5haW9uLWJ1c2luZXNzLmNvbS9yZXBvcnRlcyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjY7czoyMToicGFzc3dvcmRfaGFzaF9zYW5jdHVtIjtzOjYwOiIkMnkkMTIkOE00QVdzcFRFMU5lUzJmUG1reWYwLlhDcHhTTndXUDRuUGprSi5UQVZ6Q3VBNGJrUVVteDIiO30=', 1727727414),
('tYdQoDRfuzUEYa8wAu2G4pCIp6NpIE1wd4L3dhiK', NULL, '64.15.129.117', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWnZmdFdidEt5SjBhdWh4eXl4THVhdVNaRExMeE01cTc5ZTd5R3pWNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly90ZXN0LmFpb24tYnVzaW5lc3MuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1727727014),
('V2YOObRiaZruB9wW1lOxOQRFvlQEOv081FiqZXNf', NULL, '192.175.111.235', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQm9pY0R3aFIzVGYydUZtZ2dXdHYxa2dsVVNYa3hsa1ByeHVyTlZNeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly90ZXN0LmFpb24tYnVzaW5lc3MuY29tL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1727727014),
('WNo4vbXGmEGHcioEp553iyBhFbjck5sbtxsZqRJb', NULL, '34.248.137.227', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/33.0.1750.152 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN2I2T0NWcmpFUXVBdWdJd2I0cUlER1FwNjJvU203MThVSGFyeU1kSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzY6Imh0dHBzOi8vdGVzdC5haW9uLWJ1c2luZXNzLmNvbS9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1727729572),
('wuXYL9kV7dhbz8pR9BHBbUzttpLd7BsOEGzqjXqN', NULL, '192.175.111.235', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNVpUSXhaVnBReHRJTjVCVk1jTnFlY2xneVFPSHZsaUtHQ21lbGd1YyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyOToiaHR0cDovL3Rlc3QuYWlvbi1idXNpbmVzcy5jb20iO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czoyOToiaHR0cDovL3Rlc3QuYWlvbi1idXNpbmVzcy5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1727727014),
('Wx6f0O24EUuoNubjWOKMKGqnpg2tTygsbmBWglgX', 6, '189.203.6.198', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoidE9aR0JpVFhWTHhpdXBRcnBabzU2WUpYUzViWWRrbjRlNE9WZzFqTCI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6NjtzOjIxOiJwYXNzd29yZF9oYXNoX3NhbmN0dW0iO3M6NjA6IiQyeSQxMiQ4TTRBV3NwVEUxTmVTMmZQbWt5ZjAuWENweFNOd1dQNG5QamtKLlRBVnpDdUE0YmtRVW14MiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjU6Imh0dHBzOi8vYWlvbi1idXNpbmVzcy5jb20iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJDhNNEFXc3BURTFOZVMyZlBta3lmMC5YQ3B4U053V1A0blBqa0ouVEFWekN1QTRia1FVbXgyIjt9', 1727727390),
('ZvQN4RxCQMEJWUv9WWobfzKpZJyiOWJ7EjtABGYa', 160, '189.203.149.205', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiSFlQRzhrU0RlcUpBa0hxSUV2WlpRUmpGaGlQcXI2OGRPY2padWZnZSI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjM0OiJodHRwczovL2Fpb24tYnVzaW5lc3MuY29tL3JlcG9ydGVzIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTYwO3M6MjE6InBhc3N3b3JkX2hhc2hfc2FuY3R1bSI7czo2MDoiJDJ5JDEyJDhNNEFXc3BURTFOZVMyZlBta3lmMC5YQ3B4U053V1A0blBqa0ouVEFWekN1QTRia1FVbXgyIjtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJDhNNEFXc3BURTFOZVMyZlBta3lmMC5YQ3B4U053V1A0blBqa0ouVEFWekN1QTRia1FVbXgyIjt9', 1727727440);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tareas`
--

CREATE TABLE `tareas` (
  `id` int(11) NOT NULL,
  `area_id` int(11) DEFAULT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `responsable_id` bigint(20) UNSIGNED NOT NULL,
  `minuta_id` int(11) NOT NULL,
  `tarea` varchar(200) NOT NULL,
  `notas` text DEFAULT NULL,
  `fecha` date NOT NULL,
  `estatus_id` int(11) DEFAULT 0,
  `revisor_id` int(11) NOT NULL,
  `validacion` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `nota` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tarea_evidencia`
--

CREATE TABLE `tarea_evidencia` (
  `id` int(11) NOT NULL,
  `tarea_id` int(11) NOT NULL,
  `img_ref` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_for` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tiposDesperdicios`
--

CREATE TABLE `tiposDesperdicios` (
  `id` int(11) NOT NULL,
  `area_id` int(11) DEFAULT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `nombre` text NOT NULL,
  `descripcion` text DEFAULT NULL,
  `calificacion` int(11) DEFAULT 50,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_for` bigint(20) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `tipo` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `tiposDesperdicios`
--

INSERT INTO `tiposDesperdicios` (`id`, `area_id`, `departamento_id`, `nombre`, `descripcion`, `calificacion`, `created_at`, `updated_at`, `created_for`, `deleted_at`, `tipo`) VALUES
(3, NULL, NULL, 'Pérdidas por Paradas Planificadas', 'Pérdidas por Paradas Planificadas', 50, '2024-09-18 23:05:42', '2024-09-18 23:05:42', 6, NULL, 'Equipos'),
(4, NULL, NULL, 'Pérdidas por Cambio de Producto, Arranques y Ajustes (Set-up)', 'Pérdidas por Cambio de Producto, Arranques y Ajustes (Set-up)', 50, '2024-09-18 23:06:10', '2024-09-18 23:06:10', 6, NULL, 'Equipos'),
(5, NULL, NULL, 'Pérdidas por Averías (Quiebra/Falla) en Equipamientos', 'Pérdidas por Averías (Quiebra/Falla) en Equipamientos', 50, '2024-09-18 23:06:30', '2024-09-18 23:06:30', 6, NULL, 'Equipos'),
(6, NULL, NULL, 'Pérdidas por Fabricación de Productos o Servicios Defectuosos y/o Retrabajo', 'Pérdidas por Fabricación de Productos o Servicios Defectuosos y/o Retrabajo', 50, '2024-09-18 23:06:43', '2024-09-18 23:06:43', 6, NULL, 'Materiales'),
(7, NULL, NULL, 'Pérdidas De Rendimiento De Materiales o Servicios Productivos', 'Pérdidas De Rendimiento De Materiales o Servicios Productivos', 50, '2024-09-18 23:06:55', '2024-09-18 23:06:55', 6, NULL, 'Materiales'),
(8, NULL, NULL, 'Pérdidas de Rendimiento de Materiales Accesorios (Refacciones ICompras)', 'Pérdidas de Rendimiento de Materiales Accesorios (Refacciones ICompras)', 50, '2024-09-18 23:07:09', '2024-09-18 23:07:09', 6, NULL, 'Materiales'),
(9, NULL, NULL, 'Pérdidas de Energía', 'Pérdidas de Energía', 50, '2024-09-18 23:07:34', '2024-09-18 23:07:34', 6, NULL, 'Energia'),
(10, NULL, NULL, 'Pérdidas ambientales', 'Pérdidas ambientales (clima)', 50, '2024-09-18 23:07:48', '2024-09-18 23:09:43', 6, NULL, 'Energia'),
(11, NULL, NULL, 'Pérdidas por Deficiencias en la Gestión', 'Pérdidas por Deficiencias en la Gestión', 50, '2024-09-18 23:08:04', '2024-09-18 23:08:04', 6, NULL, 'Gente'),
(12, NULL, NULL, 'Pérdidas por Movimientos (Deficiencias en la Operación de Equipamientos)', 'Pérdidas por Movimientos (Deficiencias en la Operación de Equipamientos)', 50, '2024-09-18 23:08:20', '2024-09-18 23:08:20', 6, NULL, 'Gente'),
(13, NULL, NULL, 'perdida por robo de externos', 'perdida por robo de externos', 50, '2024-09-18 23:10:19', '2024-09-21 03:47:35', 6, '2024-09-21 03:47:35', 'Otros'),
(15, NULL, NULL, 'Mala planeacion en envio de materia prima', 'Se pago adicional por cambios', 50, '2024-09-21 03:46:40', '2024-09-21 03:46:40', 6, NULL, 'Otros');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_accion`
--

CREATE TABLE `tipos_accion` (
  `id` int(11) NOT NULL,
  `titulo` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `tipos_accion`
--

INSERT INTO `tipos_accion` (`id`, `titulo`) VALUES
(1, 'Correctivas'),
(2, 'Preventivas'),
(3, 'Mejora');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipos_minuta`
--

CREATE TABLE `tipos_minuta` (
  `id` int(11) NOT NULL,
  `titulo` varchar(250) DEFAULT NULL,
  `definicion` varchar(250) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Volcado de datos para la tabla `tipos_minuta`
--

INSERT INTO `tipos_minuta` (`id`, `titulo`, `definicion`, `created_at`, `updated_at`) VALUES
(1, 'D.D.S.', 'Junta diaria', '2024-08-02 18:30:33', '2024-08-02 18:30:33'),
(2, 'W.D.S.', 'Junta semanal', '2024-08-02 18:30:33', '2024-08-02 18:30:33'),
(3, 'M.D.S.', 'Junta mensual', '2024-08-02 18:30:33', '2024-08-02 18:30:33'),
(4, 'R.O.B.', 'Preguntar a jorge yo no se que es', '2024-08-02 18:30:33', '2024-08-02 18:30:33'),
(5, 'Mamalona', 'mamalona', '2024-08-03 04:08:00', '2024-08-03 04:08:00'),
(6, 'Productividad', 'Junta de productividad diaria de operaciones', '2024-09-13 01:26:10', '2024-09-13 01:26:10');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `area_id` int(11) DEFAULT NULL,
  `departamento_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `two_factor_secret` text DEFAULT NULL,
  `two_factor_recovery_codes` text DEFAULT NULL,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `current_team_id` bigint(20) UNSIGNED DEFAULT NULL,
  `profile_photo_path` varchar(2048) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `area_id`, `departamento_id`, `name`, `email`, `email_verified_at`, `password`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `remember_token`, `current_team_id`, `profile_photo_path`, `created_at`, `updated_at`, `deleted_at`) VALUES
(6, 1, 1, 'Ricardo Rios', 'a@a.com', NULL, '$2y$12$8M4AWspTE1NeS2fPmkyf0.XCpxSNwWP4nPjkJ.TAVzCuA4bkQUmx2', NULL, NULL, NULL, 'ab4rJyfaY7ugPPZdEUn9c2PCrHwgKszp5v3ZQ8PgaXyiynlTxT3mPG97kbg5', NULL, NULL, '2024-06-19 02:03:08', '2024-06-20 21:45:15', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `acciones`
--
ALTER TABLE `acciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `acciones_ibfk_1` (`tipo_id`),
  ADD KEY `acciones_ibfk_2` (`area_id`),
  ADD KEY `acciones_ibfk_4` (`proceso_id`),
  ADD KEY `fk_estatus_id` (`estatus_id`),
  ADD KEY `fk_responsable_id` (`responsable_id`),
  ADD KEY `acciones_departamento` (`departamento_id`);

--
-- Indices de la tabla `areas`
--
ALTER TABLE `areas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `area_evaluacion`
--
ALTER TABLE `area_evaluacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessment_id` (`assessment_id`),
  ADD KEY `area_id` (`area_id`);

--
-- Indices de la tabla `assessments`
--
ALTER TABLE `assessments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indices de la tabla `assessment_asignado`
--
ALTER TABLE `assessment_asignado`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessment_id` (`assessment_id`),
  ADD KEY `seccion_id` (`seccion_id`);

--
-- Indices de la tabla `avisos`
--
ALTER TABLE `avisos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `avisos_departamento` (`departamento_id`),
  ADD KEY `avisos_semana` (`semana_id`),
  ADD KEY `avisos_createdfor` (`created_for`),
  ADD KEY `avisos_reporte` (`reporte_id`);

--
-- Indices de la tabla `bloque`
--
ALTER TABLE `bloque`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indices de la tabla `challenges`
--
ALTER TABLE `challenges`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_challenge_area_id` (`area_id`),
  ADD KEY `FK_challenge_departamento_id` (`departamento_id`),
  ADD KEY `fk_seccion_id` (`seccion_id`);

--
-- Indices de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `area_id` (`area_id`);

--
-- Indices de la tabla `departamento_evaluacion`
--
ALTER TABLE `departamento_evaluacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessment_id` (`assessment_id`),
  ADD KEY `departamento_id` (`departamento_id`);

--
-- Indices de la tabla `desperdicios`
--
ALTER TABLE `desperdicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Desperdicio_tipoDesperdicio` (`tipoDesperdicio_id`),
  ADD KEY `Desperdicio_departamento` (`departamento_id`),
  ADD KEY `Desperdicio_area` (`area_id`),
  ADD KEY `Desperdicio_createdfor` (`created_for`);

--
-- Indices de la tabla `encargado_flujos`
--
ALTER TABLE `encargado_flujos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `encargado_flujo_user` (`user_id`),
  ADD KEY `encargado_flujo_departamento` (`departamento_id`);

--
-- Indices de la tabla `estandares`
--
ALTER TABLE `estandares`
  ADD PRIMARY KEY (`id`),
  ADD KEY `procedimiento_id` (`procedimiento_id`);

--
-- Indices de la tabla `estatus`
--
ALTER TABLE `estatus`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indices de la tabla `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indices de la tabla `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `kpis`
--
ALTER TABLE `kpis`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Kpis_area` (`area_id`),
  ADD KEY `Kpis_departamento` (`departamento_id`),
  ADD KEY `Kpis_proceso` (`proceso_id`),
  ADD KEY `Kpis_procedimiento` (`procedimiento_id`);

--
-- Indices de la tabla `lights`
--
ALTER TABLE `lights`
  ADD PRIMARY KEY (`id`),
  ADD KEY `lights_departamento` (`departamento_id`),
  ADD KEY `lights_semana` (`semana_id`),
  ADD KEY `lights_createdfor` (`created_for`),
  ADD KEY `lights_reporte` (`reporte_id`);

--
-- Indices de la tabla `metaflujos`
--
ALTER TABLE `metaflujos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `metaFlujos_departamento` (`departamento_id`),
  ADD KEY `metaFlujos_trimestre` (`trimestre_id`),
  ADD KEY `metaFlujos_createdfor` (`created_for`);

--
-- Indices de la tabla `metas`
--
ALTER TABLE `metas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `metas_departamento` (`departamento_id`),
  ADD KEY `metas_trimestres` (`trimestre_id`),
  ADD KEY `metas_createdfor` (`created_for`),
  ADD KEY `metas_metaFlujo` (`metaFlujo_id`);

--
-- Indices de la tabla `metatrimestres`
--
ALTER TABLE `metatrimestres`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `minutas`
--
ALTER TABLE `minutas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `minutas_areas_FK` (`area_id`),
  ADD KEY `minutas_departamentos_FK` (`departamento_id`),
  ADD KEY `minutas_procesos_FK` (`proceso_id`),
  ADD KEY `minutas_users_FK` (`lider_id`);

--
-- Indices de la tabla `minutas_asistentes`
--
ALTER TABLE `minutas_asistentes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `minutas_asistentes_ibfk_1` (`minuta_id`),
  ADD KEY `minutas_asistentes_ibfk_2` (`user_id`);

--
-- Indices de la tabla `model_has_permissions`
--
ALTER TABLE `model_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  ADD KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indices de la tabla `model_has_roles`
--
ALTER TABLE `model_has_roles`
  ADD PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  ADD KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`);

--
-- Indices de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indices de la tabla `objetivos`
--
ALTER TABLE `objetivos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `opciones`
--
ALTER TABLE `opciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_opciones_challenge_id` (`challenge_id`);

--
-- Indices de la tabla `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indices de la tabla `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indices de la tabla `personalizar`
--
ALTER TABLE `personalizar`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indices de la tabla `procedimientos`
--
ALTER TABLE `procedimientos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `proceso_id` (`proceso_id`);

--
-- Indices de la tabla `procesos`
--
ALTER TABLE `procesos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `area_id` (`area_id`),
  ADD KEY `departamento_id` (`departamento_id`);

--
-- Indices de la tabla `registros_kpi`
--
ALTER TABLE `registros_kpi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `registro_kpis_kpi_id` (`kpi_id`),
  ADD KEY `registro_kpis_createdfor` (`created_for`);

--
-- Indices de la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reporte_departamento` (`departamento_id`),
  ADD KEY `reporte_semana` (`semana_id`),
  ADD KEY `reporte_createdfor` (`created_for`);

--
-- Indices de la tabla `reporteSemanal`
--
ALTER TABLE `reporteSemanal`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `assessment_id` (`assessment_id`),
  ADD KEY `seccion_id` (`seccion_id`),
  ADD KEY `area_id` (`area_id`),
  ADD KEY `departamento_id` (`departamento_id`),
  ADD KEY `challenge_id` (`challenge_id`),
  ADD KEY `opcion_id` (`opcion_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_guard_name_unique` (`name`,`guard_name`);

--
-- Indices de la tabla `role_has_permissions`
--
ALTER TABLE `role_has_permissions`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `role_has_permissions_role_id_foreign` (`role_id`);

--
-- Indices de la tabla `secciones`
--
ALTER TABLE `secciones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `area_id` (`area_id`),
  ADD KEY `departamento_id` (`departamento_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indices de la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_area_id_tareas` (`area_id`),
  ADD KEY `FK_departamento_id_tareas` (`departamento_id`),
  ADD KEY `FK_responsable_id_tareas` (`responsable_id`),
  ADD KEY `FK_minuta_id_tareas` (`minuta_id`);

--
-- Indices de la tabla `tarea_evidencia`
--
ALTER TABLE `tarea_evidencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tarea_id` (`tarea_id`);

--
-- Indices de la tabla `tiposDesperdicios`
--
ALTER TABLE `tiposDesperdicios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tiposDesperdicios_departamento` (`departamento_id`),
  ADD KEY `tiposDesperdicios_area` (`area_id`),
  ADD KEY `tiposDesperdicios_createdfor` (`created_for`);

--
-- Indices de la tabla `tipos_accion`
--
ALTER TABLE `tipos_accion`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tipos_minuta`
--
ALTER TABLE `tipos_minuta`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_areas_FK` (`area_id`),
  ADD KEY `users_departamentos_FK` (`departamento_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `acciones`
--
ALTER TABLE `acciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `areas`
--
ALTER TABLE `areas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `area_evaluacion`
--
ALTER TABLE `area_evaluacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `assessments`
--
ALTER TABLE `assessments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `assessment_asignado`
--
ALTER TABLE `assessment_asignado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `avisos`
--
ALTER TABLE `avisos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=186;

--
-- AUTO_INCREMENT de la tabla `bloque`
--
ALTER TABLE `bloque`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `challenges`
--
ALTER TABLE `challenges`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=156;

--
-- AUTO_INCREMENT de la tabla `departamentos`
--
ALTER TABLE `departamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT de la tabla `departamento_evaluacion`
--
ALTER TABLE `departamento_evaluacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `desperdicios`
--
ALTER TABLE `desperdicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `encargado_flujos`
--
ALTER TABLE `encargado_flujos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estandares`
--
ALTER TABLE `estandares`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estatus`
--
ALTER TABLE `estatus`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `kpis`
--
ALTER TABLE `kpis`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lights`
--
ALTER TABLE `lights`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=719;

--
-- AUTO_INCREMENT de la tabla `metaflujos`
--
ALTER TABLE `metaflujos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `metas`
--
ALTER TABLE `metas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `metatrimestres`
--
ALTER TABLE `metatrimestres`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `minutas`
--
ALTER TABLE `minutas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `minutas_asistentes`
--
ALTER TABLE `minutas_asistentes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `objetivos`
--
ALTER TABLE `objetivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `opciones`
--
ALTER TABLE `opciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=621;

--
-- AUTO_INCREMENT de la tabla `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `personalizar`
--
ALTER TABLE `personalizar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `procedimientos`
--
ALTER TABLE `procedimientos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `procesos`
--
ALTER TABLE `procesos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `registros_kpi`
--
ALTER TABLE `registros_kpi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `reportes`
--
ALTER TABLE `reportes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT de la tabla `reporteSemanal`
--
ALTER TABLE `reporteSemanal`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `respuestas`
--
ALTER TABLE `respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `secciones`
--
ALTER TABLE `secciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tarea_evidencia`
--
ALTER TABLE `tarea_evidencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tiposDesperdicios`
--
ALTER TABLE `tiposDesperdicios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `tipos_accion`
--
ALTER TABLE `tipos_accion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipos_minuta`
--
ALTER TABLE `tipos_minuta`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=188;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `acciones`
--
ALTER TABLE `acciones`
  ADD CONSTRAINT `acciones_departamento` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `acciones_ibfk_1` FOREIGN KEY (`tipo_id`) REFERENCES `tipos_accion` (`id`),
  ADD CONSTRAINT `acciones_ibfk_2` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `acciones_ibfk_4` FOREIGN KEY (`proceso_id`) REFERENCES `procesos` (`id`),
  ADD CONSTRAINT `fk_estatus_id` FOREIGN KEY (`estatus_id`) REFERENCES `estatus` (`id`),
  ADD CONSTRAINT `fk_responsable_id` FOREIGN KEY (`responsable_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `area_evaluacion`
--
ALTER TABLE `area_evaluacion`
  ADD CONSTRAINT `area_evaluacion_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`),
  ADD CONSTRAINT `area_evaluacion_ibfk_2` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`);

--
-- Filtros para la tabla `assessments`
--
ALTER TABLE `assessments`
  ADD CONSTRAINT `assessments_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `assessment_asignado`
--
ALTER TABLE `assessment_asignado`
  ADD CONSTRAINT `assessment_asignado_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`),
  ADD CONSTRAINT `assessment_asignado_ibfk_2` FOREIGN KEY (`seccion_id`) REFERENCES `secciones` (`id`);

--
-- Filtros para la tabla `avisos`
--
ALTER TABLE `avisos`
  ADD CONSTRAINT `avisos_createdfor` FOREIGN KEY (`created_for`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `avisos_departamento` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `avisos_reporte` FOREIGN KEY (`reporte_id`) REFERENCES `reportes` (`id`),
  ADD CONSTRAINT `avisos_semana` FOREIGN KEY (`semana_id`) REFERENCES `reporteSemanal` (`id`);

--
-- Filtros para la tabla `challenges`
--
ALTER TABLE `challenges`
  ADD CONSTRAINT `FK_challenge_area_id` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `FK_challenge_departamento_id` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `fk_seccion_id` FOREIGN KEY (`seccion_id`) REFERENCES `secciones` (`id`);

--
-- Filtros para la tabla `departamento_evaluacion`
--
ALTER TABLE `departamento_evaluacion`
  ADD CONSTRAINT `departamento_evaluacion_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`),
  ADD CONSTRAINT `departamento_evaluacion_ibfk_2` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`);

--
-- Filtros para la tabla `desperdicios`
--
ALTER TABLE `desperdicios`
  ADD CONSTRAINT `Desperdicio_area` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `Desperdicio_createdfor` FOREIGN KEY (`created_for`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `Desperdicio_departamento` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `Desperdicio_tipoDesperdicio` FOREIGN KEY (`tipoDesperdicio_id`) REFERENCES `tiposDesperdicios` (`id`);

--
-- Filtros para la tabla `encargado_flujos`
--
ALTER TABLE `encargado_flujos`
  ADD CONSTRAINT `encargado_flujo_departamento` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `encargado_flujo_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `estandares`
--
ALTER TABLE `estandares`
  ADD CONSTRAINT `estandares_ibfk_1` FOREIGN KEY (`procedimiento_id`) REFERENCES `procedimientos` (`id`);

--
-- Filtros para la tabla `kpis`
--
ALTER TABLE `kpis`
  ADD CONSTRAINT `Kpis_area` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `Kpis_departamento` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `Kpis_procedimiento` FOREIGN KEY (`procedimiento_id`) REFERENCES `procedimientos` (`id`),
  ADD CONSTRAINT `Kpis_proceso` FOREIGN KEY (`proceso_id`) REFERENCES `procesos` (`id`);

--
-- Filtros para la tabla `lights`
--
ALTER TABLE `lights`
  ADD CONSTRAINT `lights_createdfor` FOREIGN KEY (`created_for`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `lights_departamento` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `lights_reporte` FOREIGN KEY (`reporte_id`) REFERENCES `reportes` (`id`),
  ADD CONSTRAINT `lights_semana` FOREIGN KEY (`semana_id`) REFERENCES `reporteSemanal` (`id`);

--
-- Filtros para la tabla `metaflujos`
--
ALTER TABLE `metaflujos`
  ADD CONSTRAINT `metaFlujos_createdfor` FOREIGN KEY (`created_for`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `metaFlujos_departamento` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `metaFlujos_trimestre` FOREIGN KEY (`trimestre_id`) REFERENCES `metatrimestres` (`id`);

--
-- Filtros para la tabla `metas`
--
ALTER TABLE `metas`
  ADD CONSTRAINT `metas_createdfor` FOREIGN KEY (`created_for`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `metas_departamento` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `metas_metaFlujo` FOREIGN KEY (`metaFlujo_id`) REFERENCES `metaflujos` (`id`),
  ADD CONSTRAINT `metas_trimestres` FOREIGN KEY (`trimestre_id`) REFERENCES `metatrimestres` (`id`);

--
-- Filtros para la tabla `minutas`
--
ALTER TABLE `minutas`
  ADD CONSTRAINT `minutas_areas_FK` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `minutas_departamentos_FK` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `minutas_procesos_FK` FOREIGN KEY (`proceso_id`) REFERENCES `procesos` (`id`),
  ADD CONSTRAINT `minutas_users_FK` FOREIGN KEY (`lider_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `minutas_asistentes`
--
ALTER TABLE `minutas_asistentes`
  ADD CONSTRAINT `minutas_asistentes_ibfk_1` FOREIGN KEY (`minuta_id`) REFERENCES `minutas` (`id`),
  ADD CONSTRAINT `minutas_asistentes_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `notificaciones`
--
ALTER TABLE `notificaciones`
  ADD CONSTRAINT `notificaciones_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `opciones`
--
ALTER TABLE `opciones`
  ADD CONSTRAINT `FK_opciones_challenge_id` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`);

--
-- Filtros para la tabla `procedimientos`
--
ALTER TABLE `procedimientos`
  ADD CONSTRAINT `procedimientos_ibfk_1` FOREIGN KEY (`proceso_id`) REFERENCES `procesos` (`id`);

--
-- Filtros para la tabla `procesos`
--
ALTER TABLE `procesos`
  ADD CONSTRAINT `procesos_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `procesos_ibfk_2` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`);

--
-- Filtros para la tabla `registros_kpi`
--
ALTER TABLE `registros_kpi`
  ADD CONSTRAINT `registro_kpis_createdfor` FOREIGN KEY (`created_for`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `registro_kpis_kpi_id` FOREIGN KEY (`kpi_id`) REFERENCES `kpis` (`id`);

--
-- Filtros para la tabla `reportes`
--
ALTER TABLE `reportes`
  ADD CONSTRAINT `reporte_createdfor` FOREIGN KEY (`created_for`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `reporte_departamento` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `reporte_semana` FOREIGN KEY (`semana_id`) REFERENCES `reporteSemanal` (`id`);

--
-- Filtros para la tabla `respuestas`
--
ALTER TABLE `respuestas`
  ADD CONSTRAINT `respuestas_ibfk_1` FOREIGN KEY (`assessment_id`) REFERENCES `assessments` (`id`),
  ADD CONSTRAINT `respuestas_ibfk_2` FOREIGN KEY (`seccion_id`) REFERENCES `secciones` (`id`),
  ADD CONSTRAINT `respuestas_ibfk_3` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `respuestas_ibfk_4` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `respuestas_ibfk_5` FOREIGN KEY (`challenge_id`) REFERENCES `challenges` (`id`),
  ADD CONSTRAINT `respuestas_ibfk_6` FOREIGN KEY (`opcion_id`) REFERENCES `opciones` (`id`);

--
-- Filtros para la tabla `secciones`
--
ALTER TABLE `secciones`
  ADD CONSTRAINT `secciones_ibfk_1` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `secciones_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `tareas`
--
ALTER TABLE `tareas`
  ADD CONSTRAINT `FK_area_id_tareas` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `FK_departamento_id_tareas` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`),
  ADD CONSTRAINT `FK_minuta_id_tareas` FOREIGN KEY (`minuta_id`) REFERENCES `minutas` (`id`),
  ADD CONSTRAINT `FK_responsable_id_tareas` FOREIGN KEY (`responsable_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `tarea_evidencia`
--
ALTER TABLE `tarea_evidencia`
  ADD CONSTRAINT `tarea_evidencia_ibfk_1` FOREIGN KEY (`tarea_id`) REFERENCES `tareas` (`id`);

--
-- Filtros para la tabla `tiposDesperdicios`
--
ALTER TABLE `tiposDesperdicios`
  ADD CONSTRAINT `tiposDesperdicios_area` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`),
  ADD CONSTRAINT `tiposDesperdicios_createdfor` FOREIGN KEY (`created_for`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tiposDesperdicios_departamento` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
