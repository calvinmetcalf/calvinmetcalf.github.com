/* Author:
Calvin Metcalf
*/
//var eURL = 'http://baystatebikeweek.org/events/rss/';
var eURL = 'calvinmetcalf.github.com/bf.xml';

 var yqlurl = 'http://query.yahooapis.com/v1/public/yql?format=json&q=select%20*%20from%20xml%20where%20url%3D';


$(function() {
$.get(yqlurl + "'" + encodeURIComponent(eURL) + "'",
        function(data){
          var v = data.query.results.rss.channel.item;
             $.each(v,function(i,ev){
                 var stuff = '<div class="row-fluid"><h2>' + ev.title + '</h2><p>' + ev.description + '</p><p><a class="btn" href="' + ev.link + '">View details &raquo;</a></p></div>';
                 
                 $('.events').append(stuff);
             }
            );
        },"jsonp");
   
});