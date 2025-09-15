-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Sep 15, 2025 at 04:59 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `WalletWise`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_feedback`
--

CREATE TABLE `app_feedback` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `star_rating` int(11) DEFAULT NULL CHECK (`star_rating` between 1 and 5),
  `feedback` text DEFAULT NULL,
  `submitted_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_feedback`
--

INSERT INTO `app_feedback` (`id`, `email`, `star_rating`, `feedback`, `submitted_at`) VALUES
(1, 'harini@gamail.com', 5, 'Excellent app!', '2025-06-02 08:00:51'),
(2, '1@gamail.com', 5, 'Excellent app!', '2025-06-02 08:02:29'),
(3, '1@gamail.com', 5, 'Excellent app!', '2025-06-02 09:31:07'),
(4, '1@gamail.com', 5, 'Excellent app!', '2025-06-02 09:42:14'),
(5, '1@gamail.com', 5, 'Excellent app!', '2025-06-02 09:44:18'),
(6, '1@gamail.com', 5, 'Excellent app!', '2025-06-02 09:47:02'),
(7, '1@gamail.com', 5, 'Excellent app!', '2025-06-02 09:58:21'),
(8, 'lav@gmail.com', 5, 'Good', '2025-06-19 05:03:10'),
(9, '1@gamail.com', 5, 'Excellent app!', '2025-06-19 05:04:55'),
(10, 'lav@gmail.com', 5, 'Good', '2025-06-19 05:06:31'),
(11, 'lav@gmail.com', 5, 'Verrry good and help full', '2025-06-19 05:59:52'),
(12, '1@gamail.com', 5, 'Excellent app!', '2025-07-23 10:21:14'),
(13, 'lav@gmail.com', 1, 'Worst', '2025-08-18 03:20:42'),
(14, '1@gamail.com', 5, 'Excellent app!', '2025-08-18 03:41:26'),
(15, '1@gamail.com', 5, 'Excellent app!', '2025-08-18 03:49:38'),
(16, '1@gmail.com', 5, 'Good', '2025-08-18 04:08:48'),
(17, '1@gamail.com', 3, 'better', '2025-08-18 04:27:22'),
(18, '1@gmail.com', 3, 'Good', '2025-08-18 05:16:26'),
(19, '1@gmail.com', 4, 'Friendly', '2025-08-18 06:43:45'),
(20, '1@gmail.com', 5, 'Friendly user', '2025-08-18 09:22:58'),
(21, '1@gmail.com', 5, 'Best', '2025-08-21 03:17:13'),
(22, '1@gmail.com', 5, 'Friendly app', '2025-08-21 03:41:37'),
(23, '1@gmail.com', 3, 'User friendlu', '2025-08-23 05:04:01'),
(24, '1@gmail.com', 5, 'Excellent', '2025-08-23 10:32:46'),
(25, 'lav@gmail.com', 5, 'Good', '2025-08-25 04:06:08'),
(26, 'reddy@gmail.com', 4, 'Good', '2025-08-26 04:15:10'),
(27, 'lav@gmail.com', 5, 'Good', '2025-09-02 06:55:20'),
(28, 'sasi@gmail.com', 5, 'Good', '2025-09-02 07:47:04'),
(29, 'lav@gmail.com', 4, 'User friendly', '2025-09-02 07:59:15');

-- --------------------------------------------------------

--
-- Table structure for table `summary`
--

CREATE TABLE `summary` (
  `email` varchar(255) NOT NULL,
  `house` int(11) NOT NULL,
  `food` int(11) NOT NULL,
  `lifestyle` int(11) NOT NULL,
  `entertainment` int(11) NOT NULL,
  `others` int(11) NOT NULL,
  `total_budget` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `summary`
--

INSERT INTO `summary` (`email`, `house`, `food`, `lifestyle`, `entertainment`, `others`, `total_budget`, `created_at`) VALUES
('test@example.com', 1000, 500, 400, 300, 200, 2400, '2025-06-19 10:11:15'),
('test@example.com', 1000, 500, 400, 300, 200, 2400, '2025-06-19 10:13:56'),
('lav@gmail.com', 1000, 500, 400, 300, 200, 2400, '2025-06-19 10:14:28');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `type` varchar(50) NOT NULL,
  `category` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `note` text DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `email`, `type`, `category`, `date`, `note`, `amount`, `created_at`) VALUES
(1, '', 'cash_in', 'Salary', '2025-05-27', 'Monthly salary credited', 1000.00, '2025-05-30 08:09:00'),
(2, '', 'cash_in', 'Salary', '2025-05-27', 'Monthly salary credited', 1000.00, '2025-05-30 08:56:45'),
(3, '', 'cash_in', 'Salary', '2025-05-27', 'Monthly salary credited', 1000.00, '2025-05-30 09:00:59'),
(4, '', 'cash_out', 'Shopping', '2025-05-30', 'New clothes', 1500.00, '2025-05-30 09:05:41'),
(5, '', 'cash_in', 'Salary', '2025-05-31', 'Sfzd', 1000.00, '2025-05-30 09:38:10'),
(6, '', 'cash_in', 'Salary', '2025-05-31', 'Sfzd', 1000.00, '2025-05-30 09:38:31'),
(7, '', 'cash_out', 'Shopping', '2025-05-30', 'New clothes', 1500.00, '2025-05-30 09:51:56'),
(8, '', 'cash_in', 'Business', '2025-05-30', 'Milk', 450000.00, '2025-05-30 09:59:44'),
(9, '', 'cash_out', 'Shopping', '2025-05-30', 'New clothes', 1500.00, '2025-05-31 02:38:43'),
(10, '', 'cash_in', 'Salary', '2025-05-31', 'Bonus', 100.00, '2025-05-31 03:11:04'),
(11, '', 'cash_in', 'Salary', '2025-05-31', 'May salary', 5000.00, '2025-05-31 03:23:03'),
(12, '', 'cash_in', 'Salary', '2025-05-31', 'May salary', 5000.00, '2025-05-31 03:23:18'),
(13, '', 'cash_out', 'Groceries', '2025-05-31', 'Weekly shopping', 100.00, '2025-05-31 03:25:26'),
(14, '', 'cash_out', 'Groceries', '2025-05-31', 'Weekly shopping', 100.00, '2025-05-31 03:25:36'),
(15, 'user@example.com', 'cash_in', 'Salary', '2025-05-31', 'Monthly salary', 1500.00, '2025-05-31 03:43:19'),
(16, 'harini@gmail.com', 'cash_in', 'Salary', '2025-05-31', 'Monthly salary', 1500.00, '2025-05-31 05:16:51'),
(17, 'harini@gmail.com', 'cash_in', 'Salary', '2025-05-31', 'Monthly salary', 1500.00, '2025-05-31 05:16:53'),
(18, 'harini@gmail.com', 'cash_in', 'Salary', '2025-05-31', 'Monthly salary', 1500.00, '2025-05-31 05:16:54'),
(19, 'harini@gmail.com', 'cash_in', 'Salary', '2025-05-31', 'Monthly salary', 150014.00, '2025-05-31 05:16:57'),
(20, 'harini@gmail.com', 'cash_in', 'Salary', '2025-05-31', 'Monthly salary', 150014.00, '2025-05-31 05:19:07'),
(21, 'h1@gmail.com', 'cash_in', 'Salary', '2025-05-31', 'May salary', 15000.00, '2025-05-31 05:30:58'),
(22, '1', 'cash_in', 'Salary', '2025-05-31', '11', 500.00, '2025-05-31 05:42:12'),
(23, '1', 'cash_in', 'Loan', '2025-05-31', '', 12000.00, '2025-05-31 06:16:37'),
(24, 'h1@gmail.com', 'cash_in', 'Salary', '2025-05-31', 'May salary', 1500.00, '2025-05-31 06:20:02'),
(25, 'user@example.com', 'cash_out', 'Groceries', '2025-05-31', 'Weekly shopping', 150.00, '2025-05-31 06:23:03'),
(26, '1', 'cash_out', 'Groceries', '2025-05-31', 'Weekly shopping', 100.00, '2025-05-31 06:23:10'),
(27, '1', 'cash_out', 'Travel', '2025-05-31', '', 200.00, '2025-05-31 06:34:02'),
(28, 'harini@gmail.com', 'cash_in', 'Business', '2025-06-02', 'सैलरी', 12000.00, '2025-06-02 07:37:25'),
(29, 'harini@gmail.com', 'cash_out', 'Food', '2025-06-02', 'पिज़्ज़ा', 500.00, '2025-06-02 07:37:59'),
(30, 'harini@gmail।com', 'cash_in', 'Salary', '2025-06-02', '/', 100.00, '2025-06-02 08:37:19'),
(31, 'lav@gmail.com', 'cash_in', 'Salary', '2025-06-02', 'bonus', 1000.00, '2025-06-02 09:20:05'),
(32, 'lav@gmail.com', 'cash_in', 'Salary', '2025-06-04', 'Salary', 5000.00, '2025-06-03 07:47:30'),
(33, 'lav@gmail.com', 'cash_in', 'Business', '2025-06-03', 'Food business', 100000.00, '2025-06-03 08:22:31'),
(34, 'lav@gmail.com', 'cash_out', 'Travel', '2025-06-03', 'Dubai', 50000.00, '2025-06-03 08:23:30'),
(35, 'lav@gmail.com', 'cash_in', 'Business', '2025-06-03', 'Fruits', 12000.00, '2025-06-03 08:47:08'),
(36, 'lav@gmail.com', 'cash_in', 'Salary', '2025-06-03', 'dad gave', 10000.00, '2025-06-03 10:18:45'),
(37, 'lav@gmail.com', 'cash_in', 'Salary', '2025-06-03', 'dad gave', 10000.00, '2025-06-03 10:18:47'),
(38, 'lav@gmail.com', 'cash_out', 'Food', '2025-06-03', 'Pizza', 200.00, '2025-06-03 10:19:21'),
(39, 'lav@gmail.com', 'cash_out', 'Food', '2025-06-03', 'Pizza', 200.00, '2025-06-03 10:19:23'),
(40, 'lav@gmail.com', 'cash_in', 'Others', '2025-06-03', 'Cn', 1200.00, '2025-06-03 10:32:59'),
(41, 'lav@gmail.com', 'cash_in', 'Others', '2025-06-03', 'Currentbill', 1200.00, '2025-06-03 10:33:08'),
(42, 'lav@gmail.com', 'cash_in', 'Business', '2025-06-19', 'LIMESTONE', 1277.00, '2025-06-19 05:50:41'),
(43, 'lav@gmail.com', 'cash_in', 'Salary', '2025-06-19', 'SHOP', 2500.00, '2025-06-19 05:53:41'),
(44, 'lav@gmail.com', 'cash_in', 'Salary', '2025-06-19', 'SHOP', 2500.00, '2025-06-19 05:53:43'),
(45, 'lav@gmail.com', 'cash_in', 'Salary', '2025-06-19', 'SHOP', 2500.00, '2025-06-19 05:53:43'),
(46, 'lav@gmail.com', 'cash_out', 'Travel', '2025-06-19', 'Home', 500.00, '2025-06-19 05:57:47'),
(47, 'lav@gmail.com', 'cash_in', 'Loan', '2025-06-19', 'MPOCKET', 2000.00, '2025-06-19 06:05:03'),
(48, 'lav@gmail.com', 'cash_in', 'Loan', '2025-06-19', 'Slice', 900.00, '2025-06-19 06:08:35'),
(49, 'lav@gmail.com', 'cash_out', 'Bills', '2025-06-19', 'cb', 520.00, '2025-06-19 06:12:02'),
(50, '1@gmail.com', 'cash_in', 'Salary', '2025-08-18', 'App', 25000.00, '2025-08-18 03:30:10'),
(51, '1@gmail.com', 'cash_out', 'Others', '2025-08-18', 'Grocery', 1200.00, '2025-08-18 03:30:30'),
(52, '1@gmail.com', 'cash_in', 'Business', '2025-08-18', 'Pickles', 50000.00, '2025-08-18 04:06:34'),
(53, '1@gmail.com', 'cash_in', 'Salary', '2025-08-18', 'August', 20000.00, '2025-08-18 06:42:14'),
(54, '1@gmail.com', 'cash_out', 'Others', '2025-08-18', 'emi', 5000.00, '2025-08-18 06:43:07'),
(55, '1@gmail.com', 'cash_in', 'Loan', '2025-08-18', 'Slice', 2000.00, '2025-08-18 07:01:49'),
(56, '1@gmail.com', 'cash_out', 'Others', '2025-08-18', 'loan clearence', 2000.00, '2025-08-18 07:02:10'),
(57, '1@gmail.com', 'cash_in', 'Business', '2025-08-18', 'event hosting', 32000.00, '2025-08-18 09:21:06'),
(58, '1@gmail.com', 'cash_out', 'Travel', '2025-08-18', 'Beach', 1250.00, '2025-08-18 09:21:30'),
(59, '1@gmail.com', 'cash_in', 'Business', '2025-08-21', 'Wallet wise', 12000.00, '2025-08-21 03:16:42'),
(60, '1@gmail.com', 'cash_in', 'Salary', '2025-08-23', 'Tution', 1230.00, '2025-08-23 05:01:57'),
(61, '1@gmail.com', 'cash_out', 'Food', '2025-08-23', 'Resturant', 300.00, '2025-08-23 05:02:25'),
(62, 'lav@gmail.com', 'cash_in', 'Loan', '2025-08-23', 'Friend', 500.00, '2025-08-23 10:14:27'),
(63, 'lav@gmail.com', 'cash_out', 'Others', '2025-08-23', 'Loan clear', 500.00, '2025-08-23 10:14:44'),
(64, 'lav@gmail.com', 'cash_in', 'Salary', '2025-08-23', 'Kjniujn', 22.00, '2025-08-23 10:24:52'),
(65, '1@gmail.com', 'cash_in', 'Salary', '2025-08-23', 'August', 15000.00, '2025-08-23 11:13:24'),
(66, 'lav@gmail.com', 'cash_in', 'Others', '2025-08-25', 'Tuition', 500.00, '2025-08-25 04:04:00'),
(67, 'lav@gmail.com', 'cash_out', 'Food', '2025-08-25', 'Biryani', 200.00, '2025-08-25 04:04:25'),
(68, '1@gmail.com', 'cash_in', 'Salary', '2025-08-25', 'August', 20000.00, '2025-08-25 04:20:06'),
(69, '1@gmail.com', 'cash_out', 'Travel', '2025-08-25', 'Home', 500.00, '2025-08-25 04:20:21'),
(70, 'reddy@gmail.com', 'cash_in', 'Salary', '2025-05-31', 'May salary', 1000.00, '2025-08-26 04:13:55'),
(71, 'reddy@gmail.com', 'cash_out', 'Travel', '2025-08-26', '', 100.00, '2025-08-26 04:14:47'),
(72, 'reddy@gmail.com', 'cash_in', 'Salary', '2025-05-31', 'May salary', 1000.00, '2025-08-28 10:28:07'),
(73, 'reddy@gmail.com', 'cash_in', 'Salary', '2025-05-31', 'May salary', 1000.00, '2025-09-02 06:47:24'),
(74, 'lav@gmail.com', 'cash_in', 'Loan', '2025-09-02', 'Emi fridge', 500.00, '2025-09-02 06:53:50'),
(75, 'lav@gmail.com', 'cash_in', 'Loan', '2025-09-02', 'Return on 1st oct', 500.00, '2025-09-02 06:56:34'),
(76, 't@gmail.com', 'cash_in', 'Salary', '2025-05-31', 'Monnthly', 1000.00, '2025-09-02 07:06:24'),
(77, '143@gmail.com', 'cash_in', 'Business', '2025-09-02', 'Land', 1000.00, '2025-09-02 07:34:01'),
(78, 'sas@gmail.com', 'cash_in', 'Business', '2025-09-02', 'Gudo are', 20000.00, '2025-09-02 07:35:12'),
(79, 'sas@gmail.com', 'cash_out', 'Food', '2025-09-02', 'Egg', 120.00, '2025-09-02 07:35:36'),
(80, 'sasi@gmail.com', 'cash_in', 'Business', '2025-09-02', 'Shop income', 100000.00, '2025-09-02 07:45:14'),
(81, 'sasi@gmail.com', 'cash_out', 'Travel', '2025-09-02', 'Kerala trip', 50000.00, '2025-09-02 07:45:33'),
(82, 'lav@gmail.com', 'cash_in', 'Salary', '2025-09-02', 'Tution', 2500.00, '2025-09-02 07:57:31'),
(83, 'lav@gmail.com', 'cash_out', 'Travel', '2025-09-02', 'Kerela', 12000.00, '2025-09-02 07:57:57'),
(84, 'lav@gmail.com', 'cash_in', 'Salary', '2025-09-05', 'Jkjkj', 123.00, '2025-09-05 06:54:42'),
(85, 'lav@gmail.com', 'cash_in', 'Salary', '2025-09-11', '', 200000.00, '2025-09-11 05:32:20'),
(86, '741@gmail.com', 'cash_in', 'Salary', '2025-09-11', '', 200000.00, '2025-09-11 05:33:36'),
(87, '741@gmail.com', 'cash_in', 'Loan', '2025-09-11', '', 50000.00, '2025-09-11 05:33:59'),
(88, '741@gmail.com', 'cash_in', 'Salary', '2025-09-11', '', 51650.00, '2025-09-11 05:34:25'),
(89, '741@gmail.com', 'cash_out', 'Travel', '2025-09-11', '', 1613.00, '2025-09-11 05:34:46'),
(90, '098@gmail.com', 'cash_in', 'Salary', '2025-09-11', '', 15000.00, '2025-09-11 05:53:25'),
(91, '098@gmail.com', 'cash_out', 'Food', '2025-09-11', '', 150.00, '2025-09-11 05:53:38');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`) VALUES
(1, 'lav', 'lavanya@gmail.com', '$2y$10$8A4wk7OxLQ3cJWuHtdOjoe.66o3qehKZ4un6KUKE.Q8ysm/kw9qGe', '2025-05-31 05:14:18'),
(2, 'pome', 'harini@gmail.com', '$2y$10$FC48TPKOGgPqoaL9f.FAauDZtDXTl4FPcdkcW8glVQGr5ZyoC7Rei', '2025-05-31 05:14:34'),
(3, 'pome', 'h1@gmail.com', '$2y$10$QYI5QhOuLv81WjJo1eZEMuLNghOsPfRbS/rxmX13d44k5GTzfL4UG', '2025-05-31 05:28:59'),
(4, 'l', 'l@gmail.com', '$2y$10$6CzwFqh8ME/HPQ/Lug8ptO9ggV7ONbHXP5laBl237FZaVQr87wdVC', '2025-06-02 09:07:58'),
(5, 'lav@gmail.com', 'lav@gmail.com', '$2y$10$iY6m6PVMvgcU/b5Ik14lLOxeymYpC.eLDy62hPTBrjznwHf49EFJq', '2025-06-02 09:17:35'),
(6, '1', '1@gmail.com', '$2y$10$21cNB7zqHwZe8boetu73R.OzGFJIfP3dNQo1kUTVCvL8KYXS69.nO', '2025-08-18 03:26:45'),
(7, 'varshini', 'varshakiruthika6153@gmail.com', '$2y$10$P3cCZiSRCgxHhCpdNi9euuXST77qxHbQpQCh9xixGz6Kw9FNaPRdG', '2025-08-20 08:16:40'),
(8, 'l', 'l2@gmail.com', '$2y$10$m/aG8P2.ywW.7NMjnsbOceUvGb2Vp9OjPke8gJdvWtVqiwLbMl.ku', '2025-08-21 03:30:03'),
(9, 'rah@gmail.com', 'rah@gmail.com', '$2y$10$CHQLJZSHewSY47zTR51r6O6CxjpiHkXAC0epQFNOR1g5vmNCjQatS', '2025-08-23 05:09:30'),
(10, '123', '123@gmail.com', '$2y$10$YekMATh7QE8URo/YA1XU1OXdUmWE2XK1y2bkR1iTd0v6XwIsojcsC', '2025-08-23 10:28:12'),
(11, '1234', '1234@gmail.com', '$2y$10$dSKAU0tPMLVl/Dug0JxD7.s5uJF/tUy8LyTQzgOTzufFgCZ5jofUu', '2025-08-26 03:53:57'),
(12, 'test', 'test@gmail.com', '$2y$10$39yqudV/Reuw85k4NIZJ1ulrhsnnxy0juTCYcEbaPX4dmXu9z.Bw.', '2025-08-26 04:00:39'),
(13, 'test', 'tes@gmail.com', '$2y$10$IloTU1IBPBv/s1CAHgSdmuFnMaogMnc2RLEGx9wvsiyLV/6AGZZsK', '2025-08-26 04:02:59'),
(14, '`test', 'user@gmail.com', '$2y$10$fvYc8hoes6Zr6aOog3ee7eTRJ5yjm/QjnVGrQF1TkS6n2M.AiO9y.', '2025-08-26 04:05:49'),
(15, 'reddy', 'reddy@gmail.com', '$2y$10$RqG6V.kknc.kwQuaLLwN4eOo.GTzVctWMGlXRwBU4WbDKSCS1I7pe', '2025-08-26 04:07:25'),
(16, '11', '11@gmail.com', '$2y$10$9KZS4ASn459tHThXj4Hq7u/OemjCfrYuSAWOuYMmHj5uwQmp1fsza', '2025-09-02 06:42:04'),
(17, 'h', '9@gmail.com', '$2y$10$U8IEAquao7aQs3KLUwdTWuenMwj6r1Am18aj8WIQFFe3SfdOl5gTm', '2025-09-02 06:56:07'),
(18, 't', 't@gmail.com', '$2y$10$cAZPSexy.0TjnKhVt1/8qeU.nVATstBXWrC31/2ZPTvcpu7qgiYom', '2025-09-02 07:01:17'),
(19, '143', '143@gmail.com', '$2y$10$Q91F0xajvuMY1QC7ySeLqemeyyMmQ178KBiqhsRtIQpG/TLgk73v.', '2025-09-02 07:33:08'),
(20, 'sas', 'sas@gmail.com', '$2y$10$UPzvfNYMLtJPRbmYPuqDIOAxS8qkaOYg9xHFcDRc3r0nrhTNd.wrW', '2025-09-02 07:34:53'),
(21, 'sasi', 'sasi@gmail.com', '$2y$10$3C0A9FbUgZo8CLVsB/JzIeJ34WsheN0K09.vhVP1fS7Md77ZdH.L2', '2025-09-02 07:44:44'),
(22, 'harini', '741@gmail.com', '$2y$10$CKBs2kc0ZEV7G4ZAnXfvS.RHZNDv3riFWx54caplR8BCTTDDDdaBS', '2025-09-11 05:33:15'),
(23, '098', '098@gmail.com', '$2y$10$yCE63n9yP8Lm8GLZgF46xeaCAu/SAR8Szv6P1A/iu8m1tsFRtXDsi', '2025-09-11 05:53:13');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `app_feedback`
--
ALTER TABLE `app_feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_feedback`
--
ALTER TABLE `app_feedback`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
