/*
  Warnings:

  - You are about to drop the `face_analysis` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `meeting_info` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `voice_analysis` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `correct_answer` on the `quiz` table. All the data in the column will be lost.
  - You are about to drop the column `meeting_info_meeting_id` on the `quiz` table. All the data in the column will be lost.
  - You are about to drop the column `option` on the `quiz` table. All the data in the column will be lost.
  - Added the required column `answer` to the `quiz` table without a default value. This is not possible if the table is not empty.
  - Added the required column `meeting_id` to the `quiz` table without a default value. This is not possible if the table is not empty.
  - Added the required column `options` to the `quiz` table without a default value. This is not possible if the table is not empty.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "face_analysis";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "meeting_info";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "voice_analysis";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "meeting" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "organizer" TEXT NOT NULL,
    "file_path" TEXT,
    "summary" TEXT
);

-- CreateTable
CREATE TABLE "participants" (
    "meeting_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,

    PRIMARY KEY ("meeting_id", "user_id"),
    CONSTRAINT "participants_meeting_id_fkey" FOREIGN KEY ("meeting_id") REFERENCES "meeting" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "participants_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "voice_emotion" (
    "user_id" INTEGER NOT NULL,
    "meeting_id" INTEGER NOT NULL,
    "angry" REAL NOT NULL DEFAULT 0,
    "sad" REAL NOT NULL DEFAULT 0,
    "neutral" REAL NOT NULL DEFAULT 0,
    "happy" REAL NOT NULL DEFAULT 0,
    "interruption_count" INTEGER NOT NULL DEFAULT 0,

    PRIMARY KEY ("user_id", "meeting_id"),
    CONSTRAINT "voice_emotion_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "voice_emotion_meeting_id_fkey" FOREIGN KEY ("meeting_id") REFERENCES "meeting" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "facial_emotion" (
    "user_id" INTEGER NOT NULL,
    "meeting_id" INTEGER NOT NULL,
    "sad" REAL NOT NULL DEFAULT 0,
    "happy" REAL NOT NULL DEFAULT 0,
    "angry" REAL NOT NULL DEFAULT 0,
    "fear" REAL NOT NULL DEFAULT 0,
    "disgust" REAL NOT NULL DEFAULT 0,
    "neutral" REAL NOT NULL DEFAULT 0,

    PRIMARY KEY ("user_id", "meeting_id"),
    CONSTRAINT "facial_emotion_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "facial_emotion_meeting_id_fkey" FOREIGN KEY ("meeting_id") REFERENCES "meeting" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_quiz" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "meeting_id" INTEGER NOT NULL,
    "question" TEXT NOT NULL,
    "options" TEXT NOT NULL,
    "answer" TEXT NOT NULL,
    "hallucination_score" REAL,
    CONSTRAINT "quiz_meeting_id_fkey" FOREIGN KEY ("meeting_id") REFERENCES "meeting" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_quiz" ("id", "question") SELECT "id", "question" FROM "quiz";
DROP TABLE "quiz";
ALTER TABLE "new_quiz" RENAME TO "quiz";
CREATE TABLE "new_user" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "department" TEXT,
    "voice_url" TEXT
);
INSERT INTO "new_user" ("id", "name", "voice_url") SELECT "id", "name", "voice_url" FROM "user";
DROP TABLE "user";
ALTER TABLE "new_user" RENAME TO "user";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
