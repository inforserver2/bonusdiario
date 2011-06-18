$(document).ready(function(){

  jQuery('#user_name').keyup(function() {
      if (this.value.match(/[^a-zA-Z0-9]/g)) {
          this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
      }
  });

});

