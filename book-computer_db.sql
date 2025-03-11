-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: mariadb
-- Generation Time: Mar 11, 2025 at 07:47 PM
-- Server version: 10.11.11-MariaDB-ubu2204
-- PHP Version: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `book-computer_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `BookContents`
--

CREATE TABLE `BookContents` (
  `content_id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`content`)),
  `type` enum('data','topic') NOT NULL DEFAULT 'data',
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `BookContents`
--

INSERT INTO `BookContents` (`content_id`, `book_id`, `content`, `type`, `created_at`) VALUES
(3, 3, '[{\"text\":\"• คอมพิวเตอร์ มาจากภาษาละตินว่า Computareซึ่งหมายถึง เครื่องมืออิเล็กทรอนิกส์ที่ใช้กระแสไฟฟ้าในการทำงาน ซึ่งสามารถนำมาประยุกต์ใช้งานในการแก้ปัญหาที่ง่ายและซับซ้อน โดยวิธีทางคณิตศาสตร์ เพื่อช่วยให้การทำงานรวดเร็ว ถูกต้อง แม่นยำ \\n• มีหน่วยประมวลผลกลาง (Central Processing Unit : CPU) ซึ่งเปรียบเสมือนสมองกลที่มีความสามารถในการคำนวณและประมวลผลข้อมูลตามชุดคำสั่ง \\n• เทคโนโลยีสารสนเทศ (Information Technology : IT) หมายถึง คอมพิวเตอร์ที่มีการเชื่อมโยงเข้ากับระบบสื่อสารความเร็วสูงเพื่อนำส่งข้อมูล\\n• เทคโนโลยีทางคอมพิวเตอร์ \\n• เทคโนโลยีด้านการสื่อสาร\",\"image\":\"/content_images/1726436778374-content_image_0.jpeg\"}]', 'data', '2024-09-15 21:46:18.377'),
(4, 4, '[{\"text\":\"● งานด้านวิทยาศาสตร์เราสามารถนำคอมพิวเตอร์มาใช้ประโยชน์เกี่ยวกับการคำนวณที่ค่อนข้างซับซ้อน งานศึกษาโมเลกุลเคมี หรืองานทะเบียน สถิต\\n● งานด้านการแพทย์เป็นอุปกรณ์ในการตรวจรักษาโรคซึ่งจะให้ผลที่แม่นยำและยังทำให้การรักษาเป็นไปได้\\n● งานธุรกิจงานอุตสาหกรรม จะนำคอมพิวเตอร์มาใช้ในการควบคุมการผลิต เช่น การใช้หุ่นยนต์หรือ คอมพิวเตอร์มาควบคุมการผลิต\\n● งานด้านบันเทิงและธุรกิจโฆษณาเราได้นำคอมพิวเตอร์มาใช้ประโยชน์ในการสร้างภาพยนตร์ เพลง หนังสือ สิ่งพิมพ์โฆษณา ผลิตสื่อต่าง ๆ\",\"image\":\"/content_images/1726437053719-content_image_0.jpeg\"},{\"text\":\"• กราฟิก ตกแต่งภาพให้คมชัด\\n• การค้า รหัสแถบแท่ง\\n• พลังงาน สำรวจหาแหล่งน้ำมัน\\n• การขนส่ง การจองตั๋ว\\n• งานหนังสือพิมพ์พิมพ์แก้ไข\\n• การเงิน เครื่อง ATM\\n• การเกษตร ตรวจสอบราคาตลาด\\n• รัฐบาล การพยากรณ์อากาศ\\n• การศึกษา การเตรียมเอกสารบรรยาย\\n• ในบ้าน การเขียนจดหมาย\\n• สุขภาพและการแพทย์การทดสอบ\\n• หุ่นยนต์ทำงานในโรงงาน\\n• วิทยาศาสตร์การคำนวณ\\n• การฝึกอบรม การฝึกอบรมนักบิน\\n• การติดต่อของมนุษย์ช่วยคนที่พิการ\",\"image\":\"/content_images/1726437053720-content_image_1.jpeg\"}]', 'data', '2024-09-15 21:50:53.725'),
(6, 6, '[{\"text\":\"ลักษณะการทำงานพื้นฐาน 4 อย่าง (IPOS cycle) ของคอมพิวเตอร์ จะประกอบไปด้วยดังนี้\\n1. การรับข้อมูลขาเข้า (Input)\\nข้อมูลขาเข้าคือคุณสมบัติในการรับข้อมูลจากอุปกรณ์ต่าง ๆ ที่มีการติดตั้งหน่วยรับข้อมูล ให้สามารถเชื่อมการทำงานกับคอมพิวเตอร์ได้ ไม่ว่าจะเป็นอุปกรณ์เชื่อมต่อทั่วไป อาทิเช่น เมาส์ คีย์บอร์ด หรืออุปกรณ์เฉพาะทางชนิดอื่น ๆ\\n\\n2. ความสามารถในการประมวลผล (Processing)\\nการประมวลผล คือการนำเอาข้อมูลไม่ว่าจะเป็นข้อมูลจากอุปกรณ์เชื่อมต่อ หรือข้อมูลจากการส่งคำสั่งผ่านคีย์บอร์ดหรือปุ่มควบคุมสั่งการที่ติดตั้งมาพร้อมกับเครื่องคอมพิวเตอร์ นำเอาข้อมูลนั้นมาคำนวณตามหลักการคำนวณที่โปรแกรมเอาไว้ ซึ่งจะทำให้ได้ผลลัพท์ออกมาตามสูตรคำนวณ โดยมีการนำมาใช้ในการประมวลผลหลายจุดประสงค์ เช่น การคำนวณเพื่อหาผลลัพท์ทางคณิตศาสตร์ หรือการคำนวณเพื่อแสดงผลออกมาเป็นภาพ แสงสีเสียง เป็นต้น\\n\\n3. ความสามารถในการแสดงผล (Output)\\nขั้นตอนการแสดงผลคือขั้นตอนที่อาศัยข้อมูล จากการประมวลผลนำมาแสดงภายใต้ข้อกำหนดของโปรแกรม หรือเงื่อนไขของอุปกรณ์รองรับการแสดงผล หรือส่งต่อข้อมูลรหัส เพื่อให้อุปกรณ์แสดงผลที่เชื่อมต่อกับคอมพิวเตอร์ สามารถนำไปประยุกต์การแสดงผลตามความสามารถและเทคโนโลยีของอุปกรณ์ได้\\n\\n4. การเก็บข้อมูล (Storage)\\nการเก็บข้อมูลเป็นคุณสมบัติเด่น ที่ได้รับความนิยมใช้งานเครื่องคอมพิวเตอร์มากที่สุด แม้แต่ผู้ที่ไม่มีทักษะในการใช้งานคอมพิวเตอร์มากนัก ก็ได้อาศัยความสามารถในเชิงเก็บข้อมูล เพื่อเก็บบันทึกข้อมูลต่าง ๆ ที่ต้องการเก็บเอาไว้และนอกจากความสามารถในการเก็บข้อมูลแล้ว ระบบหน่วยความจำของคอมพิวเตอร์ ยังจะต้องรับหน้าที่ในการเก็บผลลัพธ์จากการประมวลผลชั่วคราว ที่เกิดขึ้นจากการรันระบบปฏิบัติการหรือโปรแกรม ซึ่งมีการบันทึกข้อมูลชั่วคราว เพื่อนำมาเข้าสู่กระบวนการประมวลผลที่ซับซ้อนอย่างรวดเร็ว ซึ่งต้องขึ้นอยู่กับสมรรถนะความสามารถ ของโครงสร้างคอมพิวเตอร์แต่ละเครื่องเป็นหลัก\",\"image\":\"/content_images/1726437317868-content_image_0.jpeg\"}]', 'data', '2024-09-15 21:55:17.898'),
(7, 7, '[{\"text\":\"● ความเร็ว (speed) : ในการทำงานตามคำสั่งในหนึ่งวินาที\\n● ความเชื่อถือได้(reliable) : เชื่อถือได้ว่า ทำงานทุกคำสั่ง ทุกเวลาที่สั่ง\\n● ความถูกต้องแม่นยำ (accurate) : ผลลัพธ์ของการ ทำงาน จะคงที่ เป็นเช่นเดิมเสมอ ไม่เปลี่ยนแปลง\\n● เก็บข้อมูลจำนวนมากๆได้ (store massive amounts of information) : ความต้องการพื้นฐานในการทำงาน\\n● ย้ายข้อมูลจากที่หนึ่งไปยังอีกที่หนึ่งได้ (move information) : Disk, CD, Network \",\"image\":\"/content_images/1726438307280-content_image_0.jpeg\"},{\"text\":\"ข้อดีของคอมพิวเตอร์\\n● ผลผลิตมาก (Productivity)\\n● ประกอบการตัดสินใจ (Decision Making)\\n● ลดค่าใช้จ่าย (Cost Reduction)\\n● ง่ายต่อการติดต่อสื่อสาร (Easy Communication)\\n● เพิ่มประสิทธิภาพในการทำงาน (Work Efficiency)\\n● ตอบสนองความต้องการ (Satisfaction)\\n● ไม่ลำเอียง (Satisfaction)\\n● ไม่จำกัดสถานที่ (Portability)\",\"image\":\"/content_images/1726438307283-content_image_1.jpeg\"},{\"text\":\"ข้อเสียของคอมพิวเตอร์\\n● ขึ้นกับผู้เขียนโปรแกรม\\n● ใช้เวลาในการเรียนรู้\\n● แย่งงาน / แทนที่การทำงานของมนุษย์\\n● เกิดการเปลี่ยนแปลงทางสังคมอย่างรวดเร็ว\\n● สร้างพฤติกรรมก้าวร้าว\\n● ปัญหาสุขภาพ\\n● ข่าวสารข้อมูลมีมากเกินไป (Information Flood)\\n● การรับข่าวสารเก่าและการเข้าถึงข่าวสาร\\n● ปัญหาผู้ก่อความไม่สงบ\",\"image\":\"/content_images/1726438307284-content_image_2.jpeg\"}]', 'data', '2024-09-15 22:11:47.311'),
(8, 8, '[{\"sections\":[{\"content\":[{\"imageCredit\":{\"des\":\"ภาพที่  5-12  ยกคานล็อคขึ้น\",\"ref\":\"(ที่มา  :  มานพ ฉิมมา, 2566)\"},\"text\":\"     1) ยกคานล็อคขึ้นตรง ๆ เพื่อปลดล็อคที่ตัวซ็อกเก็ต LGA 1366\",\"image\":\"/content_images/1726441550897-chapter_image_0_0_0.jpeg\"},{\"imageCredit\":{\"des\":\"ภาพที่  5-13  ยกแผ่นเหล็กที่ครอบซ็อกเก็ต\",\"ref\":\"(ที่มา  :  มานพ ฉิมมา, 2566)\"},\"text\":\"2) ยกแผ่นเหล็กที่ครอบซ็อกเก็ตขึ้น เพื่อเตรียมการติดตั้งซีพียูบนซ็อกเก็ต LGA 1366\",\"image\":\"/content_images/1726441550898-chapter_image_0_0_1.jpeg\"},{\"imageCredit\":{\"des\":\"ภาพที่  5-14  วางซีพียูในซ๊อกเก็ต\",\"ref\":\"(ที่มา  :  มานพ ฉิมมา, 2566)\"},\"text\":\"3) บนซ็อกเก็ต  LGA  1366 และตำแหน่งขาที่  1  บนตัวซีพียู โดยจะมีรูปสามเหลี่ยม\\nสีเหลือง ระบุไว้ตรงมุมของซีพียู แล้ววางตัวซีพียูลงบนซ็อกเก็ต โดยดูตำแหน่งขาที่ 1  ให้ตรงกัน ระวังอย่าให้มีการกระแทกหรือกดบนตัวซ็อกเก็ต  LGA  1366  เพราะอาจส่งผลให้ขาที่ตัวซ็อกเก็ตหักหรืองอได้\",\"image\":\"/content_images/1726441550899-chapter_image_0_0_2.jpeg\"},{\"imageCredit\":{\"des\":\"ภาพที่  5-15  ปิดแผ่นเหล็ก\",\"ref\":\"(ที่มา  :  มานพ ฉิมมา, 2566)\"},\"text\":\"4) วางแผ่นเหล็กครอบลงไปบนตัวซีพียู โดยไม่ต้องออกแรงกดบนตัวซีพียู\",\"image\":\"/content_images/1726441550900-chapter_image_0_0_3.jpeg\"},{\"imageCredit\":{\"des\":\"ภาพที่  5-16 ยกคานเหล็กลง\",\"ref\":\"(ที่มา  :  มานพ ฉิมมา, 2566)\"},\"text\":\"5) ดันคานล็อคลงไปยึดกับตัวซ็อกเก็ตเหมือนเดิม โดยออกแรงกดอย่างระมัดระวัง \\nเพื่อป้องกันไม่ให้ขาของซ็อกเก็ตเสียหาย\",\"image\":\"/content_images/1726441550900-chapter_image_0_0_4.jpeg\"}],\"title\":\"การติดตั้งซีพียูของ Intel Socket 1366\"},{\"content\":[{\"imageCredit\":{\"des\":\"ภาพที่  5-17  ซิลิโคนบนฮีตซิงค์\",\"ref\":\"(ที่มา  :  มานพ ฉิมมา, 2566)\"},\"text\":\"1) ก่อนติดตั้งฮีตซิงค์ ให้ตรวจดูที่ตัวฮีตซิงค์ มีซิลิโคนติดให้มาหรือไม่ ถ้าไม่มีให้ทาซิลิโคนลงบนหลังซีพียู การวางฮีตซิงค์ไปบนเมนบอร์ด โดยให้ทั้ง 4 มุมให้พอดีกับช่องบนเมนบอร์ด\",\"image\":\"/content_images/1726441550901-chapter_image_0_1_0.jpeg\"},{\"imageCredit\":{\"des\":\"ภาพที่  5-18  ซิลิโคนบนซีพียู\",\"ref\":\"(ที่มา  :  มานพ ฉิมมา, 2566)\"},\"text\":\"2) วางฮีตซิงค์บนตัวซีพียู  ซิลิโคนจะติดกับตัวซีพียูบางส่วน\",\"image\":\"/content_images/1726441550902-chapter_image_0_1_1.jpeg\"},{\"imageCredit\":{\"des\":\"ภาพที่  5-18  รูล๊อคฮีตซิงค์\",\"ref\":\"(ที่มา  :  มานพ ฉิมมา, 2566)\"},\"text\":\"3) เสียบขาล็อคของฮีตซิงค์มาติดตั้งลงในรูบนเมนบอร์ด\",\"image\":\"/content_images/1726441550902-chapter_image_0_1_2.jpeg\"},{\"imageCredit\":{\"des\":\"ภาพที่  5-19  ล็อคฮีตซิงค์\",\"ref\":\"(ที่มา  :  มานพ ฉิมมา, 2566)\"},\"text\":\"4) กดตัวล็อคให้กด 2 มุมตรงข้าพร้อมกัน แล้วสังเกตใต้เมนบอร์ดว่าขาล็อคเรียบร้อย\\n\",\"image\":\"/content_images/1726441550904-chapter_image_0_1_3.jpeg\"},{\"imageCredit\":{\"des\":\"ภาพที่  5-20  ลูกศรขณะล๊อค\\n\",\"ref\":\"(ที่มา  :  มานพ ฉิมมา, 2566)\"},\"text\":\"5) เมื่อล็อคแล้วลูกศรบนตัวล็อคจะอยู่ดังภาพ\",\"image\":\"/content_images/1726441550907-chapter_image_0_1_4.jpeg\"},{\"imageCredit\":{\"des\":\"ภาพที่  5-21  สายไฟเชื่อมพัดลม\",\"ref\":\"(ที่มา  :  มานพ ฉิมมา, 2566)\"},\"text\":\"6) จากนั้นต่อสายไฟเพื่อเชื่อมต่อเข้ากับเมนบอร์ด  เพื่อให้พัดลมฮีตซิงค์ทำงาน\\n\",\"image\":\"/content_images/1726441550908-chapter_image_0_1_5.jpeg\"}],\"title\":\"การติดตั้งฮีตซิงค์\"}],\"chapter\":\"บทที่ 5\",\"label\":\"การประกอบเครื่องคอมพิวเตอร์\"}]', 'topic', '2024-09-15 23:05:50.955');

