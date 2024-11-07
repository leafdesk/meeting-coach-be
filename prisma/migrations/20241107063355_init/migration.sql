/*
  Warnings:

  - You are about to drop the `FaceAnalysis` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `MeetingInfo` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Quiz` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `VoiceAnalysis` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "FaceAnalysis";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "MeetingInfo";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Quiz";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "User";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "VoiceAnalysis";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "users" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "voice_url" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "meeting_info" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "meetingDate" DATETIME NOT NULL,
    "video_url" TEXT NOT NULL,
    "summary" TEXT NOT NULL,
    "participant_list" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "quiz" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "meeting_info_meeting_id" INTEGER NOT NULL,
    "question" TEXT NOT NULL,
    "option" TEXT NOT NULL,
    "correct_answer" INTEGER NOT NULL,
    CONSTRAINT "quiz_meeting_info_meeting_id_fkey" FOREIGN KEY ("meeting_info_meeting_id") REFERENCES "meeting_info" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "voice_analysis" (
    "meeting_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "voiceEmotion" TEXT NOT NULL,
    "interruptCount" INTEGER NOT NULL,

    PRIMARY KEY ("meeting_id", "user_id"),
    CONSTRAINT "voice_analysis_meeting_id_fkey" FOREIGN KEY ("meeting_id") REFERENCES "meeting_info" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "voice_analysis_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "face_analysis" (
    "meeting_info_meeting_id" INTEGER NOT NULL,
    "user_userID" INTEGER NOT NULL,
    "faceEmotion" TEXT NOT NULL,

    PRIMARY KEY ("meeting_info_meeting_id", "user_userID"),
    CONSTRAINT "face_analysis_meeting_info_meeting_id_fkey" FOREIGN KEY ("meeting_info_meeting_id") REFERENCES "meeting_info" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "face_analysis_user_userID_fkey" FOREIGN KEY ("user_userID") REFERENCES "users" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
