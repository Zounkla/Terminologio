-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : database:3306
-- Généré le : jeu. 21 déc. 2023 à 14:20
-- Version du serveur : 10.11.2-MariaDB-1:10.11.2+maria~ubu2204
-- Version de PHP : 8.2.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `main`
--

-- --------------------------------------------------------

--
-- Structure de la table `Caption`
--

CREATE TABLE `Caption` (
  `pic_id` int(11) NOT NULL,
  `caption_id` int(11) NOT NULL,
  `point_X` int(11) DEFAULT NULL,
  `point_Y` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Caption`
--

INSERT INTO `Caption` (`pic_id`, `caption_id`, `point_X`, `point_Y`) VALUES
(1, 1, 0, 0),
(1, 2, 837, 65),
(1, 3, 679, 330),
(1, 4, 848, 69),
(4, 0, 348, 270);

-- --------------------------------------------------------

--
-- Structure de la table `Category`
--

CREATE TABLE `Category` (
  `name` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Category`
--

INSERT INTO `Category` (`name`) VALUES
('Littérature'),
('Sciences');

-- --------------------------------------------------------

--
-- Structure de la table `Language`
--

CREATE TABLE `Language` (
  `name` varchar(32) NOT NULL,
  `code` varchar(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Language`
--

INSERT INTO `Language` (`name`, `code`) VALUES
('Deutsch', 'de'),
('English', 'en'),
('Español', 'es'),
('Français', 'fr'),
('Italiano', 'it');

-- --------------------------------------------------------

--
-- Structure de la table `Picture`
--

CREATE TABLE `Picture` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `default_language` varchar(2) NOT NULL,
  `category` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `Picture`
--

INSERT INTO `Picture` (`id`, `title`, `default_language`, `category`) VALUES
(1, 'b', 'it', 'Littérature'),
(2, 'g', 'es', 'Sciences'),
(3, 'h', 'de', 'Sciences'),
(4, 'Je teste un truc', 'en', 'Sciences'),
(8, 'raaz', 'de', 'Littérature'),
(5, 'test', 'fr', 'Sciences'),
(6, 'test2', 'fr', 'Sciences'),
(7, 'test3', 'fr', 'Littérature');

-- --------------------------------------------------------

--
-- Structure de la table `Translation`
--

CREATE TABLE `Translation` (
  `caption_id` int(11) NOT NULL,
  `language` varchar(2) NOT NULL,
  `text` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `User`
--

CREATE TABLE `User` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `is_admin` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `User`
--

INSERT INTO `User` (`username`, `password`, `is_admin`) VALUES
('a', 'b', 0),
('b', '3e23e8160039594a33894f6564e1b1348bbd7a0088d42c4acb73eeaed59c009d', 0),
('eayveayygue', '$2y$10$Xnn6cOFwa1suI6XZICa5lef2n6aPpkeV7/BsgTuMJ6mYHb6CM0fjq', 0),
('F', 'f67ab10ad4e4c53121b6a5fe4da9c10ddee905b978d3788d2723d7bfacbe28a9', 0),
('G', '333e0a1e27815d0ceee55c473fe3dc93d56c63e3bee2b3b4aee8eed6d70191a3', 0),
('guzagugu', 'cd0aa9856147b6c5b4ff2b7dfee5da20aa38253099ef1b4a64aced233c9afe29', 0),
('mp', '$2y$10$tr6WdlTKpz3tEXrH3WAHC.C6OmlhajtfsJrzfR07AgMIPdWhXRaBy', 0),
('p', '$2y$10$4iETKMWEOVLxVgNScarijObOn.MwFc5U306DtqpaR5TK1fXlxmd2u', 0),
('t', 'e3b98a4da31a127d4bde6e43033f66ba274cab0eb7eb1c70ec41402bf6273dd8', 0),
('test', '$2y$10$6IGk1zvqZGkuQ3Eu8UGOpOQMVoZVb5vf/FoOd3IhyUzj7Xa2GIWky', 1),
('zounkla', '$2y$10$DpYzt.X1UNcPbp3ILD6m1OZlCLvigKV.7mIGOODMTp7hpl9brGQfi', 0);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `Caption`
--
ALTER TABLE `Caption`
  ADD PRIMARY KEY (`pic_id`,`caption_id`),
  ADD UNIQUE KEY `caption_id` (`caption_id`);

--
-- Index pour la table `Category`
--
ALTER TABLE `Category`
  ADD PRIMARY KEY (`name`);

--
-- Index pour la table `Language`
--
ALTER TABLE `Language`
  ADD PRIMARY KEY (`code`);

--
-- Index pour la table `Picture`
--
ALTER TABLE `Picture`
  ADD PRIMARY KEY (`title`,`category`) USING BTREE,
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `category` (`category`),
  ADD KEY `Picture_ibfk_2` (`default_language`);

--
-- Index pour la table `Translation`
--
ALTER TABLE `Translation`
  ADD KEY `fk_language` (`language`),
  ADD KEY `fk_caption` (`caption_id`);

--
-- Index pour la table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `Picture`
--
ALTER TABLE `Picture`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `Caption`
--
ALTER TABLE `Caption`
  ADD CONSTRAINT `fk_pic` FOREIGN KEY (`pic_id`) REFERENCES `Picture` (`id`);

--
-- Contraintes pour la table `Picture`
--
ALTER TABLE `Picture`
  ADD CONSTRAINT `Picture_ibfk_1` FOREIGN KEY (`category`) REFERENCES `Category` (`name`),
  ADD CONSTRAINT `Picture_ibfk_2` FOREIGN KEY (`default_language`) REFERENCES `Language` (`code`);

--
-- Contraintes pour la table `Translation`
--
ALTER TABLE `Translation`
  ADD CONSTRAINT `fk_caption` FOREIGN KEY (`caption_id`) REFERENCES `Caption` (`caption_id`),
  ADD CONSTRAINT `fk_language` FOREIGN KEY (`language`) REFERENCES `Language` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
