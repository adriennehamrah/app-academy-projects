export const apiRequest = () => {
  return $.ajax({
    url: '/api/todos',
    method: 'get'
  });
};
