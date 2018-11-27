// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


 $(document).delegate('.ggroupitem', 'click', function(){
  debugger
  // $('.ggroupitem').dblclick(function(){
   var id = $(this).attr('id')
   var task_id = id.split('_')[1];
   $.post("timeline/edit",
    {
        task_id: task_id,
    },
    function(data, status){
        $('.timeline_form').html(data);
        $('#myModall').modal('show')
        // alert("Data: " + data + "\nStatus: " + status);
    });
  })


  $(document).ready(function(){
    $('.gtasklist').addClass('none');
    $('.gfoldercollapse').addClass('none');
    $('.ggroupblackendpointleft').addClass('none');
    $('.ggroupblackendpointright').addClass('none');
  })

 $(document).delegate('.gformlabel', 'click', function(){
    $('.gtasklist').addClass('none');
    $('.gfoldercollapse').addClass('none');
    $('.ggroupblackendpointleft').addClass('none');
    $('.ggroupblackendpointright').addClass('none');
    $('.glinev').addClass('none')
 })

//  $(".submit_form").click(function(e) {
//     debugger


//     var form = $(this);
//     var url = "timeline/create";

//     $.ajax({
//            type: "POST",
//            url: url,
//            data: $('.timeline_form').serialize(), // serializes the form's elements.
//            success: function(data)
//            {
//                // alert(data); // show response from the php script.
//                // location.reload() ;
//                // $('#myModall').modal('toggle');
//               $('.show_graph_container').html(data);
//            }
//          });

//     e.preventDefault(); // avoid to execute the actual submit of the form.
// });


 	$(document).delegate('.submit_form', 'click', function(){
  	// $(".submit_form").click(function(e) {
	    debugger


	    var form = $(this);
	    var url = "timeline/create";

	    $.ajax({
	           type: "POST",
	           url: url,
	           data: $('.timeline_form').serialize(), // serializes the form's elements.
	           success: function(data)
	           {
	               // alert(data); // show response from the php script.
	               // location.reload() ;
	               // $('#myModall').modal('toggle');
	              $('.show_graph_container').html(data);
	           }
	         });

	    e.preventDefault(); // avoid to execute the actual submit of the form.
	});


 	$(document).delegate('.update_form', 'click', function(){
    // $(".update_form").click(function(e) {
    	var field1 = $('.field1').val();
    	var field2 = $('.field2').val();
    	var field3 = $('.field3').val();
    	// var field4 = $('.field4').val();
    	var field5 = $('.field5').val();
	    debugger
	    if (field1 && field2 && field3 && field5){
	    	$(this).html('loading')
	    	$(this).prop('disabled', true);
		    var form = $(this);
		    var url = "timeline/create";
		    var show_graph = "show_graph";

		    $.ajax({
		           type: "POST",
		           url: url,
		           data: $('.timeline_form').serialize(), // serializes the form's elements.
		           success: function(data)
		           {
		               // alert(data); // show response from the php script.
		               // location.reload() ;
		               // $('#myModall').modal('toggle');
		              // $('.show_graph_container').html(data);
		              window.location.href = show_graph;
		           }
		         });

		    e.preventDefault(); // avoid to execute the actual submit of the form.
		}
		else {
			$('.form-control').addClass('error')
		}
	});

	$(document).delegate('.form-control', 'focus', function(){
		$(this).removeClass('error')
	})

	// $(function() {
	//   // $('#datetimepicker1').datepicker();
	//   // $('#datetimepicker2').datepicker();
	//   $('#datetimepicker1').datepicker({
	//     format: 'dd/mm/yyyy',
	//     todayHighlight:'TRUE',
	//     autoclose: true,
	// })
	//   $('#datetimepicker2').datepicker({
	//     format: 'dd/mm/yyyy',
	//     todayHighlight:'TRUE',
	//     autoclose: true,
	// })
	// });



	// $('#datetimepicker1').datepicker()
	// .on('changeDate', function(ev){                 
	//     $('#datetimepicker1').datepicker('hide');
	// });

	$(document).delegate('.edit_form', 'click', function(){
	  debugger
	  $(this).addClass('none');
	  $('.form-control').prop("disabled", false)
	  $('.submit_form').removeClass('none');

	})

	$(document).delegate('.delete_timeline', 'click', function(){
	  debugger
	  var timeline_id = $(this).data('id');
	  $('.confirm_delete').attr('data-id', timeline_id );
	  $('#destroy_timeline_modal').modal('show');
	} )

	$(document).delegate('.confirm_delete', 'click', function(){
	  debugger
	  var timeline_id = $(this).data('id');
	  $.post("timeline/destroy",
	    {
	        task_id: timeline_id,
	    },
	    function(data, status){
	        // $('.timeline_form').html(data);
	        $('#destroy_timeline_modal').modal('hide')
	        // $('.show_graph_container').html(data);
	        location.reload() ;
	    });
	} )





