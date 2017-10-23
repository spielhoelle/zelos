var sel = document.getElementById('entry_is_offer');
if(sel){
  sel.onchange = function() {
    if (this.checked == true) {
      $(".collapsible-header").addClass("active");
      $(".collapsible").collapsible({accordion: false});
      $('#invoice_type').text("Offer");
    } else {
      $(".collapsible-header").removeClass("active");
      $(".collapsible").collapsible({accordion: true});
      $('#invoice_type').text("Invoice");
    }
  }
}
$(function() {
  $('.sortable').railsSortable({
    placeholder: "ui-state-highlight",

  });
  $('.nested_index').each(function(){
    this.parentElement.id = "Item_" + this.innerText
  })
});

$(document).on('click', '.note-part', function(){
  $('#entry_notes').val($('#entry_notes').text() +"\n" + this.dataset.value)
  $('#entry_notes').prev().addClass('active')
})

$(document).on("fields_added.nested_form_fields", function(event, param) {
  $('.nested_entry_items').last().find('input:first').focus()
});
$(document).ready(function(){
  // the "href" attribute of the modal trigger must specify the modal ID that wants to be triggered
  $('.modal').modal({
    dismissible: true, // Modal can be dismissed by clicking outside of the modal
    opacity: .5, // Opacity of modal background
    inDuration: 300, // Transition in duration
    outDuration: 200, // Transition out duration
    startingTop: '4%', // Starting top style attribute
    endingTop: '10%', // Ending top style attribute
    ready: function(modal, trigger) { // Callback for Modal open. Modal and trigger parameters available.
      $('#user_email').focus().click();
    },
    complete: function() { 
    
    } // Callback for Modal close
  })
});
$(document).on('turbolinks:load', function () {
  if ($('body').hasClass('customers') || $('body').hasClass('entries-edit') || $('body').hasClass('entries-new')){
    $(function() {
      $.ajax({
        dataType: "json",
        url: "/admin/customers",
        type: "GET",
        success: function(data){
          var result = {};
          var address_result = {};
          data.forEach(function(e, i){
            result[e.name] = null
            address_result[e.name] = [e.address, e.company, e.id]
          })
          $('.autocomplete').autocomplete({
            data: result,
            limit: 20, // The max amount of results that can be shown at once. Default: Infinity.
            onAutocomplete: function(val) {
              if ( $('body').hasClass('customers-index')){
                $('form#search-form').submit()
              }
              var id = $('#entry_customer_attributes_id')
              var address = $('#entry_customer_attributes_address');
              var company = $('#entry_customer_attributes_company')
              id.val(address_result[val][2])
              address.val(address_result[val][0]).prop('readonly', true);;
              company.val(address_result[val][1]).prop('readonly', true);;
              address.prev().addClass('active');
              company.prev().addClass('active');
            },
            minLength: 0, // The minimum length of the input for the autocomplete to start. Default: 1.
          });
        }
      })

    });
    $('.autocomplete').on("change", e => {
      var value = $(e.currentTarget).val();  // ...and using it here
      if(value === "") {
        var text_field = $('#entry_customer_attributes_address, #entry_customer_attributes_company, #entry_customer_attributes_id');
        text_field.val("").prop('readonly', false);
        text_field.prev().removeClass('active');
      }
    });

  } else if($('body').hasClass('entries-index')){

    $(function() {
      $.ajax({
        dataType: "json",
        url: "/admin/entries",
        type: "GET",
        success: function(data){
          var result = {};
          var address_result = {};
          data.forEach(function(e, i){
            result[e.title] = null
            address_result[e.title] = [e.title, e.id]
          })
          console.log(result)
          $('.autocomplete').autocomplete({
            data: result,
            limit: 20, // The max amount of results that can be shown at once. Default: Infinity.
            onAutocomplete: function(val) {
              $('form#search-form').submit()
            },
            minLength: 0, // The minimum length of the input for the autocomplete to start. Default: 1.
          });
        }
      })

    });

  }

});

