-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "voice_url" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "MeetingInfo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "title" TEXT NOT NULL,
    "meetingDate" DATETIME NOT NULL,
    "video_url" TEXT NOT NULL,
    "summary" TEXT NOT NULL,
    "participant_list" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Quiz" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "meeting_info_meeting_id" INTEGER NOT NULL,
    "question" TEXT NOT NULL,
    "option" TEXT NOT NULL,
    "correct_answer" INTEGER NOT NULL,
    CONSTRAINT "Quiz_meeting_info_meeting_id_fkey" FOREIGN KEY ("meeting_info_meeting_id") REFERENCES "MeetingInfo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "VoiceAnalysis" (
    "meeting_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "voiceEmotion" TEXT NOT NULL,
    "interruptCount" INTEGER NOT NULL,

    PRIMARY KEY ("meeting_id", "user_id"),
    CONSTRAINT "VoiceAnalysis_meeting_id_fkey" FOREIGN KEY ("meeting_id") REFERENCES "MeetingInfo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "VoiceAnalysis_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "FaceAnalysis" (
    "meeting_info_meeting_id" INTEGER NOT NULL,
    "user_userID" INTEGER NOT NULL,
    "faceEmotion" TEXT NOT NULL,

    PRIMARY KEY ("meeting_info_meeting_id", "user_userID"),
    CONSTRAINT "FaceAnalysis_meeting_info_meeting_id_fkey" FOREIGN KEY ("meeting_info_meeting_id") REFERENCES "MeetingInfo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "FaceAnalysis_user_userID_fkey" FOREIGN KEY ("user_userID") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
