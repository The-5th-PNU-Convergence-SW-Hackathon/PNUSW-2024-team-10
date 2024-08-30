type GetDateTimeFunction = (date: Date) => string;

interface GetDateTime {
  ko: GetDateTimeFunction;
  en: GetDateTimeFunction;
}

function getDateTimeKO(date: Date): string {
  // YYYY년 M월 D일 H:MM
  const year = date.getFullYear();
  const month = date.getMonth() + 1;
  const day = date.getDate();
  const hour = date.getHours();
  const minute = date.getMinutes();

  // minute should be 2 digits
  const minuteFormatted = minute < 10 ? `0${minute}` : minute;

  return `${year}년 ${month}월 ${day}일 ${hour}:${minuteFormatted}`;
}

function getDateTimeEN(date: Date): string {
  // YYYY-MM-DD HH:MM
  const year = date.getFullYear();
  const month = date.getMonth() + 1;
  const day = date.getDate();
  const hour = date.getHours();
  const minute = date.getMinutes();

  // month, day, hour, minute should be 2 digits
  const monthFormatted = month < 10 ? `0${month}` : month;
  const dayFormatted = day < 10 ? `0${day}` : day;
  const hourFormatted = hour < 10 ? `0${hour}` : hour;
  const minuteFormatted = minute < 10 ? `0${minute}` : minute;

  return `${year}-${monthFormatted}-${dayFormatted} ${hourFormatted}:${minuteFormatted}`;
}

const getDateTime: GetDateTime = {
  en: getDateTimeEN,
  ko: getDateTimeKO,
};

export default getDateTime;
