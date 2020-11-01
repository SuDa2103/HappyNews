$(function() {

  $(".vote").on("click", ".upvote", function(){
    var link_id = $(this).parent().data("id"),
      is_upvote = $(this).hasClass("upvote");

    $.ajax ({
      url: "/link/vote",
      method: "POST",
      data: {link_id: link_id, upvote: is_upvote },
      success: function(){
        console.log("success..");
      }
    })
  });
});
