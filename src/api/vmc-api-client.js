import axios from 'axios'

/**
 * 실제 서버용 axios 인스턴스.
 */
export const client = axios.create({
  baseURL: 'http://3.38.135.174',
  timeout: 5000, // 타임아웃 설정 (선택사항)
  headers: {
    'Content-Type': 'application/json',
  },
})

/**
 * 테스트 서버용 axios 인스턴스.
 */
export const testClient = axios.create({
  baseURL: 'http://localhost:4000',
  timeout: 5000,
  headers: {
    'Content-Type': 'application/json',
  },
})

/**
 * 실제 서버용 인터셉터 설정.
 */
client.interceptors.request.use(
  (config) => {
    // 요청 전에 수행할 작업
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => {
    return Promise.reject(error)
  },
)

/**
 * 테스트 서버용 인터셉터 설정.
 */
testClient.interceptors.request.use(
  (config) => {
    // 요청 전에 수행할 작업
    const token = localStorage.getItem('token')
    if (token) {
      config.headers.Authorization = `Bearer ${token}`
    }
    return config
  },
  (error) => {
    return Promise.reject(error)
  },
)