-- --------------------------------------------------------

--
-- Table structure for table `Books`
--

CREATE TABLE `Books` (
  `book_id` int(11) NOT NULL,
  `th_name` varchar(150) NOT NULL,
  `eng_name` varchar(150) NOT NULL,
  `color` varchar(50) NOT NULL,
  `book_image` varchar(100) NOT NULL,
  `type` enum('data','topic') NOT NULL DEFAULT 'data',
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Books`
--

INSERT INTO `Books` (`book_id`, `th_name`, `eng_name`, `color`, `book_image`, `type`, `created_at`) VALUES
(3, 'ความหมายของคอมพิวเตอร์และเทคโนโลยีสารสนเทศ', 'Meaning Of Computer And Lnformation Technology', 'blue', '/book_images/1726436778232-book_image.jpeg', 'data', '2024-09-15 21:46:18.240'),
(4, 'การใช้งานคอมพิวเตอร์ในปัจจุบัน', 'Current Computer Usage', 'sky', '/book_images/1726437053465-book_image.jpeg', 'data', '2024-09-15 21:50:53.480'),
(6, 'การทำงานของคอมพิวเตอร์', 'Computer Operation', 'cyan', '/book_images/1726437317663-book_image.jpeg', 'data', '2024-09-15 21:55:17.676'),
(7, 'คุณสมบัติของคอมพิวเตอร์', 'Computer Features', 'blue', '/book_images/1726438307070-book_image.jpeg', 'data', '2024-09-15 22:11:47.085'),
(8, 'คอมพิวเตอร์และการบำรุงรักษา', 'Computers and Maintenance', 'pink', '/book_images/1726441550228-book_image.jpeg', 'topic', '2024-09-15 23:05:50.245');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `user_id` int(11) NOT NULL,
  `firstname` varchar(150) NOT NULL,
  `lastname` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(120) NOT NULL,
  `profile` varchar(150) NOT NULL DEFAULT 'default-profile.jpg',
  `role` enum('USER','ADMIN') NOT NULL DEFAULT 'USER',
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`user_id`, `firstname`, `lastname`, `email`, `password`, `profile`, `role`, `created_at`) VALUES
(1, 'admin', 'admin', 'admin@admin.com', '$argon2id$v=19$m=65536,t=2,p=1$ulKtCQtZjIYjJELT6WhyIwzRGbZsp3CuDqKwE480UJE$jpjt8aq/8o6v4lQa+XDnqo2L+OLXDQmgCpFNSWIU9LY', 'default-profile.jpg', 'ADMIN', '2024-09-15 14:07:34.621');

-- --------------------------------------------------------

--
-- Table structure for table `_prisma_migrations`
--

CREATE TABLE `_prisma_migrations` (
  `id` varchar(36) NOT NULL,
  `checksum` varchar(64) NOT NULL,
  `finished_at` datetime(3) DEFAULT NULL,
  `migration_name` varchar(255) NOT NULL,
  `logs` text DEFAULT NULL,
  `rolled_back_at` datetime(3) DEFAULT NULL,
  `started_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `applied_steps_count` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `_prisma_migrations`
--

INSERT INTO `_prisma_migrations` (`id`, `checksum`, `finished_at`, `migration_name`, `logs`, `rolled_back_at`, `started_at`, `applied_steps_count`) VALUES
('ca9ae202-dd93-4791-99e1-6e5f383092bd', 'f83caba52b7ee10db221e0e1174efef5b16ba5507d20cecb616ccdc6194398c4', '2024-09-15 13:55:22.874', '20240915135522_init', NULL, NULL, '2024-09-15 13:55:22.861', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `BookContents`
--
ALTER TABLE `BookContents`
  ADD PRIMARY KEY (`content_id`),
  ADD UNIQUE KEY `BookContents_book_id_key` (`book_id`);

--
-- Indexes for table `Books`
--
ALTER TABLE `Books`
  ADD PRIMARY KEY (`book_id`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `Users_email_key` (`email`);

--
-- Indexes for table `_prisma_migrations`
--
ALTER TABLE `_prisma_migrations`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `BookContents`
--
ALTER TABLE `BookContents`
  MODIFY `content_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `Books`
--
ALTER TABLE `Books`
  MODIFY `book_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `BookContents`
--
ALTER TABLE `BookContents`
  ADD CONSTRAINT `BookContents_book_id_fkey` FOREIGN KEY (`book_id`) REFERENCES `Books` (`book_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
