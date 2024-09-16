-- CreateTable
CREATE TABLE `Users` (
    `user_id` INTEGER NOT NULL AUTO_INCREMENT,
    `firstname` VARCHAR(150) NOT NULL,
    `lastname` VARCHAR(150) NOT NULL,
    `email` VARCHAR(150) NOT NULL,
    `password` VARCHAR(120) NOT NULL,
    `profile` VARCHAR(150) NOT NULL DEFAULT 'default-profile.jpg',
    `role` ENUM('USER', 'ADMIN') NOT NULL DEFAULT 'USER',
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `Users_email_key`(`email`),
    PRIMARY KEY (`user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Books` (
    `book_id` INTEGER NOT NULL AUTO_INCREMENT,
    `th_name` VARCHAR(150) NOT NULL,
    `eng_name` VARCHAR(150) NOT NULL,
    `color` VARCHAR(50) NOT NULL,
    `book_image` VARCHAR(100) NOT NULL,
    `type` ENUM('data', 'topic') NOT NULL DEFAULT 'data',
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`book_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `BookContents` (
    `content_id` INTEGER NOT NULL AUTO_INCREMENT,
    `book_id` INTEGER NOT NULL,
    `content` JSON NOT NULL,
    `type` ENUM('data', 'topic') NOT NULL DEFAULT 'data',
    `created_at` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    UNIQUE INDEX `BookContents_book_id_key`(`book_id`),
    PRIMARY KEY (`content_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `BookContents` ADD CONSTRAINT `BookContents_book_id_fkey` FOREIGN KEY (`book_id`) REFERENCES `Books`(`book_id`) ON DELETE RESTRICT ON UPDATE CASCADE;
