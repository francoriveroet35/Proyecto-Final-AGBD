-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-11-2026 a las 01:41:06
-- Versión del servidor: 10.11.16-MariaDB
-- Versión de PHP: 8.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cyberdefensedb`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarResultado` (IN `p_idPartida` INT, IN `p_resultado` VARCHAR(10), IN `p_oleadaMaxima` INT, IN `p_vidasRestantes` INT, IN `p_dineroFinal` INT)   BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    IF NOT EXISTS (
        SELECT 1
        FROM PARTIDA
        WHERE idPartida = p_idPartida
          AND estado = 'En curso'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La partida no existe o ya fue finalizada';
    END IF;

    INSERT INTO RESULTADO (
        resultado,
        oleadaMaxima,
        vidasRestantes,
        dineroFinal,
        idPartida
    )
    VALUES (
        p_resultado,
        p_oleadaMaxima,
        p_vidasRestantes,
        p_dineroFinal,
        p_idPartida
    );

    UPDATE PARTIDA
    SET estado = 'Finalizada',
        fechaFin = NOW()
    WHERE idPartida = p_idPartida;

    COMMIT;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enemigo`
--

CREATE TABLE `enemigo` (
  `idEnemigo` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `vidaBase` int(11) NOT NULL,
  `velocidadBase` decimal(5,2) NOT NULL,
  `recompensaBase` int(11) NOT NULL
) ;

--
-- Volcado de datos para la tabla `enemigo`
--

INSERT INTO `enemigo` (`idEnemigo`, `nombre`, `vidaBase`, `velocidadBase`, `recompensaBase`) VALUES
(1, 'Virus', 100, 1.80, 50),
(2, 'Malware', 180, 1.10, 80),
(3, 'Troyano', 280, 1.30, 110);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `enemigo_partida`
--

CREATE TABLE `enemigo_partida` (
  `idEnemigoPartida` int(11) NOT NULL,
  `estadoFinal` varchar(20) NOT NULL DEFAULT 'Pendiente',
  `idOleada` int(11) NOT NULL,
  `idEnemigo` int(11) NOT NULL
) ;

--
-- Volcado de datos para la tabla `enemigo_partida`
--

INSERT INTO `enemigo_partida` (`idEnemigoPartida`, `estadoFinal`, `idOleada`, `idEnemigo`) VALUES
(1, 'Derrotado', 1, 1),
(2, 'Derrotado', 1, 2),
(3, 'Derrotado', 2, 3),
(4, 'Llego al nucleo', 3, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `jugador`
--

CREATE TABLE `jugador` (
  `idJugador` int(11) NOT NULL,
  `nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `jugador`
--

INSERT INTO `jugador` (`idJugador`, `nombre`) VALUES
(1, 'Franco'),
(2, 'Jugador Prueba');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `oleada`
--

CREATE TABLE `oleada` (
  `idOleada` int(11) NOT NULL,
  `numero` int(11) NOT NULL,
  `fechaInicio` datetime NOT NULL DEFAULT current_timestamp(),
  `idPartida` int(11) NOT NULL
) ;

--
-- Volcado de datos para la tabla `oleada`
--

INSERT INTO `oleada` (`idOleada`, `numero`, `fechaInicio`, `idPartida`) VALUES
(1, 1, '2026-11-10 15:01:00', 1),
(2, 2, '2026-11-10 15:03:00', 1),
(3, 1, '2026-11-11 16:01:00', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `partida`
--

CREATE TABLE `partida` (
  `idPartida` int(11) NOT NULL,
  `fechaInicio` datetime NOT NULL DEFAULT current_timestamp(),
  `fechaFin` datetime DEFAULT NULL,
  `estado` varchar(15) NOT NULL DEFAULT 'En curso',
  `idJugador` int(11) NOT NULL
) ;

--
-- Volcado de datos para la tabla `partida`
--

INSERT INTO `partida` (`idPartida`, `fechaInicio`, `fechaFin`, `estado`, `idJugador`) VALUES
(1, '2026-11-10 15:00:00', '2026-11-10 15:10:00', 'Finalizada', 1),
(2, '2026-11-11 16:00:00', '2026-11-11 16:08:00', 'Finalizada', 2),
(3, '2026-11-18 21:36:11', '2026-11-18 21:36:11', 'Finalizada', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resultado`
--

CREATE TABLE `resultado` (
  `idResultado` int(11) NOT NULL,
  `resultado` varchar(10) NOT NULL,
  `oleadaMaxima` int(11) NOT NULL,
  `vidasRestantes` int(11) NOT NULL,
  `dineroFinal` int(11) NOT NULL,
  `idPartida` int(11) NOT NULL
) ;

--
-- Volcado de datos para la tabla `resultado`
--

INSERT INTO `resultado` (`idResultado`, `resultado`, `oleadaMaxima`, `vidasRestantes`, `dineroFinal`, `idPartida`) VALUES
(1, 'Victoria', 5, 6, 250, 1),
(2, 'Derrota', 3, 0, 100, 2),
(3, 'Victoria', 5, 6, 250, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `torre`
--

CREATE TABLE `torre` (
  `idTorre` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL,
  `costo` int(11) NOT NULL,
  `alcanceBase` int(11) NOT NULL,
  `danioBase` int(11) NOT NULL,
  `cooldownBase` int(11) NOT NULL
) ;

--
-- Volcado de datos para la tabla `torre`
--

INSERT INTO `torre` (`idTorre`, `nombre`, `costo`, `alcanceBase`, `danioBase`, `cooldownBase`) VALUES
(1, 'Antivirus', 100, 150, 25, 45),
(2, 'Firewall', 150, 110, 50, 80);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `torre_partida`
--

CREATE TABLE `torre_partida` (
  `idTorrePartida` int(11) NOT NULL,
  `nivel` int(11) NOT NULL,
  `posicionX` int(11) NOT NULL,
  `posicionY` int(11) NOT NULL,
  `idPartida` int(11) NOT NULL,
  `idTorre` int(11) NOT NULL
) ;

--
-- Volcado de datos para la tabla `torre_partida`
--

INSERT INTO `torre_partida` (`idTorrePartida`, `nivel`, `posicionX`, `posicionY`, `idPartida`, `idTorre`) VALUES
(1, 2, 300, 250, 1, 1),
(2, 1, 600, 350, 1, 2),
(3, 1, 400, 200, 2, 1);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `vistahistorialpartidas`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `vistahistorialpartidas` (
`idPartida` int(11)
,`jugador` varchar(50)
,`fechaInicio` datetime
,`fechaFin` datetime
,`estado` varchar(15)
,`resultado` varchar(10)
,`oleadaMaxima` int(11)
,`vidasRestantes` int(11)
,`dineroFinal` int(11)
);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `enemigo`
--
ALTER TABLE `enemigo`
  ADD PRIMARY KEY (`idEnemigo`),
  ADD UNIQUE KEY `UQ_ENEMIGO_NOMBRE` (`nombre`);

--
-- Indices de la tabla `enemigo_partida`
--
ALTER TABLE `enemigo_partida`
  ADD PRIMARY KEY (`idEnemigoPartida`),
  ADD KEY `IX_ENEMIGOPARTIDA_OLEADA` (`idOleada`),
  ADD KEY `IX_ENEMIGOPARTIDA_ENEMIGO` (`idEnemigo`);

--
-- Indices de la tabla `jugador`
--
ALTER TABLE `jugador`
  ADD PRIMARY KEY (`idJugador`),
  ADD UNIQUE KEY `UQ_JUGADOR_NOMBRE` (`nombre`);

--
-- Indices de la tabla `oleada`
--
ALTER TABLE `oleada`
  ADD PRIMARY KEY (`idOleada`),
  ADD UNIQUE KEY `UQ_OLEADA_PARTIDA_NUMERO` (`idPartida`,`numero`),
  ADD KEY `IX_OLEADA_PARTIDA` (`idPartida`);

--
-- Indices de la tabla `partida`
--
ALTER TABLE `partida`
  ADD PRIMARY KEY (`idPartida`),
  ADD KEY `IX_PARTIDA_JUGADOR` (`idJugador`);

--
-- Indices de la tabla `resultado`
--
ALTER TABLE `resultado`
  ADD PRIMARY KEY (`idResultado`),
  ADD UNIQUE KEY `UQ_RESULTADO_PARTIDA` (`idPartida`);

--
-- Indices de la tabla `torre`
--
ALTER TABLE `torre`
  ADD PRIMARY KEY (`idTorre`),
  ADD UNIQUE KEY `UQ_TORRE_NOMBRE` (`nombre`);

--
-- Indices de la tabla `torre_partida`
--
ALTER TABLE `torre_partida`
  ADD PRIMARY KEY (`idTorrePartida`),
  ADD KEY `IX_TORREPARTIDA_PARTIDA` (`idPartida`),
  ADD KEY `IX_TORREPARTIDA_TORRE` (`idTorre`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `enemigo`
--
ALTER TABLE `enemigo`
  MODIFY `idEnemigo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `enemigo_partida`
--
ALTER TABLE `enemigo_partida`
  MODIFY `idEnemigoPartida` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `jugador`
--
ALTER TABLE `jugador`
  MODIFY `idJugador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `oleada`
--
ALTER TABLE `oleada`
  MODIFY `idOleada` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `partida`
--
ALTER TABLE `partida`
  MODIFY `idPartida` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `resultado`
--
ALTER TABLE `resultado`
  MODIFY `idResultado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `torre`
--
ALTER TABLE `torre`
  MODIFY `idTorre` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `torre_partida`
--
ALTER TABLE `torre_partida`
  MODIFY `idTorrePartida` int(11) NOT NULL AUTO_INCREMENT;

-- --------------------------------------------------------

--
-- Estructura para la vista `vistahistorialpartidas`
--
DROP TABLE IF EXISTS `vistahistorialpartidas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vistahistorialpartidas`  AS SELECT `p`.`idPartida` AS `idPartida`, `j`.`nombre` AS `jugador`, `p`.`fechaInicio` AS `fechaInicio`, `p`.`fechaFin` AS `fechaFin`, `p`.`estado` AS `estado`, `r`.`resultado` AS `resultado`, `r`.`oleadaMaxima` AS `oleadaMaxima`, `r`.`vidasRestantes` AS `vidasRestantes`, `r`.`dineroFinal` AS `dineroFinal` FROM ((`partida` `p` join `jugador` `j` on(`p`.`idJugador` = `j`.`idJugador`)) left join `resultado` `r` on(`p`.`idPartida` = `r`.`idPartida`)) ;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `enemigo_partida`
--
ALTER TABLE `enemigo_partida`
  ADD CONSTRAINT `FK_ENEMIGOPARTIDA_ENEMIGO` FOREIGN KEY (`idEnemigo`) REFERENCES `enemigo` (`idEnemigo`),
  ADD CONSTRAINT `FK_ENEMIGOPARTIDA_OLEADA` FOREIGN KEY (`idOleada`) REFERENCES `oleada` (`idOleada`);

--
-- Filtros para la tabla `oleada`
--
ALTER TABLE `oleada`
  ADD CONSTRAINT `FK_OLEADA_PARTIDA` FOREIGN KEY (`idPartida`) REFERENCES `partida` (`idPartida`);

--
-- Filtros para la tabla `partida`
--
ALTER TABLE `partida`
  ADD CONSTRAINT `FK_PARTIDA_JUGADOR` FOREIGN KEY (`idJugador`) REFERENCES `jugador` (`idJugador`);

--
-- Filtros para la tabla `resultado`
--
ALTER TABLE `resultado`
  ADD CONSTRAINT `FK_RESULTADO_PARTIDA` FOREIGN KEY (`idPartida`) REFERENCES `partida` (`idPartida`);

--
-- Filtros para la tabla `torre_partida`
--
ALTER TABLE `torre_partida`
  ADD CONSTRAINT `FK_TORREPARTIDA_PARTIDA` FOREIGN KEY (`idPartida`) REFERENCES `partida` (`idPartida`),
  ADD CONSTRAINT `FK_TORREPARTIDA_TORRE` FOREIGN KEY (`idTorre`) REFERENCES `torre` (`idTorre`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
