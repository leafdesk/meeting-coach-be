/*
  Warnings:

  - You are about to drop the `users` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "users";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "user" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "voice_url" TEXT NOT NULL
);

-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_face_analysis" (
    "meeting_info_meeting_id" INTEGER NOT NULL,
    "user_userID" INTEGER NOT NULL,
    "faceEmotion" TEXT NOT NULL,

    PRIMARY KEY ("meeting_info_meeting_id", "user_userID"),
    CONSTRAINT "face_analysis_meeting_info_meeting_id_fkey" FOREIGN KEY ("meeting_info_meeting_id") REFERENCES "meeting_info" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "face_analysis_user_userID_fkey" FOREIGN KEY ("user_userID") REFERENCES "user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_face_analysis" ("faceEmotion", "meeting_info_meeting_id", "user_userID") SELECT "faceEmotion", "meeting_info_meeting_id", "user_userID" FROM "face_analysis";
DROP TABLE "face_analysis";
ALTER TABLE "new_face_analysis" RENAME TO "face_analysis";
CREATE TABLE "new_voice_analysis" (
    "meeting_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "voiceEmotion" TEXT NOT NULL,
    "interruptCount" INTEGER NOT NULL,

    PRIMARY KEY ("meeting_id", "user_id"),
    CONSTRAINT "voice_analysis_meeting_id_fkey" FOREIGN KEY ("meeting_id") REFERENCES "meeting_info" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "voice_analysis_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_voice_analysis" ("interruptCount", "meeting_id", "user_id", "voiceEmotion") SELECT "interruptCount", "meeting_id", "user_id", "voiceEmotion" FROM "voice_analysis";
DROP TABLE "voice_analysis";
ALTER TABLE "new_voice_analysis" RENAME TO "voice_analysis";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
