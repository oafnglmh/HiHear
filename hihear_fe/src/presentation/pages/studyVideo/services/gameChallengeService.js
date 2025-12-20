const CHALLENGE_QUESTIONS = [
  [
    {
      sentence: 'Xin ____, tôi tên là Hoai',
      options: ['chào', 'tạm biệt', 'cảm ơn', 'xin lỗi'],
      correctAnswer: 'chào',
      translation: 'Hello, my name is Hoai',
    },
    {
      sentence: 'Hôm nay tôi ____ khỏe',
      options: ['rất', 'không', 'cũng', 'đang'],
      correctAnswer: 'rất',
      translation: 'Today I am very well',
    },
    {
      sentence: 'Tôi muốn ____ cà phê',
      options: ['uống', 'ăn', 'nghe', 'đọc'],
      correctAnswer: 'uống',
      translation: 'I want to drink coffee',
    },
  ],
  [
    {
      sentence: 'Bạn ____ từ đâu đến?',
      options: ['đến', 'đi', 'về', 'ra'],
      correctAnswer: 'đến',
      translation: 'Where do you come from?',
    },
    {
      sentence: 'Tôi thích ____ tiếng Việt',
      options: ['học', 'dạy', 'nghe', 'nói'],
      correctAnswer: 'học',
      translation: 'I like to learn Vietnamese',
    },
    {
      sentence: 'Hà Nội là thủ ____ của Việt Nam',
      options: ['đô', 'phố', 'thành', 'quận'],
      correctAnswer: 'đô',
      translation: 'Hanoi is the capital of Vietnam',
    },
  ],
  [
    {
      sentence: 'Gia đình tôi có ____ người',
      options: ['bốn', 'một', 'nhiều', 'ít'],
      correctAnswer: 'bốn',
      translation: 'My family has four people',
    },
    {
      sentence: 'Mùa hè ở Việt Nam rất ____',
      options: ['nóng', 'lạnh', 'mát', 'ấm'],
      correctAnswer: 'nóng',
      translation: 'Summer in Vietnam is very hot',
    },
    {
      sentence: 'Tôi ____ đi du lịch Đà Nẵng',
      options: ['muốn', 'phải', 'nên', 'có thể'],
      correctAnswer: 'muốn',
      translation: 'I want to travel to Da Nang',
    },
  ],
];

export const getGateChallenge = (gateIndex) => {
  const gateQuestions = CHALLENGE_QUESTIONS[gateIndex] || CHALLENGE_QUESTIONS[0];
  const randomIndex = Math.floor(Math.random() * gateQuestions.length);
  
  return {
    ...gateQuestions[randomIndex],
    gateNumber: gateIndex + 1,
  };
};