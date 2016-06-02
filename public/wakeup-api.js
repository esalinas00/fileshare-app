$('#api-wake-up').click(function () {
  fetch('/api/wakeup').then(function (response) {
    return response.status;
  }).then(function (status) {
    if (status === 200) {
      swal(
        'Good job!',
        'API Server is wakeup!',
        'success'
      );
    } else {
      swal(
        'Oops...',
        'Something went wrong! API Server not found.',
        'error'
      );
    }
  }).catch(function (ex) {
    console.log('parsing failed', ex);
  });
});
