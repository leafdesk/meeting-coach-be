import { client, testClient } from './vmc-api-client'

/**
 * 테스트 모드 여부.
 */
const IS_TEST_MODE = true

/**
 * 서버에 요청 보내기.
 */
const fetchData = async (endpoint, data = null, method = 'POST') => {
  const clientInstance = IS_TEST_MODE ? testClient : client

  try {
    const config = {
      method,
      url: endpoint,
      ...(data && { data }),
    }

    const response = await clientInstance(config)
    return response.data
  } catch (error) {
    console.error(`Error fetching data from ${endpoint}:`, error)
    throw error
  }
}

/**
 * Health Check: GET /fastapi
 */
export const healthCheck = async () => {
  return fetchData('/fastapi', null, 'GET')
}

/**
 * Extract WAV from MP4: POST /fastapi/extract-wav
 */
export const extractWav = async (file) => {
  const formData = new FormData()
  formData.append('file', file)
  return fetchData('/fastapi/extract-wav', formData)
}

/**
 * Speaker Diarization: POST /fastapi/diarization
 */
export const diarization = async (wavFilePath, numSpeakers) => {
  return fetchData('/fastapi/diarization', {
    wav_file_path: wavFilePath,
    num_speakers: numSpeakers,
  })
}

/**
 * Speaker Audio Division: POST /fastapi/speaker-divide
 */
export const speakerDivide = async (diarizationExcel, wavFilePath) => {
  return fetchData('/fastapi/speaker-divide', {
    diarization_excel: diarizationExcel,
    wav_file_path: wavFilePath,
  })
}

/**
 * Speech to Text: POST /fastapi/speech-to-text
 */
export const speechToText = async (wavFilePath, diarizationExcel) => {
  return fetchData('/fastapi/speech-to-text', {
    wav_file_path: wavFilePath,
    diarization_excel: diarizationExcel,
  })
}

/**
 * Full Speech to Text: POST /fastapi/speech-to-text/full
 */
export const fullSpeechToText = async (wavFilePath) => {
  return fetchData('/fastapi/speech-to-text/full', {
    wav_file_path: wavFilePath,
  })
}

/**
 * Text Summarization: POST /fastapi/summarize
 */
export const summarizeText = async (filePath) => {
  return fetchData('/fastapi/summarize', {
    file_path: filePath,
  })
}

/**
 * Generate Quiz: POST /fastapi/generate-quiz
 */
export const generateQuiz = async (summaryText) => {
  return fetchData('/fastapi/generate-quiz', {
    summary_text: summaryText,
  })
}

/**
 * Speaker Verification: POST /fastapi/speaker-verification
 */
export const speakerVerification = async (audioFile1, audioFile2) => {
  return fetchData('/fastapi/speaker-verification', {
    audio_file1: audioFile1,
    audio_file2: audioFile2,
  })
}

/**
 * Audio Emotion Analysis: POST /fastapi/audio-emotion-analysis
 */
export const audioEmotionAnalysis = async (wavFilePath) => {
  return fetchData('/fastapi/audio-emotion-analysis', {
    wav_file_path: wavFilePath,
  })
}

/**
 * Video Emotion Analysis: POST /fastapi/video-emotion-analysis
 */
export const videoEmotionAnalysis = async (videoFilePath) => {
  return fetchData('/fastapi/video-emotion-analysis', {
    video_file_path: videoFilePath,
  })
}

/**
 * Timestamp Interrupt Detection: POST /fastapi/timestamp-interrupt
 */
export const timestampInterrupt = async (filePath) => {
  return fetchData('/fastapi/timestamp-interrupt', {
    file_path: filePath,
  })
}

/**
 * Generate Feedback: POST /fastapi/generate-feedback
 */
export const generateFeedback = async (text) => {
  return fetchData('/fastapi/generate-feedback', {
    text: text,
  })
}
