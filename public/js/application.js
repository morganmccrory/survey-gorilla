$(document).ready(function() {

    var prompt = $(".new_quest")
    var questionData = $("#new_question").serializeArray();

    $(".create_survey").on("click", function(e) {
        $.ajax({
            url: "/surveys",
            method: "POST",
            data: {
              title: $("#title").val()
        }
      });

        $(".create_survey").hide();
        $(".add_question").show();
        $(".submit_survey").show();
        prompt.show();
   });

    $(".add_question").on("click", function(e) {
        var questionRequest = $.ajax({
            url: "/surveys",
            method: "POST",
            data: {
                prompt: $(".prompt:last").val(),
                choice_1: $(".choice_1:last").val(),
                choice_2: $(".choice_2:last").val(),
                choice_3: $(".choice_3:last").val(),
                choice_4: $(".choice_4:last").val()
            }
        });
        questionRequest.done(function(response) {
            prompt.clone().find("input:text").val("").end().appendTo(".frame2");
        });
    });

    $(".submit_survey").on("click", function(e) {
      $.ajax({
            url: "/surveys",
            method: "POST",
            data: {
                prompt: $(".prompt:last").val(),
                choice_1: $(".choice_1:last").val(),
                choice_2: $(".choice_2:last").val(),
                choice_3: $(".choice_3:last").val(),
                choice_4: $(".choice_4:last").val()
            }
        });
      $(location).attr('href', "/surveys")
    });

  $('.delete').on('click', function(event) {
    event.preventDefault();
    var button = $(this);
    window.confirm('Are you sure?');
    // Does not abort if "Cancel" is clicked. :(

    var deleteRequest = $.ajax({url: button.attr("href"), method: "delete"});
    deleteRequest.done(function(response) {
      button.parents("tr").remove();
    });
  });

});
