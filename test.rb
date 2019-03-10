<!DOCTYPE html>
<html>
<head>
  <title>test</title>
  <meta charset="UTF-8">
  <link rel="stylesheet" type="text/css" href="css/admin_nav.css">
  <link rel="stylesheet" type="text/css" href="css/dashboard.css">
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css">
  <link rel="stylesheet" type="text/css" href="css/bootstrap-responsive.css">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <script src="js/jquery.min.js"></script>
  
</head>
<body>
  <div id = "wrapper">
    <%= erb :admin_nav %>
    
    <div id = "page-content-wrapper">
      <nav>
        <h1 id = "alta">Alta</h1>
        <form method="post" action = "fetch_tweets"> 
          <input type="submit" name="button" value="Fetch tweets">
        </form>
      </nav>
      <div id = "requests">
        <div id = "incoming_tweets">
          <h2>Tweets</h2>
          <div class = "displaytweets">
            <table>
                <% unless @tweets.nil? %>
                    <% @tweets.reverse_each do |tweet| %>
                              <tr>
                                <td class = "tweets">
                                  <div class = "tweet_actions">
                                    <img src = "img/check.png" class= "check" alt = "reply tweet" width = "50">
                                    <img src = "img/cross.png" class = "delete" alt = "delete tweet" width = "50">
                                  </div>
                                  <div class = "reply">
                                    <form method="post" action = "replyToTweet"> 
                                      Reply to Tweet: <input type="text" name="reply" value="<%=h params[:reply] %>"/>
                                      <input type="submit" name="button" value="reply" />
                                    </form>
                                  </div>
                                   <blockquote class="twitter-tweet" data-conversation="none" data-lang="en" data-theme="dark"><p lang="en" dir="ltr"><a href="https://twitter.com/Uber?ref_src=twsrc%5Etfw">@uber</a> <%= tweet.full_text %></p>&mdash;<a href="<%= tweet.uri %>"></a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>
                                </td>
                              </tr>
                    <% end %>
                <% end %>
              </table>
          </div>
        </div>
      </div>
    </div>
    <script>
      $('.check').click(function() {
          $($(this).parent().parent()).toggleClass("displayreply");
          //$(".inprogress_table").append($(this).parent().parent().parent());
      });
      $('.delete').click(function() {
          $(this).parent().parent().parent().remove();
      });
    </script>
    <script src="js/admin_nav.js"></script>
  </div>
</body>
</html>
