export default function convert(time) {
  const date = new Date(time);

  //Date formating
  const day =
    date.getDate() < 10 ? "0" + date.getDate().toString() : date.getDate();

  const month =
    date.getMonth() + 1 < 10
      ? "0" + (date.getMonth() + 1).toString()
      : date.getMonth() + 1;

  const year = date.getFullYear();

  //Time formating
  const hour =
    date.getHours() < 10 ? "0" + date.getHours().toString() : date.getHours();

  const minute =
    date.getMinutes() < 10
      ? "0" + date.getMinutes().toString()
      : date.getMinutes();

  //Final values
  const formatedDate = `${day}/${month}/${year}`;
  const formatedTime = `${hour}:${minute}`;

  return [formatedDate, formatedTime];
}
